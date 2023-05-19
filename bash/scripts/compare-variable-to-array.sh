#!/bin/bash

element="debian10"

unitarray="debian10 ubuntu16.4 redhat9 centos8"

echo "$unitarray"

if [[ ${unitarray,,} =~ ${element,,}  ]] ; then
	echo "got a match"
else
	echo "nO match"
fi
