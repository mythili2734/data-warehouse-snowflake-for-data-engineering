
### Real-Time Data Streaming using Apache NiFi, AWS, Snowpipe, and Snowflake Streams and Tasks

This project demonstrates to build a robust and scalable data pipeline that can generate, store, process, and analyze data streams in real-time. By leveraging the capabilities of AWS, Snowflake, and Apache NiFi, this pipeline aims to automate data flows, ensure data integrity, and provide immediate analytical insights.


### Architecture:


![Architecture for snowflake](https://github.com/mythili2734/data-warehouse-snowflake-for-data-engineering/assets/158598007/f5cead9c-7681-4803-8c63-37eeae93c0fe)

### Technologies Used:

1. *AWS:*  Amazon Web Services provides cloud computing services for storing data and running applications.
2. *Snowflake:*  A cloud-based data warehousing platform for data storage and analysis.
3. *Apache NiFi:* An open-source data integration platform that facilitates the automation of data flow between systems.
4. *Docker:* Used for containerization of applications and services for easy deployment.
5. *Python Faker Library:* Generates fake data for testing and development purposes.


#### Pipeline Overview

1. *Data Generation:*
   - Use the Python Faker library to generate fake data for testing and development purposes.

2. *Data Storage:*
   - Store the generated data in AWS S3.

3. *Data Processing:*
   - Use Snowpipe, Stream, Task to automatically ingest the data from S3 into Snowflake .

4. *Data Analysis:*
   - Analyze the ingested data in Snowflake to gain real-time insights.
  

### Project Execution Flow:

1. *EC2 Setup:*
   - Connect to EC2 instance using SSH.
   - Copy project files to EC2 instance.
  
3. *Docker Installation:*
    - Update the Software.
    - Install Docker on the EC2 instance.
    - Install Docker Compose.
    - Grant execution permission to Docker Compose.
    - Install pip.
    - Install Docker Compose pip package.
  
4. *Docker Configuration:*
    - Create your docker-compose.yml file and store it in a folder with the .pem file.
    - Copy files to EC2.
    - Check Docker installation.
    - Start Docker.
    - Verify Docker container is running.
  
5. *Running Docker Compose:*
    - Navigate to the docker-compose directory.
    - Pull images and start services.

6. *Security Group Configuration:*
    - Update inbound rules for EC2 instance.
    - Add Custom TCP rules for specific port numbers defined in docker-compose.yml.
  
7. *Accessing Services:*
    - Access Jupyter Notebook via EC2 public DNS and port 4888.
    - Access Apache NiFi via EC2 public DNS and port 2080.
  
8. *Data Generation with Jupyter:*
    - Generate fake data using Faker module in Jupyter Notebook.
    - Store fake data in CSV format.

9. *NiFi Configuration:*
     - Connect to NiFi container.
     - Navigate to the generated fake data file.
     - Configure the NiFi job:
     - Create a processor group with ListFile, FetchFile, and PutS3Object processors.
     - Configure the processors with appropriate settings.

10. *Snowflake Setup:*
      - Create tables for customer data.
      - Create a stream on the customer table.
      - Set up stage on the S3 bucket.
      - Create Snowpipe on the stage to copy files into customer_raw table.
   
11. *Snowpipe and AWS SQS Integration:*
      - Configure Snowpipe notification channel.
      - Create an event notification in AWS with necessary details.
   
12. *Handling Data Changes:*
      - Create a procedure for incremental data.
      - Use MERGE statements for upsert operations.
      - Automate the procedure with Tasks.
      - Create roles and provide necessary permissions.
      - Schedule tasks to run the procedure at specified intervals.
   
13. *Data Analysis:*
      - Analyze the data stored in Snowflake for real-time insights.
      - Utilize Snowflake features for data querying, manipulation, and visualization.
    


#### Conclusion:

This project demonstrates the end-to-end process of real-time data analysis using AWS, Snowflake, and NiFi. By integrating these technologies, organizations can efficiently manage and analyze large volumes of data, enabling informed decision-making and insights generation. The automation capabilities provided by Snowflake tasks and NiFi streamline the data processing pipeline, enhancing efficiency and scalability.
