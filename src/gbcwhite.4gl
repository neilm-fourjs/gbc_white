IMPORT FGL lib
MAIN
	DEFINE l_form STRING

	LET l_form = ARG_VAL(1)
	IF l_form.getLength() < 2 THEN
		LET l_form = "form1"
	END IF

	CALL ui.Interface.setText("GBC Testcase Program")
	CALL ui.Form.setDefaultInitializer("form_init")
	CALL ui.Interface.loadToolBar("toolbar")
	CALL ui.Interface.loadTopMenu("topmenu")

	OPEN FORM t FROM l_form
	DISPLAY FORM t

	CALL lib.reTitle()
	CALL lib.fillForm()

	CASE l_form
		WHEN "form1"
			CALL form1()
		OTHERWISE
			MENU
				ON ACTION batch MESSAGE "Batch"
				ON ACTION add MESSAGE "Add"
				ON ACTION delete MESSAGE "Delete"
				ON ACTION update MESSAGE "Update"
				ON ACTION view MESSAGE "View"
				ON ACTION defaults MESSAGE "Defaults"
				ON ACTION refresh MESSAGE "Refresh"
				ON ACTION menu MESSAGE "Menu"
				ON ACTION subscreen MESSAGE "SubScreen"
				ON ACTION parent MESSAGE "Parent"
				ON ACTION full MESSAGE "Full"
				ON ACTION query MESSAGE "Query"
				ON ACTION mark MESSAGE "Mark"
				ON ACTION sort MESSAGE "Sort"
				ON ACTION email MESSAGE "Email"
				ON ACTION support MESSAGE "Support"
				ON ACTION help MESSAGE "Help"
				ON ACTION button1 MESSAGE "Button1"
				ON ACTION button2 MESSAGE "Button2"
				ON ACTION button3 MESSAGE "Button3"
				ON ACTION button4 MESSAGE "Button4"
				ON ACTION button5 MESSAGE "Button5"
				ON ACTION button6 MESSAGE "Button6"
				ON ACTION button7 MESSAGE "Button7"
				ON ACTION button8 MESSAGE "Button8"
				ON ACTION button9 MESSAGE "Button9"
				ON ACTION button10 MESSAGE "Button10"
				ON ACTION quit
					EXIT MENU
				ON ACTION close
					EXIT MENU
			END MENU
	END CASE

END MAIN
--------------------------------------------------------------------------------------------------------------
PRIVATE FUNCTION form1()
	DEFINE l_arr DYNAMIC ARRAY OF RECORD
		prod_code INT,
		descr STRING,
		ordered DATE,
		cost DECIMAL(12,2),
		price DECIMAL(12,2),
		qty INTEGER,
		tax DECIMAL(6,3),
		total DECIMAL(12,2)
	END RECORD
	DEFINE x SMALLINT

	FOR x = 1 TO 5
		LET l_arr[x].prod_code = x
		LET l_arr[x].descr = "This is prod ",x
		LET l_arr[x].ordered = TODAY
		LET l_arr[x].price = x * 10
		LET l_arr[x].cost = x * 8
		LET l_arr[x].qty = x
		LET l_arr[x].tax = 20
		LET l_arr[x].total = (l_arr[x].price+(l_arr[x].price * ( l_arr[x].tax / 100 ))) * l_arr[x].qty
	END FOR

	DISPLAY ARRAY l_arr TO arr.*
		ON ACTION batch MESSAGE "Batch"
		ON ACTION add MESSAGE "Add"
		ON ACTION delete MESSAGE "Delete"
		ON ACTION update MESSAGE "Update"
		ON ACTION view MESSAGE "View"
		ON ACTION defaults MESSAGE "Defaults"
		ON ACTION refresh MESSAGE "Refresh"
		ON ACTION menu MESSAGE "Menu"
		ON ACTION subscreen MESSAGE "SubScreen"
		ON ACTION parent MESSAGE "Parent"
		ON ACTION full MESSAGE "Full"
		ON ACTION query MESSAGE "Query"
		ON ACTION mark MESSAGE "Mark"
		ON ACTION sort MESSAGE "Sort"
		ON ACTION email MESSAGE "Email"
		ON ACTION support MESSAGE "Support"
		ON ACTION help MESSAGE "Help"
		ON ACTION button1 MESSAGE "Button1"
		ON ACTION button2 MESSAGE "Button2"
		ON ACTION button3 MESSAGE "Button3"
		ON ACTION button4 MESSAGE "Button4"
		ON ACTION button5 MESSAGE "Button5"
		ON ACTION button6 MESSAGE "Button6"
		ON ACTION button7 MESSAGE "Button7"
		ON ACTION button8 MESSAGE "Button8"
		ON ACTION button9 MESSAGE "Button9"
		ON ACTION button10 MESSAGE "Button10"
		ON ACTION quit
			EXIT DISPLAY
		ON ACTION close
			EXIT DISPLAY
	END DISPLAY

END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION form_init(f ui.Form)
	DEFINE fn om.DomNode
	DEFINE nl om.NodeList
	DEFINE x SMALLINT
	LET fn = f.getNode()
	CALL ui.Interface.getRootNode().writeXml(fn.getAttribute("name")||".xml")
	IF ui.Interface.getFrontEndName() = "GDC" AND ui.Interface.getUniversalClientName() IS NULL THEN
		RETURN
	END IF

	LET nl = fn.selectByPath("//Label[@name=\"dummy\"]")
	FOR x = 1 TO nl.getLength()
		DISPLAY "Hide Dummy"
		CALL nl.item(x).setAttribute("hidden", 1)
	END FOR
END FUNCTION
