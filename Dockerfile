FROM cern/cc7-base:latest
ARG rootversion="6.16.00"
ARG version="2.0.1"
#LABEL description="CERN ROOT framework"
LABEL version="xfitter.${version}-root.${rootversion}"

RUN yum -y install epel-release 
RUN yum -y install gcc-c++ bzip2 libpng libjpeg \
    python-devel boost libSM libX11 libXext libXpm libXft gsl-devel python-pip make\
    && yum -y clean all
#RUN pip install --upgrade pip && pip install -U numpy scipy sklearn matplotlib
#RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

# Set ROOT environment
ENV ROOTSYS         "/opt/root"
ENV PATH            "$ROOTSYS/bin:$ROOTSYS/bin/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH      "$ROOTSYS/lib:$PYTHONPATH"

ADD https://root.cern.ch/download/root_v${rootversion}.Linux-centos7-x86_64-gcc4.8.tar.gz /var/tmp/root.tar.gz

RUN tar xzf /var/tmp/root.tar.gz -C /opt && rm /var/tmp/root.tar.gz
#Install xfitter
ADD https://gitlab.cern.ch/fitters/xfitter/raw/master/tools/install-xfitter?inline=false /var/tmp/install-xfitter
RUN chmod +x /var/tmp/install-xfitter \
    && /var/tmp/install-xfitter ${version} \
    && rm /var/tmp/install-xfitter  
