#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
set -eu
set -x

autoreconf -fi
exec ./configure "$@"
