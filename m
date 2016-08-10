From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v5 1/2] Use kmap_atomic when rewriting attached page
Date: Tue,  9 Aug 2016 20:00:28 -0500
Message-ID: <1470790829-3793-2-git-send-email-shaun@tancheff.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp81.mediacombb.net ([68.66.77.81]:49843 "EHLO
	dsmdc-mail-smtp.mcomdc.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932697AbcHJBB1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 21:01:27 -0400
In-Reply-To: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

The current SATL for WRITE_SAME does not protect against misaligned
pages. Additionally the associated page should also kmap'd when
being modified.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
 v5: Added prep patch to work with non-page aligned scatterlist pages
     and use kmap_atomic() to lock page during modification.

 drivers/ata/libata-scsi.c | 53 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/ata.h       | 26 -----------------------
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e207b33..a71067a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3282,16 +3282,60 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	return 1;
 }
 
+/**
+ * ata_format_dsm_trim_descr() - SATL Write Same to DSM Trim
+ * @sg: Scatter / Gather list attached to command.
+ * @num: Maximum number of entries (nominally 64).
+ * @sector: Starting sector
+ * @count: Total Range of request
+ *
+ * Rewrite the WRITE SAME descriptor to be a DSM TRIM little-endian formatted
+ * descriptor.
+ *
+ * Upto 64 entries of the format:
+ *   63:48 Range Length
+ *   47:0  LBA
+ *
+ *  Range Length of 0 is ignored.
+ *  LBA's should be sorted order and not overlap.
+ *
+ * NOTE: this is the same format as ADD LBA(S) TO NV CACHE PINNED SET
+ */
+static unsigned int ata_format_dsm_trim_descr(struct scatterlist *sg, u32 num,
+					      u64 sector, u32 count)
+{
+	void *ptr = kmap_atomic(sg_page(sg));
+	__le64 *buffer = ptr + sg->offset;
+	u32 i = 0, used_bytes;
+
+	while (i < num) {
+		u64 entry = sector |
+			((u64)(count > 0xffff ? 0xffff : count) << 48);
+		buffer[i++] = __cpu_to_le64(entry);
+		if (count <= 0xffff)
+			break;
+		count -= 0xffff;
+		sector += 0xffff;
+	}
+
+	used_bytes = ALIGN(i * 8, 512);
+	memset(buffer + i, 0, used_bytes - i * 8);
+
+	kunmap_atomic(ptr);
+	return used_bytes;
+}
+
 static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
+	struct scatterlist *sg;
 	u64 block;
 	u32 n_block;
+	const u32 trmax = ATA_MAX_TRIM_RNUM;
 	u32 size;
-	void *buf;
 	u16 fp;
 	u8 bp = 0xff;
 
@@ -3319,10 +3363,9 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	if (!scsi_sg_count(scmd))
 		goto invalid_param_len;
 
-	buf = page_address(sg_page(scsi_sglist(scmd)));
-
-	if (n_block <= 65535 * ATA_MAX_TRIM_RNUM) {
-		size = ata_set_lba_range_entries(buf, ATA_MAX_TRIM_RNUM, block, n_block);
+	sg = scsi_sglist(scmd);
+	if (n_block <= 0xffff * cmax) {
+		size = ata_format_dsm_trim_descr(sg, trmax, block, n_block);
 	} else {
 		fp = 2;
 		goto invalid_fld;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index adbc812..45a1d71 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -1071,32 +1071,6 @@ static inline void ata_id_to_hd_driveid(u16 *id)
 #endif
 }
 
-/*
- * Write LBA Range Entries to the buffer that will cover the extent from
- * sector to sector + count.  This is used for TRIM and for ADD LBA(S)
- * TO NV CACHE PINNED SET.
- */
-static inline unsigned ata_set_lba_range_entries(void *_buffer,
-		unsigned num, u64 sector, unsigned long count)
-{
-	__le64 *buffer = _buffer;
-	unsigned i = 0, used_bytes;
-
-	while (i < num) {
-		u64 entry = sector |
-			((u64)(count > 0xffff ? 0xffff : count) << 48);
-		buffer[i++] = __cpu_to_le64(entry);
-		if (count <= 0xffff)
-			break;
-		count -= 0xffff;
-		sector += 0xffff;
-	}
-
-	used_bytes = ALIGN(i * 8, 512);
-	memset(buffer + i, 0, used_bytes - i * 8);
-	return used_bytes;
-}
-
 static inline bool ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
-- 
2.8.1

