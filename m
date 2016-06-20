From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] ata: fixup ATA_PROT_NODATA
Date: Mon, 20 Jun 2016 13:39:14 +0200
Message-ID: <1466422756-126637-5-git-send-email-hare@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35421 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbcFTLyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:12 -0400
In-Reply-To: <1466422756-126637-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

The taskfile protocol is a numeric value, and can not be ORed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-eh.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e798915..d200102 100644
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
1.8.5.6

