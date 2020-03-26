IMPORT FGL lib
MAIN
	DEFINE itmarr DYNAMIC ARRAY OF RECORD
		formname STRING,
		descr STRING
	END RECORD
	DEFINE x SMALLINT
	LET x = 1
	LET itmarr[x].formname = "form1"
	LET itmarr[x].descr = "'form1'"

	OPEN FORM fmenu FROM "menu"
	DISPLAY FORM fmenu

	DISPLAY lib.getVersion() TO ver
	
	DISPLAY ARRAY itmarr TO arr.*
		ON ACTION accept
			RUN "fglrun gbcwhite.42r "||itmarr[ arr_curr() ].formname
		ON ACTION quit EXiT DISPLAY
		ON ACTION close EXIT DISPLAY
	END DISPLAY

END MAIN