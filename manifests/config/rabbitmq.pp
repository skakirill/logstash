
class logstash::config::rabbitmq::input
{
  logstash::config{"input-rabbitmq.conf":
    content =>"
input{
  # rabbitmq logs
  file {
    type => \"rabbitmq\"
    path => [ \"/var/log/rabbitmq/*.log\", \"/var/log/rabbitmq/shutdown_log\", \"/var/log/rabbitmq/shutup_log\" ]
  }
}
" 
  }
}
