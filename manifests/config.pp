define logstash::config($ensure=present,$content)
{
  Class['logstash::install'] -> Logstash::Config[$name] -> Class['logstash::service']

  $conf_dir = $logstash::conf_dir

  File{
    owner => root,
    group => root,
  }

  file{"${conf_dir}/${name}":
    ensure => $ensure,
    mode => 644,
    content => $content,
    notify => Class['logstash::service']
  }
}
