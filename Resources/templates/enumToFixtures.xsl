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

  <xsl:template match="//xs:simpleType">
    <xsl:variable name="enumName" select="@name" />
    Creating <xsl:value-of select="$enumName" />  <!-- Creating  -->
    <xsl:result-document href="{$output}/Load{$enumName}Data.php" method="text">(?php

namespace <xsl:value-of select="$namespace" />;

use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use WeShareMusic\ERNBundle\Entity\<xsl:value-of select="$enumName" />;

class Load<xsl:value-of select="$enumName"/>Data implements FixtureInterface
{
    /**
     * {@inheritDoc}
     */
    public function load(ObjectManager $manager)
    {
<xsl:for-each select="./xs:restriction/xs:enumeration">
  <xsl:variable name="varName" select="concat($enumName, replace(./@value, '[-().]', '_'))" />
        $<xsl:value-of select="$varName" /> = new <xsl:value-of select="$enumName"/>();
        $<xsl:value-of select="$varName" />->setValue('<xsl:value-of select="./@value"/>');
        $manager->persist($<xsl:value-of select="$varName" />);
        $manager->flush();

</xsl:for-each>
    }
}
</xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
