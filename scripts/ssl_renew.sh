#!/bin/bash

LOG_FILE="/var/log/ssl_renew.log"
CERTBOT_CMD="certbot renew --quiet --post-hook 'systemctl reload nginx'"

echo "Starting SSL renewal process..." >> $LOG_FILE
echo "Timestamp: $(date)" >> $LOG_FILE

# Run certbot renewal
if $CERTBOT_CMD >> $LOG_FILE 2>&1; then
    echo "SSL renewal successful!" >> $LOG_FILE
else
    echo "SSL renewal failed!" >> $LOG_FILE
fi

echo "------------------------------" >> $LOG_FILE
