<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="main" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:f="http://whatever"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
    >
    <p:input port="source">
        <p:document href="input/Brief_48.xml"></p:document>
    </p:input>
   <!-- Pipeline für epub -->
    <p:variable name="nav" select="'nav'"></p:variable>
    <p:variable name="mimetype" select="'mimetype'"></p:variable>
    <p:variable name="container" select="'container'"></p:variable>
    <p:variable name="content" select="'content'"></p:variable>
    <!-- für epub 2.0 -->
    <p:xslt name="nav-ncx">
        <p:with-param name="foo" select="'bar'"></p:with-param>
        <p:input port="parameters"><p:empty></p:empty></p:input>
        <p:input port="stylesheet"><p:document href="./nav-ncx.xsl"></p:document></p:input>
    </p:xslt>
    
    <p:store method="xml">
        <p:with-option name="href" select="concat('result/OEBPS/',$nav,'.ncx')"/>
        
    </p:store> 
    <!-- Navigation Document -->
    <p:xslt name="nav-toc">
        <p:input port="source">
            <p:pipe port="source" step="main"></p:pipe>
        </p:input>
        <p:with-param name="foo" select="'bar'"></p:with-param>
        <p:input port="parameters"><p:empty></p:empty></p:input>
        <p:input port="stylesheet"><p:document href="./nav-toc.xsl"></p:document></p:input>
    </p:xslt>
    
    <p:store method="xhtml"  omit-xml-declaration="false" doctype-system="about:legacy-compat">
        <p:with-option name="href" select="concat('result/OEBPS/Text/',$nav,'.xhtml')"/>
        
    </p:store> 
   <!-- Container -->
    <p:xslt name="container">
        <p:input port="source">
            <p:pipe port="source" step="main"></p:pipe>
        </p:input>
        <p:with-param name="foo" select="'bar'"></p:with-param>
        <p:input port="parameters"><p:empty></p:empty></p:input>
        <p:input port="stylesheet"><p:document href="./container.xsl"></p:document></p:input>
    </p:xslt>
    
    <p:store method="xml"  omit-xml-declaration="false">
        <p:with-option name="href" select="concat('result/META-INF/',$container, '.xml')"/>
        
    </p:store> 
    <!-- OPF-Datei -->
    <p:xslt name="content">
        <p:input port="source">
            <p:pipe port="source" step="main"></p:pipe>
        </p:input>
        <p:with-param name="foo" select="'bar'"></p:with-param>
        <p:input port="parameters"><p:empty></p:empty></p:input>
        <p:input port="stylesheet"><p:document href="./content_opf.xsl"></p:document></p:input>
    </p:xslt>
    
    <p:store method="xml"  omit-xml-declaration="false">
        <p:with-option name="href" select="concat('result/OEBPS/',$content,'.opf')"/>
        
    </p:store> 
    <!-- Mimetype -->
    <p:xslt name="mimetype">
        <p:input port="source">
            <p:pipe port="source" step="main"></p:pipe>
        </p:input>
        <p:with-param name="foo" select="'bar'"></p:with-param>
        <p:input port="parameters"><p:empty></p:empty></p:input>
        <p:input port="stylesheet"><p:document href="./mimetype.xsl"></p:document></p:input>
    </p:xslt>
    
    
    <p:store method="text">
        <p:with-option name="href" select="concat('result/',$mimetype)"/>
        
    </p:store> 
</p:declare-step>