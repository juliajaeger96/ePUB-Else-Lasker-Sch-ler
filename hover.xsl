<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:f="http://whatever"
    
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
    <xsl:import href="XHTML.xsl"></xsl:import>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Kommentare als Mouseover -->
    
    <xsl:template match="pb[1]">
        <xsl:next-match/>
        <h1>Darstellung mit Mouseover</h1>
        
    </xsl:template>
    <!-- für jedes note-Tag wird ein a-Tag mit Span-Tag (Text der Kommentierung) erstellt -->
    <xsl:template match="note">
        <a>
            <xsl:attribute name="id">
                <xsl:text>hover</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            <xsl:attribute name="class" select="'tip'"></xsl:attribute>
            
            <sup><xsl:number level="any" count="note" format="[1]"/></sup>
            <span>
                <xsl:value-of select="node()"/>
            </span>
        </a>
       
    </xsl:template>
</xsl:stylesheet>