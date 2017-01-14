From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] libata: switch allocations for command emulation to GFP_ATOMIC
Date: Sat, 14 Jan 2017 17:50:02 +0100
Message-ID: <1484412602-11801-2-git-send-email-hch@lst.de>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdANRRT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2017 12:17:19 -0500
In-Reply-To: <1484412602-11801-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

->queuecommand may be called under a spinlock or inside a critical section,
so we need to use GFP_ATOMIC for them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixes a234f739 ("libata: switch to dynamic allocation instead of ata_scsi_rbuf")
---
 drivers/ata/libata-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4de273b..465fad1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2074,7 +2074,7 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 	struct scsi_cmnd *cmd = args->cmd;
 	u8 *buf;
 
-	buf = kzalloc(ATA_SCSI_RBUF_SIZE, GFP_NOIO);
+	buf = kzalloc(ATA_SCSI_RBUF_SIZE, GFP_ATOMIC);
 	if (!buf) {
 		ata_scsi_set_sense(args->dev, cmd, NOT_READY, 0x08, 0);
 		return;
@@ -3325,7 +3325,7 @@ static ssize_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
 	__le64 *buf;
 	u32 i = 0;
 
-	buf = kzalloc(cmd->device->sector_size, GFP_NOFS);
+	buf = kzalloc(cmd->device->sector_size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
@@ -3362,7 +3362,7 @@ static ssize_t ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba,
 	size_t r;
 	u16 *buf;
 
-	buf = kzalloc(cmd->device->sector_size, GFP_NOIO);
+	buf = kzalloc(cmd->device->sector_size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
-- 
2.1.4

