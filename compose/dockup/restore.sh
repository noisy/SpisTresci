#!/bin/bash
source /envs

# Find last backup file
: ${last_backup:=$(aws s3 ls s3://$DOCKUP_S3_BUCKET_NAME | awk -F " " '{print $4}' | grep ^$DOCKUP_BACKUP_NAME | sort -r | head -n1)}

# Download backup from S3
aws s3 cp s3://$DOCKUP_S3_BUCKET_NAME/$last_backup $last_backup

# Extract backup
tar xzf $last_backup $DOCKUP_RESTORE_TAR_OPTION
