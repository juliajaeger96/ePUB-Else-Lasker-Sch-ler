<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:epub="http://www.idpf.org/2007/ops" 
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
    
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:output method="xhtml" html-version="5.0" encoding="UTF-8"/>
    <!-- Fußnoten für das Register erstellen -->
    
   <!-- für jeden Eintrag bestimmen, der eine Kommentierung besitzt-->
    <!-- für jede Kommentierung wird eine Fußnote erstellt, jedoch mit footnoteref-->
    <xsl:template match="td[@about[.!='']]">
        
               <td> <a>
                    <xsl:attribute name="id">
                        <xsl:text>footnoteref</xsl:text><xsl:number level="any" count="td[@about[.!='']]" format="1"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>#footnote</xsl:text><xsl:number level="any" count="td[@about[.!='']]" format="1"/>
                    </xsl:attribute>
                   <sup><xsl:number level="any" count="td[@about[.!='']]" format="[1]"/></sup>
                    
                    
                </a>
                <xsl:value-of select="@class"/>
               </td>
        
        
        
        
    </xsl:template>
 
    <!-- Kommentare werden in eine Liste geschrieben -->
    <xsl:template match="td[@about[.!='']]" mode="footnote">
        
        <li>
            <a>
                <xsl:attribute name="id">
                    <xsl:text>footnote</xsl:text><xsl:number level="any" count="td[@about[.!='']]" format="1"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#footnoteref</xsl:text><xsl:number level="any" count="td[@about[.!='']]" format="1"/>
                </xsl:attribute>
                <xsl:number level="any" count="td[@about[.!='']]" format="[1]"/>
            </a>
            
            
            <xsl:apply-templates/>
            <xsl:if test="@about != 'no'">
                <a>
                    <xsl:attribute name="href" select="@about"></xsl:attribute>
                    Quelle
                </a>
            </xsl:if>
        </li>
    </xsl:template>
    
    <!-- nach dem letzten <div> wird die Fußnotenliste geschrieben -->
    <xsl:template match="(div)[last()]">
        
        <xsl:next-match />
        <hr></hr>
        <section epub:type="part"> 
            <ol class="footnotes">
                <xsl:apply-templates select="//td[@about[.!='']]" mode="footnote"/>
            </ol>
        </section>
        
    </xsl:template>
    
    

    
    
</xsl:stylesheet>