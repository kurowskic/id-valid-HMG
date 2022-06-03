*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE About()
*-----------------------------------------------------------------------------*

  DECLARE WINDOW win_Main
  DECLARE WINDOW win_About


  IF !IsWIndowDefined( win_About )


#IFDEF _HMG_2_

    LOAD WINDOW about2 AS win_About

    win_About.TitleBar := .F.
    win_About.SysMenu  := .T.
    win_About.Sizable  := .F.

#ENDIF


#IFDEF _HMG_3_

    LOAD WINDOW about3 AS win_About

#ENDIF


    SetProperty( "win_About" , "frm_Main" , "Caption" , ""         )
    SetProperty( "win_About" , "lbl_0"    , "Value"   , WERSJA_PR  )
    SetProperty( "win_About" , "lbl_0_"   , "Value"   , WERSJA_DB  )

    SetProperty( "win_About" , "lbl_1"    , "Value"   , "Christian T. Kurowski"        )
    SetProperty( "win_About" , "lbl_2"    , "Value"   , MiniGUIVersion()               )


    IF "MiniGUI" $ MiniGUIVersion()

      SetProperty( "win_About" , "lbl_3"    , "Value"   , "http://hmgextended.com" )

    ELSE

      SetProperty( "win_About" , "lbl_3"    , "Value"   , "http://www.hmgforum.com/" )

    ENDIF


    SetProperty( "win_About" , "lbl_4"    , "Value"   , HB_Version()                   )
    SetProperty( "win_About" , "lbl_5"    , "Value"   , "http://harbour.github.io"     )
    SetProperty( "win_About" , "lbl_6"    , "Value"   , HB_COMPILER()                  )


    IF "Borland" $ HB_COMPILER()

      SetProperty( "win_About" , "lbl_7"    , "Value"   , "https://www.embarcadero.com/free-tools/ccompiler/free-download" )

    ELSE

      SetProperty( "win_About" , "lbl_7"    , "Value"   , "https://sourceforge.net/projects/mingw-w64/"        )

    ENDIF


    SetProperty( "win_About" , "btn_OK"   , "Caption" , 'OK' )


    ON KEY ALT+F4 OF win_About ACTION { || NIL }


    AADD( aFrm, { "win_About" , win_About.Row , win_About.Col } )

    win_About.img_APPTitle.Picture  := "APP_MAIN"

    win_About.Activate

  ENDIF


RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
#include "About_Events.prg"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
