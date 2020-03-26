# GBC Customization

This setup uses a makefile and assumes you are on Linux and have a directory or symbolic link called gbc-current in this folder that contains the GBC project directory ( as extracted from the gbc project zip file ).
```
$ ls -la
total 12
drwxrwxr-x  4 neilm neilm  113 Mar 23 10:02 .
drwxrwxr-x 10 neilm neilm  249 Mar 23 09:51 ..
drwxrwxr-x  2 neilm neilm   51 Mar 23 10:00 distbin
lrwxrwxrwx  1 neilm neilm   23 Mar 17 17:09 gbc-current -> /opt/fourjs/gbc-current
drwxrwxr-x  6 neilm neilm  216 Mar 19 11:16 gbc-white
-rw-rw-r--  1 neilm neilm  458 Mar 17 17:09 Makefile
-rw-rw-r--  1 neilm neilm  330 Mar 17 17:05 makefile.inc
-rw-rw-r--  1 neilm neilm 1127 Mar 23 10:02 README.md
```

Assuming you have also done the prerequisites in the project folder you should be able to just type 'make' to produce a zip of the custom GBC in the distbin folder.

```
$ make
make[1]: Entering directory 'gbc/gbc-white'
Building GBC ...
__clean:localdist     231ms  ▇ 1%
copy:clientlibs       308ms  ▇ 2%
templates2js:compile   3.1s  ▇▇▇▇▇▇▇ 16%
concat:cdevgbc         2.2s  ▇▇▇▇▇ 11%
copy:droidFonts       201ms  ▇ 1%
copy:materialIcons    214ms  ▇ 1%
copy:resources        471ms  ▇ 2%
themes:compile         2.1s  ▇▇▇▇▇ 11%
Total 19.8s

make[1]: Leaving directory 'gbc/gbc-white'

$ l distbin/gbc-white.zip
-rw-rw-r-- 1 neilm neilm 4899118 Mar 23 10:00 distbin/gbc-white.zip
```

