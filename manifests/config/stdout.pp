class logstash::config::stdout($debug=false)
{
  logstash::config{"output-stdout.conf":
    content =>"
output {
  stdout { debug => ${debug} }
}
" 
  }
}
