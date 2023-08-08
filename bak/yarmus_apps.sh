#!/bin/bash

# Function 1
function function_one() {
    echo "Executing Function 1 with parameters: $1, $2, $3, $4"
}

# Function 2
function function_two() {
    echo "Executing Function 2 with parameters: $1, $2, $3, $4"
}

# Function 3
function function_three() {
    echo "Executing Function 3 with parameters: $1, $2, $3, $4"
}

# Check if the primary ini file exists, if not, use the alternative ini file
if [ -f "config.ini" ]; then
    ini_file="config.ini"
else
	# wget/curl alternative config to tmp folder
    if [ -f "/tmp/alternative_config.ini" ]; then
        ini_file="/tmp/alternative_config.ini"
    else
        echo "Error: Both config.ini and alternative_config.ini files not found!"
        exit 1
    fi
fi

# Read the ini file and execute functions based on the contents
while IFS=, read -r skip_value function_num param2 param3 param4 param5; do
    if [[ "$skip_value" == "true" ]]; then
        case "$function_num" in
            "1") function_one "$param2" "$param3" "$param4" "$param5" ;;
            "2") function_two "$param2" "$param3" "$param4" "$param5" ;;
            "3") function_three "$param2" "$param3" "$param4" "$param5" ;;
        esac
#    else
#	echo "Skipped line with parameters: $skip_value, $function_num, $param2, $param3, $param4, $param5"
    fi
done < "$ini_file"

