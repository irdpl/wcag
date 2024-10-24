<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:pl="http://wcag.irdpl.p/2023/pl-functions" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:import href="base.xslt"/>
	
	<xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>
	
	<xsl:template match="guidelines">
		<xsl:result-document href="spistresci.html" method="xhtml" omit-xml-declaration="yes">
				<xsl:apply-templates select="principle | guideline | success-criterion"/>
			<section id="inne">
				<h2>Inne dokumenty objaśniające</h2>
				<ul class="toc-wcag-docs">
				<xsl:apply-templates select="understanding"/>
				</ul>
			</section>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="principle">
		<section id="{@id}">
			<h2><xsl:value-of select="name"/></h2>
			<xsl:apply-templates select="guideline"/>
		</section>
	</xsl:template>
	
	<xsl:template match="guideline">
		<xsl:variable name="href" select="file/@href"/>
		<xsl:variable name="safeHref" select="pl:replaceUnsafeChars($href)"/>
		<section id="{@id}">
			<h3>
				<a href="{$safeHref}">
					<span class="secno"><xsl:value-of select="num"/><xsl:text> </xsl:text></span>
					<xsl:value-of select="name"/>
				</a>
			</h3>
			<ul>
			<xsl:apply-templates select="success-criterion"/>
			</ul>
		</section>
	</xsl:template>
	
	<xsl:template match="success-criterion">
		<xsl:variable name="href" select="file/@href"/>
		<xsl:variable name="safeHref" select="pl:replaceUnsafeChars($href)"/>
		<li>
			<a href="{$safeHref}">
				<span class="secno"><xsl:value-of select="num"/><xsl:text> </xsl:text></span>
				<xsl:value-of select="name"/>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="understanding">
		<xsl:variable name="href" select="file/@href"/>
		<xsl:variable name="safeHref" select="pl:replaceUnsafeChars($href)"/>
		<li><a href="{$safeHref}"><xsl:value-of select="name"/></a></li>
	</xsl:template>
	
</xsl:stylesheet>