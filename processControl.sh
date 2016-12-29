#!/bin/bash

while true; do
      echo "=====================Active Processes=====================";
      ps -l | awk '{ printf "%s\t%s\t%s\n",$4,$8,$14 }'; ##Display active process with Priority 
      echo "==========================================================";
      echo "Enter process ID:";
      read process_id;
      echo "---------------------------";
      echo "Press 1 to Change Priority."
      echo "Press 2 to Hangup.";
      echo "Press 3 to Termination.";
      echo "Press 4 to Stop exuction.";
      echo "Press 5 to Kill.";
      echo "Press 0 to exit.";
      echo "---------------------------";
      echo "Enter number:"
      read input;
      case $input in
        1)
            echo "Enter Priority:";
            read priority;
       
            if [ "$priority" -gt 20 ]; then 
                echo "Priority Must below 20"
            else
             if [ "$priority" -lt -20 ]; then 
                echo "Priority above -20"
                else
                    renice -n $priority -p $process_id;
                    echo "Priority has been edited LOOK";
                fi
            fi

        ;;
        2)
            kill -SIGHUP $process_id;
            echo "Process Hanguped"; 
        ;;
        3)
            kill -SIGTERM $process_id;
            echo "Process Terminated"; 
        ;;
        4)
            kill -SIGSTOP $process_id;
            echo "Process Stoped"; 
        ;;
        5)
            kill -SIGKILL $process_id;
            echo "Process Killed"; 
        ;;
        0)
            exit
        ;;
      esac
done
