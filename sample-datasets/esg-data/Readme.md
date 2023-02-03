# ESG Demo Walkthrough

## Load the data
Obtain the required dataset from Kaggle, and load it into a MongoDB Atlas cluster (an M0 or M10 should be fine)

## Run sample queries
```
db.scores.find({companyName: "HSBC HOLDINGS PLC"})
```
or find all HSBC like companies
```
db.scores.find({companyName: /^HSBC/})
```
How many HSBC companies are there?
```
db.scores.find({companyName: /^HSBC/}).count()
```
Find all HSBC companies based in the UK
```
db.scores.find({companyName: /^HSBC/, country: "GB"})
```

## Run aggregation queries
Average ESG score across sectors
```
db.scores.pipeline([{
    $group: {
        _id: '$sector',
        avgScore: {
            $avg: '$overallScore'
        }
    }
}, {
    $sort: {
        avgScore: -1
    }
}])
```


## Data API queries
curl --location --request POST 'https://data.mongodb-api.com/app/<project>/endpoint/data/v1/action/find' \
--header 'Content-Type: application/json' \
--header 'Access-Control-Request-Headers: *' \
--header 'api-key: XXX' \
--data-raw '{
    "collection":"data",
    "database":"scores",
    "dataSource":"DemoCluster",
    "projection": {"_id": 0},
    "filter": {"companyName": "HSBC HOLDINGS PLC"}
}'

curl --location --request POST 'https://data.mongodb-api.com/app/<project>/endpoint/data/v1/action/findOne' \
--header 'Content-Type: application/json' \
--header 'Access-Control-Request-Headers: *' \
--header 'api-key: XXX' \
--data-raw '{
    "collection":"scores",
    "database":"esg",
    "dataSource":"DemoCluster",
    "filter": {"companyName": "HSBC HOLDINGS PLC"}
}'

## GraphQL Queries

```
query {
  score {
    companyName
    sector
    overallScore
  }
}
```


curl 'https://eu-west-2.aws.realm.mongodb.com/api/client/v2.0/app/<project>/graphql' \
  -X POST \
  --header 'content-type: application/json' \
  --header 'apiKey: XXX' \
  --data '{"query": "query { score(query: { companyName: \"HSBC HOLDINGS PLC\"}) { _id \n companyName \n country \n environmentalScore \n governanceScore \n overallRating \n overallScore \n sector \n socialScore \n subsector \n ticker \n}}"}'