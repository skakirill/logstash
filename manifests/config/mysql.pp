
class logstash::config::mysql::input
{
  logstash::config{"input-mysql.conf":
    content =>"
input{
  # mysql logs
  file {
    type => \"mysql\"
    path => [ \"/var/log/mysqld/*.log\" ]
  }
}
" 
  }
}
