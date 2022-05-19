*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE AutoAdjustControls( xcForm )
*-----------------------------------------------------------------------------*

  LOCAL aControls := {}
  LOCAL cControl  := ""
  LOCAL nI


#IFDEF _HMG_2_

  aControls := _GetAllControlsInForm ( xcForm )

#ENDIF


#IFDEF _HMG_3_

  aControls := _GetArrayOfAllControlsForForm ( xcForm )

#ENDIF


  IF LEN( aControls ) > 0


    FOR nI := 1 TO LEN( aControls )

      cControl := ALLTRIM( aControls[ nI ] )

      SetProperty( xcForm , cControl , "Row"    , GetProperty( xcForm , cControl , "Row" )    * APP_ADJUST_Y )
      SetProperty( xcForm , cControl , "Col"    , GetProperty( xcForm , cControl , "Col" )    * APP_ADJUST_X )
      SetProperty( xcForm , cControl , "Width"  , GetProperty( xcForm , cControl , "Width" )  * APP_ADJUST_X )
      SetProperty( xcForm , cControl , "Height" , GetProperty( xcForm , cControl , "Height" ) * APP_ADJUST_Y )


      IF .NOT. "frm_" $ cControl

        SetProperty( xcForm , cControl , "FontSize" , GetProperty( xcForm , cControl , "FontSize" ) * APP_ADJUST_Y )

      ENDIF


    NEXT nI


  ENDIF


  aControls := {}

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
// http://hmgforum.com/viewtopic.php?t=5131
FUNCTION _GetAllControlsInForm( cFormName )
*-----------------------------------------------------------------------------*

  LOCAL nFormHandle
  LOCAL i
  LOCAL nControlCount
  LOCAL aRetVal := {}
  LOCAL x


  nFormHandle := GetFormHandle ( cFormName )

  nControlCount := LEN( _HMG_aControlHandles )


  FOR i := 1 To nControlCount

    IF _HMG_aControlParentHandles[ i ] == nFormHandle

      IF VALTYPE( _HMG_aControlHandles[ i ] ) == 'N'

         IF !EMPTY( _HMG_aControlNames[ i ] )

            IF ASCAN( aRetVal , _HMG_aControlNames[ i ] ) == 0

               AADD( aRetVal , _HMG_aControlNames[ i ] )

            ENDIF

         ENDIF

      ELSEIF VALTYPE( _HMG_aControlHandles [ i ] ) == 'A'

         FOR x := 1 TO LEN( _HMG_aControlHandles[ i ] )

            IF !EMPTY( _HMG_aControlNames[ i ] )

               IF ASCAN( aRetVal , _HMG_aControlNames[ i ] ) == 0

                  AADD( aRetVal , _HMG_aControlNames [ i ] )

               ENDIF

            ENDIF

         NEXT x

      ENDIF

   ENDIF

NEXT i


RETURN aRetVal
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
// http://hmgforum.com/viewtopic.php?t=5131
FUNCTION _GetArrayOfAllControlsForForm ( cFormName )
*-----------------------------------------------------------------------------*

  LOCAL nFormHandle
  LOCAL i
  LOCAL nControlCount
  LOCAL x

  PRIVATE aRetVal1 := {}
  PRIVATE aRetVal2 := {}

  nFormHandle    := GetFormHandle ( cFormName )
  nControlCount  := LEN( _HMG_SYSDATA [ 3 ] )


  FOR i := 1 TO nControlCount

    IF _HMG_SYSDATA [ 4 ] [ i ] == nFormHandle

      IF VALTYPE( _HMG_SYSDATA [ 3 ] [ i ] ) == 'N'

          AddCtrl( i )

      ELSEIF VALTYPE( _HMG_SYSDATA [ 3 ] [ i ] ) == 'A'

         FOR x := 1 TO LEN( _HMG_SYSDATA [ 3 ] [ i ] )

               AddCtrl( i )

         NEXT x

      ELSE

          AddCtrl( i )

      ENDIF

    ENDIF

  NEXT i


RETURN aRetVal1
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION AddCtrl( nIndx )
*-----------------------------------------------------------------------------*


  If !EMPTY( _HMG_SYSDATA [ 2 ] [ nIndx ] )

    If ASCAN( aRetVal2, _HMG_SYSDATA [ 2 ] [ nIndx ] ) == 0

      IF !EMPTY( _HMG_SYSDATA [ 3 ] [ nIndx ] )

        AADD( aRetVal1 , _HMG_SYSDATA [ 2 ] [ nIndx ] )

      ENDIF

    ENDIF

  ELSE

    IF !EMPTY( _HMG_SYSDATA [ 3 ] [ nIndx ] )

       AADD( aRetVal1 , _HMG_SYSDATA [ 2 ] [ nIndx ] )

    ENDIF

  ENDIF

RETURN Nil
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
