<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <!-- globale Variablen importieren -->
   <xsl:import href="epub-global.xsl"/>
   
    <xsl:output method="xml" name="container" encoding="UTF-8" version="1.0" indent="no"></xsl:output>
    <xsl:template match="text()"></xsl:template>
    <xsl:template match="/">
       
       <!-- Container Stylesheet -->
        <!-- xsl:result-document wird in der Xproc-Pipeline durch p:store ersetzt -->
        <!-- <xsl:result-document href="result/{$containerFolder}{$containerFile}" format="container"> -->
            <container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
                <rootfiles>
                    <rootfile full-path="{$opfFolder}{$opfFile}" media-type="application/oebps-package+xml"/>
                </rootfiles>
            </container>
           <!-- </xsl:result-document> -->
    </xsl:template>
</xsl:stylesheet>