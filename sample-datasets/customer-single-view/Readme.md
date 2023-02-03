# Customer single view - banking data
This dataset produces a "single view" of a customer who might have multiple financial products (cards, loans, mortgages etc) with a bank.

First of all load the sample data into your cluster (edit number of docs needed as required). This requires you have `mgeneratejs` and `mongoimport` installed.
```
mgeneratejs schema.json -n 50000 | mongoimport mongodb+srv://<username>:<password>@<cluster_url>/ -d customer_platform -c data
```

### Find a sample customer and explore the data model
```
db.data.findOne()
```

### Find customers who have a mortgage with us
```
db.data.find({"products.type": 'Mortgage'})
```

### Find customers who have only have a mortgage with us
```
db.data.find({"products": {$size: 1}, "products.type": 'Mortgage'})
```

### Find customers who have only have a mortgage with us, and the mortgage is not their primary address
```
{"products": {$size: 1}, "products.type": 'Mortgage', "products.sameAddressAsAccount": "no"}
```

## Aggregations
Run some aggregate queries and talk about analytics

### Find total number of products we have
```
db.data.aggregate([
  {
    '$unwind': {
      'path': '$products'
    }
  }, {
    '$group': {
      '_id': '$products.type', 
      'productCount': {
        '$sum': 1
      }
    }
  }
])
```

### find total mortgage exposure
```
db.data.aggregate([
  {
    '$unwind': {
      'path': '$products'
    }
  }, {
    '$match': {
      $or: [
      {'products.type': 'Mortgage'}, {'products.type': 'Loan'}
      ]
    }
  }, {
    '$group': {
      '_id': '$products.type', 
      'totalExposure': {
        '$sum': '$products.principalAmount'
      }
    }
  }
])
```

Create a materialized view of the counts of each product on a given date
```
db.data.aggregate(
  [{
    $unwind: {
        path: '$products'
    }
}, {
    $group: {
        _id: '$products.type',
        productCount: {
            $sum: 1
        }
    }
}, {
    $addFields: {
        date: '2022-11-13'
    }
}, {
  $project: {_id: 0, product: '$_id', date: 1, productCount: 1}
},
{
    $merge: {into: 'matView'}
}]
)
```