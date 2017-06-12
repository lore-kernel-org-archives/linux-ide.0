From: Joe Perches <joe@perches.com>
Subject: [PATCH] libata: Convert bare printks to pr_cont
Date: Mon, 12 Jun 2017 12:17:39 -0700
Message-ID: <9b704f23a6e72b8b5b365efa88f9dda393407b7f.1497295039.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Linus Torvalds changed the behavior of printks without KERN_<LEVEL>.

Convert the continuation prints to use pr_cont.

At the same time, convert the existing printks with KERN_<LEVEL> to
pr_<level>

Miscellanea:

o Coalesce a multiline format

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ata/libata-scsi.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8dc84fd77369..0f788ad6f2f6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -903,32 +903,32 @@ static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 {
 	u8 stat = tf->command, err = tf->feature;
 
-	printk(KERN_WARNING "ata%u: status=0x%02x { ", id, stat);
+	pr_warn("ata%u: status=0x%02x { ", id, stat);
 	if (stat & ATA_BUSY) {
-		printk("Busy }\n");	/* Data is not valid in this case */
+		pr_cont("Busy }\n");	/* Data is not valid in this case */
 	} else {
-		if (stat & ATA_DRDY)	printk("DriveReady ");
-		if (stat & ATA_DF)	printk("DeviceFault ");
-		if (stat & ATA_DSC)	printk("SeekComplete ");
-		if (stat & ATA_DRQ)	printk("DataRequest ");
-		if (stat & ATA_CORR)	printk("CorrectedError ");
-		if (stat & ATA_SENSE)	printk("Sense ");
-		if (stat & ATA_ERR)	printk("Error ");
-		printk("}\n");
+		if (stat & ATA_DRDY)	pr_cont("DriveReady ");
+		if (stat & ATA_DF)	pr_cont("DeviceFault ");
+		if (stat & ATA_DSC)	pr_cont("SeekComplete ");
+		if (stat & ATA_DRQ)	pr_cont("DataRequest ");
+		if (stat & ATA_CORR)	pr_cont("CorrectedError ");
+		if (stat & ATA_SENSE)	pr_cont("Sense ");
+		if (stat & ATA_ERR)	pr_cont("Error ");
+		pr_cont("}\n");
 
 		if (err) {
-			printk(KERN_WARNING "ata%u: error=0x%02x { ", id, err);
-			if (err & ATA_ABORTED)	printk("DriveStatusError ");
+			pr_warn("ata%u: error=0x%02x { ", id, err);
+			if (err & ATA_ABORTED)	pr_cont("DriveStatusError ");
 			if (err & ATA_ICRC) {
 				if (err & ATA_ABORTED)
-						printk("BadCRC ");
-				else		printk("Sector ");
+						pr_cont("BadCRC ");
+				else		pr_cont("Sector ");
 			}
-			if (err & ATA_UNC)	printk("UncorrectableError ");
-			if (err & ATA_IDNF)	printk("SectorIdNotFound ");
-			if (err & ATA_TRK0NF)	printk("TrackZeroNotFound ");
-			if (err & ATA_AMNF)	printk("AddrMarkNotFound ");
-			printk("}\n");
+			if (err & ATA_UNC)	pr_cont("UncorrectableError ");
+			if (err & ATA_IDNF)	pr_cont("SectorIdNotFound ");
+			if (err & ATA_TRK0NF)	pr_cont("TrackZeroNotFound ");
+			if (err & ATA_AMNF)	pr_cont("AddrMarkNotFound ");
+			pr_cont("}\n");
 		}
 	}
 }
@@ -1059,8 +1059,7 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 
  translate_done:
 	if (verbose)
-		printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x "
-		       "to SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
+		pr_err("ata%u: translated ATA stat/err 0x%02x/%02x to SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
 		       id, drv_stat, drv_err, *sk, *asc, *ascq);
 	return;
 }
-- 
2.10.0.rc2.1.g053435c
