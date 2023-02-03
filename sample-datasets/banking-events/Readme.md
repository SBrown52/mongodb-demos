# Banking events
This dataset create a series of events used to simulate customers coming into a bank and depositing or withdrawing money.

First of all load the sample data into your cluster (edit number of docs needed as required). This requires you have `mgeneratejs` and `mongoimport` installed.
```
mgeneratejs schema.json -n 50000 | mongoimport mongodb+srv://<username>:<password>@<cluster_url>/ -d events -c data
```

## Run some database queries
Find the fraud - let's look at how many users made multiple deposits or activity on a single day

```
db.data.aggregate([
  {
    '$group': {
      '_id': {
        'customerId': '$customerId', 
        'date': {
          '$dateToString': {
            'format': '%Y-%m-%d', 
            'date': '$timestamp'
          }
        }
      }, 
      'history': {
        '$push': {
          'activity': '$activity', 
          'time': '$timestamp', 
          'details': '$details'
        }
      }
    }
  }, {
    '$addFields': {
      'numberOfEvents': {
        '$size': '$history'
      }
    }
  }, {
    '$match': {
      'numberOfEvents': {
        '$gt': 1
      }
    }
  }
])
```


Which branches are busiest on a given day
```
[
  {
    '$match': {
      'timestamp': {
        '$gte': new Date('Thu, 14 Jul 2022 00:00:00 GMT'), 
        '$lt': new Date('Fri, 15 Jul 2022 00:00:00 GMT')
      }
    }
  }, {
    '$group': {
      '_id': '$branchId', 
      'visitsPerBranch': {
        '$sum': 1
      }
    }
  }, {
    '$sort': {
      'visitsPerBranch': -1
    }
  }
]
```