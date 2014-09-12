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
  <xsl:param name="output" />

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="//xs:extension[starts-with(@base, 'avs:' ) and xs:attribute/@name = 'Namespace' and xs:attribute/@name = 'UserDefinedValue']">
    <xsl:variable name="entityName" select="./ancestor::xs:complexType[1]/@name" />
    Creating <xsl:value-of select="$entityName" />  <!-- Creating  -->
    <xsl:result-document href="{$output}/{$entityName}.php" method="text">(?php

namespace <xsl:value-of select="$namespace" />;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="avs_<xsl:value-of select="$entityName" />")
 */
class <xsl:value-of select="$entityName"/>
{
  /**
   * @ORM\Id
   * @ORM\Column(type="integer")
   * @ORM\GeneratedValue(strategy="AUTO")
   */
  protected $id;

  /**
   * @ORM\Column(type="string", nullable=true)
   */
  protected $Namespace;

  /**
   * @ORM\Column(type="string", nullable=true)
   */
  protected $Version;

  /**
   * @ORM\Column(type="string")
   */
  protected $Value;
}</xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
