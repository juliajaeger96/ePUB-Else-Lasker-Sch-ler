<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" html-version="5.0" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Stylesheet für Überschriften  -->
    <!-- Reihenfolge der Überschriften wird verändert -->
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
   
    <xsl:template match="h1" />
    
    <xsl:template match="h2[last()]">
        <xsl:copy-of select="../h1"/>  
        <xsl:copy-of select="."/>
              
    </xsl:template>
</xsl:stylesheet>
