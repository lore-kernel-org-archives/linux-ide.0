From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: kill @cdb argument from xlat methods
Date: Sun, 17 Dec 2006 10:45:57 +0900
Message-ID: <20061217014557.GH5400@htj.dyndns.org>
References: <20061217014508.GG5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:46715 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbWLQBqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 20:46:06 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1549845nfa
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 17:46:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061217014508.GG5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

xlat function will be updated to consider qc->scsicmd->cmd_len and
many xlat functions deference qc->scsicmd already.  It doesn't make
sense to pass qc->scsicmd->cmnd as @cdb separately.  Kill the
argument.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1e42cde..307910b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -51,7 +51,7 @@
 
 #define SECTOR_SIZE	512
 
-typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *cdb);
+typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
@@ -935,7 +935,6 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
- *	@cdb: SCSI command to translate
  *
  *	Sets up an ATA taskfile to issue STANDBY (to stop) or READ VERIFY
  *	(to start). Perhaps these commands should be preceded by
@@ -948,11 +947,11 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
-					     const u8 *cdb)
+static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
+	const u8 *cdb = scmd->cmnd;
 
 	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
 	tf->protocol = ATA_PROT_NODATA;
@@ -1005,7 +1004,6 @@ invalid_fld:
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
- *	@cdb: SCSI command to translate (ignored)
  *
  *	Sets up an ATA taskfile to issue FLUSH CACHE or
  *	FLUSH CACHE EXT.
@@ -1016,7 +1014,7 @@ invalid_fld:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 
@@ -1124,7 +1122,6 @@ static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 /**
  *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@cdb: SCSI command to translate
  *
  *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
  *
@@ -1134,12 +1131,13 @@ static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
 	u64 dev_sectors = qc->dev->n_sectors;
+	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
 
@@ -1242,7 +1240,6 @@ nothing_to_do:
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@cdb: SCSI command to translate
  *
  *	Converts any of six SCSI read/write commands into the
  *	ATA counterpart, including starting sector (LBA),
@@ -1258,9 +1255,10 @@ nothing_to_do:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
+static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
+	const u8 *cdb = scmd->cmnd;
 	unsigned int tf_flags = 0;
 	u64 block;
 	u32 n_block;
@@ -1451,7 +1449,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
-	u8 *cdb = cmd->cmnd;
 	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
@@ -1483,7 +1480,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
-	if (xlat_func(qc, cdb))
+	if (xlat_func(qc))
 		goto early_finish;
 
 	/* select device, send command to hardware */
@@ -2339,7 +2336,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
- *	@cdb: SCSI CDB associated with this PACKET command
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
@@ -2347,7 +2343,7 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
@@ -2359,7 +2355,7 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *cdb)
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, cdb, dev->cdb_len);
+	memcpy(&qc->cdb, scmd->cmnd, dev->cdb_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
@@ -2511,18 +2507,18 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@cdb: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *cdb)
+static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &(qc->tf);
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
+	const u8 *cdb = scmd->cmnd;
 
 	if ((tf->protocol = ata_scsi_map_proto(cdb[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
-- 
1.4.4.2

