Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC832ED34
	for <linux-ide@vger.kernel.org>; Wed,  1 Jul 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946024; cv=none; b=bUzDqxAsxIiVyLNv/gV9eu4n0QIN+XpABVu1jkemSecE+emt52bHfSmJXcz19R+lJITPf0Lrl3Fc/hz/o0eGgdJElMcu8QqXa1VthcqVdRFRjJ39wcJO36IwkLkoQQeXKj4abnpt8WQV2xUZZ8yeU7a6qL/LVe2VSYn79dFTfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946024; c=relaxed/simple;
	bh=ypgK8pcc45koWIMeftDvTa3xuIx/kPcwfRMzykeSZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlbWcI+hkmHvxOSoRBSidrLE+fxRWmpclax4tMgcrQ4vxp7dEvYE/1Mfsg+1/WOYSSHAQV5rlPCNgd8YEuYkI6XVtfJTmelBLEDZOTDPi7RwCuz6eyIVK5hu5bbYP9nc0b7U9rVs88xS9II18wfFpsEDSjkc3494gfxI/sp82jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn0WzKKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn0WzKKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3171F000E9;
	Wed,  1 Jul 2026 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782946022;
	bh=qcQCJHHRhnkOQUdz0GXbCHvthYTeySbeNh/TerF4yKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kn0WzKKuJrDNjNC3CLvKexGaCNbwHp6J4dEoYrikN5kaUOgLN/RwO7YvJB+yCL9h9
	 +y+40H3WxD4zBluhpfMZjF9AEBBq5ajtiJM1qSFzvhiiHlsBxlcar2WYcUqfDyeQRq
	 9VutMF3gpP7+7m3EoRNFpV5A+3g0aGUAxy20GOZn+qieW5IMEnwAuP3CdcQkUoArqP
	 g49VRqPnJ8wLdqX+r4R183kUTtK4VtTS2TJG4496aanaehcyKOeJ+sShXN948GQyLH
	 6KyzgowaLzblkOW1lWl9P9FAxQQ4mGKKg5QVADK7EfhipzII2ZNPmJ8k8F+dZidka5
	 OHF1s10Z7j7qA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Shaun Tancheff <shaun@tancheff.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND
Date: Thu,  2 Jul 2026 00:46:41 +0200
Message-ID: <20260701224638.1835123-6-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701224638.1835123-4-cassel@kernel.org>
References: <20260701224638.1835123-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11096; i=cassel@kernel.org; h=from:subject; bh=ypgK8pcc45koWIMeftDvTa3xuIx/kPcwfRMzykeSZsY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJcZ5w/qdXIpHww1p3P8q2f9jtrzg/hNW3hSldfne2V2 9UR+PxwRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYis4Hhr/y3nVZxpkJ1fLs8 HiTMzS3Yebphcf+vj40hXbW/qiW//GH4X6j6Nd1xReG/2iV7NTx1uzxOuMQearoUm7ZlQeLB+FR BVgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

DSM TRIM currently always emits a single 512-byte page of LBA Range Entries
(ATA_MAX_TRIM_RNUM == 64 ranges), regardless of how many pages the device
can accept in one DATA SET MANAGEMENT command.

The maximum is reported by MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word
105).  Honour it: size the TRIM descriptor as a whole number of 512-byte
pages, bounded by that limit and by the logical sector size (the WRITE SAME
data-out buffer is a single logical block).  Build and transfer only as
many pages as the request needs, and set the DSM COUNT field, qc->nbytes
and the maximum WRITE SAME length in the Block Limits VPD page accordingly.

Build the descriptor straight into the WRITE SAME data-out buffer using an
atomic sg_miter mapping, instead of staging it in the shared ata_scsi_rbuf
and copying it out.  This removes the global ata_scsi_rbuf_lock and a
memcpy from the TRIM path.

While commit 9379e6b8e0f9 ("libata: Safely overwrite attached page in WRITE
SAME xlat") replaced direct access to the data-out buffer with an
intermediate step that writes the entries in the ata_scsi_rbuf buffer, this
solution writes to the data-out buffer using sg_miter, which maps each
segment with kmap_atomic (SG_MITER_ATOMIC), so it's highmem- and
multi-segment-safe, and it's usable from the non-sleeping
command-submission path (unlike the page_address() access that
ata_scsi_rbuf originally replaced).

A 512-byte-sector device still uses a single page, so its behaviour is
unchanged.

Add ata_id_dsm_max_pages() to read IDENTIFY DEVICE word 105.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 132 ++++++++++++++++++++++++++------------
 include/linux/ata.h       |  13 ++++
 2 files changed, 104 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 429b03a08071..c0525b86755d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2198,6 +2198,36 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
 	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
+/**
+ * ata_dsm_trim_pages - maximum DSM TRIM payload for a device, in 512-byte pages
+ * @dev: ATA device the DATA SET MANAGEMENT TRIM command will be sent to
+ *
+ * A DATA SET MANAGEMENT TRIM payload is a list of 512-byte pages, each holding
+ * up to ATA_MAX_TRIM_RNUM (64) LBA Range Entries; the format is page-based and
+ * unrelated to the logical sector size.
+ *
+ * The logical sector size still bounds it, though: the descriptor is written
+ * directly into the WRITE SAME data-out buffer, which sd sizes to a single
+ * logical block, so it can hold at most sector_size / 512 pages.
+ *
+ * Return: the maximum number of 512-byte pages a single translated WRITE SAME
+ * command may send to @dev (never less than one), that is the smaller of:
+ *   - MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word 105), when the device
+ *     reports a non-zero limit; and
+ *   - the logical sector size expressed in 512-byte pages (see above).
+ */
+static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
+{
+	unsigned int sector_size = ata_id_logical_sector_size(dev->id);
+	unsigned int max_pages = ata_id_dsm_max_pages(dev->id);
+	unsigned int pages = sector_size / ATA_SECT_SIZE;
+
+	if (max_pages)
+		pages = min(pages, max_pages);
+
+	return pages;
+}
+
 /**
  *	ata_scsiop_inq_b0 - Simulate INQUIRY VPD page B0, Block Limits
  *	@dev: Target device.
@@ -2237,7 +2267,8 @@ static unsigned int ata_scsiop_inq_b0(struct ata_device *dev,
 	 * with the unmap bit set.
 	 */
 	if (ata_id_has_trim(dev->id)) {
-		u64 max_blocks = 65535 * ATA_MAX_TRIM_RNUM;
+		unsigned int max_pages = ata_dsm_trim_pages(dev);
+		u64 max_blocks = U16_MAX * max_pages * ATA_MAX_TRIM_RNUM;
 
 		if (dev->quirks & ATA_QUIRK_MAX_TRIM_128M)
 			max_blocks = 128 << (20 - SECTOR_SHIFT);
@@ -3426,14 +3457,14 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 /**
  * ata_format_dsm_trim_descr() - SATL Write Same to DSM Trim
  * @cmd: SCSI command being translated
- * @trmax: Maximum number of entries that will fit in sector_size bytes.
+ * @size: DSM TRIM payload size in bytes (a multiple of 512)
  * @sector: Starting sector
  * @count: Total Range of request in logical sectors
  *
  * Rewrite the WRITE SAME descriptor to be a DSM TRIM little-endian formatted
  * descriptor.
  *
- * Upto 64 entries of the format:
+ * The payload is a list of @size / 8 entries of the format:
  *   63:48 Range Length
  *   47:0  LBA
  *
@@ -3442,35 +3473,45 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
  *
  * NOTE: this is the same format as ADD LBA(S) TO NV CACHE PINNED SET
  *
- * Return: Number of bytes copied into sglist.
+ * The descriptor is written straight into the WRITE SAME data-out buffer;
+ * ata_dsm_trim_pages() guarantees @size does not exceed that buffer (one
+ * logical block). An atomic sg_miter mapping is used so this works from the
+ * command submission path and, unlike page_address(), copes with a high
+ * memory payload.
+ *
+ * Return: Number of bytes written into the data-out buffer.
  */
-static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
+static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, size_t size,
 					u64 sector, u32 count)
 {
-	size_t len = ATA_SECT_SIZE;
-	size_t r;
-	__le64 *buf;
-	u32 i = 0;
-	unsigned long flags;
+	struct sg_mapping_iter miter;
+	size_t offset = 0;
+
+	sg_miter_start(&miter, scsi_sglist(cmd), scsi_sg_count(cmd),
+		       SG_MITER_TO_SG | SG_MITER_ATOMIC);
+	while (offset < size && sg_miter_next(&miter)) {
+		__le64 *buf = miter.addr;
+		size_t chunk = min_t(size_t, miter.length, size - offset);
+		unsigned int n = chunk / sizeof(__le64);
+		unsigned int i;
 
-	BUILD_BUG_ON(ATA_SECT_SIZE > ATA_SCSI_RBUF_SIZE);
+		for (i = 0; i < n; i++) {
+			u64 entry = 0;
 
-	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
-	buf = ((void *)ata_scsi_rbuf);
-	memset(buf, 0, len);
-	while (i < trmax) {
-		u64 entry = sector |
-			((u64)(count > 0xffff ? 0xffff : count) << 48);
-		buf[i++] = __cpu_to_le64(entry);
-		if (count <= 0xffff)
-			break;
-		count -= 0xffff;
-		sector += 0xffff;
+			if (count) {
+				u32 rlen = min_t(u32, count, 0xffff);
+
+				entry = sector | ((u64)rlen << 48);
+				sector += rlen;
+				count -= rlen;
+			}
+			buf[i] = cpu_to_le64(entry);
+		}
+		offset += n * sizeof(__le64);
 	}
-	r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, len);
-	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
+	sg_miter_stop(&miter);
 
-	return r;
+	return offset;
 }
 
 /**
@@ -3490,10 +3531,11 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
+	unsigned int max_pages = ata_dsm_trim_pages(dev);
+	unsigned int n_pages;
+	size_t size;
 	u64 block;
 	u32 n_block;
-	const u32 trmax = ATA_MAX_TRIM_RNUM;
-	u32 size;
 	u16 fp;
 	u8 bp = 0xff;
 	u8 unmap = cdb[1] & 0x8;
@@ -3523,7 +3565,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 	/* If the request is too large the cmd is invalid */
-	if (n_block > 0xffff * trmax) {
+	if (n_block > U16_MAX * max_pages * ATA_MAX_TRIM_RNUM) {
 		fp = 2;
 		goto invalid_fld;
 	}
@@ -3536,31 +3578,39 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 
 	/*
-	 * The TRIM descriptor is a single 512-byte page, which is the maximum
-	 * WRITE SAME length advertised in the Block Limits VPD page. For DATA
-	 * SET MANAGEMENT TRIM the COUNT field (aka nsect) is the number of
-	 * 512-byte blocks to be transferred.
+	 * The DATA SET MANAGEMENT TRIM payload is a whole number of 512-byte
+	 * pages (each holding up to ATA_MAX_TRIM_RNUM LBA Range Entries),
+	 * independent of the logical sector size. Only use as many pages as
+	 * are needed to describe the request, capped at max_pages.
 	 */
-	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
-	if (size != ATA_SECT_SIZE)
+	n_pages = DIV_ROUND_UP(DIV_ROUND_UP(n_block, U16_MAX),
+			       ATA_MAX_TRIM_RNUM);
+	n_pages = clamp(n_pages, 1U, max_pages);
+	size = (size_t)n_pages * ATA_SECT_SIZE;
+
+	if (ata_format_dsm_trim_descr(scmd, size, block, n_block) != size)
 		goto invalid_param_len;
 
+	/*
+	 * For DATA SET MANAGEMENT TRIM the COUNT field (aka nsect) is the
+	 * number of 512-byte pages to be transferred.
+	 */
 	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
 		/* Newer devices support queued TRIM commands */
 		tf->protocol = ATA_PROT_NCQ;
 		tf->command = ATA_CMD_FPDMA_SEND;
 		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
 		tf->nsect = qc->hw_tag << 3;
-		tf->hob_feature = (size / 512) >> 8;
-		tf->feature = size / 512;
+		tf->hob_feature = n_pages >> 8;
+		tf->feature = n_pages;
 
 		tf->auxiliary = 1;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		tf->hob_feature = 0;
 		tf->feature = ATA_DSM_TRIM;
-		tf->hob_nsect = (size / 512) >> 8;
-		tf->nsect = size / 512;
+		tf->hob_nsect = n_pages >> 8;
+		tf->nsect = n_pages;
 		tf->command = ATA_CMD_DSM;
 	}
 
@@ -3569,9 +3619,9 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 
 	ata_qc_set_pc_nbytes(qc);
 	/*
-	 * The DSM TRIM payload is a single 512-byte page, which may be smaller
-	 * than the WRITE SAME data-out buffer (one logical block); only
-	 * transfer that page so the length matches the COUNT field.
+	 * The DSM TRIM payload (size) may be smaller than the WRITE SAME
+	 * data-out buffer (one logical block); only transfer the pages that
+	 * were actually built so the transfer length matches the COUNT field.
 	 */
 	qc->nbytes = size;
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 8fd48bcb2a46..d6361032a8af 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -75,6 +75,7 @@ enum {
 	ATA_ID_HW_CONFIG	= 93,
 	ATA_ID_SPG		= 98,
 	ATA_ID_LBA_CAPACITY_2	= 100,
+	ATA_ID_MAX_PAGES_PER_DSM	= 105,
 	ATA_ID_SECTOR_SIZE	= 106,
 	ATA_ID_WWN		= 108,
 	ATA_ID_LOGICAL_SECTOR_SIZE	= 117,	/* and 118 */
@@ -928,6 +929,18 @@ static inline bool ata_id_has_trim(const u16 *id)
 	return false;
 }
 
+static inline u16 ata_id_dsm_max_pages(const u16 *id)
+{
+	/*
+	 * IDENTIFY DEVICE word 105: MAX PAGES PER DSM COMMAND. Maximum number
+	 * of 512-byte pages of LBA Range Entries the device accepts in a
+	 * single DATA SET MANAGEMENT command. Zero means the device does not
+	 * report a limit. The field is reserved unless TRIM is supported, so
+	 * callers must gate on ata_id_has_trim().
+	 */
+	return id[ATA_ID_MAX_PAGES_PER_DSM];
+}
+
 static inline bool ata_id_has_zero_after_trim(const u16 *id)
 {
 	/* DSM supported, deterministic read, and read zero after trim set */
-- 
2.54.0

