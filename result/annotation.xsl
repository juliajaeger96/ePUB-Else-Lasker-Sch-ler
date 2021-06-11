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
    
    <!-- Kommentare als Annotation behandeln-->
    
    <xsl:template match="pb[1]">
        <xsl:next-match/>
        <h1>Darstellung als Annotation</h1>
        
    </xsl:template>
    <!-- für jedes note-Tag wird eine Fußnote erstellt, jedoch mit annoref-->
    <xsl:template match="note">
        
        <a>
            <xsl:attribute name="epub:type">
                <xsl:text>annoref</xsl:text>
            </xsl:attribute>
            
            <xsl:attribute name="href">
                <xsl:text>#annoref</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            <sup><xsl:number level="any" count="note" format="[1]"/></sup>
            
        </a>
      
    </xsl:template>
    
    <!-- Kommentar wird in ein separates span-Tag gefügt  -->
    <!-- dieses span-Tag wird mit CSS formatiert  -->
    <xsl:template match="note">
        <xsl:next-match />
        <span>
            <xsl:attribute name="epub:type">
                <xsl:text>annotation</xsl:text>
            </xsl:attribute>
            
            <xsl:attribute name="id">
                <xsl:text>annoref</xsl:text><xsl:number level="any" count="note" format="1"/>
            </xsl:attribute>
            
                <xsl:number level="any" count="note" format="[1]"/>
                
                
                
                <xsl:apply-templates/>
                <xsl:if test="@source">
                    <a>
                        <xsl:attribute name="href" select="concat('Register.xhtml#', substring-after(@source, '#'))"></xsl:attribute>
                        Quelle
                    </a>
                </xsl:if>
            
        </span>
        
       
        
        
    </xsl:template>
    
    
    
</xsl:stylesheet>