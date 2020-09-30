#!/bin/bash
file1=data/get_tenki.csv #today
file2=data/get_tenki2.csv #tomorrow
rm $file1 $file2
echo "Getting weather data..."
python3.8 get_tenki.py
if [[ -f $file1 ]]; then
    sed -i -e 's/---/0/g' $file1
    for(( i=1; i<=2; i++ ))
    do
	#fix data on file1
	sed -i -e 's/(%),//; s=(m/s),==' $file$i
	#sed -i -e 1's/.*/#&/' $file1 #either this or header=None in python
	sed -i -e 3's/.*/気温,&/' $file$i
	sed -i -e 6's/.*/降水量,&/' $file$i
	rm $file$i-e
    done
else
    echo $file1 "Does NOT exist"
fi
#cat $file1 $file2
echo "Formatting data..."
python3.8 plot_tenki.py
echo "done"
#sed -i -e 's/(%),//g' $file1
#sed -i -e 's=(m/s),==g' $file2
#fix data on file2
#sed -i -e 1's/.*/#&/' $file2
#sed -i -e 3's/.*/気温,&/' $file2
#sed -i -e 6's/.*/降水量,&/' $file2
#rm $file1-e* $file2-e*

