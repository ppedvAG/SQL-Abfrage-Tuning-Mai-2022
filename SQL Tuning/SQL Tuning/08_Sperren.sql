--Sperrniveau

/*
jede Sperre kostet ca 90 bytes

je nach Menge der Datensätze variert SQL Server das Sperrniveau
allerdings nur wenn IX vorhanden sind.....sonst bleibt es immer Tabellenniveau
(Asnahme : Partitionierung)


DB 
TAB 
BLOCK  
SEITE 
Zeile --nur bei IX

Möglichkeiten Sperren zu umgehen 

Transaktionslevel auf READ UNCOMMITTED   eher ungünstig
Momentaufnahmenisolation (Zeilenversionierung) und READ COMMITTED SNAPSHOT altivieren (keine LeseSperrre mehr bei Änderungen)

