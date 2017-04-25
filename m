From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] libata: reject passthrough WRITE SAME requests
Date: Tue, 25 Apr 2017 13:39:54 +0200
Message-ID: <20170425113954.23121-1-hch@lst.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The WRITE SAME to TRIM translation rewrites the DATA OUT buffer.  While
the SCSI code accomodates for this by passing a read-writable buffer
userspace applications don't cater for this behavior.  In fact it can
be used to rewrite e.g. a readonly file through mmap and should be
considered as a security fix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1ac70744ae7b..50f56d066936 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3462,6 +3462,14 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	if (unlikely(!dev->dma_mode))
 		goto invalid_opcode;
 
+	/*
+	 * We only allow sending this command through the block layer,
+	 * as it modifies the DATA OUT buffer, which would corrupt user
+	 * memory for SG_IO commands.
+	 */
+	if (unlikely(blk_rq_is_passthrough(scmd->request)))
+		goto invalid_opcode;
+
 	if (unlikely(scmd->cmd_len < 16)) {
 		fp = 15;
 		goto invalid_fld;
-- 
2.11.0
