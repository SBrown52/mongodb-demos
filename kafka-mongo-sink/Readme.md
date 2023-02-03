# Kafka Events 
This is a simple demo to show off the power of MongoDB and Kafka together. We produce some super simple sample data for any choice of schema you provide. We produce the sample data and then write that to a kafka queue on Confluent platform (running locally in Docker, but can also be pointed at Confluent Cloud). We then register a kafka sink connector to write all events to a MongoDB instance, which will persist the data long term and allow us to query the data.

## Prerequisites
You will need to have installed: docker, python, and have access to a running MongoDB instance - we suggest using Atlas for ease and you can get started for free.

## Run Confluence containers

```
docker-compose up -d
```

You might to check that they are all running, which can be done with `docker-compose ps`

## Install MongoDB connector
Log into the `connect` container and install the MongoDB sink plugin

```
confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:latest
```

## Setup MongoDB connector
The details are already in the file for the topic, db and collection name. You just need to pass in your Atlas URL
```
sh addMongoSink.sh "mongodb+srv://<user>:<pass>@<clustername>.mongodb.net/"
```
NB: If this errors because it cannot find the the MongoDB sink class, you might need to restart the connect container.

## Run the python script to write events to the kafka topic, which get's put in Mongo
We use `mgeneratejs` to create sample data, which is piped to a python app to push records to the Kafka topic. The script relies on having a valid `schema.json` file containing instructions on the sample data to produce. You can find a list of sample schemas in [sample-datasets](../sample-datasets)
```
sh writeRecords.sh
```

View the results in MongoDB