#!/bin/bash
source /envs
export PATH=$PATH:/usr/bin:/usr/local/bin:/bin
# Get timestamp
: ${backup_siffix:=.$(date +"%Y-%m-%d-%H-%M-%S")}
readonly tarball=$DOCKUP_BACKUP_NAME$backup_siffix.tar.gz

# Create a gzip compressed tarball with the volume(s)
tar czf $tarball $DOCKUP_BACKUP_TAR_OPTION $DOCKUP_PATHS_TO_BACKUP

# Create bucket, if it doesn't already exist
bucket_exist=$(aws s3 ls | grep $DOCKUP_S3_BUCKET_NAME | wc -l)
if [ $bucket_exist -eq 0 ];
then
  aws s3 mb s3://$DOCKUP_S3_BUCKET_NAME
fi

# Upload the backup to S3 with timestamp
aws s3 --region $DOCKUP_AWS_DEFAULT_REGION cp $tarball s3://$DOCKUP_S3_BUCKET_NAME/$tarball

# Clean up
rm $tarball
