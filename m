From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/7] ide: add "hdx=nodma" kernel parameter
Date: Sat, 18 Aug 2007 20:50:50 +0200
Message-ID: <200708182050.50372.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:64045 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbXHRTTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1246480mue
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add "hdx=nodma" option allowing user to disallow DMA for a given device.

* Obsolete "ide=nodma" option.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide.txt |    4 ++--
 drivers/ide/ide-dma.c |    2 +-
 drivers/ide/ide.c     |    7 +++++--
 include/linux/ide.h   |    1 +
 4 files changed, 9 insertions(+), 5 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -242,6 +242,8 @@ Summary of ide driver parameters for ker
 			  and quite likely to cause trouble with
 			  older/odd IDE drives.
 
+ "hdx=nodma"		: disallow DMA
+
  "hdx=swapdata"		: when the drive is a disk, byte swap all data
 
  "hdx=bswap"		: same as above..........
@@ -286,8 +288,6 @@ Summary of ide driver parameters for ker
 
  "ide=reverse"		: formerly called to pci sub-system, but now local.
 
- "ide=nodma"		: disable DMA globally for the IDE subsystem.
-
 The following are valid ONLY on ide0, which usually corresponds
 to the first ATA interface found on the particular host, and the defaults for
 the base,ctl ports must not be altered.
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -754,7 +754,7 @@ static int ide_tune_dma(ide_drive_t *dri
 {
 	u8 speed;
 
-	if (noautodma || (drive->id->capability & 1) == 0)
+	if (noautodma || drive->nodma || (drive->id->capability & 1) == 0)
 		return 0;
 
 	/* consult the list of known "bad" drives */
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1274,7 +1274,7 @@ static int __init ide_setup(char *s)
 	if (!strcmp(s, "ide=nodma")) {
 		printk(" : Prevented DMA\n");
 		noautodma = 1;
-		return 1;
+		goto obsolete_option;
 	}
 
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
@@ -1308,7 +1308,7 @@ static int __init ide_setup(char *s)
 	 */
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
-			"none", "noprobe", "nowerr", "cdrom", "minus5",
+			"none", "noprobe", "nowerr", "cdrom", "nodma",
 			"autotune", "noautotune", "minus8", "swapdata", "bswap",
 			"noflush", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
@@ -1336,6 +1336,9 @@ static int __init ide_setup(char *s)
 				drive->ready_stat = 0;
 				hwif->noprobe = 0;
 				goto done;
+			case -5: /* nodma */
+				drive->nodma = 1;
+				goto done;
 			case -6: /* "autotune" */
 				drive->autotune = IDE_TUNE_AUTO;
 				goto obsolete_option;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -599,6 +599,7 @@ typedef struct ide_drive_s {
 	unsigned nice0		: 1;	/* give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
+	unsigned nodma		: 1;	/* disallow DMA */
 	unsigned autotune	: 2;	/* 0=default, 1=autotune, 2=noautotune */
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
