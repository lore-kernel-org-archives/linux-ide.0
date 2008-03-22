From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: Documentation/ide/ide.txt fixes
Date: Sat, 22 Mar 2008 16:30:47 +0100
Message-ID: <200803221630.47341.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:26581 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYCVPQ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Mar 2008 11:16:28 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1921207fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 08:16:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

* "hdx=cyls,heads,sects,wpcom,irq" should be "hdx=cyls,heads,sects".

* "hdx=" is for "x" from 'a' to 'u', "idex=" is for "x" from '0' to '9'.

* "idex=noautotune" is long gone.

* Obsoleted "ide0=" parameters were already removed from the documentation.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes after "ide: mark special "ide0=" kernel parameters as obsoleted" patch

 Documentation/ide/ide.txt |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: b/Documentation/ide/ide.txt
===================================================================
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -105,7 +105,7 @@ Drives are normally found by auto-probin
 For really weird situations, the apparent (fdisk) geometry can also be specified
 on the kernel "command line" using LILO.  The format of such lines is:
 
-	hdx=cyls,heads,sects,wpcom,irq
+	hdx=cyls,heads,sects
 or	hdx=cdrom
 
 where hdx can be any of hda through hdh, Three values are required
@@ -214,9 +214,9 @@ driver using the "options=" keyword to i
 Summary of ide driver parameters for kernel command line
 --------------------------------------------------------
 
- "hdx="  is recognized for all "x" from "a" to "h", such as "hdc".
+ "hdx="  is recognized for all "x" from "a" to "u", such as "hdc".
 
- "idex=" is recognized for all "x" from "0" to "3", such as "ide1".
+ "idex=" is recognized for all "x" from "0" to "9", such as "ide1".
 
  "hdx=noprobe"		: drive may be present, but do not probe for it
 
@@ -233,8 +233,6 @@ Summary of ide driver parameters for ker
  "hdx=remap63"		: remap the drive: add 63 to all sector numbers
 			  (for DM OnTrack)
 
- "idex=noautotune"	: driver will NOT attempt to tune interface speed
-
  "hdx=autotune"		: driver will attempt to tune interface speed
 			  to the fastest PIO mode supported,
 			  if possible for this drive only.
@@ -282,10 +280,6 @@ Summary of ide driver parameters for ker
 
  "ide=reverse"		: formerly called to pci sub-system, but now local.
 
-The following are valid ONLY on ide0, which usually corresponds
-to the first ATA interface found on the particular host, and the defaults for
-the base,ctl ports must not be altered.
-
  "ide=doubler"		: probe/support IDE doublers on Amiga
 
 There may be more options than shown -- use the source, Luke!
