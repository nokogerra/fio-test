# Описание
Этот проект использует Ubuntu cloud-init image для нагрузочного тестирования в среде виртуализации с помощью FIO benchmark. Протестировано на Ubuntu 20.04 https://cloud-images.ubuntu.com/focal/. Для работы этого проекта необходим доступ в интернет с VM напрямую или через proxy-сервер.<br />
Состав предполагает следующие VM: контроллер с набором необходимого софта (ansible, python3, python libs, iostat-tool, terraform) и необходимое количество engine-VM для нагрузочного тестирования. После окончания тестирования для каждой engine-VM будут доступны графики, построенные из iostat дампа (via iostat-tool/matplotlib) и percentile latency в виде csv из FIO json output. Зонтичный мониторинг в проекте отсутствует.<br />
Среда виртуализации может быть любой, однако, от этого будет зависеть способ деплоя VM (terraform/ansible/powershell/etc) и способ cloud-init, т.е. способ прикрепления userdata/metadata. В данный момент доступны рецепты terraform для Openstack и VMware Cloud Director<br />
Использовать именно cloud-init image не обязательно, однако в userdata включено создание пользователя с нужным публичным SSH ключём, для контроллера также создаётся скрипт, который установит необходимые пакеты. Если cloud-init не используется, это будет необходимо сделать плэйбуком или вручную.

## Деплой и настройка контроллера и engine VM
Предполагается деплой с помощью Terraform. В каталоге проекта terraform/ находятся необходимые файлы для запуска процесса деплоя. Исполняемые файлы (.exe для Windows, bin для Linux) необходимо скопировать в соответствующий каталог проекта TF (в "openstack" или "vclouddirector").
В рецепте для Openstack создаются router, network, subnet и интерфейс роутера, затем FIO контроллер. FIO engine создаются зацикливанием модуля "engine_vm".
В рецепте для Cloud Director создаются только FIO машины (контроллер и engine), используются существующие сети и роутер.
> В случае отсутствия доступа к **registry.terraform.io** необходимо исправить конфигурационный файл terraform для указания на каталог, создержащий нужные провайдеры (terraform/providers/). Также необходимо добавить следующие перменные в среду: <br />

Windows:
```
$env:TF_PLUGIN_CACHE_DIR="c:/path/to/terraform/plugin"
$env:TF_CLI_CONFIG_FILE="c:/path/to/terraform/plugin/config.tf"
```
Linux:
```
export TF_PLUGIN_CACHE_DIR="/path/to/terraform/plugin"
export TF_CLI_CONFIG_FILE="/path/to/terraform/plugin/terraform.rc"
```
После заполнения terraform.tfvars:
```
.\terraform.exe init
.\terraform.exe plan
.\terraform.exe apply
```
> В случае, если в инфраструктуре используется proxy-сервер, следует раскомментировать соответствующую секцию в userdata*.yml файлах, чтобы обновление пакетов прошло успешно, или отключить обновление пакетов, заккоментировав строку с **"package_upgrade: true"**.
> Дефолтные логин и пароль **ansible:Root123-**.

После развёртывания контроллера FIO в домашнем каталоге пользователя ansible помещается скрипт install-packages.sh. **В случае использования proxy-сервера см. комментарии в скрипте**.

## Конфигурация NFS сервера
NFS сервер на контроллере используется для сбора выводов FIO и iostat с engine-VM.<br />
Для установки и конфигурирования NFS сервера на контроллере используется playbook **1.set_up_nfs_server.yml**. Если в инфраструктуре не используется proxy сервер, play 'set up proxy' следует закомментировать.<br />
См. **group_vars/all.yml**.

## Конфигурирование engine-VM
Playbook **2.configure_storage_and_fio.yml**:
- сконфигурирует proxyсервер, если в инфраструктуре proxy не используется, следует закомментировать play 'set up proxy';
- установит необходимые для engine-VM пакеты. См. **group_vars/fio/fio_packages.yml**
- сконфигурирует PV/VG/LV, создаст файловые системы (ext4), примонтирует их, а также примонтирует NFS share с контроллера. См. **group_vars/fio/fio_storages.yml**;
- создаст на engine-VM каталог с FIO job-файлами. Файлы будут взяты из jinja шаблонов в "{{ templates_dir }}" по маске workload_profile*.j2. См. **group_vars/fio/fio_jobs.yml** и **group_vars/fio/fio_common.yml**;
- сконфигурирует locale EN_US UTF-8 (необходимо для работы iostat-tool).

## Layout
В отдельный playbook 3.fio_layout.yml вынесена задача создания тестовых fio файлов, т.к. этот процесс может быть очень длительным и зависит от объёма заполнения и I/O потенциала хранилища. Для layout'а используется layout_profile (см. **group_vars/fio/fio_workload_profiles_list.yml**), этот профиль только создаст нужные файлы, но не запустит само тестирование.<br />
***Playbook следует запускать из tmux***, чтобы в случае отключения SSH-сессии от вашего десктопа к контроллеру, задача продолжила выполняться.
Использование async/async_status на таких временных интервалах не является надёжным решением.

## Тестирование и сбор данных
Playbook **4.run_fio_and_collect_output.yml** фактически зацикливает play **internal_scripts/fio_run_internal.yml**, который в свою очередь запускает fio в async режиме, далее через **ramp_secs** (fio_common.yml) запускает iostat также в async режиме. Вывод iostat и fio идёт в {{ nfs_input }}. Следующие задачи проверяют состояние задач fio и iostat, async параметры указаны в all.yml.<br />
Количество "прогонов" fio зависит от количества workload profile'ов, указанных в **group_vars/fio/fio_workload_profiles_list.yml**.
Во время ramp_time FIO не фиксирует метрики производительности, поэтому фактически perf снапшоты fio и iostat начнут собирать одновременно.

## Анализ
Для построения графиков используется iostat-tool, для построения percentile latency CSVs используется internal_scripts/parse_json.py.<br />
Следует запустить **5.build_graphs_and_percentiles_csvs.sh**, этот скрипт выполнит анализ всех файлов, находящихся в nfs_input. Итоговые файлы находятся в nfs output.<br />
Важно: пути в 5.build_graphs_and_percentiles_csvs.sh являются хардкодными.

#### Комментарий
Пример графиков и percentile CSV можно посмотреть в examples/.<br />
FIO zonemode strided используется для перемещения active workload set по файлу, см. https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-zonemode.
