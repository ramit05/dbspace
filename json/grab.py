import os

import json
import datetime
import time

# Open JSON File
a = open('sample.json', 'r')

# Reading JSON FILE
b = a.read()

#Loading JSON in a variable
resp_dict = json.loads(b)

# Grab first entry of JSON with parameter(PARAMETER)
c = resp_dict[0]['PARAMETER']

# Grab last entry of JSON with parameter(PARAMETER)
d = resp_dict[-1]['PARAMETER']

# Grabbing the words in 1st row (row[0])
row = r[i]

letter = r[i].split('_')[0] # Grabs first 2 letters before '_'

letter = r[i].split('_')[0][0] # Grabs first 1 letter before '_'
