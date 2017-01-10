From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] libata: avoid global response buffer in atapi_qc_complete
Date: Tue, 10 Jan 2017 09:41:43 +0100
Message-ID: <1484037708-654-2-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJIl6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:41:58 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

We only need to look at 4 bytes of the inquiry response for ATAPI
devices.  Instead of using the global ata_scsi_rbuf just use a
a stack buffer.  Also factor the fixup into it's own little helper
function to make it more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1f863e7..031a77a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2873,6 +2873,26 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	DPRINTK("EXIT\n");
 }
 
+/*
+ * ATAPI devices typically report zero for their SCSI version, and sometimes
+ * deviate from the spec WRT response data format.  If SCSI version is
+ * reported as zero like normal, then we make the following fixups:
+ *   1) Fake MMC-5 version, to indicate to the Linux scsi midlayer this is a
+ *	modern device.
+ *   2) Ensure response data format / ATAPI information are always correct.
+ */
+static void atapi_fixup_inquiry(struct scsi_cmnd *cmd)
+{
+	u8 buf[4];
+
+	sg_copy_to_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, 4);
+	if (buf[2] == 0) {
+		buf[2] = 0x5;
+		buf[3] = 0x32;
+	}
+	sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, 4);
+}
+
 static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
@@ -2927,30 +2947,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		 */
 		ata_gen_passthru_sense(qc);
 	} else {
-		u8 *scsicmd = cmd->cmnd;
-
-		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
-			unsigned long flags;
-			u8 *buf;
-
-			buf = ata_scsi_rbuf_get(cmd, true, &flags);
-
-	/* ATAPI devices typically report zero for their SCSI version,
-	 * and sometimes deviate from the spec WRT response data
-	 * format.  If SCSI version is reported as zero like normal,
-	 * then we make the following fixups:  1) Fake MMC-5 version,
-	 * to indicate to the Linux scsi midlayer this is a modern
-	 * device.  2) Ensure response data format / ATAPI information
-	 * are always correct.
-	 */
-			if (buf[2] == 0) {
-				buf[2] = 0x5;
-				buf[3] = 0x32;
-			}
-
-			ata_scsi_rbuf_put(cmd, true, &flags);
-		}
-
+		if (cmd->cmnd[0] == INQUIRY && (cmd->cmnd[1] & 0x03) == 0)
+			atapi_fixup_inquiry(cmd);
 		cmd->result = SAM_STAT_GOOD;
 	}
 
-- 
2.1.4

