#!/usr/bin/env bash

# HEADERS
echo "Content-Type: text/html"
echo

# CONTENT
echo "<html>"
echo "    <head>"
echo "        <meta http-equiv='content-type' content='text/html; charset=utf-8'>"
echo "        <title>CGI Index</title>"
echo "    </head>"
echo "    <body>"
echo "        <h1>This is the CGI Index</h1>"
echo "        <ul>"
for i in `ls`; do
    echo "            <li>$i</li>"
done
echo "        </ul>"
echo "        <b>Fecha del sistema:</b> $(date)"
echo "    </body>"
echo "</html>"

