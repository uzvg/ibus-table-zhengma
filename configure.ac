# SPDX-License-Identifier: GPL-3.0-or-later
# vim:set ts=4
#
# ibus-table-zhengma - The ZhengMa for IBus Tables.
#
# Copyright (c) 2008-2009 Yu Yuwei <acevery@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

m4_define([package_name], [ibus-table-zhengma])

# Keep the version static so that autoreconf does not embed the current
# date into every build. Bump it when making a release.
m4_define([ibus_version], [1.1.0.20261020])

AC_INIT([package_name], [ibus_version],
        [https://github.com/acevery/ibus-table-zhengma/issues],
        [package_name])
AC_CONFIG_SRCDIR([tables/zhengma.txt])
AM_INIT_AUTOMAKE([1.11 -Wall])

# AC_CONFIG_HEADERS([config.h])

# check for ibus-table-createdb
PKG_CHECK_MODULES([IBUS_TABLE], [ibus-table >= 1.1.0])

AC_ARG_VAR([IBUS_TABLE_CREATEDB],
        [[ibus-table-createdb, used to generate the database]])

AC_PATH_PROG([IBUS_TABLE_CREATEDB], [ibus-table-createdb],
        [AC_MSG_ERROR([ibus-table-createdb not found.])])

# the option for extra phrases
AC_ARG_ENABLE([extra-phrases],
    [AS_HELP_STRING([--enable-extra-phrases],
        [Add extra phrases into built Engine])], ,
    [enable_extra_phrases=no])

AM_CONDITIONAL([IBUS_TABLE_EXTRA_PHRASES],
        [test x"$enable_extra_phrases" = x"yes"])

# check for ibus-table-extraphrase, if we need it.
AS_IF([test x"$enable_extra_phrases" = x"yes"], [
    PKG_CHECK_MODULES([EXTRA_PHRASE], [ibus-table-extraphrase >= 1.1.0])
    IBUS_TABLE_EXTRAPHRASE=`$PKG_CONFIG --variable=extraphrasepath ibus-table-extraphrase`
    AC_SUBST([IBUS_TABLE_EXTRAPHRASE])
])

# OUTPUT files
AC_CONFIG_FILES([
    Makefile
    icons/Makefile
    tables/Makefile
    docs/Makefile
])

AC_OUTPUT

AC_MSG_RESULT([
Build options:
  Version                   $VERSION
  Install prefix            $prefix
  Integrate Extra Phrases   $enable_extra_phrases
])

