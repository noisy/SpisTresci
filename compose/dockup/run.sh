#!/bin/bash

export AWS_ACCESS_KEY_ID=${DOCKUP_AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${DOCKUP_AWS_SECRET_ACCESS_KEY}
export AWS_DEFAULT_REGION=${DOCKUP_AWS_DEFAULT_REGION}

export > /envs

if [[ "$DOCKUP_RESTORE" == "true" ]]; then
  ./restore.sh
else
  ./backup.sh
fi

if [ -n "$DOCKUP_CRON_TIME" ]; then
  echo "${DOCKUP_CRON_TIME} /backup.sh >> /dockup.log 2>&1" > /crontab.conf
  touch /dockup.log
  crontab  /crontab.conf
  echo "=> Running dockup backups as a cronjob for ${DOCKUP_CRON_TIME}"
  rsyslogd
  cron
  tail -f /var/log/syslog /dockup.log
fi
