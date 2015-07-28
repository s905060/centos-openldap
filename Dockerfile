############################################################
# Dockerfile to build CentOS, Openldap installed Container
# Based on CentOS6.6
############################################################

# Set the base image to CentOS
FROM centos:centos6

# File Author / Maintainer
MAINTAINER "Jash Lee" <s905060@gmail.com>

# Clean up yum repos to save spaces
RUN yum update -y >/dev/null

# Install epel repos
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Installing epel
RUN yum -y install epel-release

# Install Openldap Server and Clients package
RUN yum install -y openldap-servers openldap-clients

# Set Enviroment
env SLAPD_URL ldapi:/// ldap:///

# Adding the run file
ADD run.sh /usr/bin/run.sh

# Setup Volume (ldap datastore, ldap config)
VOLUME ["/var/lib/ldap", "/etc/openldap/"]

# Set the port to 389 for ldap server
EXPOSE 389

# Executing ldap server
CMD ["/usr/bin/run.sh"]
