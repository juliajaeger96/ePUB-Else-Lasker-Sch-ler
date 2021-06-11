<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:import href="epub-global.xsl"></xsl:import>
    <xsl:output method="xhtml" name="nav-toc" html-version="5.0" encoding="UTF-8"/>
    
   <!-- Navigation Document Stylesheet -->
    <!-- Text filtern -->
    <xsl:template match="text()"></xsl:template>
    <!-- Globale Variablen -->
    
    <xsl:template match="/">
        <!-- xsl:result-document wird in der Xproc-Pipeline durch p:store ersetzt -->
        <!--  <xsl:result-document href="result/{$opfFolder}{$HTMLFolder}{$navFile}" format="nav-toc">-->
          <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="en" xml:lang="en"  xmlns:ops="http://www.idpf.org/2007/ops">
        <head>
            <title>Inhaltsverzeichnis</title>
            
            <link href="../Styles/sgc-nav.css" rel="stylesheet" type="text/css"></link>
        </head>
        <body epub:type="frontmatter">
            <nav epub:type="toc" id="toc">
                <h1>Inhaltsverzeichnis</h1>
                <ol>
                   <li>
                       <a>
                           <xsl:attribute name="href" select="'cover.xhtml'"> </xsl:attribute>
                               <xsl:value-of select="'Cover'"/>
                          
                       </a>
                   </li>
                    <li>
                        <a>
                            <xsl:attribute name="href" select="'title_page.xhtml'"> </xsl:attribute>
                            <xsl:value-of select="'Title Page'"/>
                            
                        </a>
                    </li>
                    <!-- alle Content-Documents werden aufgelistet -->
                    <xsl:for-each select="collection(concat('result/',$opfFolder,$HTMLFolder,'?select=*.xhtml'))" >
                        <xsl:if test="(tokenize(base-uri(.), '\.|/')[last() - 1] != 'cover')and (tokenize(base-uri(.), '\.|/')[last() - 1] != 'title_page')">
                            <li>
                            <a>
                                <xsl:attribute name="href" select="tokenize(base-uri(.), '/')[last()]"></xsl:attribute>
                                <xsl:value-of select="tokenize(base-uri(.), '\.|/')[last() - 1]"/>
                            </a>
                            </li>
                        </xsl:if>
                        </xsl:for-each>
                        
                    
                </ol>
            </nav>
            <nav epub:type="landmarks" hidden="">
                <ol>
                    <li><a epub:type="cover" href="cover.xhtml">Cover</a></li>
                    <li><a epub:type="titlepage" href="title_page.xhtml">Title Page</a></li>
                    <li><a epub:type="toc" href="nav.xhtml">Table of Contents</a></li>
                    <li><a epub:type="bodymatter" href="Brief_35.xhtml">Start of Content</a></li>
                </ol>
            </nav>
        </body>
        </html>
        <!--   </xsl:result-document>-->
    </xsl:template>

</xsl:stylesheet>