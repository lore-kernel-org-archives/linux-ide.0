From: Kel Modderman <kel@otaku42.de>
Subject: [PATCH 3/5] storage-fixup: make a quiet/silent mode work
Date: Wed, 29 Oct 2008 09:10:25 +1000
Message-ID: <200810290910.25324.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:43267 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbYJ1Xlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 19:41:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by venema.h4ckr.net (Postfix) with ESMTP id 046C63067C9
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:43 +0100 (CET)
Received: from venema.h4ckr.net ([127.0.0.1])
	by localhost (venema.h4ckr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyQshXqFAh3l for <linux-ide@vger.kernel.org>;
	Wed, 29 Oct 2008 00:12:40 +0100 (CET)
Received: from [192.168.1.99] (anikodeak.plus.com [80.229.152.168])
	by venema.h4ckr.net (Postfix) with ESMTP id 01D7F3067CA
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:38 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Add a quiet mode. Remove the seemingly unused sact variable.

Signed-off-by: Kel Modderman <kel@otaku42.de>
---
--- a/storage-fixup
+++ b/storage-fixup
@@ -27,10 +27,6 @@
 #	Executes ACTION on matched devices.  ACTION can contain $DEV
 #	which will be substituted with device file of matching device.
 #
-# sact ACTION
-#	Silent version of "act".  Useful when the action to take is
-#	printing out a warning message.
-#
 # PATTERN is bash extglob pattern.
 #
 # For example, the following (useless) rule disables APM on the first
@@ -47,10 +43,11 @@
 #
 
 declare usage="
-Usage: storage-fixup [-h] [-V] [-v] [-b] [-c config_file] [-m max_devs]
+Usage: storage-fixup [-h] [-V] [-q] [-v] [-b] [-c config_file] [-m max_devs]
 
        -h      Print this help message and exit
        -V      Print version and exit
+       -q      Quiet
        -v      Verbose
        -d      Dry run, don't actually execute action
        -c      Use config_file instead of /etc/storage-fixup.conf
@@ -81,7 +78,7 @@ warn() {
 }
 
 debug() {
-    if [ $verbose -ne 0 ]; then
+    if [ $verbose -gt 0 ]; then
 	warn "$@"
     fi
 }
@@ -242,8 +239,10 @@ do_act() {
     for idx in ${matches[@]}; do
 	DEV=${storage_devs[idx]}
 	if [ $dry_run -eq 0 ]; then
-	    if [ $verbose -ne 0 ]; then
+	    if [ $verbose -gt 0 ]; then
 		eval log "$rule_name: executing \"$act\""
+	    elif [ $verbose -lt 0 ]; then
+	    	act=${act//$hdparm/$hdparm -q}
 	    fi
 	    eval "$act"
 	else
@@ -259,10 +258,12 @@ do_act() {
 #
 shopt -s extglob
 
-while getopts "dvVc:m:h" option; do
+while getopts "dqvVc:m:h" option; do
     case $option in
 	d)
 	    dry_run=1;;
+	q)
+	    verbose=-1;;
 	v)
 	    verbose=1;;
 	V)
@@ -345,10 +346,7 @@ while read f0 f1 f2; do
 	    do_storage scsi "$f1" "$f2"
 	    ;;
     act)
-	    do_act "$f1 $f2" 1
-	    ;;
-    sact)
-	    do_act "$f1 $f2" 0
+	    do_act "$f1 $f2" "$verbose"
 	    ;;
     *)
 	    false
---
