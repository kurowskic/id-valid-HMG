*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
PROCEDURE CenterModalWindow( xcForm )
*-----------------------------------------------------------------------------*

  SetProperty( xcForm , "Height" , GetProperty( xcForm , "Height" ) * ( APP_ADJUST_Y ) )
  SetProperty( xcForm , "Width"  , GetProperty( xcForm , "Width"  ) * ( APP_ADJUST_X ) )
 
  do_events()


  IF  .NOT. EMPTY ( aFrm[ 1 , 2 ] )
  
    SetProperty( xcForm , "Row" , ( APP_ROW + ( APP_HEIGHT - GetProperty( xcForm , "Height" ) ) / 2 ) )
    
  ELSE
  
    SetProperty( xcForm , "Row" , ( ( APP_HEIGHT - GetProperty( xcForm , "Height" ) ) / 2 ) )
      
  ENDIF


  IF  .NOT. EMPTY( aFrm[ 1 , 3 ] )
 
    SetProperty( xcForm , "Col" , ( APP_COL + ( APP_WIDTH - GetProperty( xcForm , "Width" ) ) / 2 ) )
    
  ELSE
  
    SetProperty( xcForm , "Col" , ( ( APP_WIDTH - GetProperty( xcForm , "Width" ) ) / 2 ) )

  ENDIF

RETURN
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
