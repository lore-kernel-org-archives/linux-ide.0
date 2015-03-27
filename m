From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/9] libata: use status bit definitions in ata_dump_status()
Date: Fri, 27 Mar 2015 16:46:34 +0100
Message-ID: <1427471198-62676-6-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41474 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932194AbbC0Pqn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2015 11:46:43 -0400
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Use the bit definitions for better readability.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1f1cb69..f065cb1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -799,26 +799,27 @@ static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 	if (stat & ATA_BUSY) {
 		printk("Busy }\n");	/* Data is not valid in this case */
 	} else {
-		if (stat & 0x40)	printk("DriveReady ");
-		if (stat & 0x20)	printk("DeviceFault ");
-		if (stat & 0x10)	printk("SeekComplete ");
-		if (stat & 0x08)	printk("DataRequest ");
-		if (stat & 0x04)	printk("CorrectedError ");
-		if (stat & 0x02)	printk("Sense ");
-		if (stat & 0x01)	printk("Error ");
+		if (stat & ATA_DRDY)	printk("DriveReady ");
+		if (stat & ATA_DF)	printk("DeviceFault ");
+		if (stat & ATA_DSC)	printk("SeekComplete ");
+		if (stat & ATA_DRQ)	printk("DataRequest ");
+		if (stat & ATA_CORR)	printk("CorrectedError ");
+		if (stat & ATA_SENSE)	printk("Sense ");
+		if (stat & ATA_ERR)	printk("Error ");
 		printk("}\n");
 
 		if (err) {
 			printk(KERN_WARNING "ata%u: error=0x%02x { ", id, err);
-			if (err & 0x04)		printk("DriveStatusError ");
-			if (err & 0x80) {
-				if (err & 0x04)	printk("BadCRC ");
+			if (err & ATA_ABORTED)	printk("DriveStatusError ");
+			if (err & ATA_ICRC) {
+				if (err & ATA_ABORTED)
+						printk("BadCRC ");
 				else		printk("Sector ");
 			}
-			if (err & 0x40)		printk("UncorrectableError ");
-			if (err & 0x10)		printk("SectorIdNotFound ");
-			if (err & 0x02)		printk("TrackZeroNotFound ");
-			if (err & 0x01)		printk("AddrMarkNotFound ");
+			if (err & ATA_UNC)	printk("UncorrectableError ");
+			if (err & ATA_IDNF)	printk("SectorIdNotFound ");
+			if (err & ATA_TRK0NF)	printk("TrackZeroNotFound ");
+			if (err & ATA_AMNF)	printk("AddrMarkNotFound ");
 			printk("}\n");
 		}
 	}
-- 
1.8.5.2

