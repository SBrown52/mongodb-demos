#!/bin/bash

# Simple script which generates 50 events and adds them to a kafka topic, loops every 5 seconds.
# Replace the schema file with whatever you want the data to look like
while true; do mgeneratejs schema.json -n 50 | python produce_events.py; sleep 5; done