import boto3

submissionsBucketName = os.environ['submissionsBucketName']

s3 = boto3.resource('s3')

download_files = "sample-fies/" + fetch
fetch = "sample.json"

try:
          logging.info("Started downloading contents to s3 {}".format(download_files));
          response = s3.Bucket(submissionsBucketName).put_object(Key=download_files, Body=filename1_data_file)
          logging.info("Completed downloading contents to s3 {}".format(download_files));        
except Exception as e:
          logging.exception('Error downloading data to s3')
          raise e
