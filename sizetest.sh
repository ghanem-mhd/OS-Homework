#!/bin/bash

function makeArchive(){    
    cd $1;                                  ##go to the path of selected dirctory
    archive_dir=$(readlink -f ..);          ##get parent dirctory
    dir_name=$(basename $1);                ##get name with extention of file.
    archive_name=$dir_name"_archive";       ##set archive file name to be file name _ archive keywrord.
    cd ..;                                  ##change current dirctory to archive_dir;
    mkdir $archive_name                     ##nake new archive dirctory 
    cp -r $1/. $archive_name                ##copy to archive dirctory
    tar czf $archive_name.tar.gz $archive_name; ##create archive
}

max_size=$(expr 4 \* 1024 \* 1024);
echo "Enter Directory Path:"

read dir_path_input;

while true; do
    file_size=$(du -b $dir_path_input | cut -f1)
    if [[ $file_size -gt $max_size ]]; then
        makeArchive $dir_path_input;     ##make archive file
        exit
    else
        echo "Size = $(du -h $dir_path_input | cut -f1) < 4 Mb"
    fi
    sleep 60;
done

