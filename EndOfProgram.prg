*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE EndOfProgram()
*-----------------------------------------------------------------------------*

  DECLARE WINDOW win_Main
  DECLARE WINDOW win_EndOfProgram


  IF !IsWIndowDefined( win_EndOfProgram )


#IFDEF _HMG_2_

    LOAD WINDOW EndOfProgram2 AS win_EndOfProgram

    win_EndOfProgram.TitleBar := .F.
    win_EndOfProgram.SysMenu  := .T.
    win_EndOfProgram.Sizable  := .F.

#ENDIF


#IFDEF _HMG_3_

    LOAD WINDOW EndOfProgram3 AS win_EndOfProgram

#ENDIF


    SetProperty( "win_EndOfProgram" , "btn_YES" , "Action" , { || win_EndOfProgram_btn_YES() } )
    SetProperty( "win_EndOfProgram" , "btn_NOT" , "Action" , { || win_EndOfProgram_btn_NOT() } )


    ON KEY ALT+F4 OF win_EndOfProgram ACTION { || NIL }


    AADD( aFrm , { "win_EndOfProgram"    , ;
                 win_EndOfProgram.Row  , ;
                 win_EndOfProgram.Col  , ;
               } )


    win_EndOfProgram.img_APPTitle.Picture  := "APP_MAIN"

    win_EndOfProgram.Activate

  ENDIF


RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
#include "EndOfProgram_Events.prg"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
