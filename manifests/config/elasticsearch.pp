class logstash::config::elasticsearch::output($es_host="127.0.0.1")
{
  logstash::config{"output-elasticsearch.conf":
    content =>"
output {
  elasticsearch_http {
    host => \"${es_host}\"
  }
}
" 
  }
}
