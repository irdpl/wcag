<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:include href="base.xslt"/>
	
	<xsl:function name="wcag:get-id">
		<xsl:param name="el" />
		<xsl:choose>
			<xsl:when test="$el/@id"><xsl:value-of select="$el/@id"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="wcag:generate-id(wcag:find-heading($el))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template name="id">
		<xsl:attribute name="id" select="wcag:get-id(.)"/>
	</xsl:template>
	
	<xsl:template name="content">
		<xsl:variable name="content"><xsl:copy-of select="*[not(name() = 'h1' or name() = 'h2' or name() = 'h3' or name() = 'h4' or name() = 'h5' or name() = 'h6' or name() = 'section' or @class = 'conformance-level' or @class = 'change')]"></xsl:copy-of></xsl:variable>
		<content><xsl:copy-of select="$content"/></content>
		<contenttext><xsl:value-of select="serialize($content)"/></contenttext>
	</xsl:template>
	
	<xsl:template match="html:html">
		<guidelines lang="{@lang}">
			<understanding>
				<name>Wprowadzenie do objaśnień WCAG <xsl:value-of select="$guidelines.version.decimal"/></name>
				<file href="wprowadzenie"/>
			</understanding>
			<understanding>
				<name>Objaśnienie technik dla kryteriów sukcesu WCAG</name>
				<file href="objasnienie-technik"/>
			</understanding>
			<understanding>
				<name>Objaśnienie zasad testowych dla kryteriów sukcesu WCAG</name>
				<file href="objasnienie-zasad-testowych"/>
			</understanding>
			<xsl:apply-templates select="//html:section[@class='principle']"/>
			<understanding>
				<name>Objaśnienie zgodności</name>
				<file href="zgodnosc"/>
			</understanding>
			<understanding>
				<name>Jak odwoływać się do WCAG <xsl:value-of select="$guidelines.version.decimal"/> z innych dokumentów</name>
				<file href="odwolania-do-wcag"/>
			</understanding>
			<understanding>
				<name>Dokumentacja obsługi dostępności dla zastosowań technologii internetowej</name>
				<file href="dokumentowanie-obslugi-dostepnosci"/>
			</understanding>
			<understanding>
				<name>Objaśnienie metadanych</name>
				<file href="objasnienie-metadanych"/>
			</understanding>
			<xsl:apply-templates select="//html:dfn"/>
		</guidelines>
	</xsl:template>
	
	<xsl:template match="html:section[@class='principle']">
		<principle>
			<xsl:call-template name="id"/>
			<version>WCAG20</version>
			<num><xsl:number count="html:section[@class='principle']" format="1"/></num>
			<name><xsl:value-of select="wcag:find-heading(.)"/></name>
			<xsl:call-template name="content"/>
			<xsl:apply-templates select="html:section"/>
		</principle>
	</xsl:template>
	
	<xsl:template match="html:section[contains(@class, 'guideline')]">
		<guideline>
			<xsl:call-template name="id"/>
			<version>
				<xsl:choose>
					<xsl:when test="@id = 'pointer-accessible'">WCAG21</xsl:when>
					<xsl:otherwise>WCAG20</xsl:otherwise>
				</xsl:choose>
			</version>
			<num><xsl:number level="multiple" count="html:section[contains(@class, 'principle')]|html:section[contains(@class, 'guideline')]" format="1.1"/></num>
			<name><xsl:value-of select="wcag:find-heading(.)"/></name>
			<xsl:call-template name="content"/>
			<file href="{wcag:generate-id(wcag:find-heading(.))}"/>
			<xsl:apply-templates select="html:section"/>
		</guideline>
	</xsl:template>
	
	<xsl:template match="html:section[contains(@class, 'sc')]">
		<success-criterion>
			<xsl:call-template name="id"/>
			<version>WCAG<xsl:value-of select="$versions.doc//id[@id = wcag:get-id(current())]/parent::version/@name"/></version>
			<num><xsl:number level="multiple" count="html:section[contains(@class, 'principle')]|html:section[contains(@class, 'guideline')]|html:section[contains(@class, 'sc')]" format="1.1.1"/></num>
			<name><xsl:value-of select="wcag:find-heading(.)"/></name>
			<xsl:call-template name="content"/>
			<level><xsl:value-of select="html:p[@class='conformance-level']"/></level>
			<file href="{wcag:generate-id(wcag:find-heading(.))}"/>
		</success-criterion>
	</xsl:template>
	
	<xsl:template match="html:dfn">
		<xsl:variable name="alts" select="tokenize(@data-lt, '\|')"></xsl:variable>
		<term>
			<id><xsl:text>dfn-</xsl:text><xsl:value-of select="wcag:generate-id(.)"/></id>
			<name><xsl:value-of select="lower-case(.)"/></name>
			<xsl:for-each select="$alts">
				<name><xsl:value-of select="lower-case(.)"/></name>
			</xsl:for-each>
			<definition>
				<xsl:copy-of select="../following-sibling::html:dd[1]/node()"/>
			</definition>
		</term>
	</xsl:template>
	
</xsl:stylesheet>
