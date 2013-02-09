#!/usr/bin/env bash

if [[ ${REQUEST_METHOD} == "POST" ]]; then
    QUERY_STRING="$(dd bs=${CONTENT_LENGTH} count=1)"
fi
DIRECTORY="$(echo ${QUERY_STRING} | sed -e "s/%2F/\//g" -e "s/dir=//g")"

# HEADERS
echo "Content-Type: text/html"
echo

# CONTENT
echo "<html>"
echo "    <head>"
echo "        <meta http-equiv='content-type' content='text/html; charset=utf-8'>"
echo "        <title>Listed Files</title>"
echo "    </head>"
echo "    <body>"
echo "        <h1>Listado de ficheros de ${DIRECTORY}:</h1>"
echo "        <ul>"
for i in $(ls ${DIRECTORY}); do
    echo "            <li>$i</li>"
done
echo "        </ul>"
echo "        <a href='/list.html'>Volver atras</a>"
echo "    </body>"
echo "</html>"

