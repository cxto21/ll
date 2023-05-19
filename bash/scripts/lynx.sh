lynx_dumpHTML_httpS(){
  #1. Check format: http[s]://host:port/path?searchpart#fragment
  lynx -dump $1
}

lynx_dumpHTML_stdin(){
  #1. Check existence o path
  lynx -stdin -dump < $1
}

lynx_seeUserAgent(){#¿an?
  lynx -anonymous -dump https://www.whatismybrowser.com/es/detect/what-is-my-user-agent/ | \
  grep -A 2 "Su agente";
}

lynx_urlReputation(){
  #1. Check format: http[s]://host:port/path?searchpart#fragment
  url=$1
  lynx_dumpHTML_https $url | grep -A 3 "Detections Counts"  
}
