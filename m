From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v5 2/2] Add support for SCT Write Same
Date: Tue,  9 Aug 2016 20:00:29 -0500
Message-ID: <1470790829-3793-3-git-send-email-shaun@tancheff.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>
List-Id: linux-ide@vger.kernel.org

SATA drives may support write same via SCT. This is useful
for setting the drive contents to a specific pattern (0's).

Translate a SCSI WRITE SAME command to be either a DSM TRIM command or
an SCT Write Same command.

Based on the UNMAP flag:
  - When set translate to DSM TRIM
  - When not set translate to SCT Write Same

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
v5:
 - Addressed review comments
 - Report support for ZBC only for zoned devices.
 - kmap page during rewrite
 - Fix unmap set to require trim or error, if not unmap then sct write
   same or error.
v4:
 - Added partial MAINTENANCE_IN opcode simulation
 - Dropped all changes in drivers/scsi/*
 - Changed to honor the UNMAP flag -> TRIM, no UNMAP -> SCT.
v3:
 - Demux UNMAP/TRIM from WRITE SAME
v2:
 - Remove fugly ata hacking from sd.c
---
 drivers/ata/libata-scsi.c | 189 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/ata.h       |  43 +++++++++++
 2 files changed, 205 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a71067a..99b0e6c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1159,8 +1159,6 @@ static void ata_scsi_sdev_config(struct scsi_device *sdev)
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
-	sdev->no_report_opcodes = 1;
-	sdev->no_write_same = 1;
 
 	/* Schedule policy is determined by ->qc_defer() callback and
 	 * it needs to see every deferred qc.  Set dev_blocked to 1 to
@@ -3325,6 +3323,41 @@ static unsigned int ata_format_dsm_trim_descr(struct scatterlist *sg, u32 num,
 	return used_bytes;
 }
 
+/**
+ * ata_format_dsm_trim_descr() - SATL Write Same to ATA SCT Write Same
+ * @sg: Scatter / Gather list attached to command.
+ * @lba: Starting sector
+ * @num: Number of bytes to be zero'd.
+ *
+ * Rewrite the WRITE SAME descriptor to be an SCT Write Same formatted
+ * descriptor.
+ * NOTE: Writes a pattern (0's) in the foreground.
+ *       Large write-same requents can timeout.
+ */
+static void ata_format_sct_write_same(struct scatterlist *sg, u64 lba, u64 num)
+{
+	void *ptr = kmap_atomic(sg_page(sg));
+	u16 *sctpg = ptr + sg->offset;
+
+	put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
+	put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
+	put_unaligned_le64(lba,     &sctpg[2]);
+	put_unaligned_le64(num,     &sctpg[6]);
+	put_unaligned_le32(0u,      &sctpg[10]);
+
+	kunmap_atomic(ptr);
+}
+
+/**
+ * ata_scsi_write_same_xlat() - SATL Write Same to ATA SCT Write Same
+ * @qc: Command to be translated
+ *
+ * Translate a SCSI WRITE SAME command to be either a DSM TRIM command or
+ * an SCT Write Same command.
+ * Based on WRITE SAME has the UNMAP flag
+ *   When set translate to DSM TRIM
+ *   When clear translate to SCT Write Same
+ */
 static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
@@ -3338,6 +3371,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	u32 size;
 	u16 fp;
 	u8 bp = 0xff;
+	u8 unmap = cdb[1] & 0x8;
 
 	/* we may not issue DMA commands if no DMA mode is set */
 	if (unlikely(!dev->dma_mode))
@@ -3350,10 +3384,23 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	scsi_16_lba_len(cdb, &block, &n_block);
 
 	/* for now we only support WRITE SAME with the unmap bit set */
-	if (unlikely(!(cdb[1] & 0x8))) {
-		fp = 1;
-		bp = 3;
-		goto invalid_fld;
+	if (unmap) {
+		if ((dev->horkage & ATA_HORKAGE_NOTRIM) ||
+		    !ata_id_has_trim(dev->id)) {
+			fp = 1;
+			bp = 3;
+			goto invalid_fld;
+		}
+		if (n_block > 0xffff * trmax) {
+			fp = 2;
+			goto invalid_fld;
+		}
+	} else {
+		if (!ata_id_sct_write_same(dev->id)) {
+			fp = 1;
+			bp = 3;
+			goto invalid_fld;
+		}
 	}
 
 	/*
@@ -3364,30 +3411,42 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 
 	sg = scsi_sglist(scmd);
-	if (n_block <= 0xffff * cmax) {
+	if (unmap) {
 		size = ata_format_dsm_trim_descr(sg, trmax, block, n_block);
+		if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
+			/* Newer devices support queued TRIM commands */
+			tf->protocol = ATA_PROT_NCQ;
+			tf->command = ATA_CMD_FPDMA_SEND;
+			tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
+			tf->nsect = qc->tag << 3;
+			tf->hob_feature = (size / 512) >> 8;
+			tf->feature = size / 512;
+
+			tf->auxiliary = 1;
+		} else {
+			tf->protocol = ATA_PROT_DMA;
+			tf->hob_feature = 0;
+			tf->feature = ATA_DSM_TRIM;
+			tf->hob_nsect = (size / 512) >> 8;
+			tf->nsect = size / 512;
+			tf->command = ATA_CMD_DSM;
+		}
 	} else {
-		fp = 2;
-		goto invalid_fld;
-	}
-
-	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
-		/* Newer devices support queued TRIM commands */
-		tf->protocol = ATA_PROT_NCQ;
-		tf->command = ATA_CMD_FPDMA_SEND;
-		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
-		tf->nsect = qc->tag << 3;
-		tf->hob_feature = (size / 512) >> 8;
-		tf->feature = size / 512;
+		ata_format_sct_write_same(sg, block, n_block);
 
-		tf->auxiliary = 1;
-	} else {
-		tf->protocol = ATA_PROT_DMA;
 		tf->hob_feature = 0;
-		tf->feature = ATA_DSM_TRIM;
-		tf->hob_nsect = (size / 512) >> 8;
-		tf->nsect = size / 512;
-		tf->command = ATA_CMD_DSM;
+		tf->feature = 0;
+		tf->hob_nsect = 0;
+		tf->nsect = 1;
+		tf->lbah = 0;
+		tf->lbam = 0;
+		tf->lbal = ATA_CMD_STANDBYNOW1;
+		tf->hob_lbah = 0;
+		tf->hob_lbam = 0;
+		tf->hob_lbal = 0;
+		tf->device = ATA_CMD_STANDBYNOW1;
+		tf->protocol = ATA_PROT_DMA;
+		tf->command = ATA_CMD_WRITE_LOG_DMA_EXT;
 	}
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
@@ -3411,6 +3470,76 @@ invalid_opcode:
 }
 
 /**
+ *	ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
+ *	@args: device MAINTENANCE_IN data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Yields a subset to satisfy scsi_report_opcode()
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
+{
+	struct ata_device *dev = args->dev;
+	u8 *cdb = args->cmd->cmnd;
+	u8 supported = 0;
+	unsigned int err = 0;
+
+	if (cdb[2] != 1) {
+		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
+		err = 2;
+		goto out;
+	}
+	switch (cdb[3]) {
+	case INQUIRY:
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+	case READ_CAPACITY:
+	case SERVICE_ACTION_IN_16:
+	case REPORT_LUNS:
+	case REQUEST_SENSE:
+	case SYNCHRONIZE_CACHE:
+	case REZERO_UNIT:
+	case SEEK_6:
+	case SEEK_10:
+	case TEST_UNIT_READY:
+	case SEND_DIAGNOSTIC:
+	case MAINTENANCE_IN:
+	case READ_6:
+	case READ_10:
+	case READ_16:
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_16:
+	case ATA_12:
+	case ATA_16:
+	case VERIFY:
+	case VERIFY_16:
+	case MODE_SELECT:
+	case MODE_SELECT_10:
+	case START_STOP:
+		supported = 3;
+		break;
+	case WRITE_SAME_16:
+		if (ata_id_sct_write_same(dev->id))
+			supported = 3;
+		break;
+	case ZBC_IN:
+	case ZBC_OUT:
+		if (ata_id_zoned_cap(dev->id) ||
+		    dev->class == ATA_DEV_ZAC)
+			supported = 3;
+		break;
+	default:
+		break;
+	}
+out:
+	rbuf[1] = supported; /* supported */
+	return err;
+}
+
+/**
  *	ata_scsi_report_zones_complete - convert ATA output
  *	@qc: command structure returning the data
  *
@@ -4190,6 +4319,13 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 			ata_scsi_invalid_field(dev, cmd, 1);
 		break;
 
+	case MAINTENANCE_IN:
+		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
+		else
+			ata_scsi_invalid_field(dev, cmd, 1);
+		break;
+
 	/* all other commands */
 	default:
 		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x20, 0x0);
@@ -4222,7 +4358,6 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		shost->max_lun = 1;
 		shost->max_channel = 1;
 		shost->max_cmd_len = 16;
-		shost->no_write_same = 1;
 
 		/* Schedule policy is determined by ->qc_defer()
 		 * callback and it needs to see every deferred qc.
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 45a1d71..fdb1803 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -105,6 +105,7 @@ enum {
 	ATA_ID_CFA_KEY_MGMT	= 162,
 	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_DATA_SET_MGMT	= 169,
+	ATA_ID_SCT_CMD_XPORT	= 206,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -789,6 +790,48 @@ static inline bool ata_id_sense_reporting_enabled(const u16 *id)
 }
 
 /**
+ *
+ * Word: 206 - SCT Command Transport
+ *    15:12 - Vendor Specific
+ *     11:6 - Reserved
+ *        5 - SCT Command Transport Data Tables supported
+ *        4 - SCT Command Transport Features Control supported
+ *        3 - SCT Command Transport Error Recovery Control supported
+ *        2 - SCT Command Transport Write Same supported
+ *        1 - SCT Command Transport Long Sector Access supported
+ *        0 - SCT Command Transport supported
+ */
+static inline bool ata_id_sct_data_tables(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 5) ? true : false;
+}
+
+static inline bool ata_id_sct_features_ctrl(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 4) ? true : false;
+}
+
+static inline bool ata_id_sct_error_recovery_ctrl(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 3) ? true : false;
+}
+
+static inline bool ata_id_sct_write_same(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 2) ? true : false;
+}
+
+static inline bool ata_id_sct_long_sector_access(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 1) ? true : false;
+}
+
+static inline bool ata_id_sct_supported(const u16 *id)
+{
+	return id[ATA_ID_SCT_CMD_XPORT] & (1 << 0) ? true : false;
+}
+
+/**
  *	ata_id_major_version	-	get ATA level of drive
  *	@id: Identify data
  *
-- 
2.8.1
