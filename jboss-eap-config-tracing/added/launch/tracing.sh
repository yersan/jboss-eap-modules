# only processes a single environment as the placeholder is not preserved

configure() {
  echo "Configure tracing, file is " $CONFIG_FILE
  local markers=("<!-- ##TRACING_EXTENSION## -->" "<!-- ##TRACING_SUBSYSTEM## -->")

  local markersFlag=0
  for i in ${markers[@]}
    do
      if fgrep -qf $i $CONFIG_FILE; then
         markersFlag=1
         break
      fi
  done

  if [[ ${markersFlag} -gt 0 ]]; then
    markers
  else
    ciScript
  fi
}

function markers() {
  if [ "x${WILDFLY_TRACING_ENABLED}" == "xtrue" ]; then

    local extension="<extension module=\"org.wildfly.extension.microprofile.opentracing-smallrye\"/>"
    local subsystem="<subsystem xmlns=\"urn:wildfly:microprofile-opentracing-smallrye:1.0\"/>"

    sed -i "s|<!-- ##TRACING_EXTENSION## -->|${extension}|" $CONFIG_FILE
    sed -i "s|<!-- ##TRACING_SUBSYSTEM## -->|${subsystem}|" $CONFIG_FILE
  fi
}

function ciScript() {
    local extension="/extension=org.wildfly.extension.microprofile.opentracing-smallrye:add()"
    local subsystem="/subsystem=microprofile-opentracing-smallrye:add()"

    if [ "x${WILDFLY_TRACING_ENABLED}" == "xtrue" ]; then
        echo ${extension} >> $CLI_SCRIPT_FILE
        echo ${subsystem} >> $CLI_SCRIPT_FILE
    fi
}
