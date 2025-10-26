FROM debian:stretch-slim

RUN apt-get update && apt-get install -y curl openssl

RUN echo "echo Hello Vulnerable World" > /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
