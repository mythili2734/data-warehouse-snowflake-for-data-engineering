//Create table first
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.employees(
 id INT,
 first_name STRING,
 last_name STRING,
 email STRING,
 location STRING,
 department STRING 
) 

//Create file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;

 // Create stage object with integration object & file format object
CREATE OR REPLACE stage MANAGE_DB.external_stages.csv_folder
    URL = 's3://snowflake-db-tutorial-mythili/snowpipe/'
    STORAGE_INTEGRATION = s3_init
    FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat
   
LIST @MANAGE_DB.external_stages.csv_folder;

//Create schema to keep thing organized
CREATE OR REPLACE SCHEMA MANAGE_DB.pipes

CREATE OR REPLACE pipe MANAGE_DB.pipes.employee_pipe
auto_ingest = TRUE
AS 
COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_folder

DESC pipe MANAGE_DB.pipes.employee_pipe;

SELECT * FROM  OUR_FIRST_DB.PUBLIC.employees;

SHOW PIPES;

SHOW PIPES like '%employee%'

SHOW PIPES in database MANAGE_DB

SHOW PIPES in schema MANAGE_DB.pipes

SHOW PIPES like '%employee%' in Database MANAGE_DB



