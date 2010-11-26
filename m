From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Bigger discard payloads
Date: Thu, 25 Nov 2010 21:43:16 -0500
Message-ID: <yq1mxown6t7.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


I posted the first version of this patch a few months ago. Inspired by
the recent discussions I decided to take another stab at supporting TRIM
payloads bigger than 512 bytes.

Unfortunately the only drives I have readily available right now are
intel and they poop on payloads bigger than 512 bytes despite
advertising support for 4 KiB. So I can't really test this and I'm
throwing the patch out there for people that want to play with it...

The patch advertises the max reported by the device but in reality we
can't currently issue discards over 4GB due to a bio limitation.

-- 
Martin K. Petersen	Oracle Linux Engineering


diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 41fb691..f0130dc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -152,7 +152,8 @@ static ssize_t queue_discard_granularity_show(struct request_queue *q, char *pag
 
 static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(q->limits.max_discard_sectors << 9, page);
+	return sprintf(page, "%lu\n",
+		       (unsigned long)q->limits.max_discard_sectors << 9);
 }
 
 static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *page)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 66aa4be..5cabec1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2120,7 +2120,13 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	 * with the unmap bit set.
 	 */
 	if (ata_id_has_trim(args->id)) {
-		put_unaligned_be32(65535 * 512 / 8, &rbuf[20]);
+		unsigned int blocks;
+
+		/* Default to 1 if unspecified in word 105.  Cap at 1 page. */
+		blocks = clamp(ata_id_trim_range_blocks(args->id), 1U,
+			       (unsigned int)ATA_MAX_TRIM_BLOCKS);
+
+		put_unaligned_be32(65535 * 512 / 8 * blocks, &rbuf[20]);
 		put_unaligned_be32(1, &rbuf[28]);
 	}
 
@@ -3001,6 +3007,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	u64 block;
 	u32 n_block;
 	u32 size;
+	unsigned int range_blocks;
 	void *buf;
 
 	/* we may not issue DMA commands if no DMA mode is set */
@@ -3023,17 +3030,25 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 
 	buf = page_address(sg_page(scsi_sglist(scmd)));
-	size = ata_set_lba_range_entries(buf, 512, block, n_block);
+	size = ata_set_lba_range_entries(buf, ATA_MAX_TRIM_BYTES, block,
+					 n_block);
+	range_blocks = size / ATA_SECT_SIZE;
 
 	tf->protocol = ATA_PROT_DMA;
 	tf->hob_feature = 0;
 	tf->feature = ATA_DSM_TRIM;
-	tf->hob_nsect = (size / 512) >> 8;
-	tf->nsect = size / 512;
+	tf->hob_nsect = range_blocks >> 8;
+	tf->nsect = range_blocks;
 	tf->command = ATA_CMD_DSM;
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
 		     ATA_TFLAG_WRITE;
 
+	/*
+	 * If we end up using more than the 512 byte payload passed by
+	 * WRITE SAME we must adjust the transfer length.
+	 */
+	if (range_blocks > 1)
+		scmd->request->extra_len = (range_blocks - 1) * ATA_SECT_SIZE;
 	ata_qc_set_pc_nbytes(qc);
 
 	return 0;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9564961..59c56bb 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -456,7 +456,7 @@ static int scsi_setup_discard_cmnd(struct scsi_device *sdp, struct request *rq)
 		nr_sectors >>= 3;
 	}
 
-	rq->timeout = SD_TIMEOUT;
+	rq->timeout = SD_WS_UNMAP_TIMEOUT;
 
 	memset(rq->cmd, 0, rq->cmd_len);
 
@@ -2090,7 +2090,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 
 		if (lba_count)
 			q->limits.max_discard_sectors =
-				lba_count * sector_sz >> 9;
+				lba_count * (sector_sz >> 9);
 
 		granularity = get_unaligned_be32(&buffer[28]);
 
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 55488fa..872e574 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -20,6 +20,7 @@
 #define SD_TIMEOUT		(30 * HZ)
 #define SD_MOD_TIMEOUT		(75 * HZ)
 #define SD_FLUSH_TIMEOUT	(60 * HZ)
+#define SD_WS_UNMAP_TIMEOUT	(300 * HZ)
 
 /*
  * Number of allowed retries
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0c4929f..8d628f8 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -47,6 +47,8 @@ enum {
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 	ATA_MAX_SECTORS_TAPE	= 65535,
+	ATA_MAX_TRIM_BYTES	= PAGE_SIZE,
+	ATA_MAX_TRIM_BLOCKS	= ATA_MAX_TRIM_BYTES >> 9,
 
 	ATA_ID_WORDS		= 256,
 	ATA_ID_CONFIG		= 0,
@@ -88,6 +90,7 @@ enum {
 	ATA_ID_HW_CONFIG	= 93,
 	ATA_ID_SPG		= 98,
 	ATA_ID_LBA_CAPACITY_2	= 100,
+	ATA_ID_TRIM_RANGE_BLKS	= 105,
 	ATA_ID_SECTOR_SIZE	= 106,
 	ATA_ID_LOGICAL_SECTOR_SIZE	= 117,	/* and 118 */
 	ATA_ID_LAST_LUN		= 126,
@@ -861,6 +864,14 @@ static inline int ata_id_has_zero_after_trim(const u16 *id)
 	return 0;
 }
 
+static inline unsigned int ata_id_trim_range_blocks(const u16 *id)
+{
+	if (ata_id_has_trim(id))
+		return id[ATA_ID_TRIM_RANGE_BLKS];
+
+	return 0;
+}
+
 static inline int ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command
