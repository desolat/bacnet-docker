FROM ubuntu:18.04
# Alpine preferred but glibc is needed and popular workarounds don't do enough.

RUN apt-get update && apt-get -y install build-essential 

ADD https://github.com/bacnet-stack/bacnet-stack/archive/refs/tags/bacnet-stack-1.0.0.tar.gz /

RUN tar -xzf bacnet-stack-1.0.0.tar.gz \
    && cd bacnet-stack-bacnet-stack-1.0.0 \
    && make \
    && rm -f bin/*.txt bin/*.bat \
    && mv bin/* /usr/local/bin \
    && cd / \
    && rm -rf bacnet-stack* 

RUN apt-get -y remove build-essential \
    && apt-get -y autoremove \
    && apt-get -y autoclean

ADD bacnet-wrapper /
RUN chmod a+x /bacnet-wrapper
ADD simulator /

EXPOSE 47808:47808/udp

CMD ["/bacnet-wrapper"]
