#!/bin/bash
IOSTATSIN=/nfs_export/input/*iostat.out
FIOSIN=/nfs_export/input/*.json
GRAPHOUT=/nfs_export/output/iostat-graphs
FIOSOUT=/nfs_export/output/fio-lat-precentiles

for i in $IOSTATSIN
do
        iostat-cli --data $i --fig-output $GRAPHOUT/$(basename -s .j2-iostat.out $i).png plot
done

for j in $FIOSIN
do
        /usr/bin/python3 internal_scripts/parse_json.py -i $j -o $FIOSOUT/$(basename -s .j2.json $j).csv
done
