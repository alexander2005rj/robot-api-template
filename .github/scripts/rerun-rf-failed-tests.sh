#!/bin/bash

echo "===> Cleaning tracing directory"
rm -r $output_path/tracing

echo "===> Executing rerun failed tests"
$1
EXIT_CODE=$?

echo "===> Executing merge of reports"
rebot -d $output_path --merge $output_path/output.xml $output_path/rerun.xml

exit $EXIT_CODE