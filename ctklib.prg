*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE Do_Events()
*-----------------------------------------------------------------------------*

  DO EVENTS

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE CTK_DrawBorder( xcForm )
*-----------------------------------------------------------------------------*


  LOCAL nControlRow := 0 ,; // GetProperty( xcForm, "Row" ),;
        nControlCol := 0 ,; // GetProperty( xcForm, "Col" ),;
        nControlWid := GetProperty( xcForm, "Width" ),;
        nControlHig := GetProperty( xcForm, "Height" )

  LOCAL nBordrRow,;
        nBordrCol,;
        nBordrWid,;
        nBordrHig

  LOCAL nPenWidth
  LOCAL color


  nPenWidth := 2
  color     := BLUE


  nBordrRow := nControlRow  + INT( nPenWidth/2 )
  nBordrCol := nControlCol  + INT( nPenWidth/2 )
  nBordrWid := nControlWid  - nPenWidth
  nBordrHig := nControlHig  - nPenWidth


  // TOP
        DRAW LINE IN WINDOW &xcForm                      ;
            AT nBordrRow           , nBordrCol           ;
            TO nBordrRow           , nBordrCol+nBordrWid ;
            PENCOLOR Color                               ;
            PENWIDTH nPenWidth

        // LEFT
        DRAW LINE IN WINDOW &xcForm                      ;
            AT nBordrRow           , nBordrCol           ;
            TO nBordrRow+nBordrHig , nBordrCol           ;
            PENCOLOR Color                               ;
            PENWIDTH nPenWidth

        // BOTTOM
        DRAW LINE IN WINDOW &xcForm                      ;
            AT nBordrRow+nBordrHig , nBordrCol           ;
            TO nBordrRow+nBordrHig , nBordrCol+nBordrWid ;
            PENCOLOR Color                               ;
            PENWIDTH nPenWidth

       // RIGHT
        DRAW LINE IN WINDOW &xcForm                      ;
            AT nBordrRow           , nBordrCol+nBordrWid ;
            TO nBordrRow+nBordrHig , nBordrCol+nBordrWid ;
            PENCOLOR Color                               ;
            PENWIDTH nPenWidth


  Do_Events()

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION CTK_Minimize( xaFrm )
*-----------------------------------------------------------------------------*

  LOCAL nI
  LOCAL nFrm

  nFrm := LEN( xaFrm )


  IF nFrm > 0

    FOR nI := 1 TO nFrm - 1

      SetProperty( xaFrm[ nI , 1 ] , "Col" , -5000  )

    NEXT I

  ENDIF


  DoMethod ( xaFrm[ nFrm , 1 ] , 'Minimize' )


RETURN xaFrm
*-----------------------------------------------------------------------------*



*-----------------------------------------------------------------------------*
FUNCTION CTK_Release( xaFrm )
*-----------------------------------------------------------------------------*

  LOCAL aLocal
  LOCAL nI
  LOCAL nFrm

  aLocal := {}


  nFrm := LEN( xaFrm )


  IF nFrm > 1

    xaFrm[ nFrm , 1 ] := NIL


    FOR nI := 1 TO nFrm


      IF xaFrm[ nI , 1 ] <> NIL

        AADD( aLocal , { xaFrm[ nI , 1 ] , xaFrm[ nI , 2 ] , xaFrm[ nI , 3 ] } )

      ENDIF


    NEXT I


  ENDIF


RETURN aLocal
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION CTK_Restore( xaFrm )
*-----------------------------------------------------------------------------*

  LOCAL nI
  LOCAL nFrm

  nFrm := LEN( xaFrm )


  IF nFrm > 1

    FOR nI := 1 TO nFrm - 1

      SetProperty( xaFrm[ nI , 1 ] , 'Row' , xaFrm[ nI , 2 ] )
      SetProperty( xaFrm[ nI , 1 ] , 'Col' , xaFrm[ nI , 3 ] )

    NEXT nI


    SetProperty( xaFrm[ nI , 1 ] , 'Row' , xaFrm[ nI , 2 ] )
    SetProperty( xaFrm[ nI , 1 ] , 'Col' , xaFrm[ nI , 3 ] )

    DoMethod ( xaFrm[ nFrm , 1 ] , 'SetFocus' )

  ENDIF


  do_events()

  aFrm[ 1 , 2 ] := APP_ROW
  aFrm[ 1 , 3 ] := APP_COL

  do_events()


RETURN xaFrm
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
