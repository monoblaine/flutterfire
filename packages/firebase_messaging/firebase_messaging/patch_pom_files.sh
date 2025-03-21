#!/bin/bash

# This script is to be executed from the Linux machine that assembles the aar files.

set -x

target_version=$1
target_version_suffixed=$target_version-defused
path_to_packages="example/android/app/local_aars/com/google/firebase"
package1_name=firebase-messaging
pom1_name="$package1_name-$target_version_suffixed.pom"
package2_name=firebase-messaging-ktx
pom2_name="$package2_name-$target_version_suffixed.pom"
pattern="<version>$target_version</version>"
replacement="<version>$target_version_suffixed</version>"

cd "$path_to_packages/$package1_name/$target_version_suffixed" &&
curl "https://dl.google.com/dl/android/maven2/com/google/firebase/firebase-messaging/$target_version/firebase-messaging-$target_version.pom" \
     >"$pom1_name" &&
perl -0777 -pi -e "s@$pattern@$replacement@g" "$pom1_name" &&
cd - &&
cd "$path_to_packages/$package2_name/$target_version_suffixed" &&
curl "https://dl.google.com/dl/android/maven2/com/google/firebase/firebase-messaging-ktx/$target_version/firebase-messaging-ktx-$target_version.pom" \
     >"$pom2_name" &&
perl -0777 -pi -e "s@$pattern@$replacement@g" "$pom2_name"
