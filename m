From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: ide_dev_is_sata() -> ata_id_is_sata()
Date: Mon, 28 Jul 2008 22:59:36 +0200
Message-ID: <200807282259.36742.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:20441 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYG1VDV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 17:03:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3557662fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 14:03:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

* Use optimized ATA version check from Sergei in ata_id_is_sata().

* ide_dev_is_sata() -> ata_id_is_sata()

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c   |    2 +-
 drivers/ide/pci/hpt366.c |    4 ++--
 include/linux/ata.h      |   10 +++++++++-
 include/linux/ide.h      |   13 -------------
 4 files changed, 12 insertions(+), 17 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -630,7 +630,7 @@ u8 eighty_ninty_three (ide_drive_t *driv
 		printk(KERN_DEBUG "%s: skipping word 93 validity check\n",
 				  drive->name);
 
-	if (ide_dev_is_sata(id) && !ivb)
+	if (ata_id_is_sata(id) && !ivb)
 		return 1;
 
 	if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -648,7 +648,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t
 	case HPT372A:
 	case HPT372N:
 	case HPT374 :
-		if (ide_dev_is_sata(drive->id))
+		if (ata_id_is_sata(drive->id))
 			mask &= ~0x0e;
 		/* Fall thru */
 	default:
@@ -670,7 +670,7 @@ static u8 hpt3xx_mdma_filter(ide_drive_t
 	case HPT372A:
 	case HPT372N:
 	case HPT374 :
-		if (ide_dev_is_sata(drive->id))
+		if (ata_id_is_sata(drive->id))
 			return 0x00;
 		/* Fall thru */
 	default:
Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -644,7 +644,15 @@ static inline unsigned int ata_id_major_
 
 static inline int ata_id_is_sata(const u16 *id)
 {
-	return ata_id_major_version(id) >= 5 && id[ATA_ID_HW_CONFIG] == 0;
+	/*
+	 * See if word 93 is 0 AND drive is at least ATA-5 compatible
+	 * verifying that word 80 by casting it to a signed type --
+	 * this trick allows us to filter out the reserved values of
+	 * 0x0000 and 0xffff along with the earlier ATA revisions...
+	 */
+	if (id[ATA_ID_HW_CONFIG] == 0 && (short)id[ATA_ID_MAJOR_VER] >= 0x0020)
+		return 1;
+	return 0;
 }
 
 static inline int ata_id_has_tpm(const u16 *id)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1391,19 +1391,6 @@ const char *ide_xfer_verbose(u8 mode);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
-static inline int ide_dev_is_sata(u16 *id)
-{
-	/*
-	 * See if word 93 is 0 AND drive is at least ATA-5 compatible
-	 * verifying that word 80 by casting it to a signed type --
-	 * this trick allows us to filter out the reserved values of
-	 * 0x0000 and 0xffff along with the earlier ATA revisions...
-	 */
-	if (id[ATA_ID_HW_CONFIG] == 0 && (short)id[ATA_ID_MAJOR_VER] >= 0x0020)
-		return 1;
-	return 0;
-}
-
 u64 ide_get_lba_addr(struct ide_taskfile *, int);
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
 
