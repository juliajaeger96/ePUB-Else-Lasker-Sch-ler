<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:import href="epub-global.xsl"/>
    <xsl:output method="text" name="mimetype" encoding="UTF-8" version="1.0"></xsl:output>
    <xsl:template match="text()"></xsl:template>
    <xsl:template match="/">
        <!-- Mimetype Stylesheet  -->
        <!-- xsl:result-document wird in der Xproc-Pipeline durch p:store ersetzt -->
        <!-- <xsl:result-document href="result/mimetype" format="mimetype"> -->
        <!-- das root-Element wird für Xproc hinzugefügt, das durch p:store method ="text" wieder ignoriert wird
        Mit der Verwendung von xsl:result-document muss root-Element rausgelöscht werden!-->
        <root>
            <xsl:text>application/epub+zip</xsl:text></root>
        <!--  </xsl:result-document>-->
    </xsl:template>
</xsl:stylesheet>