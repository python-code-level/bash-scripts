#!/bin/bash

# find deleted files within an svn repo
# use svn to delete them before commit

FILES=$(svn status | grep '^!' | awk '{print $2}')

for FILE in $FILES
do
    if [[ $FILE =~ .*.err.* ]]
    then
        echo $FILE
        svn delete $FILE
    fi
done
