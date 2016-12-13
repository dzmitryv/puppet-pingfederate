# Notes on automating configuration.

## Initial installation settings
### run.properties
Initial settings.
Just a straightforward edit of /opt/pingfederate/bin/run.properties

## What changes
### Diff between initial install and puppet config
```
[root@localhost opt]# diff -rb pingfederate-unconf pingfederate-conf1 |egrep ^diff\|Only
Only in pingfederate-conf1/pingfederate/bin: pingfederate.pid
diff -rb pingfederate-unconf/pingfederate/bin/run.properties pingfederate-conf1/pingfederate/bin/run.properties
Only in pingfederate-conf1/pingfederate: log
Only in pingfederate-conf1/pingfederate/server/default/conf: pingfederate.lic
Only in pingfederate-conf1/pingfederate/server/default/data/config-store: com.pingidentity.crypto.jwk.MasterKeySet.xml
Only in pingfederate-conf1/pingfederate/server/default/data/config-store: com.pingidentity.page.Login.xml
Only in pingfederate-conf1/pingfederate/server/default/data/config-store: InternalState.xml
Only in pingfederate-conf1/pingfederate/server/default/data/config-store: org.sourceid.common.InternalStateManager.xml
diff -rb pingfederate-unconf/pingfederate/server/default/data/config-store/org.sourceid.config.CoreConfig.xml pingfederate-conf1/pingfederate/server/default/data/config-store/org.sourceid.config.CoreConfig.xml
diff -rb pingfederate-unconf/pingfederate/server/default/data/config-store/org.sourceid.saml20.domain.mgmt.impl.SslServerPkCertManagerImpl.xml pingfederate-conf1/pingfederate/server/default/data/config-store/org.sourceid.saml20.domain.mgmt.impl.SslServerPkCertManagerImpl.xml
Only in pingfederate-conf1/pingfederate/server/default/data/config-store: org.sourceid.util.license.Data.xml
Only in pingfederate-conf1/pingfederate/server/default/data/module: provisioner-notify.txt
Only in pingfederate-conf1/pingfederate/server/default/data: pf.jwk
diff -rb pingfederate-unconf/pingfederate/server/default/data/pingfederate-admin-user.xml pingfederate-conf1/pingfederate/server/default/data/pingfederate-admin-user.xml
Only in pingfederate-conf1/pingfederate/server/default/data: ping-ssl-client-trust-cas.jks
Only in pingfederate-conf1/pingfederate/server/default/data: ping-ssl-server.jks
Only in pingfederate-conf1/pingfederate/server/default: tmp
Only in pingfederate-conf1/pingfederate: work
```

### After walking through the configuration pages

```
[root@localhost opt]# diff -rb pingfederate-conf[12] | egrep ^diff\|Only
diff -rb pingfederate-conf1/pingfederate/log/2016_12_09.request2.log pingfederate-conf2/pingfederate/log/2016_12_09.request2.log
diff -rb pingfederate-conf1/pingfederate/log/admin.log pingfederate-conf2/pingfederate/log/admin.log
diff -rb pingfederate-conf1/pingfederate/log/init.log pingfederate-conf2/pingfederate/log/init.log
diff -rb pingfederate-conf1/pingfederate/log/provisioner.log pingfederate-conf2/pingfederate/log/provisioner.log
diff -rb pingfederate-conf1/pingfederate/log/server.log pingfederate-conf2/pingfederate/log/server.log
diff -rb pingfederate-conf1/pingfederate/server/default/data/config-store/com.pingidentity.page.Login.xml pingfederate-conf2/pingfederate/server/default/data/config-store/com.pingidentity.page.Login.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/config-store/InternalState.xml pingfederate-conf2/pingfederate/server/default/data/config-store/InternalState.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/config-store/org.sourceid.common.InternalStateManager.xml pingfederate-conf2/pingfederate/server/default/data/config-store/org.sourceid.common.InternalStateManager.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/config-store/org.sourceid.config.CoreConfig.xml pingfederate-conf2/pingfederate/server/default/data/config-store/org.sourceid.config.CoreConfig.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/config-store/org.sourceid.saml20.domain.mgmt.impl.SslServerPkCertManagerImpl.xml pingfederate-conf2/pingfederate/server/default/data/config-store/org.sourceid.saml20.domain.mgmt.impl.SslServerPkCertManagerImpl.xml
Only in pingfederate-conf2/pingfederate/server/default/data/local: p1-conn-factory-local-state.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/module/saas-provisioner.xml pingfederate-conf2/pingfederate/server/default/data/module/saas-provisioner.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/oauth-authz-server-settings.xml pingfederate-conf2/pingfederate/server/default/data/oauth-authz-server-settings.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/pf.jwk pingfederate-conf2/pingfederate/server/default/data/pf.jwk
diff -rb pingfederate-conf1/pingfederate/server/default/data/pingfederate-admin-user.xml pingfederate-conf2/pingfederate/server/default/data/pingfederate-admin-user.xml
diff -rb pingfederate-conf1/pingfederate/server/default/data/sourceid-saml2-local-metadata.xml pingfederate-conf2/pingfederate/server/default/data/sourceid-saml2-local-metadata.xml
```

## Accepting the PingIdentity agreement
_com.pingidentity.page.Login.xml_
```bash
diff -r -b pingfederate-8.2.2/pingfederate/server/default/data/config-store/org.sourceid.config.CoreConfig.xml
```

This accepts the license agreement _and_ indicates that the initial setup is complete:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<con:config xmlns:con="http://www.sourceid.org/2004/05/config">
    <con:map name="license-map">
        <con:item name="initial-setup-done">true</con:item>
        <con:item name="license-agreement-accepted">true</con:item>
    </con:map>
</con:config>
```

## Installing the license file

It looks like the only documented method is a click-through upload, but
just dropping the file in `/opt/pingfederate/server/default/conf/pingfederate.lic`
will do the same thing.
See the [docs](https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#adminGuide/task/toIinstallReplacementLicenseKeyUsingAdministrativeConsole.html).

## Initial runtime settings
This is set after clicking `Next` through PingOne Account, License, Basic Information,
Enable Roles, Administrator Account. These credentials are required in order to do HTTP
Basic Auth for the pf-admin REST API. I _think (hope)_ the rest can be done from the API
once this is configured. Might also need to use this for setting up the external (Shibboleth)
IdP.

### Native login setup
_pingfederate/server/default/data/sourceid-saml2-local-metadata.xml_

For `pf.console.authentication=native`, the built-in "local" SAML2 IdP is defined.

## Initial administrator user credentials
_pingfederate/server/default/data/pingfederate-admin-user.xml_


## Commandline/API tools
### Configcopy commandline tools
_pingfederate/bin/configcopy_templates/README.txt_

See [configcopy](https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#adminGuide/concept/automatingConfigurationMigration.html)


### pf admin api
See https://localhost:9999/pf-admin-api/api-docs/ for self-documented configuration APIs.


https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#adminGuide/concept/pingFederateAdministrativeApi.html

## Non-UI/API Configuration of various XML files
A number of PingFederate configurations are done by directly editing the XML files and are documented as such.
Simply use the Puppet Augeas module to edit these.

These are some of the XML files that need editing:
```bash
$ find . -name *.bak
./etc/webdefault.xml.bak
./server/default/conf/META-INF/hivemodule.xml.bak
./server/default/data/config-store/org.sourceid.oauth20.domain.ClientManagerJdbcImpl.xml.bak
./server/default/data/config-store/org.sourceid.common.ExpressionManager.xml.bak
$
```

### Enabling OGNL
_/pingfederate/server/default/data/config-store/org.sourceid.common.ExpressionManager.xml_

OGNL scripting maybe need to be
[enabled](https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#concept_enablingAndDisablingExpressions.html)
in order to rewrite, for example, data returned from a SAML IdP that is passed along to an OAuth 2 resource server as
part of token validation.

### Allowing CORS
_/pingfederate/etc/webdefault.xml_
See the [W3C CORS](https://www.w3.org/TR/cors/) recommendation.

I found that [this approach](http://community.unboundid.com/t5/Data-Broker/Configuring-CORS-in-Ping-Federate-so-that-Data-Broker-s-Sample/ta-p/324)
works. There's probably a more secure url-pattern that I should use.

```XML
<web-app>
  ...
  <!-- enable CORS for all endpoints and allow all origins -->
    <filter>
	    <filter-name>cross-origin</filter-name>
        <filter-class>org.eclipse.jetty.servlets.CrossOriginFilter</filter-class>
	    <init-param>
		     <param-name>allowedOrigins</param-name>
		     <param-value>*</param-value>
		</init-param>
		<init-param>
		     <param-name>allowedMethods</param-name>
		     <param-value>GET,OPTIONS,POST</param-value>
		</init-param>
	</filter>
	<filter-mapping>
	    <filter-name>cross-origin</filter-name>
	    <url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>
```

### Configuring runtime state management services
Mostly used to configure JDBC connectors for OAuth 2.0 client management and the like.

#### ping OAuth Client Manager service using mysql JDBC
See [defining an OAuth Client Datastore](https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#concept_definingOauthClientDataStore.html)
for instructions.

Need to `cp /usr/share/java/mysql-connector-java-5.1.17.jar /opt/pingfederate/server/default/lib/` (via Puppet of course)
which depends on mysql-connector-java. The mysql datastore has to be up and properly configured in order to add it using
the pf-admin-api. See sample setup (also to be puppetized):

```bash
sudo yum install -y mysql-utilities mysql-server mysql mysql-connector-java
sudo mysqld start
/usr/bin/mysqladmin --user=root -h localhost.localdomain password 'new-password'
/usr/bin/mysqladmin --user=root --password=new-password -h localhost.localdomain create pingfed
mysql -u root -p pingfed
mysql> create user 'pingfed' identified by 'foobar';
mysql> grant all on pingfed.* to 'pingfed';
mysql -u pingfed -p pingfed </opt/pingfederate/server/default/conf/oauth-client-management/sql-scripts/oauth-client-management-mysql.sql
```

_server/default/conf/META-INF/hivemodule.xml_

```XML
<module id="com.pingfederatehive" version="1.0.1">
	...
    <service-point id="ClientManager" interface="org.sourceid.oauth20.domain.ClientManager">
        <invoke-factory>
            <construct class="org.sourceid.oauth20.domain.ClientManagerJdbcImpl"/>
        </invoke-factory>
    </service-point>	
```

This one is set from the pf-admin-api with a 
`POST https://localhost:9999/pf-admin-api/v1/dataStores` with these something like these form paramters:
```JSON
{
  "type": "JDBC",
  "id": "myOauth2JDBC", # this is ignored
  "maskAttributeValues": "false",
  "connectionUrl": "jdbc:mysql://localhost/pingfed?autoReconnect=true",
  "driverClass": "com.mysql.jdbc.Driver",
  "userName": "pingfed",
  "password": "foobar",
  "validateConnectionSql": "SELECT 1 from dual",
  "allowMultiValueAttributes": "true"  
}```			 

REPONSE:
```JSON
{
  "type": "JDBC",
  "id": "JDBC-29709F2FB27DF343C7D9DC9008AF921850F94436",
  "maskAttributeValues": false,
  "connectionUrl": "jdbc:mysql://localhost/pingfed?autoReconnect=true",
  "driverClass": "com.mysql.jdbc.Driver",
  "userName": "pingfed",
  "encryptedPassword": "eyJhbGciOiJkaXIiLCJlbmMiOiJBMTI4Q0JDLUhTMjU2Iiwia2lkIjoibXZxbGRIdXhleiIsInZlcnNpb24iOiI4LjIuMi4wIn0..kt0NgojDO5rH_RzgG2zPxQ.Yv8qd8d3qQXx-5aE8k0NiA.2r6zgFEgOZ5WKn0VyuqbRg",
  "validateConnectionSql": "SELECT 1 from dual",
  "allowMultiValueAttributes": true
}
```

As such, the server needs to be running before this can happen and so we can get the system-assigned ID.

Once we have that, edit the XML files. This is kind of a circular dependency as editing the XML files will
require a server restart. I guess we get to 
use [wait_for](https://forge.puppet.com/basti1302/wait_for)
combined with [this sourceforge answer](http://stackoverflow.com/questions/8244663/puppet-wait-for-a-service-to-be-ready)
for both the mysql database to be ready as well as the pf-admin-api.

_server/default/data/pingfederate-jdbc-ds.xml_

The first `local-tx-datasource`, below, is the JDBC connection for OAuth 2.0.
The second, currently shown as hypersonic, also may need to be convereted to JDBC.

```XML
<?xml version="1.0" encoding="UTF-8"?>
<datasources>
    <local-tx-datasource maskAttributeValues="false">
        <description>jdbc:mysql://localhost/pingfed?autoReconnect=true</description>
        <jndi-name>JDBC-77D1C677602129964A4EB33124AF3CFB8D9E2475</jndi-name>
        <connection-url>jdbc:mysql://localhost/pingfed?autoReconnect=true</connection-url>
        <driver-class>com.mysql.jdbc.Driver</driver-class>
        <user-name>pingfed</user-name>
        <password>eyJhbGciOiJkaXIiLCJlxxxxOiJBMTI4Q0JDLUhTMjU2Iiwia2lkIjoieFE4b3Vac2NYSiIsInZlcnNpb24iOiI4LjIuMi4wIn0..CKEcsCKPBzHvNbcbvfGLpg.zx8uTapX1TOs6McL6K1atw.krVkVEjV3x4enEeOAxBvCg</password>
        <check-valid-connection-sql>SELECT 1 from dual</check-valid-connection-sql>
        <ping-db-type>Custom</ping-db-type>
        <allow-multi-value-attributes>true</allow-multi-value-attributes>
    </local-tx-datasource>
    <local-tx-datasource maskAttributeValues="false">
        <description>jdbc:hsqldb:${pf.server.data.dir}${/}hypersonic${/}ProvisionerDefaultDB;hsqldb.lock_file=false</description>
        <jndi-name>ProvisionerDS</jndi-name>
        <connection-url>jdbc:hsqldb:${pf.server.data.dir}${/}hypersonic${/}ProvisionerDefaultDB;hsqldb.lock_file=false</connection-url>
        <driver-class>org.hsqldb.jdbcDriver</driver-class>
        <user-name>sa</user-name>
        <password>eyJhbGciOiJkaXIiLCJlbmMiOiJBMTI4Q0JDLUhTMjU2Iiwia2lkIjoieFE4b3Vac2NYSiIsInZlcnNpb24iOiI4LjIuMi4wIn0..pGVO-2n0Y9VjpKaFVmn0mw.0XBaUyWxXJZVfNxND4pzEA.7qTXM5ppDiBje1mJ4jMmAQ</password>
        <ping-db-type>Custom</ping-db-type>
        <allow-multi-value-attributes>false</allow-multi-value-attributes>
    </local-tx-datasource>
</datasources>
```

_server/default/data/config-store/org.sourceid.oauth20.domain.ClientManagerJdbcImpl.xml_

The JNDIName from above needs to be inserted here.

```XML
<?xml version="1.0" encoding="UTF-8"?>
<c:config xmlns:c="http://www.sourceid.org/2004/05/config">
    <c:item name="PingFederateDSJNDIName">JDBC-77D1C677602129964A4EB33124AF3CFB8D9E2475</c:item>
</c:config>
```


