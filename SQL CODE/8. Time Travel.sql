//Setting up table

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test (
  id int,
  first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string)


 CREATE OR REPLACE FILE FORMAT MANAGE_DB.file_formats.csv_file
    type = csv
    field_delimiter = ','
    skip_header = 1
    
CREATE OR REPLACE STAGE MANAGE_DB.external_stages.time_travel_stage
    URL = 's3://data-snowflake-fundamentals/time-travel/'
    file_format = MANAGE_DB.file_formats.csv_file;
    

LIST @MANAGE_DB.external_stages.time_travel_stage;


COPY INTO OUR_FIRST_DB.public.test
from @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv');


SELECT * FROM OUR_FIRST_DB.public.test;

// Use-case: Update data (by mistake)

UPDATE OUR_FIRST_DB.public.test
SET FIRST_NAME = 'Joyen' ;

// // // Using time travel: Method 1 - 2 minutes back
SELECT * FROM OUR_FIRST_DB.public.test at (OFFSET => -60*2);

TRUNCATE OUR_FIRST_DB.public.test;

ALTER SESSION SET TIMEZONE = 'UTC';
SELECT  CURRENT_TIMESTAMP;

//2024-06-11 14:47:08.280 +0000


UPDATE OUR_FIRST_DB.public.test
SET Job = 'Data Scientist'

SELECT * FROM OUR_FIRST_DB.public.test;

SELECT * FROM OUR_FIRST_DB.public.test before (timestamp => '2024-06-10 14:50:14.146'::timestamp);

//Altering table (by mistake)
UPDATE OUR_FIRST_DB.public.test
SET EMAIL = null 

SELECT * FROM OUR_FIRST_DB.public.test;

//01b4eafd-3201-1b9c-0009-0772000220fe
SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b4eafd-3201-1b9c-0009-0772000220fe');


// // // Bad Method

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test as
SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b4eafd-3201-1b9c-0009-0772000220fe')

SELECT * FROM OUR_FIRST_DB.public.test;

//01b4eb09-3201-1b5f-0009-077200021472

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test as
SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b4eafd-3201-1b5c-0009-07720001d826')


// // // Good Method

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test_1 as
SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b4eafd-3201-1b9c-0009-0772000220fe')

TRUNCATE INTO OUR_FIRST_DB.public.test;

INSERT INTO OUR_FIRST_DB.public.test
SELECT * FROM OUR_FIRST_DB.public.test_1;


