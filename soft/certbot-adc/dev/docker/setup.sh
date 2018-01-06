#!/bin/sh

line="* * * * * /path/to/command"
(crontab  -l; echo "0       2       *       *       *       certbot renew -n" ) | crontab -



