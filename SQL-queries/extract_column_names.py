import json
import psycopg2
import csv
import os


# Read database connection parameters from config.json
with open('settings-copy.json', 'r') as settings_file:
    connection_params = json.load(settings_file)

# Connect to the database
conn = psycopg2.connect(**connection_params)
cursor = conn.cursor()

# Get the path to the folder where you want to save CSV files
output_folder = '/Users/silviaaragon/Aicore/Online-Shopping-in-Retail-Report/SQL-queries/database-info'

# Get a list of tables in the database
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
tables = [row[0] for row in cursor.fetchall()]

# Loop through each table and export its columns to a CSV file
for table in tables:
    csv_path = os.path.join(output_folder, f"{table}_columns.csv")
    with open(csv_path, "w", newline="") as csv_file:
        csv_writer = csv.writer(csv_file)
        # Get column names and data types
        cursor.execute(f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{table}'")
        columns = cursor.fetchall()
        csv_writer.writerow(["Column Name", "Data Type"])  # Write custom column headers
        csv_writer.writerows(columns)

# Close the database connection
cursor.close()
conn.close()
