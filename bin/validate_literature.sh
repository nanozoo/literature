#!/usr/bin/env bash

########################
# git action script
########################

for library_file in bibs/*.bib; do
    toolname=$(basename -s .bib ${library_file})
    get_tags=$(wget https://registry.hub.docker.com/v1/repositories/nanozoo/${toolname}/tags -q -O - | grep "layer" )
    lines=$(printf "${get_tags}" | wc -l)

    # validate dockerhub image presence
    if [ ! -z "${get_tags}" ]; then
        printf "${toolname} --> ${get_tags} \n\n"
    else 
        echo "Cant find Docker image on Dockerhub for ${toolname}" && exit 1 
    fi

    # validate literature file presence
    if [ -e docs/${toolname}.md ] ; then
        echo "description for ${toolname} found"
    else
        echo "Could not find docs/${toolname}.md" && exit 1 
    fi

done

echo "Everything validated" && exit 0