From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/9] ide,ata: Rename ATA_IDX to ATA_SENSE
Date: Fri, 27 Mar 2015 16:46:33 +0100
Message-ID: <1427471198-62676-5-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41466 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbbC0Pqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2015 11:46:42 -0400
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>

ATA-8 defines bit 1 as 'ATA_SENSE', not 'ATA_IDX'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 2 +-
 drivers/ide/ide-lib.c     | 4 ++--
 drivers/ide/ide-probe.c   | 2 +-
 include/linux/ata.h       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d2b6196..1f1cb69 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -804,7 +804,7 @@ static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 		if (stat & 0x10)	printk("SeekComplete ");
 		if (stat & 0x08)	printk("DataRequest ");
 		if (stat & 0x04)	printk("CorrectedError ");
-		if (stat & 0x02)	printk("Index ");
+		if (stat & 0x02)	printk("Sense ");
 		if (stat & 0x01)	printk("Error ");
 		printk("}\n");
 
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
index d9c9829..e1180fa 100644
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -148,8 +148,8 @@ u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
 			printk(KERN_CONT "DataRequest ");
 		if (stat & ATA_CORR)
 			printk(KERN_CONT "CorrectedError ");
-		if (stat & ATA_IDX)
-			printk(KERN_CONT "Index ");
+		if (stat & ATA_SENSE)
+			printk(KERN_CONT "Sense ");
 		if (stat & ATA_ERR)
 			printk(KERN_CONT "Error ");
 	}
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index a3d3b17..0b63fac 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -273,7 +273,7 @@ int ide_dev_read_id(ide_drive_t *drive, u8 cmd, u16 *id, int irq_ctx)
 	    (hwif->host_flags & IDE_HFLAG_BROKEN_ALTSTATUS) == 0) {
 		a = tp_ops->read_altstatus(hwif);
 		s = tp_ops->read_status(hwif);
-		if ((a ^ s) & ~ATA_IDX)
+		if ((a ^ s) & ~ATA_SENSE)
 			/* ancient Seagate drives, broken interfaces */
 			printk(KERN_INFO "%s: probing with STATUS(0x%02x) "
 					 "instead of ALTSTATUS(0x%02x)\n",
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 681520f..e3cb41c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -177,7 +177,7 @@ enum {
 	ATA_DSC			= (1 << 4),	/* drive seek complete */
 	ATA_DRQ			= (1 << 3),	/* data request i/o */
 	ATA_CORR		= (1 << 2),	/* corrected data error */
-	ATA_IDX			= (1 << 1),	/* index */
+	ATA_SENSE		= (1 << 1),	/* sense code available */
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
 	ATA_ICRC		= (1 << 7),	/* interface CRC error */
-- 
1.8.5.2

