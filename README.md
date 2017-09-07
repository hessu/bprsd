bprsd
=====

This perl program implements the BPRS service. It looks for Bluetooth
stations nearby the server running the service, and if the bluetooth
name of those stations match a preconfigured pattern, it announces
the stations to the APRS-IS using preconfigured coordinates indicating
the location of the BPRS site. A small, pseudorandom and consistent offset
is applied to each station to avoid all stations being placed on top of
each other.


INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make install


DEPENDENCIES

perl Makefile.PL should complain about them (and contains a full
list if needed). It's also listed on the documentation page
linked below.


DOCUMENTATION

This module is documented in perldoc format - see 'perldoc bprsd' or
'man bprsd'.


SEE ALSO

  BPRS documentation (Finnish), [<http://wiki.ham.fi/BPRS]
  BPRS documentation (English), [<http://wiki.ham.fi/BPRS.en]


COPYRIGHT AND LICENCE

Copyright (C) 2010-2030 Heikki Hannikainen

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

