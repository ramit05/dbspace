#!/usr/bin/env bash
#
# Using tar utility to Zip a Repository present on a remote url
#---------------------------------------------------------------------------------------
# Example: $SCRIPT -p res -r pkgs/sda/asd

  NEW_ARTIFACT_VERSION=$(date +%Y%m%d%H%M)
  while getopts 'p:r:' opt; do
  case $opt in
        p)  PROJECT_NAME="$OPTARG" ;;
        r)  TEST_REPO="$OPTARG" ;;
        *)  exit 1            ;;
    esac
   done

   echo "${PROJECT_NAME}"     
   if [[ $NEW_ARTIFACT_VERSION =~ ^[0-9]{1,12}$ ]]; then
      cd $WORKSPACE           
       echo  "Start zip . . ."
       printf '%60s\n' | tr ' ' -
      # Check for "zip" package, if not installed - install zip
      which tar > /dev/null 2>&1
      OUT=$?
       if [ $OUT -ne 0 ];then
           apt-get install tar
       fi
      #Create a zip file excluding ".git" files/dirs
      printf '%60s\n' | tr ' ' -  
    #Check wheather the dir is present or not
    if [ -d "test" ]; then
    echo "test is present"
    else
    echo "test is not present"
    fi
      cd test
      tar --exclude='.git*' --exclude='.' -zcvf "test-0.0.${build_no}.tgz" *         
      response=$(curl -H X-Art-Api:"${ARTIF_APIKEY}" -T "test-0.0.${build_no}.tgz"  "${ARTIF_URL}/${TEST_REPO}/${PROJECT_NAME}/0.0.${build_no}/test-0.0.${build_no}.tgz")
      if [ -z "${response##*errors*}" ] ;then
           echo "Zip with build number: 0.0.${build_no} is failed . . ."
            exit 1
      else
           echo "Zip with build number: 0.0.${build_no}"  
      fi
      else
        printf "Error: Wrong Version Pattern" >&2 
      exit 1
    fi
