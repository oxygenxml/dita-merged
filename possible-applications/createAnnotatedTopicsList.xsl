<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Annotated topics list</title>
            </head>
            <body>
                <h1>Annotated topics list</h1>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Group</th>
                            <th>Topic Title</th>
                            <th>File Name</th>
                            <th>Info Type</th>
                            <th>Topic Owner</th>
                            <th>New</th>
                            <th>Major</th>
                            <th>Minor</th>
                            <th>None</th>
                            <th>Unused</th>
                        </tr>
                    </thead>
                	<xsl:for-each select="//*[contains(@class, ' topic/topic ')]">
                		<xsl:variable name="topLevelTopic" select="(ancestor-or-self::*[contains(@class, ' topic/topic ')])[1]"/>
                		<xsl:variable name="uniqueID" select="$topLevelTopic/@id"/>
                		<xsl:variable name="chunkTopic" select="if(parent::dita[@id]) then parent::dita else ."/>
                		<xsl:variable name="topicrefNoChunk" select="(//*[contains(@class, ' map/topicref ')][@first_topic_id = concat('#', $uniqueID)])"/>
                		<xsl:variable name="topicrefChunk" select="(//*[contains(@class, ' map/topicref ')][@href = concat('#', @chunkTopic/@id)])"/>
                		<xsl:variable name="topicref" select="if(empty($topicrefNoChunk)) then $topicrefChunk else $topicrefNoChunk"/>
                		<tr>
                			<td>
                				<!-- Group -->
                				<xsl:value-of select="document($topicref/@xtrf)/*/*[contains(@class, ' topic/title ')]"/>
                			</td>
                			<td>
                				<!-- Topic Title -->
                				<xsl:value-of select="*[contains(@class, ' topic/title ')]"/>
                			</td>
                			<td>
                				<!-- File Name -->
                				<xsl:variable name="originalLocationOfCurrentTopic" select="if(empty($topicrefNoChunk)) then tokenize(@xtrf, '/')[last()] else $topicref/@ohref"/>
                				<xsl:value-of select="$originalLocationOfCurrentTopic"/>
                			</td>
                			<td>
                				<xsl:value-of select="concat(upper-case(substring($topLevelTopic/local-name(),1,1)),
                					substring($topLevelTopic/local-name(), 2),
                					' '[not(last())]
                					)
                					"/>
                			</td>
                			<td>
                				<xsl:value-of select=".//author"/>
                			</td>
                			<td/>
                			<td/>
                			<td/>
                			<td/>
                			<td/>
                		</tr>
                	</xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>