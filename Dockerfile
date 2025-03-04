FROM centos/ruby-27-centos7:2.7

USER 0

RUN yum update -y \
    && yum install -y \
    libxml2-devel \
    perl-Devel-Peek \
    perl-FreezeThaw \
    perl-HTML-Parser \
    perl-libwww-perl \
    wget \
    && yum clean all

WORKDIR /headerdoc_build

RUN wget https://opensource.apple.com/tarballs/headerdoc/headerdoc-8.9.5.tar.gz -qO- | tar xzf -
WORKDIR headerdoc-8.9.5
RUN make all || true
RUN make realinstall

COPY . /translator
WORKDIR /translator

RUN bundle install --system

CMD ./translate
