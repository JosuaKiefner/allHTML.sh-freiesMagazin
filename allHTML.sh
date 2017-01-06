#!/bin/sh

# C O P Y R I G H T 2016 Josua Kiefner

# L I C E N S E
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

# A U T H O R : Josua Kiefner

# D E P E N D E N C I E S : cd, cp, echo, exit, jre, mkdir, mv,  ping, shell similiar to the bash, rm, sed, wget, zip

# P U R P O S E : This script downloads all in the html format available issues of freiesMagazin. It also moves the additonal files to another folder and adjusts it's links in the html file. allHtml.sh adapts the sites for display on mobile devices, extracts the issue's topics and puts them to the site description, the start page and the description of the search results. Furthermore, it indexes all issues with the help of external programms and implements the search function with external scripts based on java script so it can be searched offline. Finally, it packs all the files in seperated .tar.gz archives for easy redistribution.

#SETTINGS (1=yes, 0=no)
pictures=1
wgetQuiet=1
#SETTINGSEND


folderEnd=""
urlEnd=.html

#checking for internet connection
ping -q -c 3 freiesmagazin.de
if [ $? -ne 0 ]; then
    echo "ERROR: Please ensure that you have a functionating internet connection"
    exit
else
    echo "Internet connection detected."
fi

echo "Please ensure that you have at least 300MB of free disk storage."

#adapting parameter depending on settings
if [ "$pictures" == "1" ]; then
	folderEnd="-bilder$folderEnd"
	urlEnd="-bilder$urlEnd"
	bilder=-bilder
fi
if [ "$wgetQuiet" == "1" ]; then
	wget="-q"
fi

#creating array with names of months
months[1]="Januar"
months[2]="Februar"
months[3]="März"
months[4]="April"
months[5]="Mai"
months[6]="Juni"
months[7]="Juli"
months[8]="August"
months[9]="September"
months[10]="Oktober"
months[11]="November"
months[12]="Dezember"

for year in {2008..2016}
do
	#adapting url and folder paths
	urlStart="http://www.freiesmagazin.de/mobil/freiesMagazin-$year-"
	folderStart="freiesMagazin-$year-html"
	
	#creating folder for each year
    mkdir ${folderStart}${folderEnd}
	cd ${folderStart}${folderEnd}
	
	#adding necessary elements to the start page
	echo "<div data-role=\"collapsible\">" >> ../start.html
	echo "<h3>$year</h3>" >> ../start.html
	
	for i in {1..12}
	do
		#adding zero in front of months smaller than ten
		if [ "$i" -lt "10" ]; then
            ii="0$i"
		else
            ii="$i"
		fi
		
		#downloading issue
		wget $wget -nd -p --convert-links ${urlStart}${ii}${urlEnd}
		echo "Month $ii/$year downloaded."
		
		#moving additional files to an extra folder and adjusting it's links in the html file
		mkdir freiesMagazin-$year-$ii$bilder-Dateien
		mv *.jpg freiesMagazin-$year-$ii$bilder-Dateien
		mv *.png freiesMagazin-$year-$ii$bilder-Dateien
		sed -i "s/<img src=\"/<img src=\"freiesMagazin-$year-$ii$bilder-Dateien\//g" freiesMagazin-$year-$ii$urlEnd
		sed -i "s/<img border=\"0\" src=\"/<img border=\"0\" src=\"freiesMagazin-$year-$ii$bilder-Dateien\//g" freiesMagazin-$year-$ii$urlEnd
		cp ../search/css/fm_mobil_2016_05.css .
		mv *.css* freiesMagazin-$year-$ii$bilder-Dateien
		sed -i '/<link type=\"text\/css\" rel=\"stylesheet\" href=\"/g d' freiesMagazin-$year-$ii$urlEnd		
		
		#copying the website content to another file to extract it's topics
		cp freiesMagazin-$year-$ii$urlEnd $year-$ii
		sed -i '1,/>Inhalt</ d' $year-$ii
        if [ "$year" == "2012" ] && [ $i == 12 ]; then
            sed -i "/>Zum Index</,$ d" $year-$ii
        elif [ "$year" == "2015" ] && [ $i == 4 ]; then
            sed -i "/>Zum Inhaltsverzeichnis</,$ d" $year-$ii
        elif [ "$year" == "2016" ] && [ $i == 9 ]; then
            sed -i "/>Zum Inhaltsverzeichnis</,$ d" $year-$ii
        else
            sed -i "/>Impressum</,$ d" $year-$ii
		fi
		
		echo "Impressum" >> $year-$ii
		sed -i '/<div.*/ d' $year-$ii
		sed -i '/<b>.*/ d' $year-$ii
		sed -i 's/href=\".*.\">//g' $year-$ii
		sed -i 's/<a //g' $year-$ii
		sed -i 's/<.*.>//g' $year-$ii
		sed -i '/^$/ d' $year-$ii
		
		#replacing newlines with the seperator
		for s in {1..7}
		do
		sed -i '/$/ {
		N
		s:\n: | :
		}' $year-$ii
		#    ___ By replacing this underlined part in the previous line before the previous line you can change the seperator in the topic String used for site description and the direct link on the startpage
		done
		
		#special cases for getting the topics
		if [ $year == 2008 ] && [ $i == 7 ]; then
        echo "Acer stellt ,,Aspire one'' vor | Mozilla Firefox 3 hat die Ziellinie erreicht | Opera 9.5 freigegeben | OOXML vorerst auf Eis gelegt - Sieg für ODF | Distributionen aktuell | LGP führt Kopierschutz ein | ICQ-Probleme mit alternativen Clients | Baumeister für Ubuntu | Kernel-Rückblick | Spielen-unter-Linux.de feiert zweijähriges Bestehen | Kurztipp: BrettSpielWelt | Tipps und Tricks für den Alltag mit Linux | Expertenecke: Das Kommando ,,ls'' | Das Erscheinungsbild von Google Earth anpassen | Linpus Linux Lite - Ein Betriebssystem für mobile Computer | Was ist Barrierefreiheit und wozu überhaupt? | Barrierefreies GNU/Linux? | Veranstaltungen | Editorial | Leserbriefe | Konventionen | Impressum" > 2008-07
        fi
        
        if [ $year == 2013 ] && [ $i == 11 ]; then
        echo "Ubuntu Touch ausprobiert | Der Oktober im Kernelrückblick | Äquivalente Windows-Programme unter Linux – Teil 1: Office-Programme | Eigener Cloud-Dienst: Seafile-Server auf Raspberry Pi installieren | Einführung in concrete5 | Ceph | Rückblick: Ubucon 2013 in Heidelberg | Rezension: Das Buch zu Android Tablets | Rezension: Grundkurs C++ | Rezension: Shell-Programmierung: Das umfassende Handbuch | Veranstaltungskalender | Vorschau | Konventionen | Impressum" > 2008-07
        fi
		
		#recreation of spaces
		sed -i 's/\&nbsp\;/ /g' $year-$ii
		
		#converting transfered / and & in order not to clash with the special characters of sed
		sed -i 's/\&amp\;/THISISANAND/g' $year-$ii
        sed -i 's/\//THISISASLASH/g' $year-$ii
		
		#reading topics file to variable
		topics=$(cat $year-$ii)
		
		#checking either topic list is more than "Impressum" (if it's not, this issue isn't available)
		if [ "$topics" == "Impressum" ]; then
            echo "Ausgabe nicht verfügbar." > $year-$ii
            topics=$(cat $year-$ii)
        fi
		
		if [ $year == 2008 ] || [ $year == 2009 ] && [ $i -lt 9 ]; then
            #adding viewport-media tag
            sed -i "s/<html>/<html>\\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" \/>/" freiesMagazin-$year-$ii$urlEnd
            #adding newest css-stylesheet
            sed -i "s/<html>/<html>\\n<link type=\"text\/css\" rel=\"stylesheet\" href=\"freiesMagazin-$year-$ii$bilder-Dateien\/fm_mobil_2016_05.css\" \/>/" freiesMagazin-$year-$ii$urlEnd
            #adding content_idx tag
            sed -i "s/<\/title>/<\/title>\\n<div id=\"content_idx\">/" freiesMagazin-$year-$ii$urlEnd
            sed -i "s/<\/html>/<\/div>\\n<\/html>/" freiesMagazin-$year-$ii$urlEnd
            #adding topics to description tag
            sed -i "s/<html>/\<html>\\n<meta name=\"description\" content=\"$topics\" \/>/" freiesMagazin-$year-$ii$urlEnd
            #adding tag for correct encoding
            sed -i "s/<html>/<html>\\n<meta http-equiv=\"Content-Type\" content=\"text\/html\; charset\=utf-8\" \/>/" freiesMagazin-$year-$ii$urlEnd
                                                                                                                                                                                    
		else
            #deleting and adding viewport-media tag
            sed -i '/<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" \/>/ d' freiesMagazin-$year-$ii$urlEnd
            sed -i "s/<head>/<head>\\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" \/>/" freiesMagazin-$year-$ii$urlEnd
            #adding newest css-stylesheet
            sed -i "s/<\/head>/<link type=\"text\/css\" rel=\"stylesheet\" href=\"freiesMagazin-$year-$ii$bilder-Dateien\/fm_mobil_2016_05.css\" \/>\\n<\/head>/" freiesMagazin-$year-$ii$urlEnd
            #adding content_idx tag
            sed -i "s/<\/head>/<\/head>\\n<div id=\"content_idx\">/" freiesMagazin-$year-$ii$urlEnd
            sed -i "s/<\/body>/<\/div>\\n<\/body>/" freiesMagazin-$year-$ii$urlEnd
            #adding tag for correct encoding
            sed -i "s/<head>/<head>\\n<meta http-equiv=\"Content-Type\" content=\"text\/html\; charset\=utf-8\" \/>/" freiesMagazin-$year-$ii$urlEnd
            if [ $year -lt 2012 ]; then
                #adding topics to description tag
                sed -i "s/<head>/\<head>\\n<meta name=\"description\" content=\"$topics\" \/>/" freiesMagazin-$year-$ii$urlEnd
            else
                #adding topics to description tag
                sed -i "s/<meta name=\"description\" content=\"Magazin rund um Linux und Open Source\" \/>/\<meta name=\"description\" content=\"$topics\" \/>/" freiesMagazin-$year-$ii$urlEnd
            fi
        fi
		
		#reconverting / and &
		sed -i 's/THISISASLASH/\//g' freiesMagazin-$year-$ii$urlEnd
		sed -i 's/THISISANAND/\&/g' freiesMagazin-$year-$ii$urlEnd
		
		#getting name of month
		month=${months[$i]}
		
		#putting topics to the start site and link to it's issue
        echo "<a href=\"${folderStart}${folderEnd}/freiesMagazin-$year-$ii$urlEnd\" target=\"_blank\">$month</a>" >> ../start.html
        echo "<p>$topics</p>" >> ../start.html
		
		echo "Month $ii/$year proceeded."
		
	done
	#adding necessary element to the start site
	echo "</div>" >> ../start.html
	
	echo "Year $year downloaded and proceeded."
	
	cd ..
	
done

#adding necessary elements to the start page
echo "<p>Diese Seite wurde mithilfe des bash-Skriptes allHTML.sh, Copyright 2016 Josua Kiefner und lizenziert unter der GNU GPL v3, erstellt. Die Suchfunktion entstammt dem xsl-webhelpindexer und dem DocBook project. Für weitere Informationen, siehe <a target=\"_blank\" href=\"https://github.com/JosuaKiefner/allHTML.sh-freiesMagazin\">github.com/JosuaKiefner/allHTML.sh-freiesMagazin</a>.</p>" >> start.html
echo "<p>Diese Seite, freiesMagazin (Copyright freiesMagazin) sowie das Logo von freiesMagazin (erstellt von Arne Weinberg) sind lizenziert unter einer <a target=\"_blank\" rel=\"license\" href=\"http://creativecommons.org/licenses/by-sa/4.0/\">Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International Lizenz</a>.</p>" >> start.html
echo "</div>" >> start.html
echo "</body>" >> start.html
echo "</html>" >> start.html

#indexing the issues of freiesMagazin
echo "Indexing started..."
./indexer.sh
echo "Indexing finished."

#putting full topics string to HtmlFileInfoList.js
for year in {2008..2016}
do
    #adjusting folder path
    folderStart="freiesMagazin-$year-html"
    
    cd ${folderStart}${folderEnd}
    
    for i in {1..12}
	do
        
        #adding zero in front of months smaller than ten
        if [ "$i" -lt "10" ]; then
            ii="0$i"
		else
            ii="$i"
		fi
		
		#recreation of spaces
		sed -i 's/\&nbsp\;/ /g' $year-$ii
		
		#converting transfered / and & in order not to clash with the special characters of sed 
		sed -i 's/\&amp\;/THISISANAND/g' $year-$ii
        sed -i 's/\//THISISASLASH/g' $year-$ii
		
        #reading topics file to variable
		topics=$(cat $year-$ii)
		
		#inserting full topics string to HtmlFileInfoList.js
		sed -i "s/freiesMagazin $ii\/$year\@\@\@.*.\"\;/freiesMagazin $ii\/$year\@\@\@$topics\"\;/g" ../search/htmlFileInfoList.js
		
		#removing topics and robots files
		rm $year-$ii
		rm *.txt
		rm *.txt*
    done
    cd ..
done

#reconverting / and &
sed -i 's/THISISASLASH/\//g' search/htmlFileInfoList.js
sed -i 's/THISISANAND/\&/g' search/htmlFileInfoList.js

sed -i 's/THISISASLASH/\//g' start.html
sed -i 's/THISISANAND/\&/g' start.html

#packing every year in seperate .tar.gz archive
echo "Packing all files in .tar.gz archives."
for year in {2008..2016}
do
folderStart="freiesMagazin-$year-html"
tar cvzf ${folderStart}${folderEnd}.tar.gz ${folderStart}${folderEnd}
zip -r ${folderStart}${folderEnd}.zip ${folderStart}${folderEnd}
done

#packing files for search function in .tar.gz archive
tar cvzf freiesMagazin-Suche.tar.gz search start.html searchresult.html
zip -r freiesMagazin-Suche.zip search start.html searchresult.html

echo "Congratulations! allHTML.sh finished it's job and now it's up to you to make the best out of it."
