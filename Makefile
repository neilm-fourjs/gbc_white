
all: distbin/gbcwhite_demo.gar

distbin/gbcwhite_demo.gar: src/*.4gl
	gsmake gbcwhite.4pw -t gbcwhite_demo


