import json
import pandas as pd
from pandas import json_normalize

with open('test.json') as f:
    data = json.load(f)

raw = json_normalize(data,)
print(raw)
