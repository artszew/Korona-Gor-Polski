<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-public="XSLT-compat" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
	<xsl:template match="/">
		<html>
			<head>
				<title>XSLT transformation</title>
				<style>
					body {
						font-family: Arial, sans-serif;
						background-color: #f4f4f4;
						margin: 0;
						padding: 15px;}
					header {
						background-color: #333;
						color: #ffffff;
						text-align: center;
						padding: 10px;}
					section {
						display: flex;
						justify-content: space-around;
						flex-wrap: wrap;
						padding: 20px;}
					.text-block {
						width: 100%;
						margin: 20px 15px;
						padding: 10px;
						background-color: #fff;
						border-radius: 8px;
						box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);}
					table {
						border-collapse: collapse;
						width: 100%;}
					th, td {
						border: 1px solid #ddd;
						padding: 8px;
						text-align: left;}
					th {
						background-color: #333;
						color: #fff;}
				</style>
			</head>
			
			<body>
				<h1>Crown of Polish Mountains</h1>
				  
				<div>
					<h2>About the Crown</h2>
					<p><xsl:value-of select="/Crown_of_Polish_Mountains/about_crown" /></p>
				</div>

				<div>
				  <h2>Peaks</h2>
				  <table>
					<tr>
					  <th>Name</th>
					  <th>Height</th>
					  <th>Range</th>
					  <th>Country</th>
					  <th>Voivodeship</th>
					  <th>National Park</th>
					  <th>Country</th>
					</tr>
					<xsl:for-each select="/Crown_of_Polish_Mountains/peaks/peak[number(translate(height, 'm.a.s.l.', '')) > 1200]">
					  <xsl:sort select="number(height)" order="ascending"/>
					  <tr>
						<td><xsl:value-of select="name" /></td>
						<td><xsl:value-of select="height" /></td>
						<td><xsl:value-of select="range" /></td>
						<td><xsl:value-of select="country[1]/text()" /></td>
						<td><xsl:value-of select="country/voivodeship" /></td>
						<xsl:if test="count(country/national_park)=1">
						<td><xsl:value-of select="country/national_park" /></td>
						</xsl:if>
						<xsl:if test="count(country/national_park)=0">
						<td>This peak is not at any national park</td>
						</xsl:if> 
						<xsl:if test="count(country)=2">
						<td><xsl:value-of select="country[2]"/></td>
						</xsl:if>
						<xsl:if test="count(country)=1">
						<td>This is not a borderline peak</td>
						</xsl:if>
					  </tr>
					</xsl:for-each>
				  </table>
				</div>

				<div>
					<h2>Countries</h2>
						<table>
							<tr>
								<th>Name</th>
								<th>Surface</th>
								<th>Capital</th>
								<th>Currency</th>
								<th>Number of peaks</th>
							</tr>
							<xsl:for-each select="//Crown_of_Polish_Mountains/countries/country">
							<xsl:sort select="number(translate(c_surface, ' km²', ''))" order="descending"/>
							<tr>
								<td><xsl:value-of select="name" /></td>
								<td><xsl:value-of select="c_surface" /></td>
								<td><xsl:value-of select="c_capital" /></td>
								<td><xsl:value-of select="currency" /></td>
								<td><xsl:value-of select="count(//Crown_of_Polish_Mountains/peaks/peak[country/@c_id=current()/@country_id])"/></td>
							</tr>
							</xsl:for-each>
						</table>
				</div>

				<div>
				  <h2>Voivodeships</h2>
				  <table>
					<tr>
					  <th>Name</th>
					  <th>Surface</th>
					  <th>Capital</th>
					  <th>Number of mountain's national parks</th>
					  <th>Number of peaks</th>
					</tr>
					<xsl:for-each select="/Crown_of_Polish_Mountains/voivodeships/voivodeship">
					<xsl:sort select="count(//Crown_of_Polish_Mountains/peaks/peak/country[voivodeship/@v_id=current()/@voivodeship_id])" order="descending"/>
					  <tr>
						<td><xsl:value-of select="name" /></td>
						<td><xsl:value-of select="v_surface" /></td>
						<td><xsl:value-of select="v_capital" /></td>
						<td><xsl:value-of select="count(//Crown_of_Polish_Mountains/national_parks/national_park[voivodeship/@voiv_id=current()/@voivodeship_id])"/></td>
						<td><xsl:value-of select="count(//Crown_of_Polish_Mountains/peaks/peak/country[voivodeship/@v_id=current()/@voivodeship_id])"/></td>
					  </tr>
					</xsl:for-each>
				  </table>
				</div>
				
				<div>
				  <h2>National Parks</h2>
				  <table>
					<tr>
					  <th>Name</th>
					  <th>Voivodeship</th>
					  <th>Year of Formed</th>
					  <th>Surface</th>
					  <th>Peak from Crown</th>
					</tr>
					<xsl:for-each select="/Crown_of_Polish_Mountains/national_parks/national_park">
					  <xsl:sort select="number(year_of_formed)" order="ascending"/>
					  <tr>
						<td><xsl:value-of select="name" /></td>
						<td><xsl:value-of select="voivodeship" /></td>
						<td><xsl:value-of select="year_of_formed" /></td>
						<td><xsl:value-of select="np_surface" /></td>
                        <td>
                            <xsl:for-each select="//peaks/peak[country/national_park/@np_id=current()/@national_park_id]" >
                              <xsl:value-of select="name" />
                            </xsl:for-each>
                        </td>
					  </tr>
					</xsl:for-each>
				  </table>
				</div>
				
				<div>
    			 <h2>Statistics of XML document</h2>   
				</div>
				
				<div>
					<h2>Number of Elements</h3>
					<table>
					  <tr>
						<th>Peak Elements</th>
						<th>Country Elements</th>
						<th>Voivodeship Elements</th>
						<th>National Park Elements</th>
					  </tr>
					  <tr>
						<td><xsl:value-of select="count(//peak)" /></td>
						<td><xsl:value-of select="count(//countries/country)" /></td>
						<td><xsl:value-of select="count(//voivodeships/voivodeship)" /></td>
						<td><xsl:value-of select="count(//national_parks/national_park)" /></td>
					  </tr>
					</table>
				</div>
				
				<div>
					<h3>Number of Categories</h3>
					<table>
					  <tr>
						<th>Border Peaks</th>
						<th>Peaks only in Poland</th>
						<th>Peaks in National Parks</th>
						<th>Peaks not in National Parks</th>
					  </tr>
					  <tr>
						<td><xsl:value-of select="count(//peak[count(country) = 2])" /></td>
						<td><xsl:value-of select="count(//peak[count(country) = 1])" /></td>
						<td><xsl:value-of select="count(//peak[country/national_park])" /></td>
						<td><xsl:value-of select="count(//peak[not(country/national_park)])" /></td>
					  </tr>
					</table>
					
				</div>

                <div>
                    <h2>Subtotal, Grand Total</h2>
                    <table>
                        <tr>
                            <th>Element</th>
                            <th>Sum of peaks height [meters]</th>
                            <th>Number of peaks</th>
                            <th>Average height of one peak [meters]</th>
                        </tr>
                
                        <xsl:for-each select="//countries/country">
                        <xsl:sort select="sum(//peaks/peak[country/@c_id=current()/@country_id]/number(translate(height, 'm.a.s.l.', ''))) div count(//peaks/peak[country/@c_id=current()/@country_id])" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="name" /></td>
                            <td><xsl:value-of select="sum(//peaks/peak[country/@c_id=current()/@country_id]/number(translate(height, 'm.a.s.l.', '')))" /></td>
                            <td><xsl:value-of select="count(//peaks/peak[country/@c_id=current()/@country_id])" /></td>
                            <xsl:variable name="averageHeight">
                            <xsl:value-of select="sum(//peaks/peak[country/@c_id=current()/@country_id]/number(translate(height, 'm.a.s.l.', ''))) div count(//peaks/peak[country/@c_id=current()/@country_id])"/>
                            </xsl:variable>
                            <td><xsl:value-of select='format-number($averageHeight, "######.##")' /></td>
                        </tr>
                        </xsl:for-each>
                
                        <xsl:for-each select="//voivodeships/voivodeship">
                            <xsl:sort select="sum(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id]/number(translate(height, 'm.a.s.l.', ''))) div count(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id])" order="descending"/>
                            <xsl:if test="count(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id])>1">
                            <tr>
                                <td><xsl:value-of select="name" /></td>
                                <td><xsl:value-of select="sum(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id]/number(translate(height, 'm.a.s.l.', '')))" /></td>
                                <td><xsl:value-of select="count(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id])" /></td>
                                <xsl:variable name="averageHeight">
                                <xsl:value-of select="sum(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id]/number(translate(height, 'm.a.s.l.', ''))) div count(//peaks/peak[country/voivodeship/@v_id=current()/@voivodeship_id])"/>
                                </xsl:variable>
                                <td><xsl:value-of select='format-number($averageHeight, "######.##")' /></td>
                            </tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </div>
				<div>
					<h2>Author</h2>
					<table>
						<tr>
							<th>Name</th>
							<th>University</th> 
							<th>ID</th>
						</tr>
						<tr>
							<td><xsl:value-of select="/Crown_of_Polish_Mountains/author/name"/></td>
							<td><xsl:value-of select="/Crown_of_Polish_Mountains/author/university"/></td>
							<td><xsl:value-of select="/Crown_of_Polish_Mountains/author/a_id"/></td>
						</tr>
					</table>
				</div>
				<p>Date of Report Generation: <xsl:value-of select="current-dateTime()" /></p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
