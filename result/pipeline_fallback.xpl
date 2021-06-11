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
    <p:directory-list path="input" include-filter=".*xml" name="directory"/>
    <!-- <p:filter name="filter" select="//c:file[not(position() > 3)]"/>-->
    
    
    
    
    
    <p:for-each name="for">
        <!-- alle Dateien -->
        <p:iteration-source select="//c:file"/>
        
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
                <p:document href="../TEi/footnote_fallback.xsl"/>
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
        
        <p:store method="xhtml">
            <p:with-option name="href" select="concat('./result/OEBPS/Text/fallback_',$name,'.xhtml')"/>
            
        </p:store>
        
        
        
    </p:for-each>
    
</p:declare-step>
