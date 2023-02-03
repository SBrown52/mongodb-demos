/**
 * 
 * Example of joining many collections together in a single view, using the $unionWith aggregation operator.
 * 
 * NB: only works with collections in the same db namespace.
 * 
 */
db = db.getSiblingDB("scratch");

/** Clean up existing resources */
db.collectionOne.drop()
db.collectionTwo.drop()
db.collectionThree.drop()
db.combinedView.drop()

print("\n**Inserting Documents**\n")
db.collectionOne.insertOne({"from": "collection-one"})
db.collectionTwo.insertOne({"from": "collection-two"})
db.collectionThree.insertOne({"from": "collection-three"})

print("\n**Creating View**\n")
db.createView('combinedView', 'collectionOne', [
    {
      '$unionWith': {
        'coll': 'collectionTwo'
      }
    }, {
      '$unionWith': {
        'coll': 'collectionThree'
      }
    }
  ])

print("\n**Retrieve all docs**\n")
res = db.combinedView.find()

print(res)