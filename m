From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add cable detection for early UDMA66 devices (take 2)
Date: Sun, 29 Jul 2007 19:49:46 +0200
Message-ID: <200707291949.46232.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:44316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765055AbXG2SFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:13 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123524nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Craig Block <chblock3@yahoo.com>


* Move ide_in_drive_list() from ide-dma.c to ide-iops.c.

* Add ivb_list[] table for listening early UDMA66 devices which don't conform
  to ATA4 standard wrt cable detection (bit14 is zero, only bit13 is valid)
  and use only device side cable detection for them since host side cable
  detection may be unreliable.

* Add model "QUANTUM FIREBALLlct10 05" with firwmare "A03.0900" to the list
  (from Craig's bugreport).

v2:
* Improve kernel message basing on suggestion from Sergei.

Thanks to Craig for testing this patch.

Cc: Craig Block <chblock3@yahoo.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
- no other changes besides fixed printk, no need to retest
- replacement patch for the one in the IDE quilt tree

 drivers/ide/ide-dma.c  |   19 -------------------
 drivers/ide/ide-iops.c |   39 ++++++++++++++++++++++++++++++++++++---
 include/linux/ide.h    |    3 ++-
 3 files changed, 38 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -135,25 +135,6 @@ static const struct drive_list_entry dri
 };
 
 /**
- *	ide_in_drive_list	-	look for drive in black/white list
- *	@id: drive identifier
- *	@drive_table: list to inspect
- *
- *	Look for a drive in the blacklist and the whitelist tables
- *	Returns 1 if the drive is found in the table.
- */
-
-int ide_in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
-{
-	for ( ; drive_table->id_model ; drive_table++)
-		if ((!strcmp(drive_table->id_model, id->model)) &&
-		    (!drive_table->id_firmware ||
-		     strstr(id->fw_rev, drive_table->id_firmware)))
-			return 1;
-	return 0;
-}
-
-/**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
  *
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -565,6 +565,34 @@ int ide_wait_stat (ide_startstop_t *star
 
 EXPORT_SYMBOL(ide_wait_stat);
 
+/**
+ *	ide_in_drive_list	-	look for drive in black/white list
+ *	@id: drive identifier
+ *	@drive_table: list to inspect
+ *
+ *	Look for a drive in the blacklist and the whitelist tables
+ *	Returns 1 if the drive is found in the table.
+ */
+
+int ide_in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
+{
+	for ( ; drive_table->id_model ; drive_table++)
+		if ((!strcmp(drive_table->id_model, id->model)) &&
+		    (!drive_table->id_firmware ||
+		     strstr(id->fw_rev, drive_table->id_firmware)))
+			return 1;
+	return 0;
+}
+
+/*
+ * Early UDMA66 devices don't set bit14 to 1, only bit13 is valid.
+ * We list them here and depend on the device side cable detection for them.
+ */
+static const struct drive_list_entry ivb_list[] = {
+	{ "QUANTUM FIREBALLlct10 05"	, "A03.0900"	},
+	{ NULL				, NULL		}
+};
+
 /*
  *  All hosts that use the 80c ribbon must use!
  *  The name is derived from upper byte of word 93 and the 80c ribbon.
@@ -573,11 +601,16 @@ u8 eighty_ninty_three (ide_drive_t *driv
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct hd_driveid *id = drive->id;
+	int ivb = ide_in_drive_list(id, ivb_list);
+
+	if (ivb)
+		printk(KERN_DEBUG "%s: ignoring word 93 validity check\n",
+				  drive->name);
 
 	if (hwif->cbl == ATA_CBL_PATA40_SHORT)
 		return 1;
 
-	if (hwif->cbl != ATA_CBL_PATA80)
+	if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
 		goto no_80w;
 
 	/* Check for SATA but only if we are ATA5 or higher */
@@ -587,11 +620,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	/*
 	 * FIXME:
 	 * - change master/slave IDENTIFY order
-	 * - force bit13 (80c cable present) check
+	 * - force bit13 (80c cable present) check also for !ivb devices
 	 *   (unless the slave device is pre-ATA3)
 	 */
 #ifndef CONFIG_IDEDMA_IVB
-	if (id->hw_config & 0x4000)
+	if ((id->hw_config & 0x4000) || (ivb && (id->hw_config & 0x2000)))
 #else
 	if (id->hw_config & 0x6000)
 #endif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1291,13 +1291,14 @@ void ide_init_sg_cmd(ide_drive_t *, stru
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 struct drive_list_entry {
 	const char *id_model;
 	const char *id_firmware;
 };
 
 int ide_in_drive_list(struct hd_driveid *, const struct drive_list_entry *);
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 
