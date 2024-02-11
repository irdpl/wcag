<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:import href="base.xslt"/>
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:param name="understanding.dir">understanding/</xsl:param>
	
	<xsl:template match="guidelines">
		<associations>
			<xsl:apply-templates select="//guideline"/>
		</associations>
	</xsl:template>


<!-- Define a template to replace URL-unsafe characters with their safe counterparts -->
  <xsl:template name="replaceUnsafeChars">
    <xsl:param name="inputString"/>
    <xsl:choose>
      <!-- Replace Polish special characters -->
<!--      <xsl:when test="contains($inputString, 'ść')">
        <xsl:value-of select="substring-before($inputString, 'ść')"/>
        <xsl:text>sc</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ść')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'łą')">
        <xsl:value-of select="substring-before($inputString, 'łą')"/>
        <xsl:text>la</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'łą')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'łę')">
        <xsl:value-of select="substring-before($inputString, 'łę')"/>
        <xsl:text>le</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'łę')"/>
        </xsl:call-template> -->
      </xsl:when>		  
      <xsl:when test="contains($inputString, 'ą')">
        <xsl:value-of select="substring-before($inputString, 'ą')"/>
        <xsl:text>a</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ą')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'ć')">
        <xsl:value-of select="substring-before($inputString, 'ć')"/>
        <xsl:text>c</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ć')"/>
        </xsl:call-template>
      </xsl:when>	  
      <xsl:when test="contains($inputString, 'ę')">
        <xsl:value-of select="substring-before($inputString, 'ę')"/>
        <xsl:text>e</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ę')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'ł')">
        <xsl:value-of select="substring-before($inputString, 'ł')"/>
        <xsl:text>l</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ł')"/>
        </xsl:call-template>
      </xsl:when>	  	  
      <xsl:when test="contains($inputString, 'ń')">
        <xsl:value-of select="substring-before($inputString, 'ń')"/>
        <xsl:text>n</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ń')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'ó')">
        <xsl:value-of select="substring-before($inputString, 'ó')"/>
        <xsl:text>o</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ó')"/>
        </xsl:call-template>
      </xsl:when>	  
      <xsl:when test="contains($inputString, 'ś')">
        <xsl:value-of select="substring-before($inputString, 'ś')"/>
        <xsl:text>s</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ś')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($inputString, 'ż')">
        <xsl:value-of select="substring-before($inputString, 'ż')"/>
        <xsl:text>z</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ż')"/>
        </xsl:call-template>
      </xsl:when>	  
      <xsl:when test="contains($inputString, 'ź')">
        <xsl:value-of select="substring-before($inputString, 'ź')"/>
        <xsl:text>z</xsl:text>
        <xsl:call-template name="replaceUnsafeChars">
          <xsl:with-param name="inputString" select="substring-after($inputString, 'ź')"/>
        </xsl:call-template>
      </xsl:when>	 
      <!-- Dodaj więcej przypadków dla innych polskich znaków specjalnych -->
      <!-- Jeśli nie zostanie znaleziony żaden znak specjalny, skopiowany zostanie pozostały ciąg znaków -->
      <xsl:otherwise>
        <xsl:value-of select="$inputString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



	
	<xsl:template match="guideline | success-criterion">
        <xsl:variable name="safeHref">
            <!-- Replace URL-unsafe characters in the filename -->
            <xsl:call-template name="replaceUnsafeChars">
                <xsl:with-param name="inputString" select="file/@href"/>
            </xsl:call-template>
        </xsl:variable>		
		<xsl:copy>
			<xsl:attribute name="id" select="@id"/>
			<xsl:apply-templates select="document(resolve-uri(concat($safeHref, '.html'), concat($understanding.dir, max($versions.doc//id[@id = current()/@id]/parent::version/@name), '/')))">
				<xsl:with-param name="meta" select="." tunnel="yes"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="guideline | success-criterion"/>
		</xsl:copy>
	</xsl:template>

	
	<xsl:template match="html:html">
		<xsl:apply-templates select="descendant::html:section[@id = 'techniques']"/>
	</xsl:template>
	
	<xsl:template match="html:section[@id = 'techniques']">
		<sufficient>
			<xsl:apply-templates select="html:section[@id = 'sufficient']"/>
		</sufficient>
		<advisory>
			<xsl:apply-templates select="html:section[@id = 'advisory']"/>
		</advisory>
		<failure>
			<xsl:apply-templates select="html:section[@id = 'failure']"/>
		</failure>
	</xsl:template>
	
	<xsl:template match="html:section[@id = 'sufficient' or @id = 'advisory' or @id = 'failure']">
		<xsl:apply-templates select="html:ol | html:ul | html:section"/>
	</xsl:template>
	
	<xsl:template match="html:section[@class = 'situation']">
		<situation>
			<title><xsl:value-of select="wcag:find-heading(.)"/></title>
			<xsl:apply-templates select="html:ol | html:ul"/>
		</situation>
	</xsl:template>
	
	<xsl:template match="html:li[html:p]">
		<xsl:apply-templates select="html:p"/>
	</xsl:template>
	
	<xsl:template match="html:li[not(html:p)] | html:li/html:p">
		<xsl:choose>
			<xsl:when test="count(html:a) &gt; 1">
				<and>
					<xsl:apply-templates select="html:a"/>
					<xsl:if test="html:ol or html:ul or ../html:ol or ../html:ul">
						<using>
							<xsl:apply-templates select="html:ol | html:ul | ../html:ol | ../html:ul"/>
						</using>
					</xsl:if>
				</and>
			</xsl:when>
			<xsl:when test="count(html:a) = 1">
				<xsl:apply-templates select="html:a"/>
			</xsl:when>
			<xsl:otherwise>
				<technique>
					<title><xsl:apply-templates/></title>
					<xsl:if test="html:ol or html:ul or ../html:ol or ../html:ul">
						<using>
							<xsl:apply-templates select="html:ol | html:ul | ../html:ol | ../html:ul"/>
						</using>
					</xsl:if>
				</technique>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template match="html:a[wcag:is-technique-link(.)]">
		<xsl:variable name="tech-id" select="replace(@href, '^.*/([\w\d]*)(\.html)?$', '$1')"/>
		<technique>
			<xsl:attribute name="id"><xsl:value-of select="$tech-id"/></xsl:attribute>
			<xsl:if test="../html:ol or ../html:ul or ../../html:ol or ../../html:ul">
				<using>
					<xsl:apply-templates select="../html:ol | ../html:ul | ../../html:ol | ../../html:ul"/>
				</using>
			</xsl:if>
		</technique>
	</xsl:template>
	
	<xsl:template match="html:a"/>

	<xsl:template match="html:ol | html:ul">
		<xsl:apply-templates/>
	</xsl:template>
	
</xsl:stylesheet>