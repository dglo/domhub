REL=$(shell cat rel.num)
SRT=domhub-$(REL)
STB=$(SRT).tar.gz

RPMDIR=~/rpmbuild
#ARCH=$(shell arch)
ARCH=noarch
RPM=$(RPMDIR)/RPMS/$(ARCH)/$(SRT)-1.$(ARCH).rpm

SPEC=domhub-$(REL).spec
SUBDIRS=bin config dropbox lib results

# Version control directories to exclude
VCS=.svn

all: rpm

rhdirs:
	mkdir -p $(RPMDIR)
	for dir in SPECS SOURCES BUILD RPMS SRPMS ; do \
		mkdir -p $(RPMDIR)/$$dir; \
	done

rpm: $(RPM)

stb: $(STB)

spec: $(SPEC)

$(SPEC): rhdirs domhub.spec
		@sed 's/Version: [.0-9]*/Version: $(REL)/' domhub.spec > $(RPMDIR)/SPECS/$(SPEC)

$(STB):
		@mkdir $(SRT)
		@tar cf - $(SUBDIRS) --exclude=$(VCS) | ( cd $(SRT); tar xf - )
		@tar cf - $(SRT) | gzip -c > $(STB)
		@rm -rf $(SRT)

$(RPM): $(STB) $(SPEC) 
		@cp $(STB) $(RPMDIR)/SOURCES
		(cd $(RPMDIR)/SPECS; rpmbuild -ba $(SPEC))
