FROM vyos-builder:latest
ARG version=1.2.2-gce-1

RUN apt-get update -y \
    && apt-get install grub-common grub-pc grub-pc-bin grub2-common -y

WORKDIR /vyos
COPY . /vyos/

RUN ./configure --build-by="andrey@3adigital.ru" --debian-mirror="http://ftp.us.debian.org/debian/" \
    --architecture amd64 --build-type release --version ${version}

VOLUME [ "/target" ]

CMD ["bash", "-ce", "make GCE && mv --backup=t ./build/*.tar.gz /target/"]
