# DBSpace

Some notes and work on databases

## Types of DB

* [NoSQL](#nosql)
* [RDBMS](#rdbms)

## RDBMS

### MySQL

MySQl is one of the earliest and best working Db's. Using MySQL is simple and query based. In this repo I am working on [AWS RDS](https://aws.amazon.com/rds/) Service. Using this service we are going to create some tables and [aws lambda](https://aws.amazon.com/lambda/) function calls to execute the queries.



## NoSQL
### Mongodb

Setting up Mongodb cluster on aws using Master-Slave and Sharding db models.

### Architecture

### Master-Slave Architecture

![master-slave](https://user-images.githubusercontent.com/8342133/29204563-6f800658-7e95-11e7-934b-76102411878e.png)

### Sharding Model

## Comparisions

| Features/Models |        Replication           |        Sharding         |
| ----------------|:----------------------------:|:-----------------------:|
| Usage | For Regular Production Usage, redundancy & high availability | Large data sets and high throughput operations  |
| Monitoring|Mongostat,Mongotop|Mongostat,Mongotop|

## Models

* [Replication Model](#replication-model)
* [Sharding Model](#sharding-model)

## Getting Started

* [Replication Model](#replication-model)

It is also called as Master Slave architecture.

* [Sharding Model](#sharding-model)

## License

MIT License
