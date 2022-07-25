<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs oxy"
    xmlns:oxy="http://www.oxygenxml.com/extensions"
    version="2.0">
  <xsl:output indent="yes" method="xml" doctype-public="-//OASIS//DTD DITA Map//EN" doctype-system="map.dtd"/>
    <!-- Create a key definitions DITA Map with key defs for all external references.-->
    <xsl:template match="/">
        <map>
          <xsl:for-each select="//*[contains(@class, '- topic/link ') or contains(@class, '- topic/xref ')][@scope='external'][not(@keyref)]">
                <keydef>
                  <xsl:attribute name="keys">
                    <xsl:value-of select="oxy:extractKeyName(@href)"/>
                  </xsl:attribute>
                  <xsl:attribute name="href" select="@href"/>
                </keydef>
            </xsl:for-each>
        </map>
    </xsl:template>
  <!-- Try to create a key name from a reference value -->
  <xsl:function name="oxy:extractKeyName">
    <xsl:param name="reference"/>
    <xsl:variable name="processed" select="replace($reference, '\.', '_')"/>
    <xsl:variable name="processed" select="replace($processed, '%20', '_')"/>
    <xsl:variable name="processed" select="replace($processed, '\.', '_')"/>
    <xsl:variable name="processed" select="replace($processed, 'http://', '')"/>
    <xsl:variable name="processed" select="replace($processed, 'https://', '')"/>
    <xsl:value-of select="$processed"/>
  </xsl:function>
</xsl:stylesheet>