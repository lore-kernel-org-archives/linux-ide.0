From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata-ncq: update EH to handle NCQ
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <1147358683337-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:61795 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751804AbWEKOox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:53 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216442nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:53 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update EH to handle NCQ.  ata_eh_autopsy() is updated to call
ata_eh_analyze_ncq_error() which reads log page 10h on NCQ device
error and updates eh_context accordingly.  ata_eh_report() is updated
to report SActive.

---

 drivers/scsi/libata-eh.c |  171 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 163 insertions(+), 8 deletions(-)

a65e2e8c8ee789ed540ee0f10a05aa3b404cd05a
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 3b692f5..b6268b5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -691,6 +691,98 @@ static const char * ata_err_string(unsig
 }
 
 /**
+ *	ata_read_log_page - read a specific log page
+ *	@dev: target device
+ *	@page: page to read
+ *	@buf: buffer to store read page
+ *	@sectors: number of sectors to read
+ *
+ *	Read log page using READ_LOG_EXT command.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
+ */
+static unsigned int ata_read_log_page(struct ata_device *dev,
+				      u8 page, void *buf, unsigned int sectors)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	DPRINTK("read log page - page %d\n", page);
+
+	ata_tf_init(dev, &tf);
+	tf.command = ATA_CMD_READ_LOG_EXT;
+	tf.lbal = page;
+	tf.nsect = sectors;
+	tf.hob_nsect = sectors >> 8;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_LBA48 | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_PIO;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
+				     buf, sectors * ATA_SECT_SIZE);
+
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
+}
+
+/**
+ *	ata_eh_read_log_10h - Read log page 10h for NCQ error details
+ *	@dev: Device to read log page 10h from
+ *	@tag: Resulting tag of the failed command
+ *	@tf: Resulting taskfile registers of the failed command
+ *
+ *	Read log page 10h to obtain NCQ error details and clear error
+ *	condition.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_eh_read_log_10h(struct ata_device *dev,
+			       int *tag, struct ata_taskfile *tf)
+{
+	u8 *buf = dev->ap->sector_buf;
+	unsigned int err_mask;
+	u8 csum;
+	int i;
+
+	err_mask = ata_read_log_page(dev, ATA_LOG_SATA_NCQ, buf, 1);
+	if (err_mask)
+		return -EIO;
+
+	csum = 0;
+	for (i = 0; i < ATA_SECT_SIZE; i++)
+		csum += buf[i];
+	if (csum)
+		ata_dev_printk(dev, KERN_WARNING,
+			       "invalid checksum 0x%x on log page 10h\n", csum);
+
+	if (buf[0] & 0x80)
+		return -ENOENT;
+
+	*tag = buf[0] & 0x1f;
+
+	tf->command = buf[2];
+	tf->feature = buf[3];
+	tf->lbal = buf[4];
+	tf->lbam = buf[5];
+	tf->lbah = buf[6];
+	tf->device = buf[7];
+	tf->hob_lbal = buf[8];
+	tf->hob_lbam = buf[9];
+	tf->hob_lbah = buf[10];
+	tf->nsect = buf[12];
+	tf->hob_nsect = buf[13];
+
+	return 0;
+}
+
+/**
  *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
  *	@dev: device to perform REQUEST_SENSE to
  *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
@@ -789,6 +881,66 @@ static void ata_eh_analyze_serror(struct
 }
 
 /**
+ *	ata_eh_analyze_ncq_error - analyze NCQ error
+ *	@ap: ATA port to analyze NCQ error for
+ *
+ *	Read log page 10h, determine the offending qc and acquire
+ *	error status TF.  For NCQ device errors, all LLDDs have to do
+ *	is setting AC_ERR_DEV in ehi->err_mask.  This function takes
+ *	care of the rest.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_analyze_ncq_error(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_device *dev = ap->device;
+	struct ata_queued_cmd *qc;
+	struct ata_taskfile tf;
+	int tag, rc;
+
+	/* if frozen, we can't do much */
+	if (ap->flags & ATA_FLAG_FROZEN)
+		return;
+
+	/* is it NCQ device error? */
+	if (!ap->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+		return;
+
+	/* has LLDD analyzed already? */
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		qc = __ata_qc_from_tag(ap, tag);
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+
+		if (qc->err_mask)
+			return;
+	}
+
+	/* okay, this error is ours */
+	rc = ata_eh_read_log_10h(dev, &tag, &tf);
+	if (rc) {
+		ata_port_printk(ap, KERN_ERR, "failed to read log page 10h "
+				"(errno=%d)\n", rc);
+		return;
+	}
+
+	if (!(ap->sactive & (1 << tag))) {
+		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
+				"inactive tag %d\n", tag);
+		return;
+	}
+
+	/* we've got the perpetrator, condemn it */
+	qc = __ata_qc_from_tag(ap, tag);
+	memcpy(&qc->result_tf, &tf, sizeof(tf));
+	qc->err_mask |= AC_ERR_DEV;
+	ehc->i.err_mask &= ~AC_ERR_DEV;
+}
+
+/**
  *	ata_eh_analyze_tf - analyze taskfile of a failed qc
  *	@qc: qc to analyze
  *	@tf: Taskfile registers to analyze
@@ -1005,6 +1157,9 @@ static void ata_eh_autopsy(struct ata_po
 	} else if (rc != -EOPNOTSUPP)
 		action |= ATA_EH_HARDRESET;
 
+	/* analyze NCQ failure */
+	ata_eh_analyze_ncq_error(ap);
+
 	/* any real error trumps AC_ERR_OTHER */
 	if (ehc->i.err_mask & ~AC_ERR_OTHER)
 		ehc->i.err_mask &= ~AC_ERR_OTHER;
@@ -1099,17 +1254,17 @@ static void ata_eh_report(struct ata_por
 		frozen = " frozen";
 
 	if (ehc->i.dev) {
-		ata_dev_printk(ehc->i.dev, KERN_ERR,
-			       "exception Emask 0x%x SErr 0x%x action 0x%x%s\n",
-			       ehc->i.err_mask, ehc->i.serror, ehc->i.action,
-			       frozen);
+		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
+			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
+			       ehc->i.err_mask, ap->sactive, ehc->i.serror,
+			       ehc->i.action, frozen);
 		if (desc)
 			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
 	} else {
-		ata_port_printk(ap, KERN_ERR,
-				"exception Emask 0x%x SErr 0x%x action 0x%x%s\n",
-				ehc->i.err_mask, ehc->i.serror, ehc->i.action,
-				frozen);
+		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
+				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
+				ehc->i.err_mask, ap->sactive, ehc->i.serror,
+				ehc->i.action, frozen);
 		if (desc)
 			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
 	}
-- 
1.2.4


