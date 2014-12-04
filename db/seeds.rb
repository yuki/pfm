Account.create(name: "Account1", description: "My bank account", amount: 10000, currency: "EUR")
Account.create(name: "Cash", description: "Cash money", amount: 140, currency: "EUR")
Mtype.create(name: "Salary")
Mtype.create(name: "Party")
Movement.create(name: "Month salary", account_id: 1, mtype_id: 1, amount: 1000, mdate:"2014-12-04", account_amount:10000)
Movement.create(name: "Party night", account_id: 2, mtype_id: 2, amount: -50, mdate:"2014-12-06", account_amount:140)
