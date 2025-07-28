#!/bin/bash

ref=$1

if [ -z "$ref" ]; then
    echo Commit id parameter is required.
    exit 1
fi

version_info_line=$(git show $ref:packages/firebase_core/firebase_core/android/gradle.properties |grep --color=never 'FirebaseSDKVersion=')
version_info_line=(${version_info_line//=/ })
version=${version_info_line[1]}
echo version is $version
echo 'Please download the pom file from the page, find the line with "<artifactId>firebase-messaging</artifactId>" and you’ll find the version there.'
start https://mvnrepository.com/artifact/com.google.firebase/firebase-bom/$version
