package Log::Basic;

use 5.020002;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(
	debug info warning error msg sep
);

our $VERSION = '1.0';

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
our $DEFAULT_VERBOSITY = 4;
our $VERBOSITY = $DEFAULT_VERBOSITY;

# ------------------------------------------------------------------------------
# Internal functions
# ------------------------------------------------------------------------------
sub now {
	my ($S,$M,$H,$d,$m,$y) = localtime(time);
	return sprintf("%04d-%02d-%02d %02d:%02d:%02d", $y+1900, $m+1 ,$d,$H,$M,$S);
}

# ------------------------------------------------------------------------------
# Exported functions
# ------------------------------------------------------------------------------
sub debug {
	print "[debug] ".now()." - @_\n" if $VERBOSITY > 4;
}

sub info {
	print "[info] ".now()." - @_\n" if $VERBOSITY > 3;
}

sub warning {
	print "[warn] ".now()." - @_\n" if $VERBOSITY > 2;
}

sub error {
	print "[error] ".now()." - @_\n" if $VERBOSITY > 1;
}

sub msg {
	print "[msg] ".now()." - @_\n" if $VERBOSITY > 0;
}

sub fatal {
	die "[fatal] ".now()." - @_\n";
}

sub sep {
	print '-' x 80 . "\r---@_\n";
}


1;
__END__

=head1 NAME

Log::Basic - Perl extension for simple logging.

=head1 SYNOPSIS

  perl -MLog::Basic -e 'info "hey"'
  
  use Log::Basic;
  $Log::Basic::VERBOSITY=3;
  debug "stuff"; # won't be printed
  info "here is the info message"; # won't be printed
  warning "wow! beware!";
  error "something terrible happend !";
  msg "this message will be displayed whatever the verbosity level";
  sep "a separator";

=head1 DESCRIPTION

Log::Basic displays formatted log messages.

Log message are formatted as: [<level>] <date> - <message>

Level can be: "debug", "info", "warn", "error", "msg".

"fatal" is a special level, corresponding to perl's die().

Date is formatted as: "YYYY-MM-DD hh:mm:ss".

Your message could be whatever you what.

Separator will display a line of dash, with your message eventually.

=head1 EXPORT

debug info warning error msg sep

=head1 AUTHOR

Kévin Gravouil, E<lt>k.gravouil@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Kévin Gravouil

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.20.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

