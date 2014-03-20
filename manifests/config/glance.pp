
class logstash::config::glance::input
{
  logstash::config{"input-glance.conf":
    content =>"
input{
  # glance logs
  file {
    type => \"glance\"
    path => [ \"/var/log/glance/*.log\" ]
    tags => \"use_nova_filter\"
  }
}
" 
  }
}
