<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">
         <xsl:text>&#10;|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|&#10;</xsl:text>
		<xsl:text>|Name                 | Height        | First Ascent         | Range                    | Country | Voivodeship    | National Park        | Country        | Comment                  | Comment                  | Comment                  |&#10;</xsl:text>
        <xsl:text>|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|&#10;</xsl:text>
        <xsl:apply-templates select="//peaks/peak"/>
        
        <xsl:text>&#10;|---------------------------------------------------------------|</xsl:text>
        <xsl:text>&#10;|Name                 | Surface     | Capital     | Currency    |&#10;</xsl:text>
        <xsl:text>|---------------------------------------------------------------|&#10;</xsl:text>
        <xsl:apply-templates select="//countries/country"/>
        
        <xsl:text>&#10;|-----------------------------------------------------|</xsl:text>
        <xsl:text>&#10;|Name                     | Surface     | Capital     |&#10;</xsl:text>
		<xsl:text>|-----------------------------------------------------|&#10;</xsl:text>
        <xsl:apply-templates select="//voivodeships/voivodeship"/>
        
        <xsl:text>&#10;|---------------------------------------------------------------------|</xsl:text>
        <xsl:text>&#10;|Name                 | Voivodeship    | Year of formed | Surface     |&#10;</xsl:text>
        <xsl:text>|---------------------------------------------------------------------|&#10;</xsl:text>
        <xsl:apply-templates select="//national_parks/national_park"/>
        
        <xsl:text>&#10;|----------------------------------------------------------------|</xsl:text>
        <xsl:text>&#10;|Name		      | Univeristy		       | ID      |&#10;</xsl:text>
        <xsl:text>|----------------------------------------------------------------|&#10;</xsl:text>
		<xsl:apply-templates select="//author"/>
    </xsl:template>
    
    <xsl:template match="peak">
        <xsl:text>|</xsl:text>
        <xsl:call-template name="output-column">
            <xsl:with-param name="value" select="name"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-height">
            <xsl:with-param name="value" select="height"/>
        </xsl:call-template>
        
		<xsl:call-template name="output-column">
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="contains(first_ascent, 'the')">
						<xsl:value-of select="substring-before(first_ascent, 'the')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="first_ascent"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
        
        <xsl:call-template name="output-range">
            <xsl:with-param name="value" select="range"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-country">
            <xsl:with-param name="value" select="normalize-space(substring(country, 1, string-length(substring-before(country, 'd')) + 1))"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-voivodeship">
            <xsl:with-param name="value" select="normalize-space(country/voivodeship)"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-column">
            <xsl:with-param name="value" select="normalize-space(country/national_park)"/>
        </xsl:call-template>
        
        <xsl:if test="(country)">
            <xsl:call-template name="output-voivodeship">
                <xsl:with-param name="value" select="country[2]"/>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:call-template name="output-range">
            <xsl:with-param name="value" select="comments/comment[1]"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-range">
            <xsl:with-param name="value" select="comments/comment[2]"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-range">
            <xsl:with-param name="value" select="comments/comment[3]"/>
        </xsl:call-template>
        
        <xsl:text>&#10;</xsl:text>
        <xsl:text>|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="country">
        <xsl:text>|</xsl:text>
        <xsl:call-template name="output-column">
            <xsl:with-param name="value" select="name"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="c_surface"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="c_capital"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="currency"/>
        </xsl:call-template>
        
        <xsl:text>&#10;</xsl:text>
        <xsl:text>|---------------------------------------------------------------|&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="voivodeship">
        <xsl:text>|</xsl:text>
        <xsl:call-template name="output-range">
            <xsl:with-param name="value" select="name"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="v_surface"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="v_capital"/>
        </xsl:call-template>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>|-----------------------------------------------------|&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="national_park">
        <xsl:text>|</xsl:text>
        <xsl:call-template name="output-column">
            <xsl:with-param name="value" select="name"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-voivodeship">
            <xsl:with-param name="value" select="voivodeship"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-voivodeship">
            <xsl:with-param name="value" select="year_of_formed"/>
        </xsl:call-template>
		
		<xsl:call-template name="output-peak">
            <xsl:with-param name="value" select="np_surface"/>
        </xsl:call-template>
                
        <xsl:text>&#10;</xsl:text>
        <xsl:text>|---------------------------------------------------------------------|&#10;</xsl:text>
    </xsl:template>
	
	<xsl:template match="author">
        <xsl:text>|</xsl:text>
        <xsl:call-template name="output-column">
            <xsl:with-param name="value" select="name"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-university">
            <xsl:with-param name="value" select="university"/>
        </xsl:call-template>
        
        <xsl:call-template name="output-country">
            <xsl:with-param name="value" select="a_id"/>
        </xsl:call-template>
        <xsl:text>&#10;|----------------------------------------------------------------|&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template name="output-column">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="20"/>
        <xsl:value-of select="substring(concat($value, '                       '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
    
    <xsl:template name="output-peak">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="11"/>
        <xsl:value-of select="substring(concat($value, '        '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
	
	<xsl:template name="output-height">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="13"/>
        <xsl:value-of select="substring(concat($value, '        '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
    
    <xsl:template name="output-range">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="24"/>
        <xsl:value-of select="substring(concat($value, '                         '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
       
    <xsl:template name="output-country">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="7"/>
        <xsl:value-of select="substring(concat($value, '                    '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
    
    <xsl:template name="output-voivodeship">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="14"/>
        <xsl:value-of select="substring(concat($value, '                    '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
    
    <xsl:template name="output-university">
        <xsl:param name="value"/>
        <xsl:variable name="width" select="30"/>
        <xsl:value-of select="substring(concat($value, '                    '), 1, $width)"/>
        <xsl:text> | </xsl:text>
    </xsl:template>
    
</xsl:stylesheet>