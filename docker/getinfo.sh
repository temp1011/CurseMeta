#!/bin/bash

IDS=(${QUERY_STRING//-/ })
PROJECT_ID="${IDS[0]}"
FILE_ID="${IDS[1]}"

FILE_PATH="/alpacka.meta/output/addon/${PROJECT_ID}/${FILE_ID}.json"

if [[ -f $FILE_PATH ]]; then
    echo "Content-type: text/json"
    echo ""

    cat $FILE_PATH
    exit 0
fi

cd /alpacka-meta
dotnet run grab ${PROJECT_ID} ${FILE_ID} >/dev/null 2>&1

if [[ -f $FILE_PATH ]]; then
    echo "Content-type: text/json"
    echo ""

    cat $FILE_PATH
    exit 0
else
    echo "Content-type: text/json"
    echo ""

    cat <<EOF
{
  "error": true,
  "code": 404,
  "message": "Not found on backend API"
}
EOF
fi

exit 0