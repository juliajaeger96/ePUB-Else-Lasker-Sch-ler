# ePUB-Else-Lasker-Sch-ler

Das Projekt umfasst einen ePUB-Prototyp. Die Ausgangsdateien, die in XML-Form vorliegen, beinhalten eine Transkription ausgewählter Briefe Else Lasker-Schülers, wobei insbesondere der Aspekt der Brief-Kommentierung berücksichtigt und modelliert wurde.
Der Workflow besteht aus mehreren XSLT-Stylesheets, die sowohl die Generierung der Metadaten als Tabellen, als auch die Transformation aller Block- und Inlineelemente beinhalten.

Mithilfe von XML-Pipelines, die mit der XML-Sprache XProc erstellt wurden, werden alle Quelldateien eingelesen und nacheinander transformiert. Jede Realisierung der Kommen-tierungen stellen ein XSLT-Stylesheet dar, die in die Pipeline integriert werden.
Nachdem alle e-PUB-Dateien er-zeugt und in ein ZIP-Archiv ge-packt21 wurden, wird das E-Book syntaktisch mit dem Prüfprogramm EpubCheck überprüft. Um das ePUB mehrmals auf formale Korrektheit zu kontrollieren, wird sowohl die Überprüfung als auch die Generierung einer Pro-tokolldatei in eine Batchdatei geschrieben.

## Ordnerstruktur: 

### input: 
    beinhaltet die obengenannten XML-Ausgangsdateien

### result:
    beinhaltet die ePUB-Dateien in richtiger Reihenfolge

### epubcheck-4.2.5:
    beinhaltet Prüfprogramm sowie Log-Datei

