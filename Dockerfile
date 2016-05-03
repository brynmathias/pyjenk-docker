FROM jenkins

USER root

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    vim \
    git \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    libzmq3-dev \
    libcurl4-openssl-dev \
    ca-certificates \
    zlib1g-dev  \
    python3 \
    libmysqlclient-dev \
    libssl-dev \
    pylint \
    python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -k -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    pip3 --no-cache-dir install requests[security]
RUN mkdir -p ~/pypi/packages
RUN mkdir -p /var/jenkins_home/pypi/packages
RUN cd ~/pypi/packages && pip3 install pypiserver
EXPOSE 7000 
CMD ["pypi-server", "-p", "7000", "-P", "/srv/pypi/.htaccess", "/srv/pypi"]

