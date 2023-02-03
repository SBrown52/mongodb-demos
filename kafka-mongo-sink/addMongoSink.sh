echo "\nAdding MongoDB Kafka Sink Connector"
curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongo-atlas-sink",
   "config": {
     "name": "mongo-atlas-sink",
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"mytopic",
     "connection.uri":"'"$1"'",
     "database":"stream",
     "collection":"data",
     "key.converter":"org.apache.kafka.connect.json.JsonConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.json.JsonConverter",
     "value.converter.schemas.enable":false
}}' http://localhost:8083/connectors -w "\n"
