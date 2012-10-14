Cucumber Pi
=========

Tools for automated testing using Raspberry Pi boards.

&nbsp;
Installation
-----------

### Create a bootable Raspbian card (From OSX)
You should have a Raspberry Pi attached to an HDMI/DVI display, keyboard/mouse and ethernet.

1. Insert SD card in reader on your computer
2. `git clone https://github.com/Donavan/cucumberpi.git`
3. `cd cucumberpi`
4. `rake`
5. Follow prompts
6. Remove card from your computer and insert into Raspberry pi
7. Power up Raspberry Pi and complete the setup.  It's not necessary to perform the upgrade set at this time.  The bootstrap script will take care of it.

### Install all the things!
1. Log into the Raspberry Pi as the user pi
2. 
`wget -qO- https://raw.github.com/Donavan/cucumberpi/master/scripts/bootstrap.sh | sudo sh`
3. Go get a beer, it's gonna be a while.
