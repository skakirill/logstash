class logstash::config::libvirt::input
{
  logstash::config{"input-libvirt.conf":
    content =>'
input{
  # libvirt logs
  file {
    type => "libvirt"
    path => [ "/var/log/libvirt/*.log" ]
  }
}
' 
  }
}

class logstash::config::libvirt::filter
{
  logstash::config{"filter-libvirt.conf":
    content =>'
filter{
  ## Parse libvirt
  if [type] == "libvirt" {
    grok {
      match => [
                "message",
                "%{DATE:dt} %{TIME:tm}[+0-9]*: +%{INT:pid}: +%{WORD:level} +: +(?<message>.*)"
               ]
      overwrite => ["message"]
      keep_empty_captures => true
      add_field => ["timestamp","%{dt} %{tm}"]
      remove_field => ["dt","tm"]
      add_tag => ["libvirt1_parsed"]
      tag_on_failure => libvirt1_failed
    }
    ## Parse source:line
    if "libvirt1_parsed" in [tags] {
      grok {
        match => [
                  "message",
                  "^(?<source>[a-zA-Z0-9]*:[0-9]*) : (?<message>.*)"
                 ]
        overwrite => ["message"]
        keep_empty_captures => true
        add_tag => ["libvirt2_parsed"]
        tag_on_failure => libvirt2_failed
      }
    }
  }
}
'
  }
}
