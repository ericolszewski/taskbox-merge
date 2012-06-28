#!/bin/sh
if [[ ! -d include ]] ; then
    ./update.sh > autogen.out 2>&1
fi
