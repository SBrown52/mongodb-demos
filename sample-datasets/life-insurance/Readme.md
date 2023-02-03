# Life Insurance
This dataset create a series of documents to represent Life Insurance policies held by customers.


## Generate and Load Data
First of all load the sample data into your cluster (edit number of docs needed as required). This requires you have `mgeneratejs` and `mongoimport` installed.
```
mgeneratejs schema.json -n 50000 | mongoimport mongodb+srv://<username>:<password>@<cluster_url>/ -d insurance -c policies
```

