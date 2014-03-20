class logstash::config::nova::input
{
  logstash::config{"input-nova.conf":
    content =>"
input{
  # nova logs
  file {
    type => \"nova\"
    path => [ \"/var/log/nova/*.log\" ]
    tags => \"use_nova_filter\"
  }
}
" 
  }
}

class logstash::config::nova::filter
{
  logstash::config{"filter-nova.conf":
    content =>'
filter {

  if "use_nova_filter" in [tags] {
    grok {
      match => [
                "message",
                "%{DATE:dt} %{TIME:tm} %{NUMBER:pid} %{WORD:level} (?<service>[A-Za-z0-9_.\-]*) (?<message>.*)"
               ]
      overwrite => ["message"]
      keep_empty_captures => true
      add_field => ["timestamp","%{dt} %{tm}"]
      remove_field => ["dt","tm"]
      add_tag => ["nova1_parsed"]
      remove_tag => ["use_nova_filter"]
      tag_on_failure => false
    }

    ## Remove [-]
    if "nova1_parsed" in [tags] {
      grok {
        match => [
                  "message",
                  "^\[\-\] (?<message>.*)"
                 ]
        overwrite => ["message"]
        keep_empty_captures => true
        add_tag => ["nova2_parsed"]
        tag_on_failure => false
      }
    }

    ## Parse [req- ]
    if "nova1_parsed" in [tags] {
      grok {
        match => [
                  "message",
                  "^\[req\-(?<req>[0-9a-zA-Z\- ]*)\] (?<message>.*)"
                 ]
        overwrite => ["message"]
        keep_empty_captures => true
        add_tag => ["nova3_parsed"]
        tag_on_failure => false
      }
    }

    ## Parse [instance: ]
    if "nova1_parsed" in [tags] {
      grok {
        match => [
                  "message",
                  "^\[instance: (?<instance>[0-9a-z\-]*)\] (?<message>.*)"
                 ]
        overwrite => ["message"]
        keep_empty_captures => true
        add_tag => ["nova4_parsed"]
        tag_on_failure => false
      }
    }
  }
}
' 
  }
  
}
