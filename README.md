Xsd2Doctrine
============

Convert XSD to Doctrine 2 PHP classes

Use with saxon-he

- To generate enum types from avs.xsd

saxon -s:xml_samples/avs.xsd -xsl:Resources/templates/simpleTypeToEnum.xsd namespace=WeShareMusic\DDEXBundle\Types

- To generate entities from release-notification.xsd

saxon -s:xml_samples/release-notification.xsd -xsl:Resources/templates/complexTypeToEntity.xsd namespace=WeShareMusic\DDEXBundle\Entity


- To generate ern:complexType extending avs:simpleType

saxon -s:xml_samples/release-notification.xsd -xsl:Resources/templates/complexTypeExtendToEntity.xsl namespace="WeShareMusic\ERNBundle\Entity\AvsExtension" output=/home/bapt/www/WeShareMusic/DDMF/src/WeShareMusic/ERNBundle/Entity/AvsExtension
