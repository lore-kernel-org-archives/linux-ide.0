From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: factor out device type classifying from do_identify()
Date: Wed, 12 Nov 2008 22:16:46 +0100
Message-ID: <200811122216.47054.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:8933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbYKLVdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 16:33:03 -0500
Received: by ti-out-0910.google.com with SMTP id b6so351770tic.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Nov 2008 13:33:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Factor out device type classifying from do_identify()
to ide_classify_ata_dev() and ide_classify_atapi_dev().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |  154 +++++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 73 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -101,6 +101,82 @@ static void ide_disk_init_mult_count(ide
 	}
 }
 
+static void ide_classify_ata_dev(ide_drive_t *drive)
+{
+	u16 *id = drive->id;
+	char *m = (char *)&id[ATA_ID_PROD];
+	int is_cfa = ata_id_is_cfa(id);
+
+	/* CF devices are *not* removable in Linux definition of the term */
+	if (is_cfa == 0 && (id[ATA_ID_CONFIG] & (1 << 7)))
+		drive->dev_flags |= IDE_DFLAG_REMOVABLE;
+
+	drive->media = ide_disk;
+
+	if (!ata_id_has_unload(drive->id))
+		drive->dev_flags |= IDE_DFLAG_NO_UNLOAD;
+
+	printk(KERN_INFO "%s: %s, %s DISK drive\n", drive->name, m,
+		is_cfa ? "CFA" : "ATA");
+}
+
+static void ide_classify_atapi_dev(ide_drive_t *drive)
+{
+	u16 *id = drive->id;
+	char *m = (char *)&id[ATA_ID_PROD];
+	u8 type = (id[ATA_ID_CONFIG] >> 8) & 0x1f;
+
+	printk(KERN_INFO "%s: %s, ATAPI ", drive->name, m);
+	switch (type) {
+	case ide_floppy:
+		if (!strstr(m, "CD-ROM")) {
+			if (!strstr(m, "oppy") &&
+			    !strstr(m, "poyp") &&
+			    !strstr(m, "ZIP"))
+				printk(KERN_CONT "cdrom or floppy?, assuming ");
+			if (drive->media != ide_cdrom) {
+				printk(KERN_CONT "FLOPPY");
+				drive->dev_flags |= IDE_DFLAG_REMOVABLE;
+				break;
+			}
+		}
+		/* Early cdrom models used zero */
+		type = ide_cdrom;
+	case ide_cdrom:
+		drive->dev_flags |= IDE_DFLAG_REMOVABLE;
+#ifdef CONFIG_PPC
+		/* kludge for Apple PowerBook internal zip */
+		if (!strstr(m, "CD-ROM") && strstr(m, "ZIP")) {
+			printk(KERN_CONT "FLOPPY");
+			type = ide_floppy;
+			break;
+		}
+#endif
+		printk(KERN_CONT "CD/DVD-ROM");
+		break;
+	case ide_tape:
+		printk(KERN_CONT "TAPE");
+		break;
+	case ide_optical:
+		printk(KERN_CONT "OPTICAL");
+		drive->dev_flags |= IDE_DFLAG_REMOVABLE;
+		break;
+	default:
+		printk(KERN_CONT "UNKNOWN (type %d)", type);
+		break;
+	}
+
+	printk(KERN_CONT " drive\n");
+	drive->media = type;
+	/* an ATAPI device ignores DRDY */
+	drive->ready_stat = 0;
+	if (ata_id_cdb_intr(id))
+		drive->atapi_flags |= IDE_AFLAG_DRQ_INTERRUPT;
+	drive->dev_flags |= IDE_DFLAG_DOORLOCKING;
+	/* we don't do head unloading on ATAPI devices */
+	drive->dev_flags |= IDE_DFLAG_NO_UNLOAD;
+}
+
 /**
  *	do_identify	-	identify a drive
  *	@drive: drive to identify 
@@ -117,7 +193,7 @@ static void do_identify(ide_drive_t *dri
 	u16 *id = drive->id;
 	char *m = (char *)&id[ATA_ID_PROD];
 	unsigned long flags;
-	int bswap = 1, is_cfa;
+	int bswap = 1;
 
 	/* local CPU only; some systems need this */
 	local_irq_save(flags);
@@ -154,91 +230,23 @@ static void do_identify(ide_drive_t *dri
 	if (strstr(m, "E X A B Y T E N E S T"))
 		goto err_misc;
 
-	printk(KERN_INFO "%s: %s, ", drive->name, m);
-
 	drive->dev_flags |= IDE_DFLAG_PRESENT;
 	drive->dev_flags &= ~IDE_DFLAG_DEAD;
 
 	/*
 	 * Check for an ATAPI device
 	 */
-	if (cmd == ATA_CMD_ID_ATAPI) {
-		u8 type = (id[ATA_ID_CONFIG] >> 8) & 0x1f;
-
-		printk(KERN_CONT "ATAPI ");
-		switch (type) {
-			case ide_floppy:
-				if (!strstr(m, "CD-ROM")) {
-					if (!strstr(m, "oppy") &&
-					    !strstr(m, "poyp") &&
-					    !strstr(m, "ZIP"))
-						printk(KERN_CONT "cdrom or floppy?, assuming ");
-					if (drive->media != ide_cdrom) {
-						printk(KERN_CONT "FLOPPY");
-						drive->dev_flags |= IDE_DFLAG_REMOVABLE;
-						break;
-					}
-				}
-				/* Early cdrom models used zero */
-				type = ide_cdrom;
-			case ide_cdrom:
-				drive->dev_flags |= IDE_DFLAG_REMOVABLE;
-#ifdef CONFIG_PPC
-				/* kludge for Apple PowerBook internal zip */
-				if (!strstr(m, "CD-ROM") && strstr(m, "ZIP")) {
-					printk(KERN_CONT "FLOPPY");
-					type = ide_floppy;
-					break;
-				}
-#endif
-				printk(KERN_CONT "CD/DVD-ROM");
-				break;
-			case ide_tape:
-				printk(KERN_CONT "TAPE");
-				break;
-			case ide_optical:
-				printk(KERN_CONT "OPTICAL");
-				drive->dev_flags |= IDE_DFLAG_REMOVABLE;
-				break;
-			default:
-				printk(KERN_CONT "UNKNOWN (type %d)", type);
-				break;
-		}
-		printk(KERN_CONT " drive\n");
-		drive->media = type;
-		/* an ATAPI device ignores DRDY */
-		drive->ready_stat = 0;
-		if (ata_id_cdb_intr(id))
-			drive->atapi_flags |= IDE_AFLAG_DRQ_INTERRUPT;
-		drive->dev_flags |= IDE_DFLAG_DOORLOCKING;
-		/* we don't do head unloading on ATAPI devices */
-		drive->dev_flags |= IDE_DFLAG_NO_UNLOAD;
-		return;
-	}
-
+	if (cmd == ATA_CMD_ID_ATAPI)
+		ide_classify_atapi_dev(drive);
+	else
 	/*
 	 * Not an ATAPI device: looks like a "regular" hard disk
 	 */
-
-	is_cfa = ata_id_is_cfa(id);
-
-	/* CF devices are *not* removable in Linux definition of the term */
-	if (is_cfa == 0 && (id[ATA_ID_CONFIG] & (1 << 7)))
-		drive->dev_flags |= IDE_DFLAG_REMOVABLE;
-
-	drive->media = ide_disk;
-
-	if (!ata_id_has_unload(drive->id))
-		drive->dev_flags |= IDE_DFLAG_NO_UNLOAD;
-
-	printk(KERN_CONT "%s DISK drive\n", is_cfa ? "CFA" : "ATA");
-
+		ide_classify_ata_dev(drive);
 	return;
-
 err_misc:
 	kfree(id);
 	drive->dev_flags &= ~IDE_DFLAG_PRESENT;
-	return;
 }
 
 /**
