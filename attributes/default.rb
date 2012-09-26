# FIXME: right now, the statsd network is ignored -- the statsd-c implementation
# we're using binds 0.0.0.0.
default["statsd"]["flush_interval"] = 60                                    # node_attribute
default["statsd"]["services"]["statsd"]["port"] = 8125                      # node_attribute
default["statsd"]["services"]["statsd"]["network"] = "management"           # node_attribute

default["graphite"]["services"]["api"]["port"] = 80                         # node_attribute
default["graphite"]["services"]["api"]["network"] = "public"                # node_attribute

default["carbon"]["services"]["line-receiver"]["port"] = 2003               # node_attribute
default["carbon"]["services"]["line-receiver"]["network"] = "management"    # node_attribute

default["carbon"]["services"]["pickle-receiver"]["port"] = 2004             # node_attribute
default["carbon"]["services"]["pickle-receiver"]["network"] = "management"  # node_attribute

default["carbon"]["services"]["cache-query"]["port"] = 7002                 # node_attribute
default["carbon"]["services"]["cache-query"]["network"] = "management"      # node_attribute

case platform
when "fedora"
  default["graphite"]["platform"] = {
    "carbon_packages" => ["carbon"],                                # node_attribute
    "carbon_service" => "carbon-cache",                             # node_attribute
    "carbon_config_source" => "carbon.conf.redhat.erb",             # node_attribute
    "carbon_config_dest" => "/etc/graphite/carbon.conf",            # node_attribute
    "carbon_schema_config" => "/etc/graphite/storage-schemas.conf", # node_attribute
    "whisper_packages" => ["whisper"],                              # node_attribute
    "graphite_packages" => ["graphite-web", "mod_python", "django-tagging"],          # node_attribute
    "package_overrides" => "",                                      # node_attribute
    "carbon_apache_user" => "apache",                               # node_attribute
    "carbon_conf_dir" => "/etc/graphite",                           # node_attribute
    "statsd_service" => "statsd-c",                                 # node_attribute
    "statsd_template" => "/etc/statsd-c/config",                     # node_attribute
    "graphite_pythonpath" => "/opt/graphite/webapp"
  }
when "redhat", "centos"
  default["graphite"]["platform"] = {
    "carbon_packages" => ["carbon"],                                # node_attribute
    "carbon_service" => "carbon-cache",                             # node_attribute
    "carbon_config_source" => "carbon.conf.redhat.erb",             # node_attribute
    "carbon_config_dest" => "/opt/graphite/conf/carbon.conf",            # node_attribute
    "carbon_schema_config" => "/opt/graphite/conf/storage-schemas.conf", # node_attribute
    "whisper_packages" => ["whisper"],                              # node_attribute
    "graphite_packages" => ["graphite-web", "mod_python"],          # node_attribute
    "package_overrides" => "",                                      # node_attribute
    "carbon_apache_user" => "apache",                               # node_attribute
    "carbon_conf_dir" => "/opt/graphite/conf",                           # node_attribute
    "statsd_service" => "statsd-c",                                 # node_attribute
    "statsd_template" => "/etc/statsd-c/config",                     # node_attribute
    "graphite_pythonpath" => "/opt/graphite/webapp"
  }
when "ubuntu"
  default["graphite"]["platform"] = {
    "carbon_packages" =>["python-carbon"],                          # node_attribute
    "carbon_service" => "carbon-cache",                             # node_attribute
    "carbon_schema_config" => "/etc/carbon/storage-schemas.conf",   # node_attribute
    "carbon_config_source" => "",                                   # node_attribute
    "carbon_config_dest" => "/etc/carbon/carbon.conf",              # node_attribute
    "whisper_packages" => ["python-whisper"],                       # node_attribute
    "graphite_packages" => ["graphite"],                            # node_attribute
    "package_overrides" => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'", # node_attribute
    "carbon_apache_user" => "www-data",                             # node_attribute
    "carbon_conf_dir" => "/etc/carbon",                             # node_attribute
    "statsd_service" => "statsd",                                   # node_attribute
    "statsd_template" => "/etc/default/statsd" ,                     # node_attribute
    "graphite_pythonpath" => "/usr/share/graphite/webapp"
  }
end
