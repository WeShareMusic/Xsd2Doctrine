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

  <xsl:template match="//xs:complexType[@name and not(xs:simpleContent)]">
    <xsl:variable name="entityName" select="@name" />
    Creating <xsl:value-of select="$entityName" />  <!-- Creating  -->
    <xsl:result-document href="output/entities/{$entityName}.php" method="text">
(?
namespace <xsl:value-of select="namespace" />;

class <xsl:value-of select="$entityName"/>
{
    <xsl:apply-templates/>
}</xsl:result-document>
  </xsl:template>

  <xsl:template match="//xs:documentation">
  <!-- /** -->
  <!--  * <xsl:value-of select="." /> -->
  <!--  */ -->
   </xsl:template>

  <xsl:template match="//xs:element[@type='xs:boolean']">
  /**
   * @ORM\Column(type="boolean")
   */
    protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[@type='xs:string']">
  /**
   * @ORM\Column(type="string")
   */
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[@type='xs:duration']">
  /**
   * @ORM\Column(type="duration")
   */
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[@type='xs:decimal']">
  /**
   * @ORM\Column(type="float")
   */
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[@type='xs:date']">
  /**
   * @ORM\Column(type="date")
   */
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[starts-with(@type, 'avs:')]">
    <xsl:variable name="type" select="substring-after(./@type, 'avs:')" />
  /**
   * @ORM\Column(type="<xsl:value-of select="$type" />")
   */
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[starts-with(@type, 'ern:') and not(@maxOccurs) and not(@minOccurs)]">
    <xsl:variable name="target" select="substring-after(./@type, 'ern:')" />
    /**
     * @ManyToOne(targetEntity="<xsl:value-of select="./@name" />", inversedBy="<xsl:value-of select="./ancestor::xs:complexType[1]/@name" />s")
     **/
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[starts-with(@type, 'ern:') and not(@maxOccurs) and @minOccurs=0]">
    <xsl:variable name="target" select="substring-after(./@type, 'ern:')" />
    /**
     * @ManyToOne(targetEntity="<xsl:value-of select="./@name" />", inversedBy="<xsl:value-of select="./ancestor::xs:complexType[1]/@name" />s", nullable=true)
     **/
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>

  <xsl:template match="//xs:element[starts-with(@type, 'ern:') and @maxOccurs='unbounded']">
    <xsl:variable name="target" select="substring-after(./@type, 'ern:')" />
    /**
     * @ManyToMany(targetEntity="<xsl:value-of select="./@name" />")
     **/
  protected $<xsl:value-of  select="./@name" />;
  </xsl:template>
</xsl:stylesheet>
