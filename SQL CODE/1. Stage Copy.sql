CREATE OR REPLACE DATABASE MANAGE_DB;

CREATE OR REPLACE SCHEMA external_stages;

//Creating external stage
CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage 
url = 's3://snowflake-db-tutorial-mythili'
credentials=(aws_key_id='AKIA47CRZUIIXLUMGNUN'
aws_secret_key='gBgJ5Y3Y2keWug1rJFV5O5PJOd3pt77944jN0GtL');

//Description of external stage
DESC STAGE MANAGE_DB .external_stages.aws_stage;

//Alter external stage 
ALTER STAGE aws_stage
 SET credentials=(aws_key_id='xyz_dummy_id' aws_secret_key='678xyz');


 //publicly accessible staging area
 CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage 
  url='s3://bucketsnowflakes3';
  

   LIST @aws_stage;

   //Creating ORDERS table
   CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS(
      ORDERS_ID VARCHAR(30),
      AMOUNT INT,
      PROFIT INT,
      QUANTITY INT,
      CATEGORY VARCHAR(30),
      SUBCATEGORY VARCHAR(30)
   );
   
SELECT * FROM MANAGE_DB.PUBLIC.ORDERS;

COPY INTO MANAGE_DB.PUBLIC.ORDERS
FROM @aws_stage
file_format=(type= csv field_delimiter="," skip_header=1)
files=('OrderDetails.csv');

//Transformation in SnowFlake while loading

CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS_EX(
 ORDER_ID VARCHAR(30),
 AMOUNT INT
);

COPY INTO MANAGE_DB.PUBLIC.ORDERS_EX
FROM (SELECT s.$1, s.$2 FROM  @MANAGE_DB.external_stages.aws_stage s)
file_format=(type= csv field_delimiter="," skip_header=1)
files=('OrderDetails.csv');

SELECT * FROM MANAGE_DB.PUBLIC.ORDERS_EX;


CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS_EX1(
 ORDER_ID VARCHAR(30),
 AMOUNT INT,
 PROFIT INT,
 CATEGORY_SUBSTRING VARCHAR(255)
);

COPY INTO MANAGE_DB.PUBLIC.ORDERS_EX1
  FROM (select 
         s.$1,
         s.$2,
         s.$3,
         CASE WHEN CAST(s.$3 as int)< 0 then 'not profitable' else 'profitable' end 
        from @MANAGE_DB.external_stages.aws_stage s)
      file_format=(type= csv field_delimiter="," skip_header=1)
      files=('OrderDetails.csv');
  

SELECT * FROM  MANAGE_DB.PUBLIC.ORDERS_EX1;