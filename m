From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] libata: implement EH utility functions
Date: Mon, 3 Apr 2006 12:44:38 +0900
Message-ID: <11440358783523-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:36294 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932157AbWDCDon (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:43 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665767nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:43 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement two utility functions ata_err_string() and
atapi_eh_request_sense().  They will be used by EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

59bc14437422f5faeddf7c6a3a745738b0f51202
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index b5825b7..c4ef2dd 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -434,3 +434,95 @@ void ata_eh_qc_retry(struct ata_queued_c
 		scmd->retries--;
 	__ata_eh_qc_complete(qc);
 }
+
+/**
+ *	ata_err_string - convert err_mask to descriptive string
+ *	@err_mask: error mask to convert to string
+ *
+ *	Convert @err_mask to descriptive string.  Errors are
+ *	prioritized according to severity and only the most severe
+ *	error is reported.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Descriptive string for @err_mask
+ */
+static const char * ata_err_string(unsigned int err_mask)
+{
+	if (err_mask & AC_ERR_HOST_BUS)
+		return "host bus error";
+	if (err_mask & AC_ERR_ATA_BUS)
+		return "ATA bus error";
+	if (err_mask & AC_ERR_TIMEOUT)
+		return "timeout";
+	if (err_mask & AC_ERR_HSM)
+		return "host state machine violation";
+	if (err_mask & AC_ERR_SYSTEM)
+		return "host internal error";
+	if (err_mask & AC_ERR_MEDIA)
+		return "media error";
+	if (err_mask & AC_ERR_INVALID)
+		return "invalid argument error";
+	if (err_mask & AC_ERR_DEV)
+		return "unclassified device error";
+	return "unknown error";
+}
+
+/**
+ *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
+ *	@ap: port associated with device @dev
+ *	@dev: device to perform REQUEST_SENSE to
+ *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
+ *
+ *	Perform ATAPI REQUEST_SENSE after the device reported CHECK
+ *	SENSE.  This function is EH helper.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask on failure
+ */
+static unsigned int atapi_eh_request_sense(struct ata_port *ap,
+					   struct ata_device *dev,
+					   unsigned char *sense_buf)
+{
+	struct ata_taskfile tf;
+	u8 cdb[ATAPI_CDB_LEN];
+
+	DPRINTK("ATAPI request sense\n");
+
+	ata_tf_init(ap, &tf, dev->devno);
+
+	/* FIXME: is this needed? */
+	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
+
+	/* XXX: why tf_read here? */
+	ap->ops->tf_read(ap, &tf);
+
+	/* fill these in, for the case where they are -not- overwritten */
+	sense_buf[0] = 0x70;
+	sense_buf[2] = tf.feature >> 4;
+
+	memset(cdb, 0, ATAPI_CDB_LEN);
+	cdb[0] = REQUEST_SENSE;
+	cdb[4] = SCSI_SENSE_BUFFERSIZE;
+
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.command = ATA_CMD_PACKET;
+
+	/* is it pointless to prefer PIO for "safety reasons"? */
+	if (ap->flags & ATA_FLAG_PIO_DMA) {
+		tf.protocol = ATA_PROT_ATAPI_DMA;
+		tf.feature |= ATAPI_PKT_DMA;
+	} else {
+		tf.protocol = ATA_PROT_ATAPI;
+		tf.lbam = (8 * 1024) & 0xff;
+		tf.lbah = (8 * 1024) >> 8;
+	}
+
+	return ata_exec_internal(ap, dev, &tf, cdb, DMA_FROM_DEVICE,
+				 sense_buf, SCSI_SENSE_BUFFERSIZE);
+}
-- 
1.2.4


