#!/bin/bash
#
# fail2ban filter script
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

# verify file exists
if [ -f $log ]; then

 # read each line from file separately
 while read -r line

  do

   bans=$line

    # check to see if dates match
    today=$(echo $bans | grep $ymd | grep Ban)

     if [ X"$today" != X"" ]; then 

      # print date relative lines 
      echo $today

     fi
  
  done < $log

 else

  printf "Nothing Today\n"

fi

# End of script
