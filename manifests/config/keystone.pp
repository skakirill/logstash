
class logstash::config::keystone::input
{
  logstash::config{"input-keystone.conf":
    content =>"
input{
  # keystone logs
  file {
    type => \"keystone\"
    path => [ \"/var/log/keystone/*.log\" ]
    tags => \"use_nova_filter\"
  }
}
" 
  }
}
