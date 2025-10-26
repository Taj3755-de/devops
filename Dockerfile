# Use an outdated Alpine version (has known vulnerabilities)
FROM alpine:3.6

# Install curl (old version) and openssl (old version)
RUN apk add --no-cache curl=7.50.3-r0 openssl=1.0.2j-r0

# Add a dummy app
RUN echo "echo Hello Vulnerable World" > /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
