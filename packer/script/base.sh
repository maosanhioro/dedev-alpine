#!/bin/sh -eux

cp /etc/apk/repositories /etc/apk/repositories.orig

apk update
apk upgrade
