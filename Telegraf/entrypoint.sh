#!/bin/sh
if [ "$TELEGRAF_ENABLED" == "true" ]; then
    echo "Telegraf is enabled!"
    
    python env2conf.py telegraf.conf /etc/telegraf/telegraf.conf TELEGRAF_

    service telegraf restart

else
    echo "Telegraf is not enabled."
fi

/usr/bin/dumb-init node server.js