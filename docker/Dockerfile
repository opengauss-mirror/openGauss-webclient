FROM openeuler/openeuler:22.03-lts
MAINTAINER openGauss-ml@openguass.org
LABEL MAIL="heguofeng@huawei.com" \
      CREATE_DATE="2022-10" \
      GAUSS_SERVER="openGauss-3.1.0"

RUN \
    sed -i "s/gpgcheck=1/gpgcheck=0/g" /etc/yum.repos.d/openEuler.repo && \
    sed -i "s#http://repo.openeuler.org#https://mirrors.huaweicloud.com/openeuler#g" /etc/yum.repos.d/openEuler.repo  && \
    yum install -y -q net-tools wget sudo shadow vim bc util-linux git && \
    useradd opengauss && \
    sed -i "101i opengauss ALL=(ALL) NOPASSWD:ALL" /etc/sudoers && \
    sed -i "s/TMOUT=300/TMOUT=0/g" /etc/bashrc && \
    cp -rf /usr/share/zoneinfo/Asia/Beijing /etc/localtime && \
    yum install -y python -q tzdata cmake libaio-devel ncurses-devel pam-devel libffi-devel libtool \
    libtool-ltdl openssl-devel bison flex glibc-devel patch unzip openeuler-lsb make automake xz && \
    yum clean all

WORKDIR /home/opengauss
COPY --chown=opengauss:opengauss . /home/opengauss

USER opengauss:opengauss

RUN cp -f /home/opengauss/bashrc /home/opengauss/.bashrc && \
    cd /home/opengauss && \
    if [ "`uname -m`" == "x86_64" ]; then \
        wget -q https://golang.google.cn/dl/go1.18.8.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.8.linux-amd64.tar.gz && rm -rf go1.18.8.linux-amd64.tar.gz && \
        wget -q https://opengauss.obs.cn-south-1.myhuaweicloud.com/3.1.0/binarylibs/openGauss-third_party_binarylibs_openEuler_x86_64.tar.gz -O openGauss_third.tar.gz; \
    else \
        wget -q https://golang.google.cn/dl/go1.18.8.linux-arm64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.8.linux-arm64.tar.gz && rm -rf go1.18.8.linux-arm64.tar.gz && \
        wget -q https://opengauss.obs.cn-south-1.myhuaweicloud.com/3.1.0/binarylibs/openGauss-third_party_binarylibs_openEuler_arm.tar.gz -O openGauss_third.tar.gz; \
    fi && \
    tar -xf openGauss_third.tar.gz && mv openGauss-third_party_binarylibs* binarylibs && rm -f openGauss_third.tar.gz && \
    source /home/opengauss/.bashrc && git clone https://gitee.com/Nelson-He/openGauss-server.git && cd openGauss-server && \
    ./configure --gcc-version=7.3.0 CC=g++ CFLAGS='-O2' \
        --prefix=$GAUSSHOME --3rd=$BINARYLIBS \
        --enable-cassert --enable-thread-safety \
        --without-readline --without-zlib  && \
    make -sj 8 && make install -sj 8 && \
    cd /home/opengauss && wget -q https://gitee.com/opengauss/openGauss-webclient/repository/archive/master.zip && \
    go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn && \
    unzip -q master.zip && cd openGauss-webclient-master && make release && \
    sudo cp -rf ./bin/openGauss-webclient_linux_amd64  /usr/bin/openGauss_webclient; \
    cd /home/opengauss && \
    chmod +x /home/opengauss/entrypoint.sh && \
    sudo chmod 755 /usr/bin/openGauss_webclient && \
    sudo rm -rf /home/opengauss/binarylibs && \
    sudo rm -rf /home/opengauss/openGauss-server && \ 
    sudo rm -rf /home/opengauss/master.zip && \
    sudo rm -rf /home/opengauss/openGauss-webclient-master && \
    sudo yum remove -y make cmake git && \
    sudo yum clean all 

ENTRYPOINT ["/bin/bash", "/home/opengauss/entrypoint.sh"]

EXPOSE 8081

CMD ["openGauss_webclient"]
