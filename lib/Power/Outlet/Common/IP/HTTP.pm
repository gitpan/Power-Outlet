package Power::Outlet::Common::IP::HTTP;
use strict;
use warnings;
use base qw{Power::Outlet::Common::IP};

our $VERSION='0.10';


=head1 NAME

Power::Outlet::Common::IP::HTTP - Power::Outlet base class for HTTP power outlet

=head1 SYNOPSIS

  use base qw{Power::Outlet::Common::IP::HTTP};

=head1 DESCRIPTION
 
Power::Outlet::Common::IP::HTTP is a package for controlling and querying an HTTP-based network attached power outlet.

=head1 USAGE

  use base qw{Power::Outlet::Common::IP::HTTP};

=head1 PROPERTIES

=cut

sub _port_default {"80"};            #HTTP

=head2 http_path

Set and returns the http_path property

Default: /

=cut

sub http_path {
  my $self=shift;
  $self->{"http_path"}=shift if @_;
  $self->{"http_path"}=$self->_http_path_default unless defined $self->{"http_path"};
  return $self->{"http_path"};
}

sub _http_path_default {"/upnp/control/basicevent1"}; #WeMo

=head1 BUGS

Please log on RT and send an email to the author.

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  DavisNetworks.com

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

=cut

1;
