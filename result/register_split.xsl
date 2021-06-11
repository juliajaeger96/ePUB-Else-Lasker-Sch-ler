<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:f="http://whatever"
   
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:strip-space elements="*"/>
    
    
    <xsl:output method="xhtml" html-version="5.0" encoding="UTF-8"/>
    
<!-- Register-Datei wird in Tabellen aufgeteilt -->
    <xsl:template match="/" >
        <xsl:copy copy-namespaces="yes">
            <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="en" xml:lang="en">
                <head>
                    <title><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></title>
                    <style></style>
                    <link href="../Styles/basic.css" rel="stylesheet" type="text/css"/>
                    <link href="../Styles/kf8.css" media="amzn-kf8" rel="Stylesheet" type="text/css"/>
                    <link href="../Styles/mobi.css" media="amzn-mobi" rel="Stylesheet" type="text/css"/>
                    
                    
                    
                </head>
                <body epub:type="bodymatter">
                    <main>
                        
                        <section epub:type="part">
                            <h1 id="h2">
                            Register</h1>
                        <xsl:apply-templates select="//p/*">
                            
                        </xsl:apply-templates></section>
                    </main>
                </body>
            </html>
        </xsl:copy>
    
    </xsl:template>
   
    <!-- Personenregister -->
    <xsl:template match="listPerson">
        <h2>Personenregister</h2>
       <table>
           <tr>
               <th>Nachname</th>
               <th>Vorname</th>
              <th>Beruf</th>
               <th>Pseudonym</th>
               <th>Alias</th>
               <th>GND</th>
               <th>Geburtsdatum</th>
               <th>Todestag</th>
               <th>Geschlecht</th>
               <th>Kommentar</th>
              
           </tr>
           <xsl:for-each select="person">
               <xsl:sort select="string-join(persName/surname, ' ')"/>
           <tr>
               
               <td>
                   <a>
                       <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                       <xsl:value-of select="persName/surname"/>
                   </a>
                 
               </td>
               <td>
                  
                   <xsl:value-of select="persName/forename"/>
                   
               </td>
               <td>
                   <xsl:for-each  select="persName/roleName">
                       
                           <xsl:value-of select="concat(text(), '; ')"/>
                       
                   </xsl:for-each>
               </td>
               <td>
                   <xsl:for-each select="persName/addName[@type='pseudonym']">
                       
                               <xsl:value-of select="concat(text(), '; ')"/>
                      
                   </xsl:for-each>
               </td>
               <td>
                   <xsl:for-each select="persName/addName[@type='alias']">
                       
                       <xsl:value-of select="concat(text(), '; ')"/>
                       
                   </xsl:for-each>
               </td>
               <td>
                   <a>
                       <xsl:attribute name="href" select="idno/text()"></xsl:attribute>
                       <xsl:value-of select="idno"/>
                   </a>
               </td>
               <td>
                   <xsl:value-of select="birth"/>
               </td>
               <td>
                   <xsl:value-of select="death"/>
               </td>
               <td>
                   <xsl:value-of select="sex"/>
               </td>
               <td>
                   <xsl:attribute name="about" select="note/@source"></xsl:attribute>
                   <xsl:attribute name="class" select="note/@type"></xsl:attribute>
                   <xsl:value-of select="note"/>
               </td>
               
              
               
           </tr>
           </xsl:for-each>
       </table>
    </xsl:template>
  
    <!-- Körperschaftsregister -->
    <xsl:template match="listOrg">
        <h2>Körperschaftsregister</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>GND</th>
                <th>Ort</th>
                <th>Adresse</th>
                <th>Kommentar</th>
            </tr>
            <xsl:for-each select="org">
                <xsl:sort select="string-join(orgName, ' ')"/>
            <tr>
                <td>
                    <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                    <xsl:attribute name="class" select="@type"></xsl:attribute>
                    <xsl:for-each  select="orgName">
                        <xsl:choose>
                            <!-- Wenn nur ein Element vorhanden, dann wird nicht mit ; verbunden -->
                            <xsl:when test="last() = 1">
                                <xsl:value-of select="."/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(text(), '; ')"/></xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:for-each>
                    
               
                </td>
                <td>
                    <a><xsl:attribute name="href" select="idno/text()"></xsl:attribute>
                    <xsl:value-of select="idno"/></a>
                </td>
                <td>
                    <a><xsl:attribute name="href" select="location/address/settlement/@ref"></xsl:attribute>
                        <xsl:value-of select="location/address/settlement"/></a>
                </td>
                <td>
                    <xsl:value-of select="location/address/addrLine"/>
                </td>
                <td>
                    <xsl:attribute name="about" select="note/@source"></xsl:attribute>
                    <xsl:attribute name="class" select="note/@type"></xsl:attribute>
                    <xsl:value-of select="note"/>
                </td>
            </tr>
                
            </xsl:for-each>
        </table>
        
    </xsl:template>
    <!-- Ortsregister -->
    <xsl:template match="listPlace">
        <h2>Ortsregister</h2>
        <table>
            <tr>
                <th>Typ</th>
                <th>Stadt</th>
                <th>Land</th>
                <th>Region</th>
                <th>Landkreis</th>
                <th>Geografischer Name</th>
                <th>GND</th>
            </tr>
            <xsl:for-each select="place">
                <xsl:sort select="string-join(@type, ' ')"/>
                <tr>
                    <td>
                        <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                       <xsl:value-of select="@type"/>
                        
                        
                    </td>
                    <td>
                        <xsl:value-of select="settlement"/>
                    </td>
                    <td>
                        <xsl:value-of select="country"/>
                    </td>
                    <td>
                        <xsl:value-of select="region"/>
                    </td>
                    <td>
                        <xsl:value-of select="district"/>
                    </td>
                    <td>
                        <xsl:value-of select="geogName"/>
                    </td>
                    <td>
                        <a><xsl:attribute name="href" select="idno/text()"></xsl:attribute>
                            <xsl:value-of select="idno"/></a>
                    </td>
                </tr>
                
            </xsl:for-each>
        </table>
        
    </xsl:template>
    <!-- Werksregister -->
    <xsl:template match="listBibl[@type='bibl']">
        <h2>Werksregister</h2>
        <table>
            <tr>
                <th>Titel</th>
                <th>Autor</th>
                <th>Verlag</th>
                <th>Erscheinungsdatum</th>
                <th>Auflage</th>
                <th>GND</th>
            </tr>
            <xsl:for-each select="bibl">
                <xsl:sort select="string-join(title, ' ')"/>
                <tr>
                    <td>
                        <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                        <xsl:attribute name="class" select="@type"></xsl:attribute>
                        <xsl:value-of select="title"/>
                        
                        
                    </td>
                    <td>
                        <a><xsl:attribute name="href" select="author/persName/concat('#', substring-after(@ref, '#'))"></xsl:attribute>
                            <xsl:value-of select="author"/></a>
                    </td>
                    <td>
                        <a><xsl:attribute name="href" select="publisher/concat('#', substring-after(@ref, '#'))"></xsl:attribute>
                            <xsl:value-of select="publisher"/></a>
                    </td>
                    <td>
                        <xsl:value-of select="date"/>
                    </td>
                    <td>
                        <xsl:value-of select="edition"/>
                    </td>
                   
                    <td>
                        <a><xsl:attribute name="href" select="idno/text()"></xsl:attribute>
                            <xsl:value-of select="idno"/></a>
                    </td>
                </tr>
                
            </xsl:for-each>
        </table>
        
    </xsl:template>
    <!-- Sachbegriffe -->
    <xsl:template match="list[@type='notion']">
        <h2>Sachbegriffregister</h2>
        <table>
            <tr>
                <th>Begriff</th>
               
                <th>DWDS</th>
            </tr>
            <xsl:for-each select="item">
                <xsl:sort select="string-join(., ' ')"/>
                <tr>
                    <td>
                        <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                        
                        <xsl:value-of select="."/>
                        
                        
                    </td>
                    <td>
                        <a><xsl:attribute name="href" select="idno/text()"></xsl:attribute>
                            <xsl:value-of select="idno"/></a>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!-- Quellenverzeichnis der Kommentierung -->
    <xsl:template match="listBibl[@type='literature']">
        <h2>Quellenverzeichnis</h2>
        <table>
            <tr>
                <th>Titel</th>
                <th>Aufrufdatum</th>
                <th>Autor</th>
                <th>Verlag</th>
                <th>Auflage</th>
            </tr>
            <xsl:for-each select="bibl">
                <xsl:sort select="string-join(title, ' ')"/>
                <tr>
                    <td>
                        <xsl:attribute name="id" select="@xml:id"></xsl:attribute>
                        <xsl:attribute name="class" select="@type"></xsl:attribute>
                        <xsl:value-of select="title"/>
                    </td>
                    <td>
                        <xsl:value-of select="date"/>
                    </td>
                    <td>
                        <xsl:value-of select="author"/>
                    </td>
                   <td> <xsl:value-of select="publisher"/></td>
                    <td>
                        <xsl:value-of select="edition"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    
    
</xsl:stylesheet>