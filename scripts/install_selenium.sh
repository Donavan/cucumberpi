#!/bin/sh
#
# Install the Java runtime for selenium
#
echo Installing Java runtime
apt-get -qq -y install default-jre default-jdk icedtea-plugin
#
# Install selenium
#
echo Installing Selenium
mkdir /usr/lib/selenium/
wget https://selenium.googlecode.com/files/selenium-server-standalone-2.25.0.jar
mv selenium-server-standalone-2.25.0.jar /usr/lib/selenium/
mkdir -p /var/log/selenium/
chmod a+w /var/log/selenium/
cp ~/cucumberpi/scripts/selenium /etc/init.d/selenium
chmod 755 /etc/init.d/selenium
update-rc.d selenium defaults
echo Installing Selenium grid...
apt-get -qq -y install ant ant-optional
wget http://release.seleniumhq.org/selenium-grid/selenium-grid-1.0.8-bin.zip
unzip selenium-grid-1.0.8-bin.zip -d /usr/local/

gem install rspec -v 1.1.8 
gem install selenium-client -v 1.2.7
gem install deep_test -v 1.2.2
gem install selenium-client 
patch -u  /var/lib/gems/1.9.1/gems/selenium-webdriver-2.25.0/lib/selenium/webdriver/common/port_prober.rb cucumberpi/patches/port_prober.patch 
# Run sanity check
echo Running tests...
cd /usr/local/selenium-grid-1.0.8
ant sanity-check