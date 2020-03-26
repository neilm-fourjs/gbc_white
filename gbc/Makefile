
GBCBASE=$(PWD)

include makefile.inc

BASE=$(shell pwd)
dirs=gbc-white

all: distbin gbc-current subdirs

distbin:
	mkdir distbin

# Setup the GBC build env
gbc-current: 
	ln -s /opt/fourjs/gbc-current

subdirs: $(dirs)
	@for dir in $^ ; do  \
		cd $(BASE)/$$dir && make all; \
	done

clean:
	rm $(DISTBIN)/gbc*.zip

deploy: distbin
	cd distbin && gasadmin gbc --deploy $(dirs).zip

undeploy:
	gasadmin gbc --undeploy $(dirs)

redeploy: undeploy deploy

