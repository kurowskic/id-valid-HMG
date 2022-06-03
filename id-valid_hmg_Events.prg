*-----------------------------------------------------------------------------*
PROCEDURE win_main_OnInit()
*-----------------------------------------------------------------------------*

  win_Main.Hide

  AutoAdjustControls( "win_Main" )

  CenterMainWindow()

  CTK_DrawBorder( "win_Main" )

  win_Main.Show

  DO_Events()

  win_Main_buttons_Disable()
  DO_Events()

  win_Main_buttons_Enable()
  DO_Events()

  win_Main.txb_Id.SetFocus
  win_Main.txb_Id.Value := ''
  win_Main.txb_Id.CaretPos := 0


#IFDEF _HMG_2_

 win_Main.txb_Id.Refresh

#ENDIF


  DO_Events()

RETURN
*-----------------------------------------------------------------------------*


#IFDEF _HMG_3_
*-----------------------------------------------------------------------------*
PROCEDURE win_main_OnPaint()
*-----------------------------------------------------------------------------*

  Show_TitleBar()
  DO_Events()

RETURN
*-----------------------------------------------------------------------------*
#ENDIF


*-----------------------------------------------------------------------------*
PROCEDURE win_main_txb_Id_OnChange()
*-----------------------------------------------------------------------------*

  LOCAL isValid       := FALSE
  LOCAL isLEAP        := FALSE
  LOCAL isDateCorrect := FALSE
  LOCAL cPESEL
  LOCAL nPos
  LOCAL nCaretPos
  LOCAL cLastKey


  cPESEL    := ALLTRIM( win_Main.txb_Id.Value )
  nPos      := win_Main.txb_Id.CaretPos
  nCaretPos := win_Main.txb_Id.CaretPos
  nLastKey  := ASC( SUBSTR( cPESEL , nPos , 1 ) )


#IFDEF _HMG_2_

  win_Main.lbl_TrueFalse.Value := ' '
  win_Main.lbl_TrueFalse.Refresh

#ENDIF


  DO_Events()


  IF ( nLastKey >= ASC( '0' ) .AND. nLastKey <= ASC( '9' ) ) .AND. LEN( cPESEL ) < 12;
    .AND. isMonthCorrect();
    .AND. isDayOfMonthCorrect( cPESEL )


    IF LEN( cPESEL ) == 11

      win_Main.lbl_TrueFalse.FontColor := BLACK
      win_Main.lbl_TrueFalse.Value := ' '
      win_Main.lbl_TrueFalse.Refresh

      DO_Events()

      isValid := PESEL_Check( ALLTRIM ( cPESEL ) )


      DO CASE

        CASE isValid == TRUE

          win_Main.lbl_TrueFalse.FontColor := GREEN
          win_Main.lbl_TrueFalse.Value := 'PESEL poprawny'

        CASE isValid == FALSE

          win_Main.lbl_TrueFalse.FontColor := RED
          win_Main.lbl_TrueFalse.Value := 'PESEL b³êdny'

      END CASE

    ELSE

	   win_Main.lbl_TrueFalse.Value := ''

    ENDIF


  ELSE

    win_Main.txb_Id.Value := SUBSTR( win_Main.txb_Id.Value , 1 , win_Main.txb_Id.CaretPos - 1 );
      + SUBSTR( win_Main.txb_Id.Value , win_Main.txb_Id.CaretPos + 1 , LEN( ALLTRIM( win_Main.txb_Id.Value ) ) - 1 )
    DO_Events()

    win_Main.txb_Id.CaretPos := nCaretPos - 1

    DO_Events()

  ENDIF


#IFDEF _HMG_2_

  win_Main.lbl_TrueFalse.Refresh
  win_Main.txb_Id.Refresh

#ENDIF


  DO_Events()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION isDayOfMonthCorrect( xcPESEL )
*-----------------------------------------------------------------------------*

  LOCAL isDayOfMonthCorrect := FALSE
  LOCAL cPESEL := xcPESEL
  LOCAL isLeap := FALSE
  LOCAL is28Feb := FALSE
  LOCAL is29Feb := FALSE
  LOCAL is30month := FALSE
  LOCAL is31month := FALSE


  DO CASE

    CASE VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 82

      isLeap := ISLEAP( STOD( '18' + SUBSTR( cPESEL , 1 , 2 ) + '0201' ) )


    CASE VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 02

      isLeap := ISLEAP( STOD( '19' + SUBSTR( cPESEL , 1 , 2 ) + '0201' ) )


    CASE VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 22

      isLeap := ISLEAP( STOD( '20' + SUBSTR( cPESEL , 1 , 2 ) + '0201' ) )


    CASE VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 42

      isLeap := ISLEAP( STOD( '21' + SUBSTR( cPESEL , 1 , 2 ) + '0201' ) )

    CASE VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 62

      isLeap := ISLEAP( STOD( '22' + SUBSTR( cPESEL , 1 , 2 ) + '0201' ) )

  END CASE


  IF LEN( cPESEL ) > 4


    DO CASE

      CASE isLeap == .F. .AND. (;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 82;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 02;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 22;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 42;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 62;
        )

          isDayOfMonthCorrect := TRUE
		  is28Feb := TRUE


      CASE isLeap == .T. .AND. (;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 82;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 02;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 22;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 42;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 62;
        )

          isDayOfMonthCorrect := TRUE
		  is29Feb := TRUE


      CASE (;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 81;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 83;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 85;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 87;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 88;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 90;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 92;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 01;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 03;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 05;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 07;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 08;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 10;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 12;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 21;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 23;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 25;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 27;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 28;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 30;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 32;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 41;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 43;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 45;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 47;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 48;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 50;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 52;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 61;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 63;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 65;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 67;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 68;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 70;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 72;
        )

          isDayOfMonthCorrect := TRUE
		  is31month := TRUE


      CASE (;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 84;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 86;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 89;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 91;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 04;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 06;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 09;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 11;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 24;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 26;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 29;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 31;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 44;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 46;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 49;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 51;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 64;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 66;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 69;
        .OR. ;
        VAL( SUBSTR( cPESEL , 3 , 2 ) ) == 71;
        )

          isDayOfMonthCorrect := TRUE
          is30month := TRUE

    END CASE


  ELSE

    isDayOfMonthCorrect := TRUE

  ENDIF


  IF LEN( cPESEL ) == 5

    isDayOfMonthCorrect := FALSE


    DO CASE

      CASE is28Feb == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 1 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 1 ) ) <= 2 )

          isDayOfMonthCorrect := TRUE


      CASE is29Feb == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 1 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 1 ) ) <= 2 )

          isDayOfMonthCorrect := TRUE


      CASE is30month == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 1 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 1 ) ) <= 3 )

          isDayOfMonthCorrect := TRUE


      CASE is31month == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 1 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 1 ) ) <= 3 )

          isDayOfMonthCorrect := TRUE


    END CASE

  ENDIF


  IF LEN( cPESEL ) == 6

    isDayOfMonthCorrect := FALSE


    DO CASE

      CASE is28Feb == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 2 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 2 ) ) <= 28 )

          isDayOfMonthCorrect := TRUE


      CASE is29Feb == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 2 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 2 ) ) <= 29 )

          isDayOfMonthCorrect := TRUE


      CASE is30month == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 2 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 2 ) ) <= 30 )

          isDayOfMonthCorrect := TRUE


      CASE is31month == TRUE;
        .AND. ;
        ( VAL( SUBSTR( cPESEL , 5 , 2 ) ) >= 1;
          .AND.;
          VAL( SUBSTR( cPESEL , 5 , 2 ) ) <= 31 )

          isDayOfMonthCorrect := TRUE


    END CASE


  ENDIF


RETURN isDayOfMonthCorrect
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION isMonthCorrect()
*-----------------------------------------------------------------------------*
  LOCAL IsMonthCorrect := TRUE


  IF LEN( ALLTRIM( win_Main.txb_Id.Value ) ) > 3


    IF;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 13;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 14;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 15;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 16;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 17;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 18;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 19;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 20;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 33;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 34;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 35;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 36;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 37;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 38;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 39;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 40;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 53;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 54;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 55;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 56;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 57;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 58;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 59;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 60;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 73;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 74;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 75;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 76;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 77;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 78;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 79;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 80;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 93;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 94;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 95;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 96;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 97;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 98;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 99;
      .OR.;
      VAL( SUBSTR( ALLTRIM( win_Main.txb_Id.Value ) , 3 , 2 ) ) == 00

      IsMonthCorrect := FALSE

    ENDIF

  ENDIF


RETURN IsMonthCorrect
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_btn_Clear_Action()
*-----------------------------------------------------------------------------*

  win_Main.lbl_TrueFalse.Value := ''

  win_Main.txb_Id.SetFocus
  win_Main.txb_Id.Value := ''
  win_Main.txb_Id.CaretPos := 0


#IFDEF _HMG_2_

  win_Main.txb_Id.Refresh

#ENDIF


  DO_Events()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_btn_About_Action()
*-----------------------------------------------------------------------------*

  About()

  do_events()

  win_Main.lbl_BackGround.Setfocus()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_btn_ExitPR()
*-----------------------------------------------------------------------------*

  EndOfProgram()

  do_events()

  win_Main.lbl_BackGround.Setfocus()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_btn_MinPR()
*-----------------------------------------------------------------------------*

  aFrm := CTK_Minimize( aFrm )

  do_events()

  win_Main.lbl_BackGround.Setfocus()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_buttons_Disable()
*-----------------------------------------------------------------------------*

  win_Main.btn_about.Enabled       := FALSE
  win_Main.btn_minPR.Enabled       := FALSE
  win_Main.btn_ExitPR.Enabled      := FALSE

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE win_Main_buttons_Enable()
*-----------------------------------------------------------------------------*

  win_Main.btn_about.Enabled       := TRUE
  win_Main.btn_minPR.Enabled       := TRUE
  win_Main.btn_ExitPR.Enabled      := TRUE

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
