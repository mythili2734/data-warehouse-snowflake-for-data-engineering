// Creating external stage (create your own bucket)
CREATE OR REPLACE STAGE SCD_DEMO.SCD2.customer_ext_stage
    url='s3://snowflake-db-tutorial-mythili/stream_data/'
    credentials=(aws_key_id='AKIA47CRZUII6OG2T5P2' aws_secret_key='y+LtAjddYjzh+dEnrH1fQMdkrHSrooNIgDRda12W');
   

CREATE OR REPLACE FILE FORMAT SCD_DEMO.SCD2.CSV
TYPE = CSV,
FIELD_DELIMITER = ","
SKIP_HEADER = 1;

SHOW STAGES;
LIST @customer_ext_stage;


CREATE OR REPLACE PIPE customer_s3_pipe
  auto_ingest = true
  AS
  COPY INTO customer_raw
  FROM @customer_ext_stage/customer_20240614090737.csv 
  FILE_FORMAT = CSV
  ;

show pipes;
select SYSTEM$PIPE_STATUS('customer_s3_pipe');

SELECT count(*) FROM customer_raw limit 10;

TRUNCATE  customer_raw;