--Sperrniveau

/*
jede Sperre kostet ca 90 bytes

je nach Menge variert SQL Server das Sperrniveau
allerdings nur wenn IX vorhanden sind.....sonst bleibt es immer Tabellenniveau
(Asnahme : Partitionierung)


DB 
TAB 
BLOCK  
SEITE 
Zeile --nur bei IX

M�glichkeiten Sperren zu umgehen 

TRansaktionslevel auf READ UNCOMMITTED   eher ung�nstig
Momentaufnahmenisolation (Zeilneversionierung) und READ COMMITTED SNAPSHOT altivieren (keine LeseSperrre mehr bei �nderungen)

