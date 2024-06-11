CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test (
  id int,
  first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string)


  COPY INTO OUR_FIRST_DB.public.test
from @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv');


SELECT * FROM OUR_FIRST_DB.public.test;

// Use-case: Update data (by mistake)

UPDATE OUR_FIRST_DB.public.test
SET FIRST_NAME = 'Joyen' ;

UPDATE OUR_FIRST_DB.public.test
SET Job = 'Data Scientist'

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
