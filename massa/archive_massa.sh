#!/bin/bash

# Get the hostname of the server
hostname=$(hostname)

# Create the archives
tar -czvf massa_backup_11.x_${hostname}.tar.gz massa_11.back
tar -czvf massa_backup_19.x_${hostname}.tar.gz massa_backup19.x
tar -czvf massa_backup_20.x_${hostname}.tar.gz massa_backup

# Move the archives to the /tmp folder
mv massa_backup_11.x_${hostname}.tar.gz /tmp/
mv massa_backup_19.x_${hostname}.tar.gz /tmp/
mv massa_backup_20.x_${hostname}.tar.gz /tmp/
