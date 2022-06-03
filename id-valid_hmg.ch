*-----------------------------------------------------------------------------*
#include "id-valid_ver.ch"
*-----------------------------------------------------------------------------*

#DEFINE  _PRG1_      '0'
#DEFINE  _PRG2_      '01'
#DEFINE  _PRG3_      '000'

#DEFINE  _PRG4_      '001'


#DEFINE  _DB1_       '0'
#DEFINE  _DB2_       '00'
#DEFINE  _DB3_       '000'


#DEFINE  _OLD_PRG1_  '0'
#DEFINE  _OLD_PRG2_  '00'
#DEFINE  _OLD_PRG3_  '000'

#DEFINE  _OLD_PRG4_  '000'

#DEFINE  _OLD_DB1_   '0'
#DEFINE  _OLD_DB2_   '00'
#DEFINE  _OLD_DB3_   '000'


#DEFINE NAZWA_PR     "id-valid"

#DEFINE WERSJA_PR    _PRG1_+"."+_PRG2_+"."+_PRG3_ // +"."+_PRG4_
#DEFINE WERSJA_DB    _DB1_+"."+_DB2_+"."+_DB3_


#DEFINE MsgNoYes(c)  MsgYesNo( c , NAZWA_PR , .t. , 0 ,  .F. , .F. )


#INCLUDE "Dbstruct.ch"
#INCLUDE "common.ch"
#INCLUDE "fileio.ch"
#INCLUDE "Directry.ch"


#IFDEF __SQLITE__

  #IFDEF  _HMG_2_
    #INCLUDE "hbsqlit3.ch"
  #ENDIF

#ENDIF


#IFDEF _HMG_2_

  #INCLUDE  "minigui.ch"

  #INCLUDE  "miniprint.ch"
  #INCLUDE  "i_winuser.ch"

  #include "i_UsrInit.ch"
  #include "i_UsrSOOP.ch"

  #include "hbinkey.ch"

#ENDIF


#IFDEF _HMG_3_

  #INCLUDE  "hmg.ch"

#ENDIF


#IFDEF _HMG_2_

  #DEFINE  FALSE .F.
  #DEFINE  TRUE  .T.

#ENDIF


#define CRLF CHR( 13 ) + CHR( 10 )
#define CR CHR( 13 )
#define LF CHR( 10 )


#DEFINE VIEW_RECORDS 5

#ifndef __XHARBOUR__

   #xcommand TRY                => bError := errorBlock( {|oError| break( oError ) } ) ;;
                                   BEGIN SEQUENCE
   #xcommand CATCH [<!oError!>] => errorBlock( bError ) ;;
                                   RECOVER [USING <oError>] <-oError-> ;;
                                   errorBlock( bError )
#endif


MEMVAR APP_ROW
MEMVAR APP_COL
MEMVAR APP_HEIGHT
MEMVAR APP_WIDTH
MEMVAR aFrm

*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
