#/bin/sh
#
# Just in case the user didn't select to upgrade their Pi, or it's been a while let's do a dist-upgrade
#
echo Performing operating system update...
apt-get -qq update
apt-get -qq -y dist-upgrade
#
# Misc libraries we'll need later
#
echo Grabbing misc library packages we will need later...
apt-get -qq -y install libxslt1-dev libxml2-dev python-software-properties
#
# Grab the core Ruby stuff we need.
#
echo Installing Ruby development tools...
apt-get -qq -y install ruby ruby-dev rubygems rake
#
# Install git & grab our repo so we have our init scripts and what not
#
echo Installing git...
apt-get -qq -y install git git-daemon-sysvinit equivs libnss-mdns
git clone https://github.com/Donavan/cucumberpi.git

#
# Install xvfb so we can run X apps headless might as well grab firefox at the same time.
#
echo Installing headless X environment
apt-get -qq -y install xvfbx11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic xserver-xorg-core iceweasel
cp cucumberpi/scripts/xvfb /etc/init.d/
chmod 755 /etc/init.d/xvfb
update-rc.d xvfb defaults
#
# Everybody loves node.  We'll grab zombie later.
#
echo Installing node.js and NPM
apt-get -qq -y install nodejs npm
#
# Install the Java runtime for selenium
#
echo Installing Java runtime
apt-get -qq -y install openjdk-6-jre-headless icedtea-plugin
#
# Install selenium
#
echo Installing Selenium
mkdir /usr/lib/selenium/
wget https://selenium.googlecode.com/files/selenium-server-standalone-2.25.0.jar
mv selenium-server-standalone-2.25.0.jar /usr/lib/selenium/
mkdir -p /var/log/selenium/
chmod a+w /var/log/selenium/
cp cucumberpi/scripts/selenium /etc/init.d/selenium
chmod 755 /etc/init.d/selenium
update-rc.d selenium defaults
#
# install gems
#
echo Installing gems.
gem install rake bundler
gem install cucumber webrat headless
gem install watir-webdriver

