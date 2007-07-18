From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 40-wire/80-wire detection
Date: Thu, 19 Jul 2007 00:32:34 +0200
Message-ID: <200707190032.35039.bzolnier@gmail.com>
References: <305029.41682.qm@web58107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:53396 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763257AbXGRWPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 18:15:38 -0400
Received: by ik-out-1112.google.com with SMTP id b32so335066ika
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 15:15:36 -0700 (PDT)
In-Reply-To: <305029.41682.qm@web58107.mail.re3.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: Stephen.Clark@seclark.us, Jeff Garzik <jeff@garzik.org>, Matt Sealey <matt@genesi-usa.com>, linux-ide@vger.kernel.org


Hi,

On Saturday 14 July 2007, Craig Block wrote:
> 
> --- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Please send the output of hdparm --Istdout for this drive.
> > 
> > "idex=ata66" or CONFIG_IDEDMA_IVB=y should also help but we really would

I initially missed the fact that you've already tried CONFIG_IDEDMA_IVB and
that it didn't help (probably because of failed host side cable detection).

> > like to detect and workaround such issues automatically, without the need
> > for user headaches. ;)
> > 
> > Thanks,
> > Bart
> > 
> Here ya go, hope that helps :)
> 
> /dev/hda:

[...]

Thanks, could you try the patch below (it is against Linus tree)?

[PATCH] ide: add cable detection for early UDMA66 devices

* Move ide_in_drive_list() from ide-dma.c to ide-iops.c.

* Add ivb_list[] table for listening early UDMA66 devices which don't conform
  to ATA4 standard wrt cable detection (bit14 is zero, only bit13 is valid)
  and use only device side cable detection for them since host side cable
  detection may be unreliable.

* Add model "QUANTUM FIREBALLlct10 05" with firwmare "A03.0900" to the list
  (from Craig's bugreport).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Craig Block <chblock3@yahoo.com>
---
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
+		printk(KERN_DEBUG "%s: enabling IVB cable detection quirk\n",
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
@@ -1275,13 +1275,14 @@ void ide_init_sg_cmd(ide_drive_t *, stru
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
 u8 ide_max_dma_mode(ide_drive_t *);
