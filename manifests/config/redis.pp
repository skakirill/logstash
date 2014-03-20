class logstash::config::redis::input($redis_host)
{
  logstash::config{"input-redis.conf":
    content =>"
input{
  redis {
    host => \"$redis_host\"
    # these settings should match the output of the agent
    data_type => \"list\"
    key => \"logstash\"

    # We use the 'json' codec here because we expect to read
    # json events from redis.
    codec => json
  }
}
" 
  }
}

class logstash::config::redis::output($redis_host)
{
  logstash::config{"output-redis.conf":
    content =>"
output {
  redis {
    host => \"$redis_host\"
    # these settings should match the output of the agent
    data_type => \"list\"
    key => \"logstash\"

    # We use the 'json' codec here because we expect to read
    # json events from redis.
    codec => json
  }
}
" 
  }
}
