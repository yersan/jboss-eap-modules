@jboss-eap-7 @jboss-eap-7-tech-preview
Feature: Openshift EAP galleon s2i tests

  Scenario: Galleon provision cloud-server
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    | variable                        | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | cloud-server |
    Then container log should contain WFLYSRV0025
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: Galleon provision jaxrs-server
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    | variable                        | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | jaxrs-server |
    Then container log should contain WFLYSRV0025
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: Galleon provision datasources-web-server
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    | variable                        | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | datasources-web-server |
    Then container log should contain WFLYSRV0025
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value datasources-web-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value datasources-web-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: Galleon provision web-clustering
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    | variable                        | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | cloud-server,web-clustering            |
    Then container log should contain WFLYSRV0025
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value web-clustering on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value web-clustering on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
  
  Scenario: build the example, then check that cloud-server and postgresql-driver are provisioned and artifacts are downloaded
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-postgres
    Then s2i build log should contain Downloaded
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value postgresql-datasource on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value postgresql-datasource on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: build the example, then check that cloud-server and postgresql-driver are provisioned and artifacts are not downloaded
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-postgres with env and true
    Then s2i build log should not contain Downloaded
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value postgresql-datasource on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value postgresql-datasource on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: build the jaxrs example and jaxrs server from user defined server, then check that jaxrs-server is provisioned
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-jaxrs with env and true
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: build the jaxrs example, then check that galleon env var overrides user defined galleon server
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-jaxrs with env and true
    | variable          | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | core-server |
    Then file /s2i-output/server/.galleon/provisioning.xml should exist
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value core-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /s2i-output/server/.galleon/provisioning.xml should contain value core-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

  Scenario: failing to build the example due to invalid user defined galleon definition
    Given failing s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-jaxrs using master
    | variable          | value                                                                                  |
    | GALLEON_VERSION | 0.0.0.Foo |

  Scenario: failing to build the example due to multiple env vars in conflict
    Given failing s2i build git://github.com/openshift/openshift-jee-sample from . using master
    | variable          | value                                                                                  |
    | GALLEON_PROVISION_SERVER        | slim-default-server |
    | GALLEON_PROVISION_LAYERS        | cloud-server       |
 
  Scenario: build the example without galleon, check that s2i-output doesn't contain a copied server
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    Then file /s2i-output/server/ should not exist

  Scenario: build the example with galleon, check that s2i-output contain a copied server
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
    | variable          | value                                                                                  |
    | GALLEON_PROVISION_DEFAULT_FAT_SERVER        | true |
    Then file /s2i-output/server/ should exist

  Scenario: build the keycloak examples, then checks failure when applying config change on cloud-server (no sso).
    Given XML namespaces
       | prefix | url                          |
       | ns     | urn:jboss:domain:keycloak:1.1 |
    Given s2i build https://github.com/redhat-developer/redhat-sso-quickstarts from . with env and true using 7.0.x-ose
       | variable               | value                                            |
       | ARTIFACT_DIR           | app-jee-jsp/target,app-profile-jee-jsp/target |
       | SSO_REALM         | demo    |
       | SSO_PUBLIC_KEY    | MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiLezsNQtZSaJvNZXTmjhlpIJnnwgGL5R1vkPLdt7odMgDzLHQ1h4DlfJPuPI4aI8uo8VkSGYQXWaOGUh3YJXtdO1vcym1SuP8ep6YnDy9vbUibA/o8RW6Wnj3Y4tqShIfuWf3MEsiH+KizoIJm6Av7DTGZSGFQnZWxBEZ2WUyFt297aLWuVM0k9vHMWSraXQo78XuU3pxrYzkI+A4QpeShg8xE7mNrs8g3uTmc53KR45+wW1icclzdix/JcT6YaSgLEVrIR9WkkYfEGj3vSrOzYA46pQe6WQoenLKtIDFmFDPjhcPoi989px9f+1HCIYP0txBS/hnJZaPdn5/lEUKQIDAQAB  |
       | SSO_URL           | http://localhost:8080/auth    |
       | MAVEN_ARGS_APPEND | -Dmaven.compiler.source=1.6 -Dmaven.compiler.target=1.6 |
       | GALLEON_PROVISION_LAYERS | cloud-server |
    Then container log should contain WFLYCTL0310: Extension module org.keycloak.keycloak-adapter-subsystem not found

  Scenario: failing to build the example due to invalid layer name
    Given failing s2i build git://github.com/openshift/openshift-jee-sample from . using master
    | variable          | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | foo |

  Scenario: failing to build the example due to invalid layer name
    Given failing s2i build git://github.com/openshift/openshift-jee-sample from . using master
    | variable          | value                                                                                  |
    | GALLEON_PROVISION_LAYERS        | cloud-server,foo |

  Scenario: Test custom settings with galleon
   Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-settings with env and true
    | variable                     | value                                                 |
    | GALLEON_PROVISION_LAYERS     | cloud-server  |
    Then container log should contain WFLYSRV0025
    Then file /home/jboss/.m2/settings.xml should contain foo-repository

  Scenario: Test custom settings by env with galleon
    Given s2i build git://github.com/openshift/openshift-jee-sample from . with env and true using master
     | variable                     | value                                                 |
     | MAVEN_SETTINGS_XML           | /home/jboss/../jboss/../jboss/.m2/settings.xml |
     | GALLEON_PROVISION_LAYERS     | cloud-server  |
    Then s2i build log should contain /home/jboss/../jboss/../jboss/.m2/settings.xml
    Then container log should contain WFLYSRV0025

 Scenario: Galleon provision cloud-server with user redefined MAVEN_ARGS
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-empty with env and true
    | variable                        | value        |
    | MAVEN_ARGS                      | foo          |
    | GALLEON_PROVISION_LAYERS        | cloud-server |
    Then container log should contain WFLYSRV0025
    Then file /opt/eap/.galleon/provisioning.xml should exist
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name

Scenario: Test jaxrs-server -jpa +jpa-distributed
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-jpa2lc with env and True using master
      | variable                             | value                                                    |
      | GALLEON_PROVISION_LAYERS             | jaxrs-server,-jpa,jpa-distributed,h2-default-datasource  |
    Then container log should contain WFLYSRV0025
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc                        |
      | port                  | 8080                                    |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc/create/1               |
      | port                  | 8080                                    |
      | expected_phrase       | 1 created                               |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc/isInCache/1            |
      | port                  | 8080                                    |
      | expected_phrase       | true                                    |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc/cache/1                |
      | port                  | 8080                                    |
      | expected_phrase       | 1                                       |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc/evict/1                |
      | port                  | 8080                                    |
      | expected_phrase       | 1 evict                                 |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-jpa2lc/isInCache/1            |
      | port                  | 8080                                    |
      | expected_phrase       | false                                   |
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jpa-distributed on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jpa on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='exclude']/@name

  Scenario: Test jaxrs-server +ejb-lite, -ejb-local-cache +ejb-dist-cache. Verify JGroups configuration added by ejb-dist-cache
    Given s2i build git://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-ejb with env and True using master
      | variable                             | value                                                    |
      | GALLEON_PROVISION_LAYERS             | jaxrs-server,ejb-lite,-ejb-local-cache,ejb-dist-cache    |
    Then container log should contain WFLYSRV0025
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-ejb                           |
      | port                  | 8080                                    |
    Then check that page is served
      | property              | value                                   |
      | path                  | /test-app-ejb/messages/hello            |
      | port                  | 8080                                    |
      | expected_phrase       | sfsb_hello                              |
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value jaxrs-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value ejb-dist-cache on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/eap/.galleon/provisioning.xml should contain value ejb-local-cache on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='exclude']/@name
    Then XML file /opt/eap/standalone/configuration/standalone-openshift.xml should have 1 elements on XPath //*[local-name()='subsystem' and starts-with(namespace-uri(), 'urn:jboss:domain:jgroups:')]//*[local-name()='channel'][@name='ee' and @stack='tcp']
    Then XML file /opt/eap/standalone/configuration/standalone-openshift.xml should have 1 elements on XPath //*[local-name()='subsystem' and starts-with(namespace-uri(), 'urn:jboss:domain:jgroups:')]//*[local-name()='transport'][@type='TCP' and @socket-binding='jgroups-tcp']
    Then XML file /opt/eap/standalone/configuration/standalone-openshift.xml should have 1 elements on XPath //*[local-name()='subsystem' and starts-with(namespace-uri(), 'urn:jboss:domain:jgroups:')]//*[local-name()='transport'][@type='UDP' and @socket-binding='jgroups-udp']
    Then XML file /opt/eap/standalone/configuration/standalone-openshift.xml should have 0 elements on XPath //*[local-name()='subsystem' and starts-with(namespace-uri(), 'urn:jboss:domain:jgroups:')]//*[local-name()='stack'][@name='tcp']/*[local-name()='protocol' and @type='MPING']
    Then XML file /opt/eap/standalone/configuration/standalone-openshift.xml should have 0 elements on XPath //*[local-name()='subsystem' and starts-with(namespace-uri(), 'urn:jboss:domain:jgroups:')]//*[local-name()='stack'][@name='udp']/*[local-name()='protocol' and @type='PING'] 
