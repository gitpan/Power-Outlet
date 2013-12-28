use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Power::Outlet',
    VERSION_FROM => 'lib/Power/Outlet.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (mdavis@stopllc.com)',
    ABSTRACT     => 'Control and query network attached power switches',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'Package::New' => 0,
                     'Net::SNMP'    => 0,
                    },
    EXE_FILES    => [
                    qw{
                       scripts/power-outlet
                      }
                    ],
);
