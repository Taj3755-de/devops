FROM alpine:3.6

# Just install packages without version pinning
RUN apk add --no-cache curl openssl bash

# Dummy app
RUN echo "echo Hello Vulnerable World" > /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
