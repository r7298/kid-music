#!/bin/sh

t=/usr/lib/android-sdk/build-tools/debian
aj=/usr/lib/android-sdk/platforms/android-24/android.jar
rj=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/rt.jar
src=ru/yuryreshetnikov/caller
n=Caller

rm -Rf build
mkdir -pv build/gen build/apk
aapt package -f -m -J build/gen -M AndroidManifest.xml -S res -I $aj &&
javac -source 1.7 -target 1.7 -bootclasspath $rj -classpath $aj \
      -d build/obj build/gen/$src/R.java java/$src/*.java &&
$t/dx --dex --output=build/apk/classes.dex build/obj &&
aapt package -f -M AndroidManifest.xml -S res -I $aj \
     -F build/$n.unsigned.apk build/apk &&
zipalign -f 4 build/$n.unsigned.apk build/$n.aligned.apk &&
apksigner sign --ks ~/.hidden/keystore.jks \
	  --ks-key-alias androidkey --ks-pass pass:android \
	  --key-pass pass:android --out build/$n.apk build/$n.aligned.apk &&
ls -l `pwd`/build/$n.apk
