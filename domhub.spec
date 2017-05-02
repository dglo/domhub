# Be sure buildpolicy set to do nothing
%define        __spec_install_post %{nil}
%define          debug_package %{nil}
%define        __os_install_post %{_dbpath}/brp-compress

Summary: DOMHub central controls cripts
Name: domhub
# Don't need to update this version, Makefile will do it
Version: 1.0
Release: 1
License: Copyright 2017 IceCube Collaboration
Group: System Environment/Base
SOURCE0 : %{name}-%{version}.tar.gz
URL: http://icecube.wisc.edu

# Required DBD module for Perl not autodetected
#Requires: perl(DBD::mysql)
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
rm -rf %{buildroot}
mkdir -p  %{buildroot}/usr/local/pdaq/domhub

# in builddir
cp -a * %{buildroot}/usr/local/pdaq/domhub

%clean
rm -rf %{buildroot}

%files
#%defattr(-, pdaq, pdaq, -)
%attr(777, -, -) %dir dropbox/tape
%attr(777, -, -) %dir dropbox/satellite-only/high-priority

%changelog
* Tue May 2 2017 John Kelley <jkelley@icecube.wisc.edu>
Initial version moved and reorganized from testdaq-user RPM.
