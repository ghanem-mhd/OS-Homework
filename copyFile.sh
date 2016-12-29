#!/bin/bash

##First  paramter is directory for first file.
##Second paramter is name of first file.
##Thired  paramter is directory for second file.
##Forth paramter is name of second file.

function printFilesDetiels (){
    printf "%-40s%-15s%-15s%-15s%-15s\n" $"----" $"-------" $"-----------" $"----------" $"-----------";
    printf "%-40s%-15s%-15s%-15s%-15s\n" $"Name" $"Size(b)" $"Permessions" $"Line Count" $"Words Count";
    printf "%-40s%-15s%-15s%-15s%-15s\n" $"----" $"-------" $"-----------" $"----------" $"-----------";
    
    ls -l $1 | awk '{printf "%-40s%-15s%-15s",$9,$5,$1}'; 
    printf "%-15s" $(wc -l < $1); 
    printf "%-15s\n" $(wc -l < $1);
    
    ls -l $2 | awk '{printf "%-40s%-15s%-15s",$9,$5,$1}'; 
    printf "%-15s" $(wc -l < $2); 
    printf "%-15s\n" $(wc -l < $2);   
}

##First  paramter is dir_file_path.
##Second paramter is file name.
##Thired paramter is file_full_path
function makeCopy(){
     file_name_without_extention=$(basename "$2" | cut -d. -f1);
     file_extention=$(basename "$2" | cut -d. -f2);
     ##check directory to previous copy and get the number of last copy
     max_copy_number=$(find dir -name "$file_name_without_extention[0-9]*" | sort  | tail -1 | tr  -d '[A-Za-z\/.]');
     max_copy_number=$((max_copy_number + 1))
     new_copy_name=$file_name_without_extention$max_copy_number.$file_extention;
     cp $3 $1/$new_copy_name; 
     
     ##Extra print files detiels after copy 
     printFilesDetiels $1/$2 $1/$new_copy_name
     
}

echo "Enter File Name:"
read input_file_name;

file_name=$(basename "$input_file_name") ## In case the input was with input_dir_path; we get name from this command and store it in variable
file_full_path=$(readlink -f "$file_name") ## also we get input_dir_path; and store it in variable

if [[ ! -f $file_full_path ]];then ##check if this file exist 
    echo "No such file";
    exit ##finish script
fi
    

echo "Enter directory path:"
read input_dir_path;

dir_file_path=$input_dir_path/$file_name;

if [[ -f $dir_file_path  ]]; then
        echo "Another file with the same name aleady exist.";
        echo "---------------------------------------------";
        echo "Press 1 to Replace File.";
        echo "Press 2 to Keep Both File";
        echo "Press 3 to Show info for Both Files";
        echo "Press 4 to cancel Copy";

        read input;
        case $input in
            1)
            echo "Do you want to repace it (Y/N)?";
             read ans;
            if [[ $ans =~ ^(Yes|yes|Y|y)$ ]]; then
                rm $dir_file_path; ##Delete Old File 
                cp $file_full_path $input_dir_path;
              else
                echo "File not Replaced.";
            fi
            ;;
            2)
                makeCopy $input_dir_path $file_name $file_full_path
            ;;
            3)
                printFilesDetiels $file_full_path  $dir_file_path 
            ;;
            4)
                exit;
            ;;
        esac
else
    cp $file_full_path $input_dir_path;    
    chmod 775 $dir_file_path
fi
exit