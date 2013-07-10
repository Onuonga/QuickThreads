/*
 * QuickThreads -- Threads-building toolkit.
 * Copyright (c) 2013 by Frankie Onuonga
 *
 * Permission to use, copy, modify and distribute this software and
 * its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice and this notice
 * appear in all copies.  This software is provided as a
 * proof-of-concept and for demonstration purposes; there is no
 * representation about the suitability of this software for any
 * purpose.
 */


#include <stdarg.h>
#include "qt.h"


/* We actually don't know how the compiler accomodates arguments in the 
 * va_list. In some implementation (e.g. Linux PPC) we cannot scan the
 * list as an array. To avoid this problem, this version of "qt_varg",
 * retrieves arguments by means of the standard "va_arg" macro defined
 * in stdargs.h.
 *
 * Notice that we still suppose that the number of arguments is given
 * by nbytes/sizeof(qt_word_t) and we load the stack of "qt_vstart"
 * assuming that all parameters are alligned to the size of qt_word_t.
 *
 * Marco Bucci <marco.bucci@inwind.it>
 * December 2002
 */

/*

qt_t *qt_vargs (qt_t *sp, int nbytes, void *vargs,
	  void *pt, qt_startup_t *startup,
	  qt_vuserf_t *vuserf, qt_cleanup_t *cleanup)
	  
*/

  qt_t *
qt_vargs_stdarg (qt_t *sp, int nbytes, va_list vargs,
		 void *pt, qt_startup_t *startup,
		 qt_vuserf_t *vuserf, qt_cleanup_t *cleanup)
{
  int i;
  qt_word_t arg;

  sp = QT_VARGS_MD0 (sp, nbytes);

  for (i=0; i<nbytes/sizeof(qt_word_t); i++) {
    arg = va_arg(vargs, qt_word_t);
    QT_SPUT (QT_VARGS_ADJUST(sp), i, arg);
  }

  QT_VARGS_MD1 (QT_VADJ(sp));
  QT_SPUT (QT_VADJ(sp), QT_VARGT_INDEX, pt);
  QT_SPUT (QT_VADJ(sp), QT_VSTARTUP_INDEX, startup);
  QT_SPUT (QT_VADJ(sp), QT_VUSERF_INDEX, vuserf);
  QT_SPUT (QT_VADJ(sp), QT_VCLEANUP_INDEX, cleanup);
  return ((qt_t *)QT_VADJ(sp));
}
