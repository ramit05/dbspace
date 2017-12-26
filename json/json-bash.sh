#!/usr/bin/env bash
# 
# Using JSON parsing with function in Bash 
# 
#--------------------------------------------------------------------------------------
# Example: $SCRIPT -t test1 -n test.sh -v xx.xx.xx.xx
# Error Code & meanings :
# 200 - Test Completed. Everything is Successful
# 400 - Bad Request Error
# 500 - Internal Server Error

VM_SSH_KEY_PATH=~/ssh_keys/aws.pem
VM_USER=root

# Function defined for parsing JSON in Bash
function readJson {
  SED_EXTENDED='-r'

  VALUE=`grep -m 1 "\"${2}\"" ${1} | sed ${SED_EXTENDED} 's/^ *//;s/.*: *"//;s/",?//'`

  if [ ! "$VALUE" ]; then
    echo "Error: Cannot find \"${2}\" in ${1}" >&2;
    exit 1;
  else
    echo $VALUE ;
  fi;
}

while getopts 't:n:v:' opt; do
    case $opt in
        t)  test_type="$OPTARG" ;;
        n)  script_name="$OPTARG" ;;
        v)  vm="$OPTARG" ;;
        *)  exit 1            ;;
    esac
   done

# Using a bash function for passing the parameters in JSON
generate_post_data() {
cat <<-EOF
{"url": "${URL}", "test_type": "${test_type}", "script_name": "${script_name}", "args":{"SYSTEM_ENDPOINT": "${SYSTEM_ENDPOINT}"}}
EOF
}

# Curl the for required parameters by using SSH
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${VM_SSH_KEY_PATH} ${VM_USER}@${vm} "curl -kX POST -H 'Content-Type: application/json' -d '"$(generate_post_data)"' https://xxx.com/xxx" > output.json

cat output.json

# Validating JSON
python -mjson.tool "output.json" > /dev/null

if [ $? -eq 0 ]; then
    echo OK.JSON is Valid.
else
    echo FAIL.Cannot Validate JSON.
    exit 1
fi

# Read and Extract JSON with 'key' as 'status_code'
STATUS_CODE=`readJson output.json status_code` || exit 1;

# Obtaining the value from the Key Value Pair 
STATUS_CODE_VALUE="${STATUS_CODE##* }"  

echo $STATUS_CODE_VALUE

if [ $STATUS_CODE_VALUE -eq 200 ];then
echo "Test Completed. Everything is Successful"
elif [ $STATUS_CODE_VALUE -eq 400 ];then
echo "Bad Request Error"
exit 1
elif [ $STATUS_CODE_VALUE -eq 500 ];then
echo "Internal Server Error"
exit 1
else echo "Unexpected Response Received"
echo "$STATUS_CODE_VALUE"
exit 1
fi
