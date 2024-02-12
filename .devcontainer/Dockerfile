FROM alpine:3.19.0

WORKDIR /

#wget, curl for getting downloads, make for build, xz-utils for extracting
RUN apk --no-cache add \
wget \
curl \
tar \
make \
git \    
ncurses \
curl \
llvm17 \
python3 \
py3-pip \
gcc-arm-none-eabi \
cmake \
rpm \
openssh \
sed \
libjaylink 
#dpkg \

#RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git config --global core.autocrlf input

ENV PATH="/.devcontainer/scripts:${PATH}"
#RUN find /build_tools/scripts -type f -exec chmod +x {} \;

#fix gdb libcurses issue
#RUN cd /usr/lib/x86_64-linux-gnu && ln -s libncursesw.so.6.4 libncursesw.so.5 && ln -s libtinfo.so.6.4 libtinfo.so.5

#get Segger tools
#RUN curl -X POST -F 'submit=Download+software' -F 'accept_license_agreement=accepted' https://www.segger.com/downloads/jlink/JLink_Linux_V754a_x86_64.deb --output jlink.deb
#RUN curl -X POST -F 'submit=Download+software' -F 'accept_license_agreement=accepted' https://www.segger.com/downloads/jlink/JLink_Linux_V794f_x86_64.rpm --output jlink.rpm
#RUN rpm -i jlink.rpm && rm jlink.rpm