# =============================================================================
# centos-apache
#
# CentOS-7, Apache 
# 
# =============================================================================
FROM centos:centos7

MAINTAINER Irwan_Syahputra <irwansyahputra92@gmail.com>
# -----------------------------------------------------------------------------
# Apache 
# -----------------------------------------------------------------------------
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd httpd-tools && \
    yum clean all

# -----------------------------------------------------------------------------
# Set port 80
# -----------------------------------------------------------------------------
EXPOSE 80 

# -----------------------------------------------------------------------------
# Copy files 
# -----------------------------------------------------------------------------
ADD ./src/ /var/www/html

# -----------------------------------------------------------------------------
# Update Apache Configuration
# -----------------------------------------------------------------------------
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.html \1/g' /etc/httpd/conf/httpd.conf

# -----------------------------------------------------------------------------
# Start Apache
# -----------------------------------------------------------------------------
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]