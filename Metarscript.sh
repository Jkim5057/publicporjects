#!/bin/bash

#metar data analysis for independent pilots/aviation industry

#Environmental data analysis

#Batch processing potential with scripts that enable scaling

printf "Report type:   "
egrep -o 'METAR|SPECI' metar.txt
printf "Airport code: "
egrep -o '\sK[A-Z]{3}\s' metar.txt
#
day=$( egrep -o '\s[0-9]{6}Z\s' metar.txt | cut -c2-3 )
hour=$( egrep -o '\s[0-9]{6}Z\s' metar.txt | cut -c4-5 )
minute=$( egrep -o '\s[0-9]{6}Z\s' metar.txt | cut -c6-7 )
printf "This report was generated on day: %d at %d:%d Zulu hours" $day $hour $minute
#
windDir=$( egrep -o '\s[0-9]{5}(G[0-9]{2})?KT\s' metar.txt | cut -c2-4 )
windSpd=$( egrep -o '\s[0-9]{5}(G[0-9]{2})?KT\s' metar.txt | cut -c5-6 )
printf "\nWinds are from %d degrees at %d Knots" $windDir $windSpd
#
gustFlag=$( egrep -o '\s[0-9]{5}(G[0-9]{2})?KT\s' metar.txt | cut -c7-7 )
if [ "$gustFlag" = "G" ]; then
   gustSpd=$( egrep -o '\s[0-9]{5}(G[0-9]{2})?KT\s' metar.txt | cut -c8-9 )
   printf "\nWinds are gusting at %d Knots" $gustSpd
fi
#
varWinds=$( egrep -o '\s[0-9]{3}V[0-9]{3}\s' metar.txt )
if [ -n "$varWinds" ]; then
   dir1=$( egrep -o '\s[0-9]{3}V[0-9]{3}\s' metar.txt | cut -c2-4)
   dir2=$( egrep -o '\s[0-9]{3}V[0-9]{3}\s' metar.txt | cut -c6-8)
   printf "\nWinds are variable from %s degrees to %s degrees" $dir1 $dir2
fi

cor_auto=$( egrep -o '\s(AUTO|COR)\s' metar.txt )
if [ "$cor_auto" = " COR " ]; then
  printf "This is a corrected observation "
elif [ "$cor_auto" = " AUTO " ]; then
  printf "\nThis is an automatic  report."        
fi

visibility=$( egrep -o '\s[0-9]{2}SM\s' metar.txt | cut -c1-3)
printf "\nYour visibility is: %d miles" $visibility

rain=$( egrep -o '\s.?RA\s' metar.txt )
if [ "$rain" = " +RA " ]; then
  printf "\nHeavy rains reported in the area"
elif [ "$rain" = " -RA " ]; then
  printf "\nLight rain reported in the area "
elif [ "$rain" = " RA " ]; then
  printf "\nRain is been reported in the area."
fi
few=$(egrep -o 'FEW[0-9]{3}' metar.txt)
if [ -n "$few" ]; then
  printf "few clouds reported "
fi
sctd=$(egrep -o 'SCT[0-9]{3}' metar.txt)
if [ -n "$sctd" ]; then
  printf "scattered clouds reported "
fi
brkn=$(egrep -o 'BKN[0-9]{3}' metar.txt)
if [ -n "$brkn" ]; then
  printf "broken clouds reported "
fi

ovct=$(egrep -o 'OVC[0-9]{3}' metar.txt)
if [ -n "$ovct" ]; then
  printf "overcast clouds reported "         
fi
temp=$(egrep -o '[0-9]{2}//?M[0-9]{2}' metar.txt | cut -c1-2)
printf "\n The Temperature is %d degrees Celsius" $temp
dew=$(egrep -o '[0-9]{2}//?M[0-9]{2}' metar.txt | tr -d M | cut -c4-5)
printf "\nThe Dew Point is %d degrees Celsius" $dew

altimeter=$( egrep -o '\sA[0-9]{4}\s' metar.txt | cut -c3-4 )
altimeterinches=$( egrep -o '\sA[0-9]{4}\s' metar.txt | cut -c5-6 )
printf "\nThe Altimeter Reads: %d.%d inches of mercury" $altimeter $altimeterinces

TH=$( egrep -o '\sTH\s' metar.txt )
if [ -n "$TH" ]; then
printf "\nThunderstorms reported in the area"
fi
