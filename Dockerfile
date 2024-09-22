# 1. Use an outdated and unmaintained base image with known vulnerabilities
FROM ubuntu:14.04

# 2. Run everything as root (privilege escalation risk)
USER root

# 3. Install outdated packages with known vulnerabilities and without verification
RUN apt-get update && apt-get install -y \
    apache2=2.4.7-1ubuntu4.18 \
    php5=5.5.9+dfsg-1ubuntu4.29 \
    curl=7.35.0-1ubuntu2.20

# 4. Install OpenSSL with known vulnerabilities
RUN apt-get install -y openssl=1.0.1f-1ubuntu2.27

# 5. Download and execute a script from an untrusted HTTP source without verification
RUN curl http://example.com/vulnerable-script.sh -o /usr/local/bin/vulnerable-script.sh && \
    chmod +x /usr/local/bin/vulnerable-script.sh

# 6. Hardcoded environment variables with sensitive data (security risk)
ENV DB_PASSWORD=mysecretpassword

# 7. Unnecessarily expose multiple ports (increasing attack surface)
EXPOSE 80 22 3306

# 8. Run outdated service with default settings (no hardening or updates)
CMD ["apache2ctl", "-D", "FOREGROUND"]
