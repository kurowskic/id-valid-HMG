*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE Main()
*-----------------------------------------------------------------------------*

  MEMVAR APP_ROW
  MEMVAR APP_COL
  MEMVAR APP_HEIGHT
  MEMVAR APP_WIDTH

  MEMVAR APP_ADJUST_X
  MEMVAR APP_ADJUST_Y

  MEMVAR fARIAL
  MEMVAR fCOURIER
  MEMVAR fTIMES
  MEMVAR fTAHOMA
  MEMVAR fCALIBRI

  MEMVAR aDataBase

  MEMVAR nPage

  PUBLIC APP_ROW
  PUBLIC APP_COL
  PUBLIC APP_HEIGHT
  PUBLIC APP_WIDTH

  PUBLIC APP_ADJUST_X
  PUBLIC APP_ADJUST_Y

  PUBLIC fARIAL
  PUBLIC fCOURIER
  PUBLIC fTIMES
  PUBLIC fTAHOMA
  PUBLIC fCALIBRI

  PUBLIC aDataBase
  PUBLIC nPage


#IFDEF _HMG_3_

  REQUEST HB_CODEPAGE_PLWIN
  HB_SETCODEPAGE("PLWIN")

  REQUEST HB_LANG_PL
  HB_LANGSELECT("PL")

  SET LANGUAGE TO POLISH
  SET CODEPAGE TO POLISH

#ENDIF


  SETCANCEL( FALSE )
  SET DELETED ON

  SETCANCEL(FALSE)
  SET DELETED ON

  SET SCOREBOARD OFF
  SET CENTURY ON
  SET EPOCH TO 2001
  SET DECIMALS TO 2
  SET EXACT ON
  SET FIXED ON
  SET OPTIMIZE ON

  SET DATE TO BRITISH


#IFDEF _HMG_2_

  SET INTERACTIVECLOSE OFF
  SET MULTIPLE  OFF

  SET TOOLTIP OFF

  SET PROGRAMMATICCHANGE OFF

  SET MENUSTYLE EXTENDED

  SET BROWSESYNC ON

#ENDIF


  ERRORLEVEL( 0 )

  aDataBase := {}
  nPage := 1


#IFDEF _HMG_3_

  APP_ROW    :=    0
  APP_COL    :=    0
  APP_HEIGHT := 1536
  APP_WIDTH  :=  824

#ENDIF

  APP_ADJUST_X := 1
  APP_ADJUST_Y := 1


  aFrm := {}


  DO CASE

    CASE "Windows 10" $ OS()

      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Calibri'

    CASE "Windows NT 10" $ OS()

      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Calibri'

    CASE "Windows 8" $ OS()

      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Calibri'

    CASE "Windows 7" $ OS()

      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Calibri'

    CASE "Windows XP" $ OS()
      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Calibri'

    CASE "Windows NT" $ OS()

      fARIAL   := 'Arial CE'
      fCOURIER := 'Courier New CE'
      fTAHOMA  := 'Times New Roman CE'
      fTIMES   := 'Times New Roman CE'
      fCALIBRI := 'Times New Roman CE'

    CASE "Windows 98" $ OS()

      fARIAL   := 'Arial'
      fCOURIER := 'Courier New'
      fTAHOMA  := 'Tahoma'
      fTIMES   := 'Times New Roman'
      fCALIBRI := 'Times New Roman'

  END CASE


  DECLARE WINDOW win_Main


  IF !IsWIndowDefined( win_Main )


#IFDEF _HMG_2_

    LOAD WINDOW id-valid_hmg2 AS win_Main

#ENDIF


#IFDEF _HMG_3_

    LOAD WINDOW id-valid_hmg3 AS win_Main

#ENDIF


#IFDEF _HMG_2_

    Application.Title := NAZWA_PR
    win_Main.TitleBar := .F.
    win_Main.SysMenu  := .T.
    win_Main.Sizable  := .F.

#ENDIF


#IFDEF _HMG_3_

    win_Main.Title := NAZWA_PR

#ENDIF


    DO CASE

      CASE GetDesktopRealHeight() == GetProperty( "win_Main" , "Height" ) ;
           .AND. ;
           GetDesktopRealWidth() == GetProperty( "win_Main" , "Width" )


      CASE GetDesktopRealHeight() < GetProperty( "win_Main" , "Height" ) ;
           .AND. ;
           GetDesktopRealWidth() < GetProperty( "win_Main" , "Width" )

             APP_ADJUST_Y :=  GetDesktopRealHeight() / win_Main.Height
             SetProperty( "win_Main" , "Height" , GetProperty( "win_Main" , "Height" ) * APP_ADJUST_Y )

             APP_ADJUST_X := GetDesktopRealWidth() / win_Main.Width
             SetProperty( "win_Main" , "Width" , GetProperty( "win_Main" , "Width" ) * APP_ADJUST_X )


      CASE GetDesktopRealHeight() > GetProperty( "win_Main" , "Height" ) ;
               .AND. ;
           GetDesktopRealWidth() > GetProperty( "win_Main" , "Width" )


    END CASE


    APP_ROW    := GetProperty( "win_Main" , "Row" )
    APP_COL    := GetProperty( "win_Main" , "Col" )
    APP_HEIGHT := win_Main.Height
    APP_WIDTH  := win_Main.Width

    AADD( aFrm , { "win_Main" , win_Main.Row , win_Main.Col } )

    ON KEY ALT+F4 OF win_Main ACTION { || EndOfProgram() }
    ON KEY F2     OF win_Main ACTION { || CenterMainWindow()    }

    SetProperty( "win_Main" , "btn_ExitPR" , "Action" , { || win_main_btn_ExitPr() } )
    SetProperty( "win_Main" , "btn_MinPR"  , "Action" , { || win_main_btn_MinPr()  } )

    win_Main.btn_About.Picture       := 'APP_INFO_20'
    win_Main.btn_MinPR.Picture       := 'APP_MINI_20'
    win_Main.btn_ExitPR.Picture      := 'APP_EXIT_20'

    win_Main.Center
    win_Main.Activate

  ELSE

    win_Main.Show

  ENDIF

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
#include "id-valid_hmg_Events.prg"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
