# -*- perl -*-
use strict;
use warnings;
use Test::More tests => 36;

BEGIN { use_ok( 'Power::Outlet' ); }
BEGIN { use_ok( 'Power::Outlet::Common' ); }
BEGIN { use_ok( 'Power::Outlet::Common::IP' ); }
BEGIN { use_ok( 'Power::Outlet::Common::IP::SNMP' ); }
BEGIN { use_ok( 'Power::Outlet::iBoot' ); }
BEGIN { use_ok( 'Power::Outlet::iBootBar' ); }

{
my $object = Power::Outlet->new(type=>"Common");
isa_ok ($object, 'Power::Outlet::Common');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
}

{
my $object = Power::Outlet->new(type=>"iBoot");
isa_ok ($object, 'Power::Outlet::iBoot');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
}

{
my $object = Power::Outlet->new(type=>"iBootBar");
isa_ok ($object, 'Power::Outlet::iBootBar');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
}

{
my $object = Power::Outlet::Common->new;
isa_ok ($object, 'Power::Outlet::Common');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
}

{
my $object = Power::Outlet::Common::IP->new;
isa_ok ($object, 'Power::Outlet::Common::IP');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
can_ok($object, qw{host port});
}

{
my $object = Power::Outlet::Common::IP::SNMP->new;
isa_ok ($object, 'Power::Outlet::Common::IP::SNMP');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
can_ok($object, qw{host port});
can_ok($object, qw{snmp_get snmp_set snmp_session});
}

{
my $object = Power::Outlet::iBoot->new;
isa_ok ($object, 'Power::Outlet::iBoot');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
can_ok($object, qw{host port});
}

{
my $object = Power::Outlet::iBootBar->new;
isa_ok ($object, 'Power::Outlet::iBootBar');
can_ok($object, qw{new});
can_ok($object, qw{on off switch cycle query});
can_ok($object, qw{host port});
can_ok($object, qw{snmp_get snmp_set snmp_session});
}
