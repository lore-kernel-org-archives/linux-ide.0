From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: take scmd->cmd_len into account when translating SCSI commands
Date: Sun, 17 Dec 2006 10:46:33 +0900
Message-ID: <20061217014633.GI5400@htj.dyndns.org>
References: <20061217014508.GG5400@htj.dyndns.org> <20061217014557.GH5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:16176 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbWLQBqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 20:46:45 -0500
Received: by an-out-0708.google.com with SMTP id b33so352008ana
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 17:46:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061217014557.GH5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Jens Axboe <jens.axboe@oracle.com>, Douglas Gilbert <dougg@torque.net>

libata depended on SCSI command to have the correct length when
tranlating it into an ATA command.  This generally worked for commands
issued by SCSI HLD but user could issue arbitrary broken command using
sg interface.

Also, when building ATAPI command, full command size was always
copied.  Because some ATAPI devices needs bytes after CDB cleared, if
upper layer doesn't clear bytes after CDB, such devices will
malfunction.  This necessiated recent clear-garbage-after-CDB fix in
sg interfaces.  However, scsi_execute() isn't fixed yet and HL-DT-ST
DVD-RAM GSA-H30N malfunctions on initialization commands issued from
SCSI.

This patch makes xlat functions always consider SCSI cmd_len.  Each
translation function checks for proper cmd_len and ATAPI translaation
clears bytes after CDB.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Douglas Gilbert <dougg@torque.net>
---
 drivers/ata/libata-scsi.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 307910b..836947d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -953,6 +953,9 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->tf;
 	const u8 *cdb = scmd->cmnd;
 
+	if (scmd->cmd_len < 5)
+		goto invalid_fld;
+
 	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
 	tf->protocol = ATA_PROT_NODATA;
 	if (cdb[1] & 0x1) {
@@ -1144,11 +1147,15 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (cdb[0] == VERIFY)
+	if (cdb[0] == VERIFY) {
+		if (scmd->cmd_len < 10)
+			goto invalid_fld;
 		scsi_10_lba_len(cdb, &block, &n_block);
-	else if (cdb[0] == VERIFY_16)
+	} else if (cdb[0] == VERIFY_16) {
+		if (scmd->cmd_len < 16)
+			goto invalid_fld;
 		scsi_16_lba_len(cdb, &block, &n_block);
-	else
+	} else
 		goto invalid_fld;
 
 	if (!n_block)
@@ -1271,12 +1278,16 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 	switch (cdb[0]) {
 	case READ_10:
 	case WRITE_10:
+		if (unlikely(scmd->cmd_len < 10))
+			goto invalid_fld;
 		scsi_10_lba_len(cdb, &block, &n_block);
 		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
+		if (unlikely(scmd->cmd_len < 6))
+			goto invalid_fld;
 		scsi_6_lba_len(cdb, &block, &n_block);
 
 		/* for 6-byte r/w commands, transfer length 0
@@ -1287,6 +1298,8 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 		break;
 	case READ_16:
 	case WRITE_16:
+		if (unlikely(scmd->cmd_len < 16))
+			goto invalid_fld;
 		scsi_16_lba_len(cdb, &block, &n_block);
 		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
@@ -2355,7 +2368,8 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scmd->cmnd, dev->cdb_len);
+	memset(qc->cdb, 0, dev->cdb_len);
+	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
@@ -2696,6 +2710,13 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 {
 	int rc = 0;
 
+	if (unlikely(!scmd->cmd_len)) {
+		ata_dev_printk(dev, KERN_WARNING, "WARNING: zero len CDB\n");
+		scmd->result = DID_ERROR << 16;
+		done(scmd);
+		return 0;
+	}
+
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
 							      scmd->cmnd[0]);
-- 
1.4.4.2

