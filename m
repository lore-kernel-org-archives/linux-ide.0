From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata-eh: implement EH utility functions
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633022148-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:12958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750935AbWDKNsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:24 -0400
Received: by wproxy.gmail.com with SMTP id i11so926523wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:24 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement two utility functions ata_err_string() and
atapi_eh_request_sense().  They will be used by EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

75a537b896e2e5c014503d310769ae6abb5d57d8
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 485ebaa..7ef2b78 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -466,3 +466,95 @@ void ata_eh_qc_retry(struct ata_queued_c
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


