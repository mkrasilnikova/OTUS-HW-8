create database if not exists testdb;
use testdb;

create external table if not exists yellow_taxi (
  VendorID int,
  tpep_pickup_datetime timestamp,
  tpep_dropoff_datetime timestamp,
  passenger_count int,
  trip_distance double,
  RatecodeID int,
  store_and_fwd_flag string,
  PULocationID int,
  DOLocationID int,
  payment_type int,
  fare_amount double,
  extra double,
  mta_tax double,
  tip_amount double,
  tolls_amount double,
  improvement_surcharge double,
  total_amount double
)
STORED AS PARQUET
location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/yellow_taxi';


create external table if not exists taxi_zones (
  LocationID int,
  Borough string,
  PULocationID string,
  Zone string,
  service_zone string
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/taxi_zones'


