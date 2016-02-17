Log::Basic
==========

#SYNOPSIS

##One-liner
```
perl -MLog::Basic -e 'info "Hello"'
```
This outputs `[info] 2016-02-17 11:32:51 - Hello`

##Full Perl example
```perl
use Log::Basic;
$Log::Basic::VERBOSITY=3;
debug "stuff"; # won't be printed
info "here is the info message"; # won't be printed
warning "wow! beware!";
error "something terrible happend !";
msg "this message will be displayed whatever the verbosity level";
sep "a separator";
fatal "fatal error: $!";
```

#DESCRIPTION

Log::Basic displays formatted log messages accorinding to the defined verbosity level (default:4).

Log messages are formatted as: `[<level>] <date> - <message>`

Verbosity and associated levels are:
- level 1, `msg`
- level 2, `error`
- level 3, `warn`
- level 4, `info`
- level 5, `debug`
- no level, `fatal`

Setting verbosity to 3 will print `warn`, `info`, and `msg` only.
`fatal` is a special level, corresponding to perl's `die()`.
Dates are formatted as: `YYYY-MM-DD hh:mm:ss`.
Your message could be whatever you what.

Separator is a special functions which display a line of 80 dashes, with your message eventually.

#INSTALLATION

To install this module type the following:

```
perl Makefile.PL
make
make install
```

#DEPENDENCIES

None.

#COPYRIGHT AND LICENCE

Put the correct copyright and licence information here.

Copyright (C) 2016 by Kévin Gravouil

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.20.2 or,
at your option, any later version of Perl 5 you may have available.

