HM585 - Modul for Homematic Wired (HM485) communication
=======================================================
Von Dirk Hoffmann <dirk@FHEM_Forum (forum.fhem.de)>

V 0.0.2

HM585 ist ein Modul für FHEM um mit den Homemaic Wired Modulen komunizieren zu können.
Homematic Wired bassiert auf der RS485 Schnittstelle.

History:
-----------
V0.0.1 - Initiale Version
V0.0.2 - Überarbeitete Version mit eigenem Prozess

RS485 Hardware:
--------------
Derzeit benutzte und getestete RS485 Adapter:
- DIGITUS DA-70157: USB-Serial Adapter mit RS485 Schnittstelle, Funktioniert auch an der FritzBox, ca. 11€ bei Reichelt
  http://www.reichelt.de/USB-Konverter/DIGITUS-DA-70157/3//index.html?ARTICLE=122187

- Wiznet - WIZ108SR Compact RS422/RS485-to-Ethernet module
  http://tigal.at/product/2276
  http://forum.fhem.de/index.php?t=msg&th=14096&start=0&rid=0

- HMW-LAN-GW (der Test ist noch nicht bestätigt)
  http://www.elv.de/homematic-rs485-gateway-1.html

Installation:
- Der Inhalt vom Branch kommt in das Verzeichniss /FHEM/

- Je nach verwendetem Interface existiert eine Beispiel cfg-Datei
	USB -> RS485 Konverter:      fhem_SERIAL.cfg
	Netzwerk -> RS485 Konverter: fhem_WIZ108SR.cfg
	HMW-LAN-GW:                  fhem_HMW-LAN-GW.cfg

### TODOs ###

Derzeit wird nur das Senden von RAW-Befehlen unterstützt.

- Hardware Protokoll (HM485_SerialServer.pl)
	x Sendframe
	x SendQueue
	x SendFrame über eigenen Prozess
	x Discovery über eigenen Prozess
	x ack nach parse frame
	x Discovery: Bekannte Geräte nicht mit als neu anzeigen

- FHEM-Intervace-Modul (00_HM485_LAN.pm)
	x timeout zum Starten des HM485d als Attribut hinzugefügt. Ggf. muss dieser
	  auf langsamen Geräten (Fritzbox, Raspberry Pi) erhöht werdenst.
	- discovery nur ausführen wenn das interface verbunden ist
	- Timeout nach dem der Discovery mode automatisch abgebrochen wird.
	
	x Duplicate frame detection
	x model anhand von config setzen
	x Senden während discovery verhindern (globales lock?)
	x event nach discovery und autocreate

	- ctrl-byte richtig setzen
	- txState für Line richtig setzen bzw. interpretieren
	- Beim RAW Senden ggf. fremde Absenderadressen angeben können bzw. verbieten
	- firmware update der Module
