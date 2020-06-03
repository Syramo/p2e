dnl $Id$
dnl config.m4 for extension p2e -> php to erlang bridge


PHP_ARG_ENABLE(p2e, [whether to enable php to erlang bridge support],
	[AS_HELP_STRING([--enable-p2e],[Enable php-erlang bridge support])])

if test "${PHP_P2E}" != "no"; then

	PHP_ARG_WITH(erlang, [for specifying Erlang interface directory],
    	[AS_HELP_STRING([--with-erlang=DIR],[Path to Erlang interface directory containing lib and include])], no, no)

	if test "${PHP_ERLANG}" != "no"; then
		if test "${PHP_ERLANG}" == "yes"; then
      		AC_MSG_ERROR([You must specify a path to the erlang interface])
    	fi
    	
		PHP_ADD_INCLUDE("${PHP_ERLANG}/include")
    	PHP_ADD_LIBRARY_WITH_PATH(ei,"${PHP_ERLANG}/lib")
    	
    	AC_MSG_CHECKING([for erlang interface])
    
	    if test -f "${PHP_ERLANG}/include/ei.h" && test -f "${PHP_ERLANG}/lib/libei.a"; then
    		AC_MSG_RESULT([${PHP_ERLANG}])
    	else
    		AC_MSG_RESULT([not found])
    		AC_MSG_ERROR([Please check your erlang installation.])
    	fi
    else
    	AC_MSG_ERROR([You must specify a path to the erlang interface])
    fi
    
    CPPFLAGS="${CPPFLAGS} ${INCLUDES}"
    
    AC_CHECK_LIB([pthread], [pthread_mutex_trylock], [], [AC_MSG_ERROR([Could not find libpthread])])
  
  	AC_CHECK_LIB([ei], [ei_connect_init], [], [AC_MSG_ERROR([Could not find libei])])
	
  	AC_CHECK_HEADER([ei.h], [], [AC_MSG_ERROR([Could not find header file ei.h])])
    
    
    PHP_NEW_EXTENSION(p2e, p2e.c, $ext_shared)
	
	PHP_SUBST(P2E_SHARED_LIBADD)

fi