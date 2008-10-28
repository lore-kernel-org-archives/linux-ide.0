From: Kel Modderman <kel@otaku42.de>
Subject: [PATCH 4/5] storage-fixup: manual page
Date: Wed, 29 Oct 2008 09:10:56 +1000
Message-ID: <200810290910.56166.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:43265 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbYJ1Xlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 19:41:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by venema.h4ckr.net (Postfix) with ESMTP id 630613067CA
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:45 +0100 (CET)
Received: from venema.h4ckr.net ([127.0.0.1])
	by localhost (venema.h4ckr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zpj3ojcGfa-9 for <linux-ide@vger.kernel.org>;
	Wed, 29 Oct 2008 00:12:42 +0100 (CET)
Received: from [192.168.1.99] (anikodeak.plus.com [80.229.152.168])
	by venema.h4ckr.net (Postfix) with ESMTP id 71C2E3067CC
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:39 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Add a manual page for storage-fixup script. Description snagged from the wiki.

Signed-off-by: Kel Modderman <kel@otaku42.de>
---
--- /dev/null
+++ b/storage-fixup.8
@@ -0,0 +1,39 @@
+.TH STORAGE_FIXUP 8 "2008" "storage-fixup" "Linux"
+.SH NAME
+storage\-fixup \- a script which applies a workaround to buggy ata devices
+.SH SYNOPSIS
+.B storage\-fixup
+.RI "[-h] [-V] [-q] [-v] [-b] [-c config_file] [-m max_devs]"
+.SH DESCRIPTION
+Script to issue fix up commands for weird disks. This is primarily
+to adjust ATA APM setting. Some laptop BIOSen set this value too
+aggressively causing frequent head unloads which can kill the drive
+quickly. This script should be called during boot and resume. It
+examines rules from \fI/etc/storage\-fixup.conf\fR and executes matching
+commands.
+.SH OPTIONS
+.TP
+.I \-h
+Print help message and exit
+.TP
+.I \-V
+Print version and exit
+.TP
+.I \-q
+Quiet mode
+.TP
+.I \-v
+Verbose mode
+.TP
+.I \-d
+Dry run, don't actually execute action
+.TP
+.I \-c "config_file"
+Use config_file instead of /etc/storage-fixup.conf
+.TP
+.I \-m "max_devs"
+Maximum number of allowed devices (default=64, 0 for unlimited)
+.SH FILES
+.I /etc/storage\-fixup.conf
+.SH SEE ALSO
+hdparm(8) dmidecode(8)
---
