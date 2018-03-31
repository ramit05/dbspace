import boto3
import os, json, sys
import datetime
import time
from datetime import datetime
from datetime import date

s3 = boto3.resource('s3')
s3_client = boto3.client('s3')
bucket_name = 'xxxxx'
s3_cache_folder = 'yyyyy/'

def s3_list_files():
    #try:
        # S3 Get List of all Files
        list_objects = s3_client.list_objects(Bucket=bucket_name, Prefix=s3_cache_folder)    
        list_files_using_keys = list_objects['Contents'][1:]    
        # Convert List into Dictionary
        oldusers = dict()
        for ud in list_files_using_keys:
            oldusers[ud.pop('Key')] = ud
        # List of all Files in S3
        list_files = list(oldusers.keys())
        print(list_files)
        #list_files_names = [i.split('/', 1)[1] for i in list_files] # Seprate file name as per the conventions
        #list_files_date = [i.split('T', 1)[0] for i in list_files_names] # Seprate file name as per the conventions
        #print(list_files_date)
    #except:
        #print ('Error')
        
def s3_download_file():
    #try:
        #S3 Connection and Downloading Date.json     
        #current_date is a object in this case
        KEY = 'yyyyy/{0}.json'.format(current_date)
        response = s3.Bucket(bucket_name).download_file(KEY, '/tmp/{0}.json'.format(current_date))            
        print(response)
        #return True
    #except botocore.#exceptions.ClientError as client_error:
        if exception.response['ResponseMetadata']['HTTPStatusCode'] == '400':
            print('S3 Downloading File Failed')
        else:
            print('Error Downloading S3 file')        
            
def find_s3_file():
    # Check the file is present or not
    #try:
        # Emp Id and Current Date are objects
        s3_file_path = 'zzzz/xxxx={0}/{1}.json'.format(emp_id,current_date)
        response = s3.Object(bucket_name, s3_file_path).load()
        return response
    #except botocore.#exceptions.ClientError as client_error:
        print(client_error.response)
        if client_error.response['Error']['Code'] == "404":
            print("The file does not exist.")
            create_emp_file(s3_current_date)
        else:
            print ('Error')
            
