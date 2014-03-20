class logstash::service($base_dir, $conf_dir, $log_dir, $jarfile)
{
  $service = "/etc/init.d/logstash"
  file{$service:
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    content => template("${module_name}/init.d/logstash.erb")
  }
  
  service{'logstash':
    ensure => true,
    enable => true,
    require => File[$service],
  }
}
