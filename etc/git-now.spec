Summary: making convenient git commit
Name: git-now
Version: 0.0
Release: 1%{?dist}
License: Apache License, Version 2.0
Group: Development/Languages
Provides: git-now
Requires: git
BuildRequires: git
Source0: git-now
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Packager: Kazuhisa Hara <kazuhisya@gmail.com>

%description
git now: making convenient git commit

%prep

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/libexec/git-core
make prefix=$RPM_BUILD_ROOT/usr/libexec/git-core install

%clean
rm -Rf $RPM_BUILD_ROOT

%post

%files
%defattr(-,root,root)
/usr/libexec/git-core/git-now


%changelog
* Mon Jul 04 2011 Kazuhisa Hara <kazuhisya@gmail.com>
- Initial version
* Mon Oct 17 2011 Motonori Iwata <gootonori@gmail.com>
- use Makefile
