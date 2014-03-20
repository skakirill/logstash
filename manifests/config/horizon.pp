
class logstash::config::horizon::input
{
  logstash::config{"input-horizon.conf":
    content =>"
input{
  # horizon logs
  file {
    type => \"horizon\"
    path => [ \"/var/log/horizon/*.log\" ]
    tags => \"use_nova_filter\"
  }
}
" 
  }
}
