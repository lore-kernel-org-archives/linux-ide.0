From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v4] Add support for SCT Write Same
Date: Fri, 29 Jul 2016 13:01:16 -0500
Message-ID: <1469815276-18423-1-git-send-email-shaun@tancheff.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>
List-Id: linux-ide@vger.kernel.org

SATA drives may support write same via SCT. This is useful
for setting the drive contents to a specific pattern (0's).

If UNMAP is not set or TRIM is not available then
fall back to SCT WRITE SAME, if it is available.

In this way it would be possible to mimic lbprz for devices that
support TRIM but fail to zero blocks reliably. For example a
file-system or DM target could issue a write same w/o unmap followed
by an trim.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
At some point the method of issuing Write Same for ATA drives changed.
Currently write same is commonly available via SCT so expose the SCT
capabilities and use SCT Write Same when it is available.

This is useful for zoned based media that prefers to support discard
with lbprz set, aka discard zeroes data by mapping discard operations to
reset write pointer operations. Conventional zones that do not support
reset write pointer can still honor the discard zeroes data by issuing
a write same over the zone.

With this patch if UNMAP is set the TRIM support will follow the existing 
code path.
When UNMAP is not set and SCT WRITE SAME support is available the specified
blocks will be zero'd.

This patch is also at
https://github.com/stancheff/linux/tree/v4.7-sct.ws.v4

git@github.com:stancheff/linux.git v4.7-sct.ws.v4


v4:
 - Added partial MAINTENANCE_IN opcode simulation
 - Dropped all changes in drivers/scsi/*
 - Changed to honor the UNMAP flag -> TRIM, no UNMAP -> SCT.
v3:
 - Demux UNMAP/TRIM from WRITE SAME
v2:
 - Remove fugly ata hacking from sd.c
---
 drivers/ata/libata-scsi.c | 166 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/ata.h       |  43 ++++++++++++
 2 files changed, 187 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bfec66f..6c7a87e 100644
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
@@ -3267,11 +3265,20 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	return 1;
 }
 
+/**
+ *	ata_scsi_write_same_xlat - Handle WRITE_SAME commands
+ *
+ *	@qc: command structure
+ *
+ *	Translate WRITE_SAME w/UNMAP set to TRIM/discard request.
+ *	Otherwise use SCT WRITE SAME when available.
+ */
 static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
+	struct scatterlist *sg;
 	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
@@ -3279,6 +3286,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	void *buf;
 	u16 fp;
 	u8 bp = 0xff;
+	u8 unmap = cdb[1] & 0x8;
+	bool use_sct = unmap ? false : true;
 
 	/* we may not issue DMA commands if no DMA mode is set */
 	if (unlikely(!dev->dma_mode))
@@ -3290,8 +3299,10 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	}
 	scsi_16_lba_len(cdb, &block, &n_block);
 
-	/* for now we only support WRITE SAME with the unmap bit set */
-	if (unlikely(!(cdb[1] & 0x8))) {
+	/*
+	 * If UNMAP is not set and SCT write same is not available then fail.
+	 */
+	if (use_sct && !ata_id_sct_write_same(dev->id)) {
 		fp = 1;
 		bp = 3;
 		goto invalid_fld;
@@ -3304,26 +3315,56 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	if (!scsi_sg_count(scmd))
 		goto invalid_param_len;
 
-	buf = page_address(sg_page(scsi_sglist(scmd)));
-	size = ata_set_lba_range_entries(buf, 512, block, n_block);
+	sg = scsi_sglist(scmd);
+	buf = page_address(sg_page(sg)) + sg->offset;
 
-	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
-		/* Newer devices support queued TRIM commands */
-		tf->protocol = ATA_PROT_NCQ;
-		tf->command = ATA_CMD_FPDMA_SEND;
-		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
-		tf->nsect = qc->tag << 3;
-		tf->hob_feature = (size / 512) >> 8;
-		tf->feature = size / 512;
+	/*
+	 * if we only have SCT then ignore the state of unmap request
+	 * a zero the blocks.
+	 */
+	if (use_sct) {
+		u16 *sctpg = buf;
+
+		put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
+		put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
+		put_unaligned_le64(block,   &sctpg[2]);
+		put_unaligned_le64(n_block, &sctpg[6]);
+		put_unaligned_le32(0u,      &sctpg[10]);
 
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
+	} else {
+		size = ata_set_lba_range_entries(buf, 512, block, n_block);
+
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
 	}
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
@@ -3347,6 +3388,81 @@ invalid_opcode:
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
+	case FORMAT_UNIT:
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
+		supported = 3;
+		break;
+	case MAINTENANCE_IN:
+		supported = 3;
+		break;
+	case READ_6:
+	case READ_10:
+	case READ_16:
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_16:
+		supported = 3;
+		break;
+	case WRITE_SAME_16:
+		if (ata_id_sct_write_same(dev->id))
+			supported = 3;
+		break;
+	case ATA_12:
+	case ATA_16:
+	case VERIFY:
+	case VERIFY_16:
+	case MODE_SELECT:
+	case MODE_SELECT_10:
+	case START_STOP:
+		supported = 3;
+		break;
+	case ZBC_IN:
+	case ZBC_OUT:
+		supported = 3;
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
@@ -4131,6 +4247,13 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
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
@@ -4163,7 +4286,6 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		shost->max_lun = 1;
 		shost->max_channel = 1;
 		shost->max_cmd_len = 16;
-		shost->no_write_same = 1;
 
 		/* Schedule policy is determined by ->qc_defer()
 		 * callback and it needs to see every deferred qc.
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 99346be..4132de3 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -104,6 +104,7 @@ enum {
 	ATA_ID_CFA_KEY_MGMT	= 162,
 	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_DATA_SET_MGMT	= 169,
+	ATA_ID_SCT_CMD_XPORT	= 206,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -778,6 +779,48 @@ static inline bool ata_id_sense_reporting_enabled(const u16 *id)
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
