DATE=$(date +%y%m%d)
FILE=archive$DATE.tar.gz
CONFIG_FILE=./archive/Files_To_Backup #配置文件
DESTINATION=./archive/$FILE

#检查配置文件存不存在
if [ -f $CONFIG_FILE ]; then
	echo
else 
	echo
	echo "$CONFIG_FILE does not exist."
	echo "Backup not completed due to missing Configuration File."
	echo 
	exit
fi

#备份
FILE_NO=1
exec < $CONFIG_FILE
read FILE_NAME

while [ $? -eq 0 ]; do
	#statements
	if [ -f $FILE_NAME -o -d $FILE_NAME ]; then
			#文件存在，添加到列表
			FILE_LIST="$FILE_LIST $FILE_NAME"
	else 
			echo
			echo "$FILE_NAME, does not exist"
			echo "Obviously, i will not include it in this archive"
			echo "it is listed on line $FILE_NO of the config file"
			echo "Continuing to build archive list ...."
			echo
	fi	

	FILE_NO=$[$FILE_NO + 1]
	read FILE_NAME
done

echo "Starting archive"
echo
tar -czf $DESTINATION $FILE_LIST 2> /dev/null

echo "archive complited."
echo "Resulting archive file is : $DESTINATION"
echo

exit





