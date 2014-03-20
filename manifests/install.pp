class logstash::install($base_dir,$jarfile, $log_dir, $conf_dir)
{
  File{
    owner => root,
    group => root,
  }

  file{$base_dir:
    ensure => directory,
    mode => 755
  }
  file{"${base_dir}/tmp":
    ensure => directory,
    mode => 755,
    require => File[$base_dir]
  }
  
  file{"${base_dir}/${jarfile}":
    ensure => present,
    mode => 644,
    source => "puppet:///distrib/logstash-1.3.3-flatjar.jar",
    require => File[$base_dir]
  }

  file{$log_dir:
    ensure => directory,
    mode => 755,
  }

  $pid_dir = "/var/run/logstash"
  file{$pid_dir:
    ensure => directory,
    mode => 755
  }

  file{$conf_dir:
    ensure => directory,
    mode => 755
  }

}
