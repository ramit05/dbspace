#!/bin/sh
#
# Docker Script to automatically detect changes based on commit, build images and push the images to dockerhub.
#
 
GIT_HASH="$(git rev-parse --short HEAD)"
TOP_LEVEL="$(git rev-parse --show-toplevel)"
FILES_FETCHED="$(git show --stat --pretty="format:" $GIT_HASH)"
FILES_CHANGED="$(echo "$FILES_FETCHED" | cut -d"|" -f1 | head -n -1)"

if [[ ! -z $FILES_CHANGED ]]; then 
  echo "File Path Exists";
else 
  echo "FAILED: File Path Does Not Exist";
  exit 1
fi

docker login -u $USER

 
for file in $FILES_CHANGED; do
  local_path="$(dirname $file)"
  if [[ -f $local_path/build.sh ]]; then
    cd $local_path && chmod +x build.sh
    id=$(./build.sh)
 
    ret="$?"
    if [[ $ret -eq 0 ]]; then
      printf "Build successful for image %s.\n" $id
      image="$(docker images --no-trunc | grep $id | awk '{print $1":"$2}')"
 
      printf "Found %s.\n" $image
      docker push $image
 
      ret="$?"
      if [[ $ret -eq 0 ]]; then
        echo "push OK"
      else
        echo "Not OK"
        exit 1
      fi
      
      # Cleanup command for removing image
      docker rmi $id
      
      ret="$?"
      if [[ $ret -eq 0 ]]; then
        echo "Docker Image Successfully Removed"
      else
        echo "Cannot Remove Docker Image"
        exit 1
      fi
       
      cd $TOP_LEVEL
    else
      printf >&2 "Build failed for %s.\n" $id
      exit 1
    fi
  else
    printf "Did not find build.sh at location %s.\n" $local_path
    exit 1
  fi
done
