#!/bin/bash
injected_dir=$1
source /usr/local/s2i/install-common.sh

cli_script=${injected_dir}/configuration.cli

echo "/system-property=YTLC.Environment.Properties:add(value=/opt/eap/portal/)" > ${cli_script}
echo "/subsystem=logging/periodic-rotating-file-handler=FILE:add(autoflush=true,append=true,named-formatter=COLOR-PATTERN,file={path=server.log,relative-to=jboss.server.log.dir},level=INFO,suffix=.yyyy-MM-dd)" >> ${cli_script}
echo "/subsystem=logging/root-logger=ROOT:add-handler(name=FILE)" >> ${cli_script}

run_cli_script ${cli_script}
