
DEFINE m_tbi BOOLEAN = FALSE
DEFINE m_tmg BOOLEAN = FALSE
DEFINE m_tmc BOOLEAN = FALSE
DEFINE m_msg STRING
DEFINE m_comma CHAR(1)
MAIN
	DEFINE c base.Channel
	LET c = base.Channel.create()

	DISPLAY "<StyleList>"
	CALL c.openFile("st","r")
	WHILE NOT c.isEof()
		CALL procLineST( c.readLine() )
	END WHILE
	CALL c.close()
	DISPLAY "	</Style>"
	DISPLAY "</StyleList>"

	CALL c.openFile("tm","r")
	WHILE NOT c.isEof()
		CALL procLine( c.readLine() )
	END WHILE
	CALL c.close()

	CALL c.openFile("tb","r")
	WHILE NOT c.isEof()
		CALL procLine( c.readLine() )
	END WHILE
	CALL c.close()

END MAIN
--------------------------------------------------------------------------------
FUNCTION procLineST( l_str STRING )
	DEFINE x SMALLINT
	DEFINE l_val STRING
	IF l_str.getLength() < 4 THEN RETURN END IF
	DISPLAY SFMT("debug: STR: %1 MSG: %2",l_str,m_msg)

	LET x = l_str.getIndexOf("Style ",1)
	IF x > 1 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg
			LET m_msg = NULL
			DISPLAY "	</Style>"
		END IF
		LET m_msg = "	<Style name=\""
	END IF

	LET x = l_str.getIndexOf("StyleAttribute",1)
	IF x > 1 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg
			LET m_msg = NULL
		END IF
		LET m_msg = "		<StyleAttribute name=\""
	END IF

	LET l_val = getValue( "name", l_str )
	IF l_val IS NOT NULL THEN
		IF m_msg = "	<Style name=\"" THEN
			LET m_msg = m_msg.append(l_val||"\">")
		ELSE
			LET m_msg = m_msg.append(l_val||"\"")
		END IF
	END IF
	LET l_val = getValue( "value", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(l_val||"/>")
	END IF

END FUNCTION
--------------------------------------------------------------------------------
FUNCTION procLine( l_str STRING )
	DEFINE x SMALLINT
	DEFINE l_val STRING
	IF l_str.getLength() < 4 THEN RETURN END IF
	DISPLAY SFMT("debug: STR: %1 MSG: %2",l_str,m_msg)

	LET x =  l_str.getIndexOf("TopMenu ",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
		END IF
		LET m_tbi = FALSE
		DISPLAY "TOPMENU"
		RETURN
	END IF
	LET x =  l_str.getIndexOf("TopMenuGroup",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
			DISPLAY "	END -- GROUP"
		END IF
		LET m_msg = "	GROUP "
		LET m_comma = " "
	END IF

	LET x =  l_str.getIndexOf("TopMenuCommand",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
			LET m_comma = " "
		END IF
		LET m_msg = "		COMMAND "
	END IF

	LET x =  l_str.getIndexOf("TopMenuSeparator",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
			DISPLAY "	END -- GROUP"
		END IF
		DISPLAY "		SEPARATOR"
		RETURN
	END IF

	LET x =  l_str.getIndexOf("ToolBarItem",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
			LET m_comma = " "
		END IF
		LET m_msg = "	ITEM "
		LET m_tbi = TRUE
	END IF
	LET x =  l_str.getIndexOf("ToolBarSeparator",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
		END IF
		LET m_tbi = FALSE
		DISPLAY "	SEPARATOR"
		RETURN
	END IF
	LET x =  l_str.getIndexOf("ToolBar ",1)
	IF x > 0 THEN
		IF m_msg.getLength() > 1 THEN
			DISPLAY m_msg,")"
			LET m_msg = NULL
		END IF
		LET m_tbi = FALSE
		DISPLAY "TOOLBAR"
		RETURN
	END IF
	IF m_msg.getLength() = 0 THEN RETURN END IF
	LET l_val = getValue( "name", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(l_val||" (")
		LET m_comma = " "
	ELSE
		IF m_msg = "	GROUP " THEN
			LET m_msg = m_msg.append("(")
		END IF
	END IF
	LET l_val = getValue( "text", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(m_comma||" "||l_val||" ")
		LET m_comma = ","
	END IF
	LET l_val = getValue( "image", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(m_comma||" "||l_val||" ")
		LET m_comma = ","
	END IF
	LET l_val = getValue( "comment", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(m_comma||" "||l_val||" ")
		LET m_comma = ","
	END IF
	LET l_val = getValue( "acceleratorName", l_str )
	IF l_val IS NOT NULL THEN
		LET m_msg = m_msg.append(m_comma||" "||l_val||" ")
		LET m_comma = ","
	END IF
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION getValue( l_att STRING, l_str STRING ) RETURNS STRING
	DEFINE x, y SMALLINT
	DEFINE l_val STRING
	DISPLAY "debug: ATT:", l_att, " STR: ",l_str
	LET x =  l_str.getIndexOf(l_att,1)
	IF x = 0 THEN RETURN NULL END IF
	LET x = l_str.getIndexOf("\"",x)
	IF x > 0 THEN
		LET y = l_str.getIndexOf("\\",x+1)
	END IF
	LET l_val = l_str.subString(x+1,y-1)
	IF l_att = "image" THEN
		LET y = l_val.getIndexOf("?",1)
		IF y > 1 THEN
			FOR x = y TO 1 STEP -1
				IF l_val.getCharAt(x) = "/" THEN
				LET l_val = l_val.subString(x+1,y-1)
				END IF
			END FOR
		END IF
	END IF
	IF y > 0 THEN
		IF l_att = "name" THEN
			RETURN l_val
		ELSE
			IF l_att = "acceleratorName" THEN
				RETURN SFMT("ACCELERATOR=%2",l_att.toUpperCase(), l_val)
			ELSE
				IF l_att = "value" THEN
					RETURN SFMT(" %1=\"%2\"",l_att, l_val)
				ELSE
					RETURN SFMT("%1=\"%2\"",l_att.toUpperCase(), l_val)
				END IF
			END IF
		END IF
	END IF
	RETURN NULL
END FUNCTION
