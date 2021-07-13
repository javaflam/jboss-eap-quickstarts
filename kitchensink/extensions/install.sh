#!/bin/bash
injected_dir=$1
source /usr/local/s2i/install-common.sh

install_modules ${injected_dir}/modules
configure_drivers ${injected_dir}/drivers.env

cli_script=${injected_dir}/configuration.cli

echo "/system-property=http.proxyHost:add(value=10.26.64.22)" > ${cli_script}
echo "/system-property=http.proxyPort:add(value=3128)" >> ${cli_script}
echo "/system-property=http.nonProxyHosts:add(value=localhost|127.0.0.1|10.26.64.39|10.26.64.40|10.26.64.41|10.26.64.42|10.26.64.43|10.26.64.44|10.26.64.45|10.26.64.46|10.26.64.47|10.26.64.48|10.26.64.49|10.26.64.50|10.26.64.55|10.26.64.56|10.26.64.63|10.26.64.64|10.26.64.67|10.26.64.68|10.26.64.73|10.26.64.74|10.26.64.79|10.26.64.80|10.26.64.85|10.26.64.86|10.26.64.91|10.26.64.92|10.26.64.69|10.26.64.70|10.26.64.51|10.26.64.52|10.26.64.57|10.26.64.58|10.26.64.65|10.26.64.66|10.26.64.75|10.26.64.76|10.26.64.81|10.26.64.82|10.26.64.87|10.26.64.88|10.26.64.93|10.26.64.94|10.26.81.31|10.26.64.114|10.26.64.115|10.26.64.122|10.26.64.123|10.26.64.126|10.26.64.127|10.26.64.132|10.26.64.133|10.26.64.138|10.26.64.139|10.26.64.144|10.26.64.145|10.26.64.148|10.26.64.149|10.26.64.106|10.26.64.111)" >> ${cli_script}
echo "/system-property=YTLC.Environment.Properties:add(value=/opt/eap/portal/)" >> ${cli_script}
echo "/subsystem=logging/periodic-rotating-file-handler=FILE:add(autoflush=true,append=true,named-formatter=COLOR-PATTERN,file={path=server.log,relative-to=jboss.server.log.dir},level=INFO,suffix=.yyyy-MM-dd)" >> ${cli_script}
echo "/subsystem=logging/root-logger=ROOT:add-handler(name=FILE)" >> ${cli_script}

exec_cli_scripts ${cli_script}
