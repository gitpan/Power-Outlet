package Power::Outlet;
use strict;
use warnings;

our $VERSION='0.12';

=head1 NAME

Power::Outlet - Control and query network attached power outlets

=head1 SYNOPSIS

Constructs a L<Power::Outlet::iBoot>

  my $outlet=Power::Outlet->new(                   #sane defaults from manufactures spec
                                type => "iBoot",
                                host => "mylamp",
                               );
  print $outlet->query, "\n";
  print $outlet->on, "\n";
  print $outlet->off, "\n";

Constructs a L<Power::Outlet::iBootBar>

  my $outlet=Power::Outlet->new(       #sane defaults from manufactures spec
                                type   => "iBootBar",
                                host   => "mybar",
                                outlet => 1,
                               );
  print $outlet->query, "\n";
  print $outlet->on, "\n";
  print $outlet->off, "\n";

=head1 DESCRIPTION
 
Power::Outlet is a package for controlling and querying network attached power outlets.  Individual hardware drivers in this name space must provide a common object interface for the controlling and querying of an outlet.  Common methods that every network attached power outlet must know are on, off, query, switch and cycle.  Optional methods might be implemented in some drivers like amps and volts.

=head2 SCOPE

The current scope of these packages is network attached power outlets. I have started with iBoot and iBootBar since I have test hardware.  Hardware configuration is beyond the scope of this group of packages as most power outlets have functional web based or command line configuration tools.

=head2 FUTURE

I hope to be able to support WeMo.  As well as integrate with services like IFTTT (ifttt.com).  I would appreciate community support to help develop drivers for USB controlled power strips and serial devices like the X10 family.

=head1 USAGE

The Perl one liner

  perl -MPower::Outlet -e 'print Power::Outlet->new(type=>"iBoot", host=>shift)->switch, "\n"' lamp

The included script

  power-outlet iBoot SWITCH host lamp

=head1 CONSTRUCTOR

=head2 new

  my $outlet=Power::Outlet->new(type=>"iBoot", host=>"mylamp");
  my $outlet=Power::Outlet->new(type=>"iBootBar", host=>"mybar", outlet=>1);

=cut

sub new {
  my $this=shift;
  my $base=ref($this) || $this;
  my %data=@_;
  my $type=$data{"type"} or die("Error: the type parameter is required.");
  my $class=join("::", $base, $type);
  eval "use $class";
  my $error=$@;
  die(qq{Errot: Cannot find package "$class" for outlet type "$type"\n}) if $error;
  my $outlet=$class->new(%data);
  return $outlet;
}

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

L<Power::Outlet::iBoot>, L<Power::Outlet::iBootBar>, L<Power::Outlet::WeMo>

=cut

1;
