#!/usr/bin/env bash

ROOTD="$(pwd)"
INDEX="index.html"
IN404="404.html"

export SERVER_PORT="80"
export SERVER_SOFTWARE="Troll Server 0.9b"
export GATEWAY_INTERFACE="CGI/1.1"

read line
export REQUEST_METHOD="$(echo ${line} | cut -d' ' -f1)"
export REQUEST_URI="$(echo ${line} | cut -d' ' -f2)"
export SEVER_PROTOCOL="$(echo ${line} | cut -d' ' -f3)"
export REDIRECT_STATUS="on"
export HTTP_COOKIE=""

while read line; do
    line="$(echo ${line} | tr -d '[[:cntrl:]]')"
    [[ -z "${line}" ]] && break

    if [[ ! -z "$(echo ${line} | grep -i "Content-Length: ")" ]]; then
        export CONTENT_LENGTH="$(echo ${line} | cut -d' ' -f2)"
    elif [[ ! -z "$(echo ${line} | grep -i "Content-Type: ")" ]]; then
        export CONTENT_TYPE="$(echo ${line} | cut -d' ' -f2)"
    elif [[ ! -z "$(echo ${line} | grep -i "Cookie: ")" ]]; then
        export HTTP_COOKIE="${HTTP_COOKIE}$(echo ${line} | sed \
            -e "s/^.*: //g" \
            -e "s/[Dd]omain=[^;]*//g" \
            -e "s/[Ee]xpires=[^;]*//g" \
            -e "s/[Pp]ath=[^;]*//g" \
            -e "s/[Ss]ecure=[^;]*//g" \
            -e "s/[Hh]ttponly=[^;]*//g" \
        );"
    fi
done

export QUERY_STRING="$(echo ${REQUEST_URI} | sed -e 's/^.*?//g')"
export HTTP_GET_VARS=${QUERY_STRING}
export SCRIPT_FILENAME="${ROOTD}$(echo ${REQUEST_URI} | sed -e 's/?.*//g')"

file=${SCRIPT_FILENAME}
[[ -d ${file} ]] && file="${file}${INDEX}"

if [[ ! -z "$(echo ${file} | grep cgi-bin)" ]]; then
    echo "HTTP/1.1 200 OK"
    ${file}
elif [[ ! -z "$(echo ${file} | grep "\.php$")" ]]; then
    echo "HTTP/1.1 200 OK"
    php5-cgi -f ${file}
elif [[ -f ${file} ]]; then
    echo "HTTP/1.1 200 OK"
    echo "Content-Type: text/html"
    echo "Content-Length: $(du -b ${file} | cut -f1)"
    echo
    cat ${file}
else
    echo "HTTP/1.1 404 Not Found"
    echo "Content-Length: $(du -b ${IN404} | cut -f1)"
    echo "Content-Type: text/html"
    echo
    cat ${IN404}
fi

