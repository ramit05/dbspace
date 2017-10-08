import sys, json
import logging
import rds_config
import pymysql
import boto3

rds_host  = "YOUR_HOSTNAME"
name = rds_config.db_username
password = rds_config.db_password
db_name = "DB_NAME"

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=15)
except:
    logger.error("ERROR: Unexpected error: Could not connect to MySql instance.")
    sys.exit()

logger.info("SUCCESS: Connection to RDS mysql instance succeeded")

def handler(event, context):
	with conn.cursor() as cur:
		cur.execute("""YOUR_QUERY_HERE""")
	
	#S3 Connection and uploading data
	client = boto3.client('s3')
	response = client.put_object(Bucket='YOUR_S3_BUCKET_NAME',Key='NAME_OF_FILE_TO_BE_UPDATED', Body = #data variable content to be updated with file in S3)
	return "success!"	

