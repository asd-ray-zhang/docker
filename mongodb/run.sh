#!/bin/bash
/usr/sbin/sshd -D &
exec usr/bin/mongod
