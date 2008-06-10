From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 1/2] libata-eh: update atapi_eh_request_sense()
 to take @dev instead of @qc
Date: Tue, 10 Jun 2008 18:28:05 +0900
Message-ID: <484E4925.30202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:48648 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYFJJ2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 05:28:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so793918rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 02:28:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Update atapi_eh_request_sense() to take @dev, @sense_buf and
@dfl_sense_key instead of taking @qc and extracting information from
it.  This change is to make the function more generic and allow it to
be called from other places.

While at it, make cdb initialization use initializer.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1238,6 +1238,7 @@ static int ata_eh_read_log_10h(struct at
  *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
  *	@dev: device to perform REQUEST_SENSE to
  *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
+ *	@dfl_sense_key: default sense key to use
  *
  *	Perform ATAPI REQUEST_SENSE after the device reported CHECK
  *	SENSE.  This function is EH helper.
@@ -1248,13 +1249,13 @@ static int ata_eh_read_log_10h(struct at
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure
  */
-static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
+static unsigned int atapi_eh_request_sense(struct ata_device *dev,
+					   u8 *sense_buf, u8 dfl_sense_key)
 {
-	struct ata_device *dev = qc->dev;
-	unsigned char *sense_buf = qc->scsicmd->sense_buffer;
+	u8 cdb[ATAPI_CDB_LEN] =
+		{ REQUEST_SENSE, 0, 0, 0, SCSI_SENSE_BUFFERSIZE, 0 };
 	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
-	u8 cdb[ATAPI_CDB_LEN];
 
 	DPRINTK("ATAPI request sense\n");
 
@@ -1265,15 +1266,11 @@ static unsigned int atapi_eh_request_sen
 	 * for the case where they are -not- overwritten
 	 */
 	sense_buf[0] = 0x70;
-	sense_buf[2] = qc->result_tf.feature >> 4;
+	sense_buf[2] = dfl_sense_key;
 
 	/* some devices time out if garbage left in tf */
 	ata_tf_init(dev, &tf);
 
-	memset(cdb, 0, ATAPI_CDB_LEN);
-	cdb[0] = REQUEST_SENSE;
-	cdb[4] = SCSI_SENSE_BUFFERSIZE;
-
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
@@ -1450,7 +1447,9 @@ static unsigned int ata_eh_analyze_tf(st
 
 	case ATA_DEV_ATAPI:
 		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
-			tmp = atapi_eh_request_sense(qc);
+			tmp = atapi_eh_request_sense(qc->dev,
+						qc->scsicmd->sense_buffer,
+						qc->result_tf.feature >> 4);
 			if (!tmp) {
 				/* ATA_QCFLAG_SENSE_VALID is used to
 				 * tell atapi_qc_complete() that sense
