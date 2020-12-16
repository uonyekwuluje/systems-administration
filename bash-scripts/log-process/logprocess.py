#!/usr/bin/env python3
import requests

filename="webaccess.log"
logfile_url="https://github.io/uonyekwuluje/access.log"

# Download access.log and save in current directory as webaccess.log
request_object = requests.get(logfile_url)
with open(filename,'wb') as file_handle:
    file_handle.write(request_object.content)

# Create a dictionary and capture agent count by frequency
unsorted_log = dict()
with open(filename) as fhandle:
    for line in fhandle:
        agent = line.rstrip("\n").split('"-"')[1:2]
        if str(agent) in unsorted_log:
            unsorted_log[str(agent)] += 1
        else:
            unsorted_log[str(agent)] = 1 

# Sort the values and print the top 5
sorted_keys = sorted(unsorted_log, key=unsorted_log.get, reverse=True)
count = 0
for r in sorted_keys:
    if (len(str(r)) <= 5):
        pass
    else:
        print(unsorted_log[r], str(r))

    count += 1
    if count == 6:
        break
