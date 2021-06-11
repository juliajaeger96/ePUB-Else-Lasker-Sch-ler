<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:f="http://whatever"
    xmlns:epub="http://www.idpf.org/2007/ops"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
   <xsl:import href="XHTML.xsl"/>
    <xsl:mode on-no-match="shallow-copy"/>
   
<!-- Fußnoten erstellen -->
   
    <xsl:template match="pb[1]">
        <xsl:next-match/>
        <h1>Darstellung mit Fußnoten</h1>
        
    </xsl:template>
    <!-- für jedes note-Tag wird eine Fußnote erstellt, jedoch mit footnoteref-->
    <xsl:template match="note">
        <a epub:type="noteref">
            <xsl:attribute name="id">
                <xsl:text>footnoteref</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#footnote</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            <sup><xsl:number level="any" count="note" format="[1]"/></sup>
            
           
        </a>
        
    </xsl:template>
    <!-- Kommentare werden in eine Liste geschrieben -->
    <xsl:template match="note" mode="footnote">
        <li epub:type="footnote">
            <a>
                <xsl:attribute name="id">
                    <xsl:text>footnote</xsl:text><xsl:number level="any" count="note" format="1"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#footnoteref</xsl:text><xsl:number level="any" count="note" format="1"/>
                </xsl:attribute>
                <sup><xsl:number level="any" count="note" format="[1]"/></sup>
            </a>
            
           
            <xsl:apply-templates/>
            <xsl:if test="@source">
            <a>
                <xsl:attribute name="href" select="concat('Register.xhtml#', substring-after(@source, '#'))"></xsl:attribute>
                Quelle
            </a>
            </xsl:if>
        </li>
    </xsl:template>
    
    <!-- nach dem letzten <div> wird die Fußnotenliste geschrieben -->
    <xsl:template match="(div[@n])[last()]">
        
           <xsl:next-match />
        <hr></hr>
           <section epub:type="part"> 
               <ol class="footnotes">
                  <xsl:apply-templates select="//note" mode="footnote"/>
               </ol>
            </section>
        
    </xsl:template>

    
</xsl:stylesheet>
    
