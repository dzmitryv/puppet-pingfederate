# run.properties defaults
# see https://documentation.pingidentity.com/pingfederate/pf82/index.shtml#adminGuide/concept/changingConfigurationParameters.html
# and /opt/pingfederate-$PF_VERSION/pingfederate/bin/run.properties
class pingfederate::params {
  # package details (TODO: figure out how to get this from the installed RPM)
  $install_dir                         = '/opt/pingfederate'
  # add-on packages: social media oauth adapters
  $adapter_facebook                    = false
  $adapter_google                      = false
  $adapter_linkedin                    = false
  $adapter_twitter                     = false
  $adapter_windowslive                 = false
  # various run.properties:
  $admin_https_port                    = 9999
  $admin_hostname                      = undef
  $console_bind_address                = '0.0.0.0'
  $console_title                       = 'PingFederate'
  $console_session_timeout             = 30
  $console_login_mode                  = 'multiple'
  $console_authentication              = 'native'
  $admin_api_authentication            = 'native'
  # ldap_properties, etc. just default to run.properties values
  $http_port                           = -1
  $https_port                          = 9031
  $secondary_https_port                = -1
  $engine_bind_address                 = '0.0.0.0'
  $monitor_bind_address                = '0.0.0.0'
  # engine_prefer_ipv4, runtime_context_path default
  $log_event_detail                    = false
  $heartbeat_system_monitoring         = false
  $operational_mode                    = 'STANDALONE'
  $cluster_node_index                  = 0
  $cluster_auth_pwd                    = undef
  $cluster_encrypt                     = false
  $cluster_bind_address                = 'NON_LOOPBACK'
  $cluster_bind_port                   = 7600
  $cluster_failure_detection_bind_port = 7700
  $cluster_transport_protocol          = 'tcp'
  $cluster_mcast_group_address         = '239.16.96.69'
  $cluster_mcast_group_port            = 7601
  $cluster_tcp_discovery_initial_hosts = undef
  $pf_cluster_diagnostics_enabled      = false
  $pf_cluster_diagnostics_addr         = '224.0.75.75'
  $pf_cluster_diagnostics_port         = 7500
  # no HSM, etc. got bored retyping
}