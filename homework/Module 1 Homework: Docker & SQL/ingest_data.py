import pandas as pd
from sqlalchemy import create_engine
import pyarrow.parquet as pq

# Connection string ke database
# Format: postgresql://user:password@host:port/database
# Host = localhost karena kita akses dari luar container
# Port = 5433 karena itu port yang di-expose ke host
engine = create_engine('postgresql://postgres:postgres@localhost:5433/ny_taxi')

# Load parquet file
print("Loading green taxi data...")
df_trips = pd.read_parquet('green_tripdata_2025-11.parquet')

# Load ke database dengan nama table 'green_taxi_trips'
# if_exists='replace' = kalau table sudah ada, hapus dan buat baru
# chunksize=100000 = insert data per 100k rows (supaya tidak overload memory)
df_trips.to_sql(name='green_taxi_trips', con=engine, if_exists='replace', chunksize=100000, index=False)
print(f"Loaded {len(df_trips)} rows to green_taxi_trips table")

# Load zones data
print("Loading zones data...")
df_zones = pd.read_csv('taxi_zone_lookup.csv')
df_zones.to_sql(name='zones', con=engine, if_exists='replace', index=False)
print(f"Loaded {len(df_zones)} rows to zones table")

print("Data ingestion completed!")