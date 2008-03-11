From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: mark "hdx=[driver_name]" and "hdx=scsi" kernel parameters as obsoleted
Date: Tue, 11 Mar 2008 21:32:00 +0100
Message-ID: <200803112132.00122.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:42069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYCKUTK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 16:19:10 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2546213fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 13:19:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Mark "hdx=[driver_name]" and "hdx=scsi" kernel parameters as obsoleted
(nowadays device-driver binding can be changed at runtime through sysfs
 and it can also be dealt with using per device driver parameters).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide/ide.txt |    4 ----
 drivers/ide/ide.c         |    4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: b/Documentation/ide/ide.txt
===================================================================
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -219,10 +219,6 @@ Summary of ide driver parameters for ker
 
  "hdx=nodma"		: disallow DMA
 
- "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
- 			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
- 			  to use ide-scsi emulation on a device specific option.
-
  "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
 			  used when tuning chipset PIO modes.
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -919,7 +919,7 @@ static int __init ide_setup(char *s)
 		drive = &hwif->drives[unit];
 		if (strncmp(s + 4, "ide-", 4) == 0) {
 			strlcpy(drive->driver_req, s + 4, sizeof(drive->driver_req));
-			goto done;
+			goto obsolete_option;
 		}
 		switch (match_parm(&s[3], hd_words, vals, 3)) {
 			case -1: /* "none" */
@@ -952,7 +952,7 @@ static int __init ide_setup(char *s)
 				goto done;
 			case -14: /* "scsi" */
 				drive->scsi = 1;
-				goto done;
+				goto obsolete_option;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->ready_stat = READY_STAT;
