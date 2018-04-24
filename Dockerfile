FROM fedora:27

RUN yum -y install python-pip
RUN pip install --upgrade pip
RUN python3 -m pip install -U pip
RUN pip3 install robotframework robotframework-selenium2library robotframework-faker robotframework-debuglibrary -U requests -U robotframework-requests
RUN pip3 install tornado

COPY run /usr/bin/run
RUN chmod 777 /usr/bin/run

RUN mkdir component-test
COPY . /component-test

EXPOSE 8888

WORKDIR /component-test/challenge
CMD '/usr/bin/run'





