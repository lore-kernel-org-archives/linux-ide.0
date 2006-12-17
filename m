From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: clean up variable name usage in xlat related functions
Date: Sun, 17 Dec 2006 10:45:08 +0900
Message-ID: <20061217014508.GG5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:24212 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbWLQBpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 20:45:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1186091uga
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 17:45:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Variable names in xlat functions are quite confusing now.  'scsicmd'
is used for CDB while qc->scsicmd points to struct scsi_cmnd while
'cmd' is used for struct scsi_cmnd.

This patch cleans up variable names in xlat functions such that 'scmd'
is used for struct scsi_cmnd and 'cdb' for CDB.  Also, 'scmd' local
variable is added if qc->scsicmd is used multiple times.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Okay, separated as suggested and regenerated against
libata-dev#upstream-fixes.

Thanks.

 drivers/ata/libata-scsi.c |  217 ++++++++++++++++++++++-----------------------
 1 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a4790be..1e42cde 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -51,7 +51,7 @@
 
 #define SECTOR_SIZE	512
 
-typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
+typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *cdb);
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
@@ -935,7 +935,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Sets up an ATA taskfile to issue STANDBY (to stop) or READ VERIFY
  *	(to start). Perhaps these commands should be preceded by
@@ -948,22 +948,22 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
 static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
-					     const u8 *scsicmd)
+					     const u8 *cdb)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 
 	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
 	tf->protocol = ATA_PROT_NODATA;
-	if (scsicmd[1] & 0x1) {
+	if (cdb[1] & 0x1) {
 		;	/* ignore IMMED bit, violates sat-r05 */
 	}
-	if (scsicmd[4] & 0x2)
+	if (cdb[4] & 0x2)
 		goto invalid_fld;       /* LOEJ bit set not supported */
-	if (((scsicmd[4] >> 4) & 0xf) != 0)
+	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
-	if (scsicmd[4] & 0x1) {
+	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
@@ -996,7 +996,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 }
@@ -1005,7 +1005,7 @@ invalid_fld:
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate (ignored)
+ *	@cdb: SCSI command to translate (ignored)
  *
  *	Sets up an ATA taskfile to issue FLUSH CACHE or
  *	FLUSH CACHE EXT.
@@ -1016,8 +1016,7 @@ invalid_fld:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
 {
 	struct ata_taskfile *tf = &qc->tf;
 
@@ -1034,7 +1033,7 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
 
 /**
  *	scsi_6_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 6-byte commands.
  *
@@ -1042,18 +1041,17 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("six-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 8;
-	lba |= ((u64)scsicmd[3]);
+	lba |= ((u64)cdb[2]) << 8;
+	lba |= ((u64)cdb[3]);
 
-	len |= ((u32)scsicmd[4]);
+	len |= ((u32)cdb[4]);
 
 	*plba = lba;
 	*plen = len;
@@ -1061,7 +1059,7 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_10_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 10-byte commands.
  *
@@ -1069,21 +1067,20 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("ten-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 24;
-	lba |= ((u64)scsicmd[3]) << 16;
-	lba |= ((u64)scsicmd[4]) << 8;
-	lba |= ((u64)scsicmd[5]);
+	lba |= ((u64)cdb[2]) << 24;
+	lba |= ((u64)cdb[3]) << 16;
+	lba |= ((u64)cdb[4]) << 8;
+	lba |= ((u64)cdb[5]);
 
-	len |= ((u32)scsicmd[7]) << 8;
-	len |= ((u32)scsicmd[8]);
+	len |= ((u32)cdb[7]) << 8;
+	len |= ((u32)cdb[8]);
 
 	*plba = lba;
 	*plen = len;
@@ -1091,7 +1088,7 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_16_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 16-byte commands.
  *
@@ -1099,27 +1096,26 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("sixteen-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 56;
-	lba |= ((u64)scsicmd[3]) << 48;
-	lba |= ((u64)scsicmd[4]) << 40;
-	lba |= ((u64)scsicmd[5]) << 32;
-	lba |= ((u64)scsicmd[6]) << 24;
-	lba |= ((u64)scsicmd[7]) << 16;
-	lba |= ((u64)scsicmd[8]) << 8;
-	lba |= ((u64)scsicmd[9]);
+	lba |= ((u64)cdb[2]) << 56;
+	lba |= ((u64)cdb[3]) << 48;
+	lba |= ((u64)cdb[4]) << 40;
+	lba |= ((u64)cdb[5]) << 32;
+	lba |= ((u64)cdb[6]) << 24;
+	lba |= ((u64)cdb[7]) << 16;
+	lba |= ((u64)cdb[8]) << 8;
+	lba |= ((u64)cdb[9]);
 
-	len |= ((u32)scsicmd[10]) << 24;
-	len |= ((u32)scsicmd[11]) << 16;
-	len |= ((u32)scsicmd[12]) << 8;
-	len |= ((u32)scsicmd[13]);
+	len |= ((u32)cdb[10]) << 24;
+	len |= ((u32)cdb[11]) << 16;
+	len |= ((u32)cdb[12]) << 8;
+	len |= ((u32)cdb[13]);
 
 	*plba = lba;
 	*plen = len;
@@ -1128,7 +1124,7 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 /**
  *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
  *
@@ -1138,9 +1134,9 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
 	u64 dev_sectors = qc->dev->n_sectors;
@@ -1150,10 +1146,10 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *sc
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (scsicmd[0] == VERIFY)
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-	else if (scsicmd[0] == VERIFY_16)
-		scsi_16_lba_len(scsicmd, &block, &n_block);
+	if (cdb[0] == VERIFY)
+		scsi_10_lba_len(cdb, &block, &n_block);
+	else if (cdb[0] == VERIFY_16)
+		scsi_16_lba_len(cdb, &block, &n_block);
 	else
 		goto invalid_fld;
 
@@ -1229,24 +1225,24 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *sc
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Converts any of six SCSI read/write commands into the
  *	ATA counterpart, including starting sector (LBA),
@@ -1262,29 +1258,28 @@ nothing_to_do:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	unsigned int tf_flags = 0;
 	u64 block;
 	u32 n_block;
 	int rc;
 
-	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
-	    scsicmd[0] == WRITE_16)
+	if (cdb[0] == WRITE_10 || cdb[0] == WRITE_6 || cdb[0] == WRITE_16)
 		tf_flags |= ATA_TFLAG_WRITE;
 
 	/* Calculate the SCSI LBA, transfer length and FUA. */
-	switch (scsicmd[0]) {
+	switch (cdb[0]) {
 	case READ_10:
 	case WRITE_10:
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		scsi_10_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
-		scsi_6_lba_len(scsicmd, &block, &n_block);
+		scsi_6_lba_len(cdb, &block, &n_block);
 
 		/* for 6-byte r/w commands, transfer length 0
 		 * means 256 blocks of data, not 0 block.
@@ -1294,8 +1289,8 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 		break;
 	case READ_16:
 	case WRITE_16:
-		scsi_16_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		scsi_16_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	default:
@@ -1326,17 +1321,17 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 		goto out_of_range;
 	/* treat all other errors as -EINVAL, fall through */
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
@@ -1456,7 +1451,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
-	u8 *scsicmd = cmd->cmnd;
+	u8 *cdb = cmd->cmnd;
 	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
@@ -1488,7 +1483,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
-	if (xlat_func(qc, scsicmd))
+	if (xlat_func(qc, cdb))
 		goto early_finish;
 
 	/* select device, send command to hardware */
@@ -2344,7 +2339,7 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI CDB associated with this PACKET command
+ *	@cdb: SCSI CDB associated with this PACKET command
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
@@ -2352,25 +2347,24 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-
-static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
-	int nodata = (cmd->sc_data_direction == DMA_NONE);
+	int nodata = (scmd->sc_data_direction == DMA_NONE);
 
 	if (!using_pio)
 		/* Check whether ATAPI DMA is safe */
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scsicmd, dev->cdb_len);
+	memcpy(&qc->cdb, cdb, dev->cdb_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
 		DPRINTK("direction: write\n");
 	}
@@ -2392,12 +2386,12 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (cmd->sc_data_direction != DMA_TO_DEVICE))
+		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
 			/* some SATA bridges need us to indicate data xfer direction */
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	qc->nbytes = cmd->request_bufflen;
+	qc->nbytes = scmd->request_bufflen;
 
 	return 0;
 }
@@ -2517,28 +2511,27 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI command to convert
+ *	@cdb: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-static unsigned int
-ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *cdb)
 {
 	struct ata_taskfile *tf = &(qc->tf);
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 
-	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
+	if ((tf->protocol = ata_scsi_map_proto(cdb[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
 	/* We may not issue DMA commands if no DMA mode is set */
 	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
 		goto invalid_fld;
 
-	if (scsicmd[1] & 0xe0)
+	if (cdb[1] & 0xe0)
 		/* PIO multi not supported yet */
 		goto invalid_fld;
 
@@ -2546,18 +2539,18 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
 	 */
-	if (scsicmd[0] == ATA_16) {
+	if (cdb[0] == ATA_16) {
 		/*
 		 * 16-byte CDB - may contain extended commands.
 		 *
 		 * If that is the case, copy the upper byte register values.
 		 */
-		if (scsicmd[1] & 0x01) {
-			tf->hob_feature = scsicmd[3];
-			tf->hob_nsect = scsicmd[5];
-			tf->hob_lbal = scsicmd[7];
-			tf->hob_lbam = scsicmd[9];
-			tf->hob_lbah = scsicmd[11];
+		if (cdb[1] & 0x01) {
+			tf->hob_feature = cdb[3];
+			tf->hob_nsect = cdb[5];
+			tf->hob_lbal = cdb[7];
+			tf->hob_lbam = cdb[9];
+			tf->hob_lbah = cdb[11];
 			tf->flags |= ATA_TFLAG_LBA48;
 		} else
 			tf->flags &= ~ATA_TFLAG_LBA48;
@@ -2565,26 +2558,26 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		/*
 		 * Always copy low byte, device and command registers.
 		 */
-		tf->feature = scsicmd[4];
-		tf->nsect = scsicmd[6];
-		tf->lbal = scsicmd[8];
-		tf->lbam = scsicmd[10];
-		tf->lbah = scsicmd[12];
-		tf->device = scsicmd[13];
-		tf->command = scsicmd[14];
+		tf->feature = cdb[4];
+		tf->nsect = cdb[6];
+		tf->lbal = cdb[8];
+		tf->lbam = cdb[10];
+		tf->lbah = cdb[12];
+		tf->device = cdb[13];
+		tf->command = cdb[14];
 	} else {
 		/*
 		 * 12-byte CDB - incapable of extended commands.
 		 */
 		tf->flags &= ~ATA_TFLAG_LBA48;
 
-		tf->feature = scsicmd[3];
-		tf->nsect = scsicmd[4];
-		tf->lbal = scsicmd[5];
-		tf->lbam = scsicmd[6];
-		tf->lbah = scsicmd[7];
-		tf->device = scsicmd[8];
-		tf->command = scsicmd[9];
+		tf->feature = cdb[3];
+		tf->nsect = cdb[4];
+		tf->lbal = cdb[5];
+		tf->lbam = cdb[6];
+		tf->lbah = cdb[7];
+		tf->device = cdb[8];
+		tf->command = cdb[9];
 	}
 	/*
 	 * If slave is possible, enforce correct master/slave bit
@@ -2611,7 +2604,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 */
 	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
 
-	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+	if (scmd->sc_data_direction == DMA_TO_DEVICE)
 		tf->flags |= ATA_TFLAG_WRITE;
 
 	/*
@@ -2620,7 +2613,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = cmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
@@ -2628,7 +2621,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	return 0;
 
  invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x00);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x00);
 	/* "Invalid field in cdb" */
 	return 1;
 }
@@ -2701,7 +2694,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
+static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
@@ -2709,14 +2702,14 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
 
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
+							      scmd->cmnd[0]);
 
 		if (xlat_func)
-			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
+			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
 		else
-			ata_scsi_simulate(dev, cmd, done);
+			ata_scsi_simulate(dev, scmd, done);
 	} else
-		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
 
 	return rc;
 }
-- 
1.4.4.2

