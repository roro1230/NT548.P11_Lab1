#!/bin/bash

# Run the Go test and capture the output
go test -v -run TestTerraformInfrastructure > full_log.txt

# Extract the section between "Outputs:" and "- destroy" and lines containing PASS, FAIL, or Error
awk '/Apply complete!/ {capture=1} /destroy -auto-approve/ {capture=0} capture || /PASS|FAIL|Error/' full_log.txt > results.txt