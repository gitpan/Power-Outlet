package Power::Outlet::Hue;
use strict;
use warnings;
#use Data::Dumper qw{Dumper};
use List::Util qw{first};
use base qw{Power::Outlet::Common::IP::HTTP::JSON};

our $VERSION='0.14';

=head1 NAME

Power::Outlet::Hue - Control and query a Philips Hue light

=head1 SYNOPSIS

  my $outlet=Power::Outlet::Hue->new(host => "mybridge", id=>1, username=>"myuser");
  print $outlet->query, "\n";
  print $outlet->on, "\n";
  print $outlet->off, "\n";

=head1 DESCRIPTION

Power::Outlet::Hue is a package for controlling and querying a light on a Philips Hue network attached bridge.

=head1 USAGE

  use Power::Outlet::Hue;
  my $lamp=Power::Outlet::Hue->new(host=>"mybridge", id=>1, username=>"myuser");
  print $lamp->on, "\n";

=head1 CONSTRUCTOR

=head2 new

  my $outlet=Power::Outlet->new(type=>"Hue", host=>"mybridge", id=>1);
  my $outlet=Power::Outlet::Hue->new(host=>"mybridge", id=>1);

=head1 PROPERTIES

=head2 id

ID for the particular light as configured in the Philips Hue Bridge

Note: default = 1

=cut

sub id {
  my $self=shift;
  $self->{"id"}=shift if @_;
  $self->{"id"}=$self->_id_default unless defined $self->{"id"};
  return $self->{"id"};
}

sub _id_default {1};

=head2 host

Sets and returns the hostname or IP address.

Note: Set IP address via DHCP static mapping

Default: mybridge

=cut

sub _host_default {"mybridge"};

=head2 port

Sets and returns the port number.

Default: 80

=cut

sub _port_default {"80"};

=head2 username

Default: newdeveloper (Hue Emulator default)

=cut

sub username {
  my $self=shift;
  $self->{"username"}=shift if @_;
  $self->{"username"}=$self->_username_default unless defined $self->{"username"};
  return $self->{"username"};
}

sub _username_default {"newdeveloper"};

=head2 name

Returns the configured FriendlyName from the Hue device

=cut

sub _name_default {
  my $self=shift;
  my $url=$self->url; #isa URI from Power::Outlet::Common::IP::HTTP
  $url->path(sprintf("/api/%s/lights/%s", $self->username, $self->id));
  my $res=$self->json_request(GET => $url); #isa perl structure
  return $res->{"name"}; #isa string
}

=head1 METHODS

=head2 query

Sends an HTTP message to the Hue device to query the current state

=cut

#Return: {"identifier":null,"state":{"on":true,"bri":254,"hue":4444,"sat":254,"xy":[0.0,0.0],"ct":0,"alert":"none","effect":"none","colormode":"hs","reachable":true,"transitionTime":null},"type":"Extended color light","name":"Hue Lamp 1","modelid":"LCT001","swversion":"65003148","pointsymbol":{"1":"none","2":"none","3":"none","4":"none","5":"none","6":"none","7":"none","8":"none"}}

sub query {
  my $self=shift;
  if (defined wantarray) { #scalar and list context
    my $url=$self->url; #isa URI from Power::Outlet::Common::IP::HTTP
    $url->path(sprintf("/api/%s/lights/%s", $self->username, $self->id));
    my $res=$self->json_request(GET => $url); #isa perl structure
    my $state=$res->{"state"}->{"on"}; #isa boolean true/false
    #print Dumper(query=>$state);
    return $state ? "ON" : "OFF";
  } else { #void context
    return;
  }
}

=head2 on

Sends a UPnP message to the Hue device to Turn Power ON

=cut

#return: [{"success":{"/lights/1/state/on":true}}]

sub on {
  my $self=shift;
  my $url=$self->url; #isa URI from Power::Outlet::Common::IP::HTTP
  $url->path(sprintf("/api/%s/%s/state", $self->username, $self->id));
  my $res=$self->json_request(PUT => $url, {on=>\1}); #isa perl structure
  #print Dumper(on=>$res);
  my $hash=$res->[0]->{"success"};
  my $state=first {1} values(%$hash); #isa boolean true/false
  return $state ? "ON" : "OFF";
}

=head2 off

Sends a UPnP message to the Hue device to Turn Power OFF

=cut

sub off {
  my $self=shift;
  my $url=$self->url; #isa URI from Power::Outlet::Common::IP::HTTP
  $url->path(sprintf("/api/%s/%s/state", $self->username, $self->id));
  my $res=$self->json_request(PUT => $url, {on=>\0}); #isa perl structure
  #print Dumper(on=>$res);
  my $hash=$res->[0]->{"success"};
  my $state=first {1} values(%$hash); #isa boolean true/false
  return $state ? "ON" : "OFF";
}

=head2 switch

Queries the device for the current status and then requests the opposite.

=cut

#see Power::Outlet::Common->switch

=head2 cycle

Sends messages to the Hue device to Cycle Power (ON-OFF-ON or OFF-ON-OFF).

=cut

#see Power::Outlet::Common->cycle

=head1 BUGS

Please log on RT and send an email to the author.

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  DavisNetworks.com

=head1 COPYRIGHT

Copyright (c) 2013 Michael R. Davis

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

Portions of the Hue Implementation Copyright (c) 2013 Eric Blue

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<WebService::Belkin::Wemo::Device>, L<https://gist.github.com/jscrane/7257511>

=cut

1;
