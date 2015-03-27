From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/9] libata: use READ_LOG_DMA_EXT
Date: Fri, 27 Mar 2015 16:46:30 +0100
Message-ID: <1427471198-62676-2-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41464 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbbC0Pqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2015 11:46:42 -0400
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>

If READ_LOG_DMA_EXT is supported we should try to use it for
reading the log pages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c | 9 +++++++--
 include/linux/ata.h     | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d2029a4..d35d7a7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1510,13 +1510,18 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
 
 	ata_tf_init(dev, &tf);
-	tf.command = ATA_CMD_READ_LOG_EXT;
+	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id)) {
+		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
+		tf.protocol = ATA_PROT_DMA;
+	} else {
+		tf.command = ATA_CMD_READ_LOG_EXT;
+		tf.protocol = ATA_PROT_PIO;
+	}
 	tf.lbal = log;
 	tf.lbam = page;
 	tf.nsect = sectors;
 	tf.hob_nsect = sectors >> 8;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_LBA48 | ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_PIO;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     buf, sectors * ATA_SECT_SIZE, 0);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1648026..681520f 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -696,6 +696,13 @@ static inline bool ata_id_wcache_enabled(const u16 *id)
 	return id[ATA_ID_CFS_ENABLE_1] & (1 << 5);
 }
 
+static inline bool ata_id_has_read_log_dma_ext(const u16 *id)
+{
+	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
+		return false;
+	return id[ATA_ID_COMMAND_SET_3] & (1 << 3);
+}
+
 /**
  *	ata_id_major_version	-	get ATA level of drive
  *	@id: Identify data
-- 
1.8.5.2

