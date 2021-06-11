<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step name="register" xmlns:p="http://www.w3.org/ns/xproc" xmlns:f="http://whatever"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">
    <p:input port="source" sequence="true" primary="true">
        <p:document href="./Register.xml"></p:document>
    </p:input>
    <!-- Register-Dateien in Tabellen aufteilen -->
    <p:xslt name="register_split">
        <p:with-param name="foo" select="'bar'"/>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        
        <p:input port="stylesheet">
            <p:document href="./register_split.xsl"/>
        </p:input>
    </p:xslt>
    <!-- Fußnoten hinzufügen -->
    <p:xslt name="footnotes">
        <p:with-param name="foo" select="'bar'"/>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="./footnote_register.xsl"/>
        </p:input>
    </p:xslt>
    <p:store method="xhtml"  omit-xml-declaration="false" doctype-system="about:legacy-compat">
        <p:with-option name="href" select="'./result/OEBPS/Text/Register.xhtml'"/>
        
    </p:store>
</p:declare-step>