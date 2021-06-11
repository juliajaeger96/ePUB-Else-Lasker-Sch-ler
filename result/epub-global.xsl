<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <!-- Werkmetadaten imporieren -->
    <xsl:import href="epub-werk.xsl">
    </xsl:import>
    <!-- Globale Variablen definieren -->
    <!-- Pfade und Dateinamen -->
    <!-- OPF -->
    <xsl:variable name="opfFolder">
        <xsl:text>OEBPS/</xsl:text>
    </xsl:variable>
    <xsl:variable name="opfFile">
        <xsl:text>content.opf</xsl:text>
    </xsl:variable>
    <!-- OPS -->
    <!-- eventuell nicht nötig -->
    <xsl:variable name="coverFile">
        <xsl:text>cover.xhtml</xsl:text>
    </xsl:variable>
    <xsl:variable name="containerFolder">
        <xsl:text>META-INF/</xsl:text>
    </xsl:variable>
    <xsl:variable name="containerFile">
        <xsl:text>container.xml</xsl:text>
    </xsl:variable>
    <xsl:variable name="coverImgFile">
        <xsl:text>cover.jpeg</xsl:text>
    </xsl:variable>
    <xsl:variable name="navFile">
        <xsl:text>nav.xhtml</xsl:text>
    </xsl:variable>
    <!-- Bilderordner -->
    <xsl:variable name="ImageFolder">
        <xsl:text>Images/</xsl:text>
    </xsl:variable>
    <!-- CssOrdner -->
    <xsl:variable name="CSSFolder">
        <xsl:text>Styles/</xsl:text>
    </xsl:variable>
    <!-- XHMTLOrdner -->
    <xsl:variable name="HTMLFolder">
        <xsl:text>Text/</xsl:text>
    </xsl:variable>
    
</xsl:stylesheet>