import json
import psycopg2
import csv
import os


# Read database connection parameters from config.json
with open('settings.json', 'r') as settings_file:
    connection_params = json.load(settings_file)

# Connect to the database
conn = psycopg2.connect(**connection_params)
cursor = conn.cursor()

# Get the path to the folder where you want to save CSV files
output_folder = '/Users/silviaaragon/Aicore/Online-Shopping-in-Retail-Report/SQL-queries'

# Get a list of tables in the database
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
tables = [row[0] for row in cursor.fetchall()]

# Loop through each table and export its columns to a CSV file
for table in tables:
    cursor.execute(f"COPY (SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{table}') TO STDOUT WITH CSV HEADER;")
    csv_path = os.path.join(output_folder, f"{table}-columns.csv")
    with open(csv_path, "w", newline="") as csv_file:
        csv_writer = csv.writer(csv_file)
        csv_writer.writerow([desc[0] for desc in cursor.description])  # Write column headers
        csv_writer.writerows(cursor)


# Close the database connection
cursor.close()
conn.close()


