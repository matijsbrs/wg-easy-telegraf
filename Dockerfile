# There's an issue with node:16-alpine.
# On Raspberry Pi, the following crash happens:

# #FailureMessage Object: 0x7e87753c
# #
# # Fatal error in , line 0
# # unreachable code
# #
# #
# #

# FROM docker.io/library/node:14-alpine@sha256:dc92f36e7cd917816fa2df041d4e9081453366381a00f40398d99e9392e78664 AS build_node_modules
# FROM node:lts-alpine3.18 as build_node_modules
FROM node:lts-alpine3.18

# Copy Web UI
COPY src/ /app/
COPY Telegraf/ /app/
WORKDIR /app
RUN npm ci --production

# Copy build result to a new image.
# This saves a lot of disk space.
# FROM docker.io/library/node:14-alpine@sha256:dc92f36e7cd917816fa2df041d4e9081453366381a00f40398d99e9392e78664
# COPY --from=build_node_modules /app /app


# Move node_modules one directory up, so during development
# we don't have to mount it in a volume.
# This results in much faster reloading!
#
# Also, some node_modules might be native, and
# the architecture & OS of your development machine might differ
# than what runs inside of docker.
# RUN mv /app/node_modules /node_modules

# Enable this to run `npm run serve`
RUN npm i -g nodemon

# Install Linux packages
RUN apk add -U --no-cache \
  wireguard-tools \
  dumb-init \
  python3 \
  telegraf

# Expose Ports
EXPOSE 51820/udp
EXPOSE 51821/tcp

# Set Environment
ENV DEBUG=Server,WireGuard
# Disable Telegraf support by default.
ENV INFLUXDB_V2_HOSTNAME="wg-easy"
ENV TELEGRAF_ENABLED=false

# Run Web UI
WORKDIR /app
# CMD ["/usr/bin/dumb-init", "node", "server.js"]
CMD ["sh", "entrypoint.sh"]