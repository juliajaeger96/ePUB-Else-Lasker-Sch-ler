<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/2000/xhtml"
    
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:import href="epub-global.xsl"></xsl:import>
    <xsl:output method="xml" name="package" encoding="UTF-8" version="1.0" indent="yes"></xsl:output>
    <xsl:template match="text()"></xsl:template>
    <xsl:template match="/">
        <!-- xsl:result-document wird in der Xproc-Pipeline durch p:store ersetzt -->
        <!-- <xsl:result-document href="result/{$opfFolder}{$opfFile}" format="package"> -->
            <package version="3.0"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:opf="http://www.idpf.org/2007/opf"
                xmlns="http://www.idpf.org/2007/opf" unique-identifier="BookId">
                <!-- Metadaten einfügen -->
                <metadata>
                    <dc:identifier id="BookId">
                        <xsl:value-of select="$dcIdentifier"/>
                    </dc:identifier>
                    <dc:language>
                        <xsl:value-of select="$dcLanguage"/>
                    </dc:language>
                    <dc:title>
                        <xsl:value-of select="$dcTitle"/>
                    </dc:title>
                    <dc:publisher>
                        <xsl:value-of select="$dcPublisher"/>
                    </dc:publisher>
                    <dc:creator>
                        <xsl:value-of select="$dcAuthor"/>
                    </dc:creator>
                    <dc:date>
                        <xsl:value-of select="$dcDate"/>
                    </dc:date>
                    <meta property="dcterms:modified">
                        <xsl:value-of select="$dcTerms"/>
                    </meta>
                    <meta name="cover" content="cover-image"/>
                </metadata>
                <!-- Manifest -->
                <manifest>
                   
                    <item id="cover.xhtml" href="Text/cover.xhtml" media-type="application/xhtml+xml"/>
                    <item id="title_page.xhtml" href="Text/title_page.xhtml" media-type="application/xhtml+xml"/>
                    <item id="nav.xhtml"    href="Text/nav.xhtml"   media-type="application/xhtml+xml" properties="nav"/>
                    <!-- für epub 2.0 -->
                    <item id="nav.ncx" href="nav.ncx" media-type="application/x-dtbncx+xml" />
                    <!-- alle xhmtl-Dateien -->
                    <xsl:for-each select="collection(concat('result/',$opfFolder,$HTMLFolder,'?select=*.xhtml'))" >
                        <xsl:if test="(tokenize(base-uri(.), '\.|/')[last() - 1] != 'cover')and (tokenize(base-uri(.), '\.|/')[last() - 1] != 'title_page')">
                            <xsl:choose>
                                <xsl:when test="starts-with(tokenize(base-uri(.), '\.|/')[last() - 1], 'fallback')">
                            
                    <item media-type="application/xhtml+xml">
                       
                        <xsl:attribute name="id" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                        <xsl:attribute name="href" select="concat('Text/',tokenize(base-uri(.), '/')[last()])"></xsl:attribute>
                        
                        
                    </item>
                                </xsl:when>
                                <xsl:when test="starts-with(tokenize(base-uri(.), '\.|/')[last() - 1], 'Register')">
                                    <item media-type="application/xhtml+xml">
                                        
                                        <xsl:attribute name="id" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                                        <xsl:attribute name="href" select="concat('Text/',tokenize(base-uri(.), '/')[last()])"></xsl:attribute>
                                    </item>
                                </xsl:when>
                            <xsl:otherwise>
                                <item media-type="application/xhtml+xml">
                                    
                                    <xsl:attribute name="id" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                                    <xsl:attribute name="href" select="concat('Text/',tokenize(base-uri(.), '/')[last()])"></xsl:attribute>
                                    
                                    <xsl:attribute name="properties" select="'scripted'"></xsl:attribute>
                                    <!--  <xsl:attribute name="fallback" select="concat('fallback_',tokenize(base-uri(.), '/')[last()]) "></xsl:attribute>-->
                                </item>
                            </xsl:otherwise></xsl:choose>
                            
                        </xsl:if>
                    </xsl:for-each>
                    <!-- alle CSS-Dateien -->
                    <xsl:for-each select="uri-collection(concat('result/',$opfFolder,$CSSFolder,'?select=*.css'))">
                        <item media-type="text/css">
                            <xsl:attribute name="id" select="tokenize(iri-to-uri(.), '/')[last()]"></xsl:attribute>
                            <xsl:attribute name="href" select="concat($CSSFolder,tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute></item>
                    </xsl:for-each>
                    <!-- alle JPEG-Bilder -->
                    <xsl:for-each select="uri-collection(concat('result/',$opfFolder,$ImageFolder,'?select=*.jpg'))">
                        <item media-type="image/jpeg">
                            <xsl:if test="tokenize(iri-to-uri(.), '\.|/')[last() - 1]= 'cover'">
                                <xsl:attribute name="properties" select="'cover-image'"></xsl:attribute>
                                </xsl:if>
                            <xsl:attribute name="id" select="concat('x',tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute>
                            <xsl:attribute name="href" select="concat($ImageFolder,tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute></item>
                    </xsl:for-each>
                   <!-- alle PNG-Dateien -->
                    <xsl:for-each select="uri-collection(concat('result/',$opfFolder,$ImageFolder,'?select=*.png'))">
                        <item media-type="image/png">
                            <xsl:if test="tokenize(iri-to-uri(.), '\.|/')[last() - 1]= 'cover'">
                                <xsl:attribute name="properties" select="'cover-image'"></xsl:attribute>
                            </xsl:if>
                            <xsl:attribute name="id" select="concat('x',tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute>
                            <xsl:attribute name="href" select="concat($ImageFolder,tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute></item>
                    </xsl:for-each>
                    <!-- alle JavaScript-Dateien -->
                    <xsl:for-each select="uri-collection(concat('result/',$opfFolder,'Misc/?select=*.js'))">
                        <item media-type="text/javascript">
                            <xsl:attribute name="id" select="tokenize(iri-to-uri(.), '/')[last()]"></xsl:attribute>
                            <xsl:attribute name="href" select="concat('Misc/',tokenize(iri-to-uri(.), '/')[last()])"></xsl:attribute></item>
                    </xsl:for-each>
                    
                </manifest>
                    
                <spine toc="nav.ncx">
                    <itemref linear="yes" idref="cover.xhtml"></itemref>
                    <itemref linear="yes" idref="title_page.xhtml"></itemref>
                    <itemref linear="yes" idref="nav.xhtml"></itemref>
                    
                  <!-- es werden alle XHTML-Dateien geladen, abgesehen von cover, Titel-Page und nav -->
                            <xsl:for-each select="collection(concat('result/',$opfFolder,$HTMLFolder,'?select=*.xhtml'))" >
                                <xsl:if test="(tokenize(base-uri(.), '\.|/')[last() - 1] != 'cover')and (tokenize(base-uri(.), '\.|/')[last() - 1] != 'title_page')">
                                    <!-- falls fallback-XHTML-Dateien erstellt wurden, dann diese mitauffühen -->
                                    <xsl:choose>
                                        <xsl:when test="starts-with(tokenize(base-uri(.), '\.|/')[last() - 1], 'fallback')">
                                        <itemref>
                                            
                                            
                                            <xsl:attribute name="idref" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                                            <xsl:attribute name="properties" select="'page-spread-left'"></xsl:attribute>
                                            <xsl:attribute name="linear" select="'no'"></xsl:attribute>
                                        </itemref>
                                    </xsl:when>
                                    <xsl:otherwise>
                                <itemref>
                                    
                                   
                                    <xsl:attribute name="idref" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                                    <xsl:attribute name="properties" select="'page-spread-left'"></xsl:attribute>
                                </itemref>
                                    </xsl:otherwise></xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                </spine>
                
            </package>
           <!-- </xsl:result-document> -->
        
    </xsl:template>
    
</xsl:stylesheet>