# Credit Decisions
This dataset create a series of documents to a credit decisioning process. There are fields for account number and customer ID, the rest of the information is random datapoints (can generate as many as needed), which could be the result of a ML or scoring process. This data can then be fed to a decisioning tool via REST or direct access.


## Generate and Load Data
This example is a little different. Instead of a fixed schema, we generate it so that we can have a arbitrary number of data points in our document, for example from 10 to 5000 as the mode requires. Follow the steps in `writeData.sh`.

## Query Data
Find by accountID
```
db.decisions.findOne({accountNo: "975079931"}, {cin: 1, accountNo: 1, dataPoint0: 1, dataPoint1: 1, dataPoint138: 1})
```

find by cin
```
db.decisions.findOne({cin: "975079931"}, {cin: 1, accountNo: 1, dataPoint0: 1, dataPoint1: 1, dataPoint138: 1})

```