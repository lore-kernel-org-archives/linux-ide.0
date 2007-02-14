From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/8] ide: remove some obsoleted kernel params
Date: Wed, 14 Feb 2007 02:56:52 +0100
Message-ID: <20070214015652.4619.2752.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXBNBvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:10 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: remove some obsoleted kernel params

Remove

* "hdx=serialize"
* "idex=noautotune"
* "idex=autotune"

kernel params, they have been obsoleted for ages.

"idex=serialize", "hdx=noautotune" and "hdx=autotune" are still available
so there is no funcionality loss caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 Documentation/ide.txt       |   15 +++------------
 drivers/ide/ide.c           |   18 ++++--------------
 drivers/ide/legacy/qd65xx.c |    4 ++--
 drivers/ide/pci/opti621.c   |    2 +-
 4 files changed, 10 insertions(+), 29 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -232,7 +232,9 @@ Summary of ide driver parameters for ker
 
  "hdx=remap63"		: remap the drive: add 63 to all sector numbers
 			  (for DM OnTrack)
- 
+
+ "idex=noautotune"	: driver will NOT attempt to tune interface speed
+
  "hdx=autotune"		: driver will attempt to tune interface speed
 			  to the fastest PIO mode supported,
 			  if possible for this drive only.
@@ -267,17 +269,6 @@ Summary of ide driver parameters for ker
  "idex=base,ctl"	: specify both base and ctl
 
  "idex=base,ctl,irq"	: specify base, ctl, and irq number
- 
- "idex=autotune"	: driver will attempt to tune interface speed
-			  to the fastest PIO mode supported,
-			  for all drives on this interface.
-			  Not fully supported by all chipset types,
-			  and quite likely to cause trouble with
-			  older/odd IDE drives.
-
- "idex=noautotune"	: driver will NOT attempt to tune interface speed 
-			  This is the default for most chipsets,
-			  except the cmd640.
 
  "idex=serialize"	: do not overlap operations on idex. Please note
 			  that you will have to specify this option for
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1346,7 +1346,7 @@ static int __init ide_setup(char *s)
 	 */
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
-			"none", "noprobe", "nowerr", "cdrom", "serialize",
+			"none", "noprobe", "nowerr", "cdrom", "minus5",
 			"autotune", "noautotune", "minus8", "swapdata", "bswap",
 			"noflush", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
@@ -1374,9 +1374,6 @@ static int __init ide_setup(char *s)
 				drive->ready_stat = 0;
 				hwif->noprobe = 0;
 				goto done;
-			case -5: /* "serialize" */
-				printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
-				goto do_serialize;
 			case -6: /* "autotune" */
 				drive->autotune = IDE_TUNE_AUTO;
 				goto obsolete_option;
@@ -1437,7 +1434,7 @@ static int __init ide_setup(char *s)
 		 * (-8, -9, -10) are reserved to ease the hardcoding.
 		 */
 		static const char *ide_words[] = {
-			"noprobe", "serialize", "autotune", "noautotune", 
+			"noprobe", "serialize", "minus3", "minus4",
 			"reset", "dma", "ata66", "minus8", "minus9",
 			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
 			"dtc2278", "umc8672", "ali14xx", NULL };
@@ -1514,6 +1511,8 @@ static int __init ide_setup(char *s)
 			case -10: /* minus10 */
 			case -9: /* minus9 */
 			case -8: /* minus8 */
+			case -4:
+			case -3:
 				goto bad_option;
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -1528,16 +1527,7 @@ static int __init ide_setup(char *s)
 			case -5: /* "reset" */
 				hwif->reset = 1;
 				goto obsolete_option;
-			case -4: /* "noautotune" */
-				hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
-				hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
-				goto obsolete_option;
-			case -3: /* "autotune" */
-				hwif->drives[0].autotune = IDE_TUNE_AUTO;
-				hwif->drives[1].autotune = IDE_TUNE_AUTO;
-				goto obsolete_option;
 			case -2: /* "serialize" */
-			do_serialize:
 				hwif->mate = &ide_hwifs[hw^1];
 				hwif->mate->mate = hwif;
 				hwif->serialized = hwif->mate->serialized = 1;
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -16,8 +16,8 @@
  * Please set local bus speed using kernel parameter idebus
  * 	for example, "idebus=33" stands for 33Mhz VLbus
  * To activate controller support, use "ide0=qd65xx"
- * To enable tuning, use "ide0=autotune"
- * To enable second channel tuning (qd6580 only), use "ide1=autotune"
+ * To enable tuning, use "hda=autotune hdb=autotune"
+ * To enable 2nd channel tuning (qd6580 only), use "hdc=autotune hdd=autotune"
  */
 
 /*
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -57,7 +57,7 @@
  * There is a 25/33MHz switch in configuration
  * register, but driver is written for use at any frequency which get
  * (use idebus=xx to select PCI bus speed).
- * Use ide0=autotune for automatical tune of the PIO modes.
+ * Use hda=autotune and hdb=autotune for automatical tune of the PIO modes.
  * If you get strange results, do not use this and set PIO manually
  * by hdparm.
  *
