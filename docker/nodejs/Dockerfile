FROM node:14.16.1-alpine3.12

RUN apk add --no-cache \
		bash

# Add the main user with specific UID
ARG USER=nodejs
ARG UID=2000
RUN sed -i -e "s/^\($USER:[^:]\):[0-9]*:[0-9]*:/\1:$UID:$UID:/" /etc/passwd && \
	sed -i -e "s/^\($USER:[^:]\):[0-9]*:/\1:$UID:/" /etc/group
