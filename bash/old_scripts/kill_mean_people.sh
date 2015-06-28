IPT=/usr/sbin/iptables
MEAN_FILE="/scripts/mean_people_unique.txt"
echo "get mean people"
cat /var/log/messages | grep "sshd" | grep "Failed" | cut -d " " -f 13 | grep "[0-9]\.[0-9]" | sort | uniq > $MEAN_FILE

echo "Killing mean people begins"
COUNT=0
while read p; do
	$IPT -A INPUT -s  $p -j DROP
	echo $p "is dead!"
	let COUNT=COUNT+1
done < $MEAN_FILE
echo $COUNT  "mean people are now dead!"

