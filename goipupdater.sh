#!/bin/sh

USERNAME="<enter_user_here>"
PASSWORD="<enter_password_here>"
SUBDOMAIN="<enter_your_goip_domain_here>"

# FAQ
# https://www.goip.de/faq.html

# It is also possible to add the ip as parameter here
#curl --data "username=${USERNAME}&password=${PASSWORD}&subdomain=${SUBDOMAIN}&ip=123.123.123.123" https://www.goip.de/setip?

# However it is not needed, as goip.de can figure it out without giving it as parameter
curl --data "username=${USERNAME}&password=${PASSWORD}&subdomain=${SUBDOMAIN}" https://www.goip.de/setip?
