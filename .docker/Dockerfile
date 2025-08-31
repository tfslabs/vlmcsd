FROM ubuntu:noble AS builder

WORKDIR /root/vlmcsd

# Install required build packages
RUN apt update && apt upgrade -y && apt install -y gcc make git

# Clone the repository and build the binary
RUN git clone --depth 2 --branch "master" "https://github.com/tfslabs/vlmcsd.git" .
RUN make -j"$(nproc)" vlmcsd

FROM ubuntu:noble

# Install necessary runtime libraries (glibc is provided by Debian base)
RUN apt update && apt install -y libgcc-s1 libstdc++6 && rm -rf /var/lib/apt/lists/*

# Copy only the compiled binary from the builder stage
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd

EXPOSE 1688

CMD ["/usr/bin/vlmcsd", "-P", "1688", "-H", "26100", "-C", "1033", "-T0", "-e", "-v", "-D"]