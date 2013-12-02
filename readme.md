Podcast-O-Matic
==============

A collection of shell scripts to record radio shows from an
online stream and generate a podcast.

It's a side project, but nevertheless it's working like a charm for years know.

At first - in 2007 when online radio streams were not that common - the audio
was recorded from an external radio receiver.


System overview
---------------

The current system is based on a
[low power computer](http://www.pcengines.ch/alix1d.htm)
which records the radio shows and generates the podcast.
The xml- and the mp3-files are then uploaded onto a publicly available server,
such that people with a login can access the podcast.


Getting started
---------------

The document voyage\_installation.txt describes how to install the operating
system voyage linux (A debian based linux, which can run in a read only mode,
to go ease on the cf card (the hard disc surrogate)) and how to set up
everything else.

klangfreund.com is the name of my server.


Remarks
-------

It should be possible to set up a similar system on a Raspberry Pi.

Nowadays I would even run all the scripts directly on the server and
omit the low power computer.
