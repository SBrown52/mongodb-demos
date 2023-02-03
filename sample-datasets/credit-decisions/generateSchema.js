let schema = {
    "cin": {"$join": {"array": ["#CIN-YYY", {"$inc": {"start": 17000000, "step": 1}}]}},
    "accountNo": { "$ssn": { "dashes": false } },
}

noPoints = 5000;
for (let i = 0; i < noPoints; i++) {
    schema['version'] = 1;
    schema['dataPoint' + i] = "$numberDecimal"
  }

console.log(JSON.stringify(schema))