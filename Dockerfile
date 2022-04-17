FROM ubuntu:hirsute

LABEL maintainer="tyuzu <tyuzu@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV USE_CCACHE=1
ENV HOME=/root
WORKDIR /tmp

#RUN apt-get -yqq update \    
#    && apt-get install -yqq --no-install-recommends ffmpeg openjdk-8-jdk openjdk-8-jre maven nodejs ca-certificates-java python-is-python3 pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev python-is-python3 re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd \
#    && apt-get -yqq purge default-jre-headless openjdk-11-jre-headless \
#    && curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo \
#    && chmod a+rx /usr/local/bin/repo \
#    && echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen && /usr/sbin/locale-gen \
#    && TZ=Asia/Jakarta \
#    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN apt-get -yqq clean \
#    && apt-get -yqq autoremove \
#    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
#    && echo "Set disable_coredump false" >> /etc/sudo.conf

RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get install  -yqq sudo tzdata locales python-is-python3 pigz tar rsync rclone aria2 ccache curl wget zip unzip lzip lzop zlib1g-dev xzdec xz-utils pixz p7zip-full p7zip-rar zstd libzstd-dev lib32z1-dev ffmpeg maven nodejs ca-certificates-java python-is-python3 pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev python-is-python3 re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd
#RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
#RUN /usr/sbin/locale-gen
#RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
#RUN echo Asia/Jakarta > /etc/timezone

RUN apt-get install tzdata
RUN apt-mark hold tzdata
RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
RUN /usr/sbin/locale-gen
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN echo Asia/Jakarta > /etc/timezone
RUN apt install sudo git -yqq
RUN git clone https://github.com/akhilnarang/scripts /tmp/scripts
WORKDIR /tmp/scripts
RUN bash setup/android_build_env.sh

RUN git clone https://github.com/I-n-o-k/android_tools /tmp/anu
WORKDIR /tmp/anu
RUN bash setup.sh
WORKDIR /tmp

VOLUME ["/tmp/rom", "/tmp/ccache"]
