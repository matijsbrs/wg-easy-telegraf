# There's an issue with node:16-alpine.
# On Raspberry Pi, the following crash happens:

# #FailureMessage Object: 0x7e87753c
# #
# # Fatal error in , line 0
# # unreachable code
# #
# #
# #

FROM weejewel/wg-easy

# Copy Web UI
COPY Telegraf/ /app/
WORKDIR /app

# Disable Telegraf support by default.
ENV INFLUXDB_V2_HOSTNAME="wg-easy"
ENV TELEGRAF_ENABLED=false 

# CMD ["/usr/bin/dumb-init", "node", "server.js"]
CMD ["sh", "entrypoint.sh"]
