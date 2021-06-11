<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step name="myPipeline" xmlns:p="http://www.w3.org/ns/xproc" xmlns:f="http://whatever"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">
    <p:input port="source" sequence="true" primary="true">
        <p:empty/>
    </p:input>
    <p:output port="result" primary="true">
        <p:pipe step="directory" port="result"/>
    </p:output>
    <!-- XHTML-Dateien als Liste laden -->
    <p:directory-list path="input" include-filter=".*xml" name="directory"/>
    <!-- <p:filter name="filter" select="//c:file[not(position() > 3)]"/>-->

    <p:for-each name="for">
        <!-- ersten zwei Dateien für Fußnoten-->
        <p:iteration-source select="//c:file[not(position() > 2)]"/>
        
        <p:variable name="filename" select="c:file/@name"/>
        <p:variable name="name" select="tokenize($filename, '\.|/')[last() - 1]"/>
        <p:make-absolute-uris match="c:file/@name">
            <p:with-option name="base-uri" select="'input/'"/>
        </p:make-absolute-uris>

        <p:load dtd-validate="false">
            <p:with-option name="href" select="c:file/@name"/>
        </p:load>

        <p:xslt name="footnote">
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/footnote.xsl"/>
            </p:input>
        </p:xslt>
        <p:xslt name="footnote_headings">
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/change_headings.xsl"/>
            </p:input>
        </p:xslt>

        <p:store method="xhtml" omit-xml-declaration="false" doctype-system="about:legacy-compat">
            <p:with-option name="href" select="concat('./result/OEBPS/Text/',$name,'.xhtml')"/>

        </p:store>
      
    
        
    </p:for-each>
    <p:for-each name="popover">
        <!-- die nächsten drei Dateien für Popover -->
        <p:iteration-source select="//c:file[position() > 2 and not(position()> 5) ]">
            <p:pipe step="directory" port="result"/>
        </p:iteration-source>
        <p:variable name="filename" select="c:file/@name"/>
        <p:variable name="name" select="tokenize($filename, '\.|/')[last() - 1]"/>
        <p:make-absolute-uris match="c:file/@name">
            <p:with-option name="base-uri" select="'input/'"/>
        </p:make-absolute-uris>
        
        <p:load dtd-validate="false">
            <p:with-option name="href" select="c:file/@name"/>
        </p:load>
        
        <p:xslt>
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/popover.xsl"/>
            </p:input>
        </p:xslt>
        <p:xslt name="popover_headings">
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/change_headings.xsl"/>
            </p:input>
        </p:xslt>
        
       
        <!--    <p:insert match="/html/body/main/h2" position="before">
            <p:input port="source">
                <p:inline exclude-inline-prefixes="#all">
                    <h1>Test</h1>
                </p:inline>
            </p:input>
            <p:input port="insertion">
                <p:pipe step="footnote" port="result" />        
            </p:input>
        </p:insert>-->
        <p:store method="xhtml"  omit-xml-declaration="false" doctype-system="about:legacy-compat">
            <p:with-option name="href" select="concat('./result/OEBPS/Text/',$name,'.xhtml')"/>
            
        </p:store>
    </p:for-each>
    <p:for-each name="hover">
        <!-- die nächsten 3 Dateien für Mouseover -->
        <p:iteration-source select="//c:file[position() > 5 and not(position()> 8) ]">
            <p:pipe step="directory" port="result"/>
        </p:iteration-source>
        <p:variable name="filename" select="c:file/@name"/>
        <p:variable name="name" select="tokenize($filename, '\.|/')[last() - 1]"/>
        <p:make-absolute-uris match="c:file/@name">
            <p:with-option name="base-uri" select="'input/'"/>
        </p:make-absolute-uris>
        
        <p:load dtd-validate="false">
            <p:with-option name="href" select="c:file/@name"/>
        </p:load>
        
        <p:xslt >
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/hover.xsl"/>
            </p:input>
        </p:xslt>
        <p:xslt name="hover_headings">
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/change_headings.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store method="xhtml"  omit-xml-declaration="false" doctype-system="about:legacy-compat">
            <p:with-option name="href" select="concat('./result/OEBPS/Text/',$name,'.xhtml')"/>
            
        </p:store>
    </p:for-each>
    
   
    <p:for-each name="annotation">
        <!-- die letzten zwei Dateien für Annotation -->
        <p:iteration-source select="//c:file[position() > 8 and not(position()> 10) ]">
            <p:pipe step="directory" port="result"/>
        </p:iteration-source>
        <p:variable name="filename" select="c:file/@name"/>
        <p:variable name="name" select="tokenize($filename, '\.|/')[last() - 1]"/>
        <p:make-absolute-uris match="c:file/@name">
            <p:with-option name="base-uri" select="'input/'"/>
        </p:make-absolute-uris>
        
        <p:load dtd-validate="false">
            <p:with-option name="href" select="c:file/@name"/>
        </p:load>
        
        <p:xslt >
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/annotation.xsl"/>
            </p:input>
        </p:xslt>
        <p:xslt name="hover_headings">
            
            <p:with-param name="foo" select="'bar'"/>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../TEi/change_headings.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store method="xhtml"  omit-xml-declaration="false" doctype-system="about:legacy-compat">
           
            <p:with-option name="href" select="concat('./result/OEBPS/Text/',$name,'.xhtml')"/>
            
        </p:store>
    </p:for-each>
    



</p:declare-step>
