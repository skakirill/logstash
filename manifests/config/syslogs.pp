class logstash::config::syslogs::input
{
  logstash::config{"input-syslogs.conf":
    content =>"
input{
  file {
    type => \"syslogs\"
    path => [ \"/var/log/messages\", \"/var/log/secure\" ]
    debug => true
  }
}"
  }
}


class logstash::config::syslogs::filter
{
  logstash::config{"filter-syslogs.conf":
    content =>"
filter{
  ## Parse syslogs
  if [type] == \"syslogs\" {
    grok {
      match => [
                \"message\",
                \"%{SYSLOGBASE} (?<message>.*)\"
               ]
      overwrite => [\"message\"]
      keep_empty_captures => true
      add_tag => [\"syslogs1_parsed\"]
      tag_on_failure => false
    }
  }

}
" 
  }
}
