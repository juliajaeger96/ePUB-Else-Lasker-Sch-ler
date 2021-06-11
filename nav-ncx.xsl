<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:import href="epub-global.xsl"/>
    <xsl:output method="xml" name="ncx" encoding="UTF-8" version="1.0" indent="yes" doctype-public="-//NISO//DTD ncx 2005-1//EN" doctype-system="http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"></xsl:output>
    <xsl:template match="text()"></xsl:template>
    <xsl:template match="/">
        <!-- <xsl:result-document href="result/{$opfFolder}nav.ncx" format="ncx"> -->
        <!-- Nav.ncx für epub2-Format -->
            <ncx
                xmlns="http://www.daisy.org/z3986/2005/ncx/"
                version="2005-1"
                xml:lang="de">
                <head>
                    <!-- Dieselbe Buchidentifikation wie in der OPF-Datei: -->
                    <meta name="dtb:uid" content="{$dcIdentifier}"/>
                    <meta name="dtb:depth" content="-1" />
                    <meta name="dtb:totalPageCount" content="0" />
                    <meta name="dtb:maxPageNumber" content="0" />
                </head>
                <!-- Dokumentitel -->
                <docTitle>
                    <text>
                        <xsl:value-of select="$dcTitle"/>
                    </text>
                </docTitle>
                <!-- NavMap -->
                <navMap id="hierarchie">
                    <xsl:for-each select="collection(concat('result/',$opfFolder,$HTMLFolder,'?select=*.xhtml'))">
                   <!--   <xsl:if test="tokenize(base-uri(.), '\.|/')[last() - 1] != 'nav'">-->
                   <navPoint>
                       <xsl:attribute name="playOrder" select="position()"></xsl:attribute>
                      
                       <xsl:attribute name="id" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                       <navLabel>
                           <text>
                               <xsl:value-of select="tokenize(base-uri(.), '\.|/')[last() - 1]"/>
                           </text>
                       </navLabel>
                       <content>
                           <xsl:attribute name="src" select="concat('Text/', tokenize(base-uri(.), '/')[last()])"></xsl:attribute>
                       </content>
                   </navPoint>
                        <!--   </xsl:if>-->
                 </xsl:for-each>
                </navMap>
            </ncx>
            
            <!--</xsl:result-document> -->
    </xsl:template>
</xsl:stylesheet>