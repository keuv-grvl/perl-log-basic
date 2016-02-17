package Log::Basic;

use 5.020002;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(
	debug info warning error msg sep fatal
);

our $VERSION = '1.1';

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
our $DEFAULT_VERBOSITY = 4;
our $VERBOSITY = $DEFAULT_VERBOSITY;
open(OUT, ">>", "./log/$$.$0.log")
	or open(OUT, ">>", "$$.$0.log")
	or die("Could not open $0.$$.log: $!");

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
	print OUT "[debug] ".now()." - @_\n" if(fileno(OUT));
}

sub info {
	print "[info] ".now()." - @_\n" if $VERBOSITY > 3;
	print OUT "[info] ".now()." - @_\n" if(fileno(OUT));
}

sub warning {
	print "[warn] ".now()." - @_\n" if $VERBOSITY > 2;
	print OUT "[warn] ".now()." - @_\n" if(fileno(OUT));
}

sub error {
	print "[error] ".now()." - @_\n" if $VERBOSITY > 1;
	print OUT "[error] ".now()." - @_\n" if(fileno(OUT));
}

sub msg {
	print "[msg] ".now()." - @_\n" if $VERBOSITY > 0;
	print OUT "[msg] ".now()." - @_\n" if(fileno(OUT));
}

sub fatal {
	print OUT "[fatal] ".now()." - @_\n" if(fileno(OUT));
	die "[fatal] ".now()." - @_\n";
}

sub sep {
	my $str = join(';', @_);
	print '---', $str, '-' x (80 - (3 + length $str)), "\n";
	print OUT '---', $str, '-' x (80 - (3 + length $str)), "\n";
}

END {
	close OUT if(fileno(OUT));
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

