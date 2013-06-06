#!/bin/sh

if [ $# -lt 1 ] ; then
    echo "$0 resolution (eg 640x480)"
    exit 1
fi

while [ $# -ge 1 ] ; do

    image_resolution=$1
    
    for image_size in `echo ${image_resolution}` ; do
        echo ${image_size}
        mkdir ${image_resolution} > /dev/null 2>&1
        for image in `ls *.jpg *.JPG 2> /dev/null ` ; do
            echo ".... ${image}"
            convert -size ${image_size} ${image} -resize ${image_size} +profile "*" ${image_size}/${image}
        done
    done
    
    shift
done
