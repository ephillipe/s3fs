#!/bin/bash 

# Configuration
# -------------
# BUCKET: The S3 bucket to sync
# AWS_ACCESS_KEY: The access key to use for S3
# AWS_SECRET_KEY: The secret key to use for S3

export AWSACCESSKEYID=$AWS_ACCESS_KEY
export AWSSECRETACCESSKEY=$AWS_SECRET_KEY

/usr/bin/s3fs -o allow_other -o use_cache=/tmp $BUCKET /data

echo "/data *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
#echo "/data *(rw,async,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports

chmod 777 /etc/sv/nfs/run
chmod 777 /etc/sv/nfs/finish
chmod 777 /etc/exports


# On HOST:
# sudo modprobe nfs && sudo modprobe nfsd

# Example:
# docker run --name s3fs -d --net=host --privileged -e BUCKET=XXX -e AWS_ACCESS_KEY=XXX -e AWS_SECRET_KEY=XXX misakai/s3fs


runsvdir /etc/sv