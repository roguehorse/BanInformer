#!/bin/bash
#
# fail2ban filter script 3
#
# Scan fail2ban log for banned IP's
# and report only those IP's which
# match the current date.
# 
# Fri Mar 27 10:33:40 PDT 2015
# Written by: Scott DuBois

# fail2ban log file
log=/var/log/fail2ban.log

# date results to variable
ymd=$(date +%Y-%m-%d)
hm=$(date +%H:%M)

# verify file exists
if [ -f $log ]; then

 # create file to work with
 echo "bans3                    $hm" > /home/scott/Bans/bans3.txt
 printf "==============================\n" >> /home/scott/Bans/bans3.txt 

 # read each line from file separately
 while read -r line

  do

   bans=$line

    # check to see if dates match
    today=$(echo $bans | grep $ymd | grep Ban)

     if [ X"$today" != X"" ]; then 

      # extract necessary data
      banIP=$(echo $today | cut --delimiter=' ' --fields=1,6,7)

      # print date relative lines 
      echo $banIP >> /home/scott/Bans/daily.txt
     
     else

      printf "Server time has rolled over...\n" > /home/scott/Bans/daily.txt  
     
     fi
  
  done < $log

  # sort the file
  sort -n /home/scott/Bans/daily.txt > /home/scott/Bans/bansx.txt

  # add the sorted info to the report file
  cat /home/scott/Bans/bansx.txt >> /home/scott/Bans/bans3.txt

  # remove working files
  rm /home/scott/Bans/daily.txt /home/scott/Bans/bansx.txt

else

 echo "fail2ban is totally empty\n" >> /home/scott/Bans/bans3.txt

fi

# End of script
