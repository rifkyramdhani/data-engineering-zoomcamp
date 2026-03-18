# Create External Table

CREATE OR REPLACE EXTERNAL TABLE `kestra-sandbox-486807.nytaxi.external_yellow_tripdata_2024`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://zoomcamp-rifky-2026/yellow_tripdata_2024-*.parquet']
);

# Create Regular (Materialized) Table

CREATE OR REPLACE TABLE `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned` AS
SELECT * FROM `kestra-sandbox-486807.zoomcamp.external_yellow_tripdata_2024`;

SELECT COUNT(1) FROM `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned`;

SELECT COUNT (DISTINCT PULocationID ) AS PULocationID  FROM `kestra-sandbox-486807.zoomcamp.external_yellow_tripdata_2024`
SELECT COUNT (DISTINCT PULocationID ) AS PULocationID  FROM `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned`

SELECT DISTINCT PULocationID   FROM `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned`
SELECT DISTINCT PULocationID,DOLocationID    FROM `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned`

SELECT COUNT(1) FROM `kestra-sandbox-486807.zoomcamp.yellow_tripdata_2024_non_partitioned` WHERE fare_amount = 0
