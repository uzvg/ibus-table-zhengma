#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
set -e
set -x

aclocal -I m4
automake --add-missing --copy
autoconf
./configure --enable-maintainer-mode $*
