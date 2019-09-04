#!/bin/bash
USER="Jenkins"

    COLOR="red"
    ROOM_ID="MAW"
    FROM="Jenkins"
    NOTIFY=1
    MESSAGE_FORMAT="text"
    AUTH_TOKEN="kQA6wbQzJL64UJBSd9W0sOz82RDedzEhh30aSSPa"


    echo "Sending to MAW"
    curl -H "Content-type: text/plain" \
    -H "Authorization: Bearer $AUTH_TOKEN" \
    -X POST \
    -d " Jobs to be deleted: 

$1 " \
    https://api.hipchat.com/v2/room/$ROOM_ID/notification?auth_token=$AUTH_TOKEN