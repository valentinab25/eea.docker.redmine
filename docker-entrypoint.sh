#!/bin/bash
set -e

# Add env to cronjobs
if [ ! -z "$SYNC_API_KEY" ]; then
  sed -i "s|SYNC_API_KEY|$SYNC_API_KEY|" ${REDMINE_LOCAL_PATH}/crons/cronjobs
else
  # Remove
  sed -i "s|-k SYNC_API_KEY||" ${REDMINE_LOCAL_PATH}/crons/cronjobs
fi

if [ ! -z "$SYNC_REDMINE_URL" ]; then
  sed -i "s|SYNC_REDMINE_URL|$SYNC_REDMINE_URL|" ${REDMINE_LOCAL_PATH}/crons/cronjobs
else
  # Remove
  sed -i "s|-r SYNC_REDMINE_URL||" ${REDMINE_LOCAL_PATH}/crons/cronjobs
fi

if [ ! -z "$SYNC_GITHUB_URL" ]; then
  sed -i "s|SYNC_GITHUB_URL|$SYNC_GITHUB_URL|" ${REDMINE_LOCAL_PATH}/crons/cronjobs
else
  # Remove
  sed -i "s|-g SYNC_GITHUB_URL||" ${REDMINE_LOCAL_PATH}/crons/cronjobs
fi

# Start crond
crontab -u redmine ${REDMINE_LOCAL_PATH}/crons/cronjobs
cron

# Run redmine entry-point
exec /redmine-entrypoint.sh "$@"