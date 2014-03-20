class logstash(
)
{
  Class['common::java'] -> Class['logstash']

  $base_dir = "/opt/logstash"
  $conf_dir = "/etc/logstash/conf.d"
  $log_dir  = "/var/log/logstash"
  $jarfile = "logstash.jar"

  class{'logstash::install':
    base_dir => $base_dir,
    log_dir  => $log_dir,
    jarfile => $jarfile,
    conf_dir => $conf_dir
  }
  class{'logstash::service':
    base_dir => $base_dir,
    conf_dir => $conf_dir,
    log_dir  => $log_dir,
    jarfile  => $jarfile,
    require  => Class['common::java']
  }
}
