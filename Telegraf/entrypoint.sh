#!/bin/sh
if [ "$TELEGRAF_ENABLED" == "true" ]; then
    echo "Telegraf is enabled!"
    
    python env2conf.py telegraf.conf /etc/telegraf.conf TELEGRAF_

    /usr/bin/telegraf --config /etc/telegraf.conf &

else
    echo "Telegraf is not enabled."
fi

/usr/bin/dumb-init node server.js
