DEFINE m_GeneroVersions STRING
--------------------------------------------------------------------------------------------------------------
FUNCTION reTitle()
	DEFINE l_f, l_w om.DomNode
	DEFINE l_titl STRING
	LET l_w = ui.Window.getCurrent().getNode()
	IF l_w.getAttribute("style") = "dialog" THEN
		RETURN
	END IF
	LET l_titl = l_w.getAttribute("text")
	IF l_titl IS NULL THEN
		LET l_f = ui.Window.getCurrent().getForm().getNode()
		LET l_titl = l_f.getAttribute("name")
	END IF
	LET l_titl = l_titl.append(" "||getVersion())
	CALL l_w.setAttribute("text",l_titl)
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION getVersion()
	DEFINE l_tmp, l_fglver, l_cliver STRING
	IF m_GeneroVersions IS NOT NULL THEN RETURN m_GeneroVersions END IF
	LET l_tmp = fgl_getVersion()
	LET l_fglver = "FGL: ",l_tmp.getCharAt(1),".",l_tmp.subString(2,3),".",l_tmp.subString(4,5)
	LET l_cliver = ui.interface.getFrontEndName()
	IF l_cliver = "GDC" THEN
		LET l_cliver = l_cliver.append(": "||ui.Interface.getFrontEndVersion().subString(1,7))
		IF ui.Interface.getUniversalClientName() THEN
			LET l_cliver = l_cliver.append("+"||ui.Interface.getUniversalClientName()||" "||ui.Interface.getUniversalClientVersion())
		END IF
	ELSE
		LET l_cliver = l_cliver.append(": "||ui.Interface.getFrontEndVersion())
	END IF
	LET m_GeneroVersions = l_fglver||" "||l_cliver
	RETURN m_GeneroVersions
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION fillForm()
	DEFINE l_f, l_ff om.DomNode
	DEFINE l_nl om.NodeList
	DEFINE x SMALLINT
	LET l_f = ui.Window.getCurrent().getForm().getNode()
	LET l_nl = l_f.selectByTagName("FormField")
	FOR x = 1 TO l_nl.getLength()
		LET l_ff = l_nl.item(x)
		CALL l_ff.setAttribute("value", l_ff.getAttribute("colName"))
	END FOR
END FUNCTION