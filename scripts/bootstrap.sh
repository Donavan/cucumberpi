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
apt-get -qq -y install vim vim-scripts vim-addon-manager vim-rails
#
# Install git & grab our repo so we have our init scripts and what not
#
echo Installing git...
apt-get -qq -y install git git-daemon-sysvinit equivs libnss-mdns
git clone https://github.com/Donavan/cucumberpi.git
chmod a+x ~/cucumberpi/install_selenium.sh
#
# Install xvfb so we can run X apps headless might as well grab browsers at the same time.
#
echo Installing headless X environment
apt-get -qq -y install xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic xserver-xorg-core iceweasel chromium
cp cucumberpi/scripts/xvfb /etc/init.d/
chmod 755 /etc/init.d/xvfb
update-rc.d xvfb defaults
ln -s /usr/lib/iceweasel/firefox-bin /usr/bin/firefox-bin
patch -u  /etc/profile cucumberpi/patches/profile.patch
chmod a+rw /var/run
#
# Everybody loves node.  We'll grab zombie later.
#
echo Installing node.js and NPM
apt-get -qq -y install nodejs npm
#
# install gems
#
echo Installing gems...
gem install rake bundler
gem install cucumber webrat headless rspec deep_test spec_ui webidl polyglot pry linecache19 method_source
gem install watir-webdriver firewatir watir pry-debugger pry-syntax-hacks pry-remote pry-remote-em pry-stack_explorer pry-exception_explorer



