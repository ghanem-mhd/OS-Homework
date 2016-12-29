#!/bin/bash

echo "Enter File Path:";
read file_path;

modify_time=$(stat -c "%Y" $file_path);
backup_file_dir=~/Desktop/backup.txt;
touch $backup_file_dir; 

while true; do
    last_time_modified=$(stat -c "%Y" $file_path);
    ##if date modified greater than las date modified and if file is not currntly opend 
    if [ $last_time_modified -gt $modify_time ] && [ -z "$(lsof $file_path)" ]; then 
        modify_time=$last_time_modified;
        cat $file_path >> $backup_file_dir; ##append content of file to backup file.
        >$file_path;                        ##clear file.
    fi
    sleep 30;
done