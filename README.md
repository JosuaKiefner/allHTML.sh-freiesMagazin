#allHTML.sh freiesMagazin
Eine Online-Verson finden sie unter folgendem Link: https://josuakiefner.github.io/allHTML.sh-freiesMagazin/start.html

##Funktionen
* Herunterladen aller im HTML-Format verfügbaren Ausgaben von <a target="_blank" href="freiesmagazin.de">freiesMagazin</a>, wahlweise mit oder ohne Bilder
* Sortieren der Dateien nach Jahrgang und Ausgabe
* Anpassung der Seiten zur lokalen Nutzung und zur Nutzung auf Mobilgeräten
* Extrahieren der einzelnen Artikelthemen und Verwendung dieser in der Seitenbeschreibung, auf der Startseite sowie in der Seitenbeschreibung bei den Suchergebnissen
* Indexierung aller Ausgaben mithilfe externer Programme und Implementierung einer auf externen JavScript-Skripten basierten Suchfunktion, welche auch ohne Webserver genutzt werden kann
* optionale Komprimierung der einzelnen Jahrgänge und der zusätzlichen Seiten und Skripte im .zip und/oder im .tar.gz-Format

##Ergebnisse
Die heruntergeldenen und angepassten Inhalte inklusive der Suchfunktion können auf verschiedene Arten bezogen werden:
* Ausführen von allHTML.sh: 
** Herunterladen des Skriptes mit den zusätzlichen Dateien aus den <a target="_blank" href="freiesmagazin.de">Releases</a>
** Extrahieren
** ausführbar machen mit (sudo) chmod 777 allHTML.sh (Root-Rechte werden benötigt)
** Jahrgänge werden am selben Ort wie allHTML.sh gespeichert
* Herunterladen der komprimierten Jahrgänge von der <a target="_blank" href="https://github.com/JosuaKiefner/allHTML.sh-freiesMagazin/releases">Releases-Seite</a>
* Klonen des Repositories, welches in /docs die Dateien der Online-Version enthält

##Abhängigkeiten
* cd
* cp
* echo
* exit
* jre
* mkdir
* mv
* ping
* bash-compatible shell
* rm
* sed
* wget
* zip

#verwendete Projekte
* <a target="_blank" href="freiesmagazin.de">freiesMagazin</a> (Inhalte)
* <a target="_blank" href="https://github.com/Myria-de/xsl-webhelpindexer">xsl-webhelpindexer</a> aus dem <a target="_blank" href="http://docbook.sourceforge.net/">DocBook Project</a>, bezogen von <a target="_blank" href="http://www.pcwelt.de/ratgeber/Indexsuche-fuer-die-Website-9963262.html">PC-WELT</a> (Indexierung und Suchfunktion)
* <a target="_blank" href="jquery.com">jquery</a> sowie <a target="_blank" href="jquerymobile.com">jquery mobile</a> (JavaScript-Bibliotheken)

##Lizenz
Die Lizenz zusätzlicher Software von Drittanbietern kann variieren

Copyright © 2016 Josua Kiefner
Copyleft <img src="Copyleft.svg.png" height=12.5em> 2016 Josua Kiefner

Dieses Programm ist Freie Software: Sie können es unter den Bedingungen
der GNU General Public License, wie von der Free Software Foundation,
Version 3 der Lizenz oder (nach Ihrer Wahl) jeder neueren
veröffentlichten Version, weiterverbreiten und/oder modifizieren.

Dieses Programm wird in der Hoffnung, dass es nützlich sein wird, aber
OHNE JEDE GEWÄHRLEISTUNG, bereitgestellt; sogar ohne die implizite
Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK.
Siehe die GNU General Public License für weitere Details.

Sie sollten eine Kopie der GNU General Public License zusammen mit diesem
Programm erhalten haben. Wenn nicht, siehe <http://www.gnu.org/licenses/>.


start.html, searchresult.html, freiesMagazin (Copyright freiesMagazin) sowie das Logo von freiesMagazin (erstellt von Arne Weinberg) sind lizenziert unter einer <a target="_blank" rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/" class="ui-link">Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International Lizenz</a>.
