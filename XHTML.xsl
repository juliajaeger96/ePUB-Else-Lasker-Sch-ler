<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
   
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns:f="http://whatever"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
    
    
    <xsl:output method="xhtml" html-version="5.0" encoding="UTF-8"/>
    
    <!-- Inline- und Blockelemente festlegen -->
    <xsl:function name="f:isBlock" as="xs:string">
        <xsl:param name="element" as="element()"></xsl:param>
        <xsl:choose>
            
            <xsl:when test="$element/self::p">p</xsl:when>
            <xsl:when test="$element/self::lb">br</xsl:when>
            <xsl:when test="$element/self::dateline">div</xsl:when>
            <xsl:when test="$element/self::opener">div</xsl:when>
            <xsl:when test="$element/self::closer">div</xsl:when>
            <xsl:when test="$element/self::body">div</xsl:when>
            <xsl:when test="$element/self::div">section</xsl:when>
            <xsl:when test="$element/self::ref">a</xsl:when>
            
            
           
            
            
            <xsl:otherwise>span</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:mode on-no-match="shallow-copy"/>
   
    <xsl:template match="/" >
        <xsl:copy copy-namespaces="yes">
            
            <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en" >
                <xsl:namespace name="epub">http://www.idpf.org/2007/ops</xsl:namespace>
            <head>
                <title><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></title>
                <style></style>
                <link href="../Styles/basic.css" rel="stylesheet" type="text/css"/>
                <link href="../Styles/kf8.css" media="amzn-kf8" rel="Stylesheet" type="text/css"/>
                <link href="../Styles/mobi.css" media="amzn-mobi" rel="Stylesheet" type="text/css"/>
               
               
                
            </head>
            
                <body epub:type="bodymatter">
                    <script src="../Misc/button_function.js">
                    </script>
                <main>
                    
                    <h2 id="h2">
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></h2>
                    <h3 id="h3">Metadaten</h3>
                    <!-- Metadaten als Tabelle festlegen, mit Button abrufbar -->
                    <button onclick="Poststempel()">Poststempel</button>
                    
                    <table class="meta" id="stemp" >
                        <tr>
                            <th>
                                Ort
                            </th>
                            <th>
                               Datum
                            </th>
                            <th>
                                Koordinaten
                            </th>
                        </tr>
                        <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/support/p">
                            <tr>
                                <td>
                                    <a>
                                        <xsl:attribute name="href" select="stamp/mentioned/placeName/concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                                        <xsl:value-of select="stamp/mentioned/placeName"/>
                                    </a>
                                 
                                </td>
                                <td>
                                    <xsl:value-of select="stamp/mentioned/date"/>
                                </td>
                                <td>
                                    <xsl:value-of select="stamp/mentioned/date/following-sibling::text()[1]"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    <button onclick="Briefmarken()">Briefmarken</button>
                   
                    <div id="result">
                        <!-- Result will appear be here -->
                    </div>
                    
                    <table class="meta" id="circle" >
                        <tr>
                            <th>
                                Zitat
                            </th>
                            <th>
                                Währung
                            </th>
                            <th>
                                Bildbeschreibung
                            </th>
                        </tr>
                        <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/p">
                        <tr>
                            <td>
                                <xsl:value-of select="quote"/>
                            </td>
                            <td>
                                <xsl:value-of select="measure"/>
                            </td>
                            <td>
                                <xsl:value-of select="figure/figDesc"/>
                            </td>
                        </tr>
                        </xsl:for-each>
                    </table>
                    <button onclick="Adressen()">Adressen</button>
                    <table class="meta" id="myDIV" >
                        <tr>
                            <th>Personen</th>               
                            <th>Ort</th>
                            <th>Datum</th>
                        </tr>
                        <tr>
                        <td>
                            <a>
                                <xsl:attribute name="href" select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='sent']/persName/concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                            <xsl:value-of select="concat('Sender:',/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='sent']/persName)"/>
                            </a>
                        </td>
                            <td><a> <xsl:attribute name="href" select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='sent']/settlement/concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                            <xsl:value-of select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='sent']/settlement"/>
                            </a>
                        </td>
                        <td>
                            
                                    <xsl:value-of select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='sent']/date"/>
                        </td>
                        </tr>
                        <tr>
                            <td>
                                <a>
                                    <xsl:attribute name="href" select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='received']/persName/concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                                    <xsl:value-of select="concat('Empfänger:',/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='received']/persName)"/>
                                </a>
                                
                            </td>
                            <td>
                                <a> <xsl:attribute name="href" select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='received']/settlement/concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                                    <xsl:value-of select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='received']/settlement"/>
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="/TEI/teiHeader/profileDesc/correspDesc/correspAction[@type='received']/date"/>
                            </td>
                        </tr>
                    </table>
                   
                    <xsl:apply-templates select="//body/*">
                        
                    </xsl:apply-templates>
                </main>
            </body>
        </html>
        </xsl:copy>
    </xsl:template>
    
    
 <!-- Silbentrennung -->
    <xsl:template match="c[text()]">
        
        <wbr>
            <xsl:value-of select="replace(., '-', '')"></xsl:value-of>
           
        </wbr>
        
    </xsl:template>

    <!-- Bilder als eigenes Tag hinzufügen -->
    <!-- Link ändern -->
    <xsl:template match="*[@facs]">
        <span epub:type="pagebreak"></span>
        <xsl:if test="local-name() = 'pb'">
        <figure class="image">
            <img>
                <xsl:attribute name="src" select="concat('../Images/',string-join(tokenize(@facs,'/')[position()=last()],'/'))"></xsl:attribute>
                <xsl:attribute name="id" select="@n"></xsl:attribute>
                
            <xsl:apply-templates/>
            </img>
            <figcaption>
                <xsl:value-of select="concat('Brief_',string-join(tokenize(@facs,'/')[position()=last()],'/'))"/>
            </figcaption>
        </figure>
        </xsl:if>
        <!-- <xsl:if test="local-name() = 'unclear'">
           
               <span class="unclear_figure">
                   <xsl:attribute name="data-url" select="concat('../Images/',string-join(tokenize(@facs,'/')[position()=last()],'/'))"></xsl:attribute>
                    
                    <xsl:apply-templates/>
                </span>
            
        </xsl:if> -->
    </xsl:template>
    
    <xsl:template match="date">
        <time>
            <xsl:attribute name="datetime" select="@when"></xsl:attribute>
                <xsl:apply-templates/>
        </time>
    </xsl:template>
    
    <!--  <xsl:template match="hi">
        <xsl:if test="@rend ='underline'">
        <u>
            
                <xsl:apply-templates/>
        </u>
        </xsl:if>
        <xsl:if test="@type ='overstrike'">
            <srtike>
                
                <xsl:apply-templates/>
            </srtike>
        </xsl:if>
    </xsl:template>-->
    
    <!-- Registerverweise abändern -->
    <xsl:template match="*[@ref]">
        <a>
            
                
            <xsl:attribute name="href" select="concat('Register.xhtml#', substring-after(@ref, '#'))"></xsl:attribute>
                <xsl:apply-templates/>
            
        </a>
    </xsl:template>
    
   
    
    <!-- Funktion anwenden -->
    <xsl:template match="*">
       
        <xsl:element name="{f:isBlock(.)}">
           
            <xsl:attribute name="class" select="local-name(.)"></xsl:attribute>
            <!--for all attributes -->
            
            <xsl:if test="@n">
                <xsl:attribute name="epub:type" select="'part'"></xsl:attribute>
            </xsl:if>
            
            <xsl:if test="@target">
                <xsl:attribute name="href" select="concat(substring-before(@target, '.'), '.xhtml')"></xsl:attribute>
            </xsl:if>
            <xsl:if test="@source">
                <xsl:attribute name="data-url" select="@source"></xsl:attribute>
            </xsl:if>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
            </xsl:if>
            <!-- Durchgestrichener Text -->
            <xsl:if test="@type='overstrike'">
                <xsl:attribute name="style" select="'text-decoration:line-through'"></xsl:attribute>
            </xsl:if>
            <!-- unterstrichener Text -->
            <xsl:if test="@type='underline'">
                <xsl:attribute name="style" select="'text-decoration:underline'"></xsl:attribute>
            </xsl:if>
          
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:element>
        
    </xsl:template>
    
    
</xsl:stylesheet>