From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: use FLUSH_EXT only when driver is larger than LBA28 limit
Date: Sat, 11 Nov 2006 03:33:04 +0900
Message-ID: <20061110183304.GA22793@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:57607 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161871AbWKJSdN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 13:33:13 -0500
Received: by ug-out-1314.google.com with SMTP id m3so601555ugc
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 10:33:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Danny Kukawka <dkukawka@novell.com>, Stefan Seyfried <seife@novell.com>

Many drives support LBA48 even when its capacity is smaller than
1<<28, as LBA48 is required for many functionalities.  FLUSH_EXT is
mandatory for drives w/ LBA48 support.

Interestingly, at least one of such drives (ST960812A) has problems
dealing with FLUSH_EXT.  It eventually completes the command but takes
around 7 seconds to finish in many cases thus drastically slowing down
IO transactions.  This seems to be a firmware bug which sneaked into
production probably because no other ATA driver including linux IDE
issues FLUSH_EXT to drives which report support for LBA48 & FLUSH_EXT
but is smaller than 1<<28 blocks.

This patch adds ATA_DFLAG_FLUSH_EXT which is set iff the drive
supports LBA48 & FLUSH_EXT and is larger than LBA28 limit.  Both cache
flush paths are updated to issue FLUSH_EXT only when the flag is set.
Note that the changed behavior is more inline with the rest of libata.
libata prefers shorter commands whenever possible.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Danny Kukawka <dkukawka@novell.com>
Cc: Stefan Seyfried <seife@novell.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fdb266..669ee26 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1457,6 +1457,10 @@ int ata_dev_configure(struct ata_device
 			if (ata_id_has_lba48(id)) {
 				dev->flags |= ATA_DFLAG_LBA48;
 				lba_desc = "LBA48";
+
+				if (ata_id_u64(id, 100) >= (1UL << 28) &&
+				    ata_id_has_flush_ext(id))
+					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
 			/* config NCQ */
@@ -5128,7 +5132,7 @@ int ata_flush_cache(struct ata_device *d
 	if (!ata_try_flush_cache(dev))
 		return 0;
 
-	if (ata_id_has_flush_ext(dev->id))
+	if (dev->flags & ATA_DFLAG_FLUSH_EXT)
 		cmd = ATA_CMD_FLUSH_EXT;
 	else
 		cmd = ATA_CMD_FLUSH;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a0b6ee1..2be51c6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1027,8 +1027,7 @@ static unsigned int ata_scsi_flush_xlat(
 	tf->flags |= ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if ((qc->dev->flags & ATA_DFLAG_LBA48) &&
-	    (ata_id_has_flush_ext(qc->dev->id)))
+	if (qc->dev->flags & ATA_DFLAG_FLUSH_EXT)
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
 		tf->command = ATA_CMD_FLUSH;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0d0ddea..36e233c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -140,6 +140,7 @@ enum {
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
+	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */

