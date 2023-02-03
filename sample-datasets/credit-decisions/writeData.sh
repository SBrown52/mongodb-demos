#!/bin/bash

# Generate the schema on the fly, then generate data from the schema before importing data into MongoDB
node generateSchema.js | mgeneratejs -n 15000 | mongoimport --db credit --collection decisions