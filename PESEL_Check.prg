*-----------------------------------------------------------------------------*
#include "id-valid_hmg.ch"
*-----------------------------------------------------------------------------*


*-----------------------------------------------------------------------------*
FUNCTION PESEL_Check( cPesel )
*-----------------------------------------------------------------------------*

  LOCAL cHash
  LOCAL nDigit := 0

  cHash := '13791379131'


  FOR nI := 1 TO 11

    nDigit := nDigit + VAL( SUBSTR( cHash , nI , 1 ) ) * VAL( SUBSTR( cPesel , nI , 1 ) )

  NEXT nI


RETURN ( MOD( nDigit, 10 ) == 0 )
*-----------------------------------------------------------------------------*
