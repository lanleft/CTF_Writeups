
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update -y

# Install dependencies
RUN apt-get install -y lib32z1 libseccomp-dev socat supervisor

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create ctf-user
RUN groupadd -r ctf && useradd -r -g ctf ctf
RUN mkdir -p /home/ctf

# Configuration files/scripts
ADD config/supervisord.conf /etc/

# Challenge files
COPY --chown=ctf challenge/ /home/ctf/

# Set some proper permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/wizards_diary
RUN chmod 440 /home/ctf/flag.txt

EXPOSE 1337

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]