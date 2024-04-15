<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Definiujemy parametry dla szerokości i wysokości wykresu -->
  <xsl:param name="chartWidth" select="3200" />
  <xsl:param name="chartHeight" select="1200" />

  <!-- Główny szablon przekształcający -->
  <xsl:template match="/">
    <xsl:text>&#10;&#10;</xsl:text>
    <svg width="{$chartWidth + 100}" height="{$chartHeight + 600}" xmlns="http://www.w3.org/2000/svg">
      <xsl:text>&#10;&#10;</xsl:text>

      <!-- Dodajemy oś X -->
      <line x1="0" y1="{$chartHeight}" x2="{$chartWidth}" y2="{$chartHeight}" stroke="black" stroke-width="2" />
      <xsl:text>&#10;</xsl:text>      
      <!-- Dodajemy oś Y -->
      <line x1="80" y1="0" x2="76" y2="{$chartHeight}" stroke="black" stroke-width="2" />
      <xsl:text>&#10;</xsl:text>      
      <text x="295" y="{$chartHeight + 70}" font-size="72" text-anchor="middle" transform="rotate(-90, 25, {$chartHeight + 40})">height [meters]</text>
      <xsl:text>&#10;</xsl:text>

      <!-- Iteracja po szczytach górskich i tworzenie słupków -->
      <xsl:for-each select="//peak">
        <xsl:text>&#10;</xsl:text>
        <!-- Pobieramy wysokość szczytu -->
        <xsl:variable name="peakHeight" select="number(substring-before(height, ' m.a.s.l.'))" />

        <!-- Sprawdzamy, czy szczyt leży tylko na terytorium Polski -->
        <xsl:choose>
          <xsl:when test="count(country) = 1">
            <rect x="{($chartWidth div count(//peak)) * position()}" y="{($chartHeight - $peakHeight * 0.4)}" width="70" height="{$peakHeight * 0.4}" fill="#ffa94d" />
          </xsl:when>
          <xsl:when test="count(country) = 2 and country[2] = 'Slovakia'">
            <!-- Szczyt na granicy Polski i Słowacji -->
            <rect x="{($chartWidth div count(//peak)) * position()}" y="{($chartHeight - $peakHeight * 0.4)}" width="70" height="{$peakHeight * 0.4}" fill="#cc6600" />
          </xsl:when>
          <xsl:when test="count(country) = 2 and country[2] = 'Czech Republic'">
            <!-- Szczyt na granicy Polski i Czech -->
            <rect x="{($chartWidth div count(//peak)) * position()}" y="{($chartHeight - $peakHeight * 0.4)}" width="70" height="{$peakHeight * 0.4}" fill="#663300" />
          </xsl:when>
        </xsl:choose>

        <!-- Dodajemy etykietę pod słupkiem -->
        <text x="{($chartWidth div count(//peak)) * position() + 90}" y="{($chartHeight)+150}" font-size="72" text-anchor="end" transform="rotate(-90, {($chartWidth div count(//peak)) * position()}, {($chartHeight)+100})">
          <xsl:choose>
            <xsl:when test="country/national_park/count(@np_id) = 1">
              <tspan style="text-decoration: underline; fill: #004d1a;">
                <xsl:value-of select="name" />
              </tspan>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="name" />
            </xsl:otherwise>
          </xsl:choose>
        </text>
        <xsl:text>&#10;</xsl:text>

        <!-- Dodajemy etykietę nad słupkiem -->
        <text x="{($chartWidth div count(//peak)) * position() +50}" y="{($chartHeight - $peakHeight * 0.4) +5}" font-size="72" text-anchor="start" transform="rotate(-90, {($chartWidth div count(//peak)) * position() + 45}, {$chartHeight - $peakHeight * 0.4 - 10})">
          <xsl:value-of select="format-number($peakHeight, '#')" />
        </text>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>

      <!-- Dodajemy legendę -->
      <rect x="2450" y="100" width="80" height="80" fill="#ffa94d" />
      <text x="2550" y="150" font-size="46" text-anchor="start">Poland - not border peak</text>
      <rect x="2450" y="200" width="80" height="80" fill="#cc6600" />
      <text x="2550" y="250" font-size="46" text-anchor="start">Poland &amp; Slovakia border peak</text>
      <rect x="2450" y="300" width="80" height="80" fill="#663300" />
      <text x="2550" y="350" font-size="46" text-anchor="start">Poland &amp; Czech Republic border peak</text>
      <text x="2440" y="450" font-size="46" text-anchor="start">
      <tspan style="text-decoration: underline; fill:#004d1a;">Rysy</tspan>&#160; Peak is in national park</text>
      <xsl:text>&#10;</xsl:text>
    </svg>
  </xsl:template>

</xsl:stylesheet>
