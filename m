From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: use ata_id_is_cfa()
Date: Sat, 2 Aug 2008 19:08:13 +0200
Message-ID: <200808021908.13984.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756664AbYHBRQ1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Use ata_id_is_cfa() in do_identify() instead of open-coding
check for CompactFlash devices (the inline helper also takes
care of detecting CFs advertising themselves as ATA disks).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -116,7 +116,7 @@ static inline void do_identify (ide_driv
 	ide_hwif_t *hwif = HWIF(drive);
 	u16 *id = drive->id;
 	char *m = (char *)&id[ATA_ID_PROD];
-	int bswap = 1;
+	int bswap = 1, is_cfa;
 
 	/* read 512 bytes of id info */
 	hwif->tp_ops->input_data(drive, NULL, id, SECTOR_SIZE);
@@ -212,17 +212,15 @@ static inline void do_identify (ide_driv
 	 * Not an ATAPI device: looks like a "regular" hard disk
 	 */
 
-	/*
-	 * 0x848a = CompactFlash device
-	 * These are *not* removable in Linux definition of the term
-	 */
-	if (id[ATA_ID_CONFIG] != 0x848a && (id[ATA_ID_CONFIG] & (1 << 7)))
+	is_cfa = ata_id_is_cfa(id);
+
+	/* CF devices are *not* removable in Linux definition of the term */
+	if (is_cfa == 0 && (id[ATA_ID_CONFIG] & (1 << 7)))
 		drive->removable = 1;
 
 	drive->media = ide_disk;
 
-	printk(KERN_CONT "%s DISK drive\n",
-		(id[ATA_ID_CONFIG] == 0x848a) ? "CFA" : "ATA");
+	printk(KERN_CONT "%s DISK drive\n", is_cfa ? "CFA" : "ATA");
 
 	return;
 
