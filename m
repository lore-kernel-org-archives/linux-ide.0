From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] ata: fixup ATA_PROT_NODATA
Date: Thu, 14 Jul 2016 09:05:46 +0900
Message-ID: <1468454751-12466-6-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55756 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:12 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

The taskfile protocol is a numeric value, and can not be ORed.  Currently
this is harmless as the protocol is always zeroed before, but if it ever
has a non-zero value the ORing would create incorrect results.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[hch: updated patch description]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-eh.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f5eb07e..522848a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1238,7 +1238,7 @@ static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
 	} else
 		tf.command = ATA_CMD_READ_NATIVE_MAX;
 
-	tf.protocol |= ATA_PROT_NODATA;
+	tf.protocol = ATA_PROT_NODATA;
 	tf.device |= ATA_LBA;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
@@ -1297,7 +1297,7 @@ static int ata_set_max_sectors(struct ata_device *dev, u64 new_sectors)
 		tf.device |= (new_sectors >> 24) & 0xf;
 	}
 
-	tf.protocol |= ATA_PROT_NODATA;
+	tf.protocol = ATA_PROT_NODATA;
 	tf.device |= ATA_LBA;
 
 	tf.lbal = (new_sectors >> 0) & 0xff;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 61dc7a9..7832e55 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3177,7 +3177,7 @@ static void ata_eh_park_issue_cmd(struct ata_device *dev, int park)
 	}
 
 	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol |= ATA_PROT_NODATA;
+	tf.protocol = ATA_PROT_NODATA;
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	if (park && (err_mask || tf.lbal != 0xc4)) {
 		ata_dev_err(dev, "head unload failed!\n");
-- 
2.1.4

