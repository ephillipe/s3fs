#!/bin/bash 

# Configuration
# -------------
# BUCKET: The S3 bucket to sync
# AWS_ACCESS_KEY: The access key to use for S3
# AWS_SECRET_KEY: The secret key to use for S3

export AWSACCESSKEYID=AWS_ACCESS_KEY
export AWSSECRETACCESSKEY=AWS_SECRET_KEY

/usr/bin/s3fs -o allow_other -o use_cache=/tmp $BUCKET /data

#  CMD ["/bin/bash", "/app/deploy.sh"]