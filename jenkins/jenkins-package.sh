#!/usr/bin/env bash
# jiangjiawen 2018/1/18
moduleName=$1
branchName=$2
gitrepository=$3
projectName=$4
work_path=$5
server=$6
cd ${work_path}
echo ${moduleName}+${branchName}+${gitrepository}
if [ ! -d "${work_path}/modules" ]; then
  mkdir ./modules
fi
cd ${work_path}/modules
if [ -d "./${projectName}" ]; then
    rm -rf ${projectName}
fi
git clone -b ${branchName} ${gitrepository}
if [ ! -d "./${projectName}" ]; then
    exit 0
fi
cd ${projectName}
sed -i ""  "s#^isSnapshot=.*#isSnapshot=${server}#g"  gradle.properties
gradle wrapper
if [ -d "./project.properties" ]; then
    rm -rf ./project.properties
fi
touch ./project.properties
echo "sdk.dir=${ANDROID_HOME}" >> ./project.properties 
./gradlew uploadArchives
