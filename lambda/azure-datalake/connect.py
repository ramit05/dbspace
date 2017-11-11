import os
## Use this only for Azure AD service-to-service authentication
from azure.common.credentials import ServicePrincipalCredentials

## Use this only for Azure AD end-user authentication
from azure.common.credentials import UserPassCredentials

## Use this only for Azure AD multi-factor authentication
from msrestazure.azure_active_directory import AADTokenCredentials

## Required for Azure Data Lake Store account management
from azure.mgmt.datalake.store import DataLakeStoreAccountManagementClient
from azure.mgmt.datalake.store.models import DataLakeStoreAccount

## Required for Azure Data Lake Store filesystem management
from azure.datalake.store import core, lib, multithread

# Common Azure imports
from azure.mgmt.resource.resources import ResourceManagementClient
from azure.mgmt.resource.resources.models import ResourceGroup

## Use these as needed for your application
import logging, getpass, pprint, uuid, time

# Import CSV processor
import csv

from csv import DictReader

adlsAccountName = 'PASTE-YOUR-ACCOUNT-NAME'

token = lib.auth(tenant_id='PASTE-YOUR-TENANT-ID', client_secret='PASTE-YOUR-CLIENT-SECRET', client_id='PASTE-YOUR-CLIENT-ID')

adl = core.AzureDLFileSystem(token, store_name=adlsAccountName)
