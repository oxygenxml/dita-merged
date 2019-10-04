<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <!-- Create a relationship table from merged XML content.-->
    <xsl:template match="/">
        <reltable>
            <xsl:for-each select="//*[contains(@class, '- topic/link ')]">
                <relrow>
                    <relcell>
                        <xsl:variable name="uniqueID" select="(ancestor::*[contains(@class, ' topic/topic ')])[1]/@id"/>
                        <xsl:variable name="originalLocationOfCurrentTopic" select="(//*[contains(@class, ' map/topicref ')][@first_topic_id = concat('#', $uniqueID)])/@ohref"/>
                        <topicref href="{$originalLocationOfCurrentTopic}"/>
                    </relcell>
                    <relcell>
                        <topicref href="{@ohref}"/>    
                    </relcell>
                </relrow>
            </xsl:for-each>
        </reltable>
    </xsl:template>
    
</xsl:stylesheet>