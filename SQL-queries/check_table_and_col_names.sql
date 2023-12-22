-- Extract table list
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Extract column list and data types for Orders table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders';
-- the query above is automated in script 'extract_column_names.py' for all tables