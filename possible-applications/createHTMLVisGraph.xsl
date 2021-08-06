<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xhtml" indent="yes"/>
	
    <!-- Create an HTML page with a graph showing how topics link to each other.-->
	<xsl:template match="/">
		<html lang="en">
			<head>
				<title>Network</title>
				<script
					type="text/javascript"
					src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"
					></script>
				<style type="text/css">
					#mynetwork {
					width: 1600px;
					height: 1400px;
					border: 1px solid lightgray;
					}
				</style>
			</head>
			<body>
				<div id="mynetwork"></div>
				<script type="text/javascript">
				<xsl:variable name="var" as="map(xs:string, xs:integer)">
					<xsl:map>
						<xsl:for-each select="//*[contains(@class, ' topic/topic ')][@id]">
							<xsl:map-entry key="xs:string(@id)" select="position()"/>
						</xsl:for-each>
					</xsl:map>
				</xsl:variable>
				<xsl:text>var nodes = new vis.DataSet([</xsl:text>
				<xsl:for-each select="//*[contains(@class, ' topic/topic ')][@id]">{ id: <xsl:value-of select="$var(@id)"/>, label: "<xsl:value-of select="normalize-space(*[contains(@class, ' topic/title ')])"/>" },</xsl:for-each>
				<xsl:text>]);
		</xsl:text>
				<!-- Create links -->
				<xsl:text>var edges = new vis.DataSet([</xsl:text>
				<xsl:for-each select="//*[contains(@class, ' topic/topic ')][@id]">
					<xsl:variable name="id" select="@id"/>
					<xsl:variable name="pos" select="$var(@id)"/>
					<!-- For each link to the topic -->
					<xsl:for-each select="//topic[.//*[starts-with(@href, concat('#', $id, '/')) or @href = concat('#', $id)]]"><xsl:if test="$var(@id) != $pos">{ from: <xsl:value-of select="$var(@id)"/>, to: <xsl:value-of select="$pos"/>, arrows: "to" },</xsl:if></xsl:for-each>
				</xsl:for-each>
				<xsl:text>]);</xsl:text>
				<xsl:text>
					// create a network
      var container = document.getElementById("mynetwork");
      var data = {
        nodes: nodes,
        edges: edges,
      };
      var options = {
      	nodes:{
      		shape: 'box',
      		widthConstraint: 200,
      	}
      };
      var network = new vis.Network(container, data, options);
				</xsl:text>
				</script>
			</body>
		</html>
	</xsl:template>
    
</xsl:stylesheet>