--Sperrniveau

/*
jede Sperre kostet ca 90 bytes

je nach Menge der Datens�tze variert SQL Server das Sperrniveau
allerdings nur wenn IX vorhanden sind.....sonst bleibt es immer Tabellenniveau
(Asnahme : Partitionierung)


DB 
TAB 
BLOCK  
SEITE 
Zeile --nur bei IX

M�glichkeiten Sperren zu umgehen 

Transaktionslevel auf READ UNCOMMITTED   eher ung�nstig
Momentaufnahmenisolation (Zeilenversionierung) und READ COMMITTED SNAPSHOT altivieren (keine LeseSperrre mehr bei �nderungen)

