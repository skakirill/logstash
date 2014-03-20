
class logstash::config::heat::input
{
  logstash::config{"input-heat.conf":
    content =>"
input{
  # heat logs
  file {
    type => \"heat\"
    path => [ \"/var/log/heat/*.log\" ]
    tags => \"use_nova_filter\"
  }
}
" 
  }
}
