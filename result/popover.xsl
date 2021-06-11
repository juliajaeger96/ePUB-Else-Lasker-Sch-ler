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
    <xsl:import href="XHTML.xsl"></xsl:import>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Kommentare als Popup -->
    
    <xsl:template match="pb[1]">
        <xsl:next-match/>
        <h1>Darstellung mit Popover</h1>
        
    </xsl:template>
    <!-- für jedes note-Tag wird eine Fußnote erstellt, jedoch mit noteref-->
    <xsl:template match="note">
        
        <a>
            <xsl:attribute name="epub:type">
                <xsl:text>noteref</xsl:text>
            </xsl:attribute>
           
            <xsl:attribute name="href">
                <xsl:text>#popover</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            <sup><xsl:number level="any" count="note" format="[1]"/></sup>
            
        </a>
        
    </xsl:template>
    <!-- Kommentar wird in ein separates aside-Tag gefügt  -->
    <xsl:template match="note" mode="footnote">
       
            <aside>
                <xsl:attribute name="epub:type">
                    <xsl:text>footnote</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:text>popover</xsl:text><xsl:number level="any" count="note" format="1"/>
                </xsl:attribute>
                <p>
                    <xsl:number level="any" count="note" format="[1]"/>
                
                   
                
                <xsl:apply-templates/>
                    <xsl:if test="@source">
                        <a>
                            <xsl:attribute name="href" select="concat('Register.xhtml#', substring-after(@source, '#'))"></xsl:attribute>
                            Quelle
                        </a>
                    </xsl:if>
                </p>
            </aside>
        
        
        
    </xsl:template>
    
    <!-- nach dem letzten <div> werden die aside-Tags geschrieben -->
    <xsl:template match="(div[@n])[last()]">
        
        <xsl:next-match />
        <hr></hr>
       
            
                <xsl:apply-templates select="//note" mode="footnote"/>
            
        
        
    </xsl:template>
    
        
    
</xsl:stylesheet>