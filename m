From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted
Date: Tue, 11 Mar 2008 21:32:50 +0100
Message-ID: <200803112132.50440.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:40378 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYCKUTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 16:19:11 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2546217fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 13:19:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted
(they are layering violation and should be dealt with in the same
 way as done by libata - device-mapper should be used instead).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide/ide.txt |    5 -----
 drivers/ide/ide.c         |    4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

Index: b/Documentation/ide/ide.txt
===================================================================
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -203,11 +203,6 @@ Summary of ide driver parameters for ker
 
  "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
 
- "hdx=remap"		: remap access of sector 0 to sector 1 (for EZDrive)
-
- "hdx=remap63"		: remap the drive: add 63 to all sector numbers
-			  (for DM OnTrack)
-
  "idex=noautotune"	: driver will NOT attempt to tune interface speed
 
  "hdx=autotune"		: driver will attempt to tune interface speed
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -946,10 +946,10 @@ static int __init ide_setup(char *s)
 				goto done;
 			case -12: /* "remap" */
 				drive->remap_0_to_1 = 1;
-				goto done;
+				goto obsolete_option;
 			case -13: /* "remap63" */
 				drive->sect0 = 63;
-				goto done;
+				goto obsolete_option;
 			case -14: /* "scsi" */
 				drive->scsi = 1;
 				goto obsolete_option;
