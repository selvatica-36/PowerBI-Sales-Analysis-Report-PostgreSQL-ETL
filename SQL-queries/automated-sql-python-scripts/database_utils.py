import json
import psycopg2
import csv
import os


class DatabaseConnector:
    def __init__(self, config_file_path, output_folder):
        self.config_file_path = config_file_path
        self.output_folder = output_folder

    def read_config(self):
        with open(self.config_file_path, 'r') as config_file:
            return json.load(config_file)
        
    def connect_to_database(self, connection_params):
        conn = psycopg2.connect(**connection_params)
        return conn
    
    def define_cursor(self):
        cursor = self.connect_to_database.cursor()
        return cursor
    
    def close_cursor(self):
        return self.define_cursor.close()
    
    def close_connection(self):
        return self.connect_to_database.close()


class InfoExtractor(DatabaseConnector):
    def __init__(self, config_file_path, output_folder):
        super.__init__(config_file_path, output_folder)

    def export_table_columns_to_csv(self, cursor, table_name, csv_path):
        with open(csv_path, "w", newline="") as csv_file:
            csv_writer = csv.writer(csv_file)
            # Get column names and data types
            cursor.execute(f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{table_name}'")
            columns = cursor.fetchall()
            csv_writer.writerow(["Column Name", "Data Type"])  # Write custom column headers
            csv_writer.writerows(columns)

    def export_all_table_columns(self):
        connection_params = self.read_config()
        with self.connect_to_database(connection_params) as conn:
            with conn.cursor() as cursor:
                tables = self.get_table_list(cursor)
                # Loop through each table and export its columns to a CSV file
                for table in tables:
                    csv_path = os.path.join(self.output_folder, f"{table}_columns.csv")
                    self.export_table_columns_to_csv(cursor, table, csv_path)

    

if __name__ == "__main__":
    output_folder = '/Users/silviaaragon/Aicore/Online-Shopping-in-Retail-Report/SQL-queries/database-info'
    exporter = InfoExtractor(output_folder=output_folder)
    exporter.export_all_table_columns()