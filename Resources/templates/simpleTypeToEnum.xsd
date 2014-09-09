<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://doctrine-project.org/schemas/orm/doctrine-mapping"
  xmlns:xsi="http://www.w3.org/2001/xmlschema-instance"
  xsi:schemalocation="http://doctrine-project.org/schemas/orm/doctrine-mapping http://www.doctrine-project.org/schemas/orm/doctrine-mapping.xsd"
  version="2.0">
  <xsl:strip-space elements="*"/>
  <xsl:output method="text"/>
  <xsl:param name="namespace" />

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="//xs:simpleType">
    <xsl:variable name="enumName" select="@name" />
    Creating <xsl:value-of select="$enumName" />  <!-- Creating  -->
    <xsl:result-document href="output/types/{$enumName}Type.php" method="text">
(?
namespace <xsl:value-of select="namespace" />;

class <xsl:value-of select="$enumName"/>Type extends EnumType
{
protected $name = '<xsl:value-of select="$enumName"/>';
  protected $values = [<xsl:for-each select="./xs:restriction/xs:enumeration">
    "<xsl:value-of select="./@value"/>" => "<xsl:value-of select="./xs:annotation/xs:documentation"/>"<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if></xsl:for-each>
  ];
}</xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
