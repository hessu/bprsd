
BPRS
======

BPRS, Bluetooth Position Reporting System, is a program which can announce
the presence of amateur radio operators at a certain location (club station,
hamfest, swap meet) on the APRS-IS based on the presence of their Bluetooth
enabled devices.

Locations with BPRS coverage (having a BPRS hotspot) are marked with a
visible BPRS sign which also contains the following user guide.


BPRS User Guide
-----------------

1. Set the name of your mobile phone (or laptop, or ipad, or some other
   Bluetooth gadget you keep with you) to "bprs yourcall", for example
   "bprs n0call". Capital or small letters, it doesn't care. Only
   callsigns with 1 to 3 letters in the suffix will work. Watch for
   the significant difference between a zero and an O character, they
   look pretty much the same on a small mobile display. Do not add an
   APRS SSID, BPRS will automatically add -BP in the callsign.
2. Enable the phone's bluetooth connection and make it discoverable
   (visible to others).
3. Wait a few minutes.
4. The BPRS station yourcall-BP should appear on the APRS maps (such as
   aprs.fi) close to the location of the club.
5. You can now undo the changes done in steps 1 and 2. Change the name
   of your phone back to your liking and make it non-discoverable.
6. Next time you arrive at the BPRS location, BPRS will detect your
   phone's presence in a few minutes and announce you on the APRS-IS.
   There is no need to go back to steps 1 and 2 any more - BPRS will
   remember your device's Bluetooth address. In the current incarnation,
   you'll need to register separately at each BPRS site, there is no
   distributed database of Bluetooth addresses.


Installation instructions for the BPRS hotspot
------------------------------------------------

Using this guide you can set up BPRS at your club station or hamfest.

The hotspot software is written in the Perl programming language and will
easily install on a Linux server.  There are no intentions to port it to
Windows or any other operating system by the original author (who doesn't
have any competence for doing so either).  The Perl software should easily
run on other operating systems, but it uses the Linux bluetooth command line
tools (hcitool) which do not exist on other platforms.

First, let's install some dependencies (this command is for Ubuntu and
Debian, other distributions should have something similar):

    sudo apt-get install perl libjson-perl libstring-crc32-perl bluez \
        libyaml-tiny-perl libdate-calc-perl

Then, let's install the APRS-IS connectivity package, latest version:

    wget http://he.fi/bprs/Ham-APRS-FAP-1.18.tar.gz
    tar xvfz Ham-APRS-FAP-1.18.tar.gz
    cd Ham-APRS-FAP-1.18
    perl Makefile.PL
    make
    sudo make install

And then, the BPRS hotspot software itself:

    wget http://he.fi/bprs/bprsd-1.00.tar.gz
    tar xvfz bprsd-1.00.tar.gz
    cd bprsd-1.00
    perl Makefile.PL
    make
    sudo make install

bprsd will be installed as /usr/local/bin/bprsd.

Copy the example configuration file from the package, bprsd.conf.example, to
/etc/bprsd.conf (or /usr/local/etc/bprsd.conf), and edit it to contain your
site information.

Launch the bprsd as a normal user (nobody, yourself, or someone else, but
not root).  This initial beta release does not contain any startup scripts,
and all logging will be through stdout and stderr.  The most convenient way
to run it and handle log rotation is supervisord (apt-get install
supervisor).


Bluetooth dongle for the hotspot
----------------------------------

If your server does not have bluetooth, you can purchase one for a couple
dollars from Dealextreme (or just about any store selling computer
accessories, but it'll be more expensive).  When ordering from Dealextreme
be sure to pick a model which they claim to have in store.  The ones with a
visible external antenna are no better (or worse) than the ones which don't.
I bought one and the antenna is plastic and empty (the antenna still being
a patch on the circuit board).

Search bluetooth on Dealextreme

If and when the server is hidden in a rack, or under the table, it's a good
idea to extend the Bluetooth range by bringing the dongle higher on the wall
using a 2-meter USB 2.0 extender cable.  Just the case of a regular computer
can create some sort of coverage block.

USB extension cables on Dealextreme


How it really works?
----------------------

The bprs hotspot does a Bluetooth "scan" operation every few minutes to look
for new BPRS stations.  The scan will only find Bluetooth devices which are
currently in discoverable mode and publicly visible to other devices.  For
security reasons most Bluetooth devices are by default not discoverable, and
need to be explicitly made discoverable.

Each visible device's name is tested if it matches the 'bprs callsign'
format.  Also, the callsign is validated that it looks roughly like an
amateur radio callsign.  The callsign is converted to upper case.

All found BPRS stations are stored locally in a simple database file (SDBM). 
The database is keyed by the bluetooth address and contains the callsign
found in the initial discovery scan, and a few timers.

The bprs hotspot periodically (every few minutes) tries to directly talk to
the bluetooth MAC address of each BPRS station it has seen before and stored
in the database.  This direct connection will work even after the bluetooth
device's hostname has been changed and when the device is not discoverable. 
When the stations are seen, they are announced to the APRS-IS network.

Each BPRS station will only be announced every 15 minutes.  The coordinates
are offset to the north and to the east from the BPRS hotspot's coordinates
using a pseudorandom scheme.  Each station will always appear at the same
offset, since it's calculated from the callsign of the station.

