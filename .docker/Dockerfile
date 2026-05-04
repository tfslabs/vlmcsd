FROM debian:trixie AS builder

# Set the current dir
WORKDIR /root/vlmcsd

# Install build pacakges
RUN apt update 
RUN apt full-upgrade -y 
RUN apt install -y gcc make

# Copy source code
COPY --chown=root:root man /root/vlmcsd/man
COPY --chown=root:root src /root/vlmcsd/src
COPY --chown=root:root GNUmakefile /root/vlmcsd/GNUmakefile

# Start build
RUN make -j"$(nproc)" vlmcsd

FROM debian:trixie

RUN apt update \
    && apt full-upgrade -y \
    && apt autoremove -y \
    && apt install -y libgcc-s1 libstdc++6 netcat-openbsd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd

EXPOSE 1688

ENTRYPOINT [ "/usr/bin/vlmcsd" ]

CMD ["-e", "-v", "-D", "-w"]
