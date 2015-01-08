%define lowername  power-outlet

Name:           perl-Power-Outlet
Version:        0.15
Release:        2%{?dist}
Summary:        Control and query network attached power outlets
License:        GPL+ or Artistic
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Power-Outlet/
Source0:        http://www.cpan.org/modules/by-module/Power/Power-Outlet-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(Test::Simple) >= 0.44
BuildRequires:  perl(Package::New)
BuildRequires:  perl(HTTP::Tiny)
BuildRequires:  perl(JSON)
BuildRequires:  perl(URI)
Requires:       perl(Net::SNMP)
Requires:       perl(Net::UPnP)
Requires:       perl(XML::LibXML::LazyBuilder)
Requires:       perl(Package::New)
Requires:       perl(HTTP::Tiny)
Requires:       perl(JSON)
Requires:       perl(URI)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
Power::Outlet is a package for controlling and querying network attached
power outlets. Individual hardware drivers in this name space must provide
a common object interface for the controlling and querying of an outlet.
Common methods that every network attached power outlet must know are on,
off, query, switch and cycle. Optional methods might be implemented in some
drivers like amps and volts.

%package application-cgi
Summary:        Control multiple Power::Outlet devices from web browser
Requires:       %{name} = %{version}-%{release}
Requires:       perl(CGI)
Requires:       perl(Config::IniFiles)
Requires:       perl(JSON)

%description application-cgi
power-outlet.cgi is a CGI application to control multiple Power::Outlet
devices. It was written to work on iPhone and look ok in most browsers.

%prep
%setup -q -n Power-Outlet-%{version}

%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT

make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT

find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} \;
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

%{_fixperms} $RPM_BUILD_ROOT/*

echo -ne "\n\n\nFiles Installed\n\n\n"
find $RPM_BUILD_ROOT
echo -ne "\n\n\nFiles in Tar Ball\n\n\n"
find
echo -ne "\n\n\n"

mkdir -p $RPM_BUILD_ROOT/
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/httpd/conf.d/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/conf/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/cgi-bin/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/images/
cp ./scripts/httpd/%{lowername}.conf $RPM_BUILD_ROOT/%{_sysconfdir}/httpd/conf.d/
cp ./scripts/images/btn-on.png       $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/images/
cp ./scripts/images/btn-off.png      $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/images/
cp ./scripts/conf/%{lowername}.ini   $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/conf/
cp ./scripts/%{lowername}.cgi        $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/cgi-bin/
cp ./scripts/%{lowername}-json.cgi   $RPM_BUILD_ROOT/%{_datadir}/%{lowername}/cgi-bin/

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files application-cgi
%defattr(-,root,root,-)
%{_sysconfdir}/httpd/conf.d/%{lowername}.conf
%dir %{_datadir}/%{lowername}
%dir %{_datadir}/%{lowername}/conf/
%dir %{_datadir}/%{lowername}/cgi-bin/
%dir %{_datadir}/%{lowername}/images/
%config %{_datadir}/%{lowername}/conf/%{lowername}.ini
%attr(0755,root,root) %{_datadir}/%{lowername}/cgi-bin/%{lowername}.cgi
%attr(0755,root,root) %{_datadir}/%{lowername}/cgi-bin/%{lowername}-json.cgi
%{_datadir}/%{lowername}/images/btn-on.png
%{_datadir}/%{lowername}/images/btn-off.png

%files
%defattr(-,root,root,-)
%doc Changes LICENSE perl-Power-Outlet.spec README Todo
%{perl_vendorlib}/*
%{_mandir}/man3/*
%{_mandir}/man1/%{lowername}.1.gz
%attr(0755,root,root) %{_bindir}/%{lowername}

%changelog
* Tue Nov 26 2013 Michael R. Davis (mdavis@stopllc.com) 0.01-1
- Specfile autogenerated by cpanspec 1.78.
