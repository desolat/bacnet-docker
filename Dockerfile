FROM ubuntu:18.04
# Alpine preferred but glibc is needed and popular workarounds don't do enough.
#ADD https://astuteinternet.dl.sourceforge.net/project/bacnet/bacnet-stack/bacnet-stack-0.8.6/bacnet-stack-0.8.6.tgz .
ADD bacnet-stack-1.0.0.tgz /
ADD bacnet-wrapper /
ADD simulator /

RUN apt-get update && apt-get -y install build-essential 

RUN cd bacnet-stack-1.0.0 \
    && make \
    && rm -f bin/*.txt bin/*.bat \
    && mv bin/* /usr/local/bin \
    && chmod a+x /bacnet-wrapper \
    && cd /
     #&& rm -rf bacnet-stack* 
RUN apt-get -y remove build-essential \
    && apt-get -y autoremove \
    && apt-get -y autoclean

EXPOSE 47808:47808/udp

CMD ["/bacnet-wrapper"]
