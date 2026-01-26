# Question 1. Understanding Docker images
docker run -it --entrypoint bash python:3.13
pip --version
exit

#Create the docker-compose.yaml

# Start the docker compose
docker-compose up -d
docker ps

# Download green taxi data November 2025
wget https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet

# Download zones data
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv

# Create script ingest_data.py

# Install libraries
pip install pandas sqlalchemy psycopg2-binary pyarrow

# Runing the script
python ingest_data.py

# Open pgadmin on browser
http://localhost:8080

email: pgadmin@pgadmin.com
password: pgadmin

Host name/address: db
Port: 5432
Maintenance database: ny_taxi
Username: postgres
Password: postgres

# Query No 3
SELECT COUNT(*) 
FROM green_taxi_trips 
WHERE lpep_pickup_datetime >= '2025-11-01' 
  AND lpep_pickup_datetime < '2025-12-01' 
  AND trip_distance <= 1

# Query No 4
SELECT 
  DATE(lpep_pickup_datetime) AS pickup_day,
  MAX(trip_distance) AS max_distance
FROM green_taxi_trips
WHERE trip_distance < 100
GROUP BY DATE(lpep_pickup_datetime)
ORDER BY max_distance DESC
LIMIT 1

# Query No 5
SELECT 
  z."Zone",
  SUM(t.total_amount) AS total
FROM green_taxi_trips t
JOIN zones z ON t."PULocationID" = z."LocationID"
WHERE DATE(t.lpep_pickup_datetime) = '2025-11-18'
GROUP BY z."Zone"
ORDER BY total DESC
LIMIT 1

# Query No 6
SELECT 
  z_dropoff."Zone",
  MAX(t.tip_amount) AS max_tip
FROM green_taxi_trips t
JOIN zones z_pickup ON t."PULocationID" = z_pickup."LocationID"
JOIN zones z_dropoff ON t."DOLocationID" = z_dropoff."LocationID"
WHERE z_pickup."Zone" = 'East Harlem North'
  AND DATE(t.lpep_pickup_datetime) >= '2025-11-01'
  AND DATE(t.lpep_pickup_datetime) < '2025-12-01'
GROUP BY z_dropoff."Zone"
ORDER BY max_tip DESC
LIMIT 1

# Question No 7
terraform init, terraform apply -auto-approve, terraform destroy