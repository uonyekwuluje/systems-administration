#!/bin/bash
wget https://github.io/uonyekwuluje/access.log
awk -F '"-"' '{print $2}' access.log | sort | uniq -c | sort -nr | head -n 5
