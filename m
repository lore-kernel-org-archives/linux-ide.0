From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: improve media error handling
Date: Tue, 14 Nov 2006 22:47:10 +0900
Message-ID: <11635120303772-git-send-email-htejun@gmail.com>
References: <1163512029469-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:334 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965786AbWKNNrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:47:17 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1175633wxc
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:47:16 -0800 (PST)
In-Reply-To: <1163512029469-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The ATA spec says "The amount of data transferred is indeterminate"
when READ/WRITE commands fail with error status.  TF regs contain the
address of the first sector which failed, but that's it.  libata
reports the reported sector to sd which assumes data upto the first
failed sector was transferred successfully.  This can result in data
corruption.

This patch implements highlevel command-aware recovery which currently
has only one recovery action - ata_eh_do_partial().  If the device
reports the first failed block, it tries to transfer upto that block.

SCSI sense generation is updated such that the first failed block is
reported to SCSI layer iff partial IO occurred.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c   |  143 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c |   36 +++++++-----
 include/linux/libata.h    |    2 +
 3 files changed, 166 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 104836e..0917423 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1873,6 +1873,144 @@ static int ata_eh_resume(struct ata_port
 	return 0;
 }
 
+/**
+ *	ata_eh_do_partial - perform partial IO after media error
+ *	@qc: target ATA command
+ *
+ *	The amount of succesfully transferred data is 'indeterminate'
+ *	after a device error.  This makes media error recovery
+ *	difficult for high level driver.  This function makes sure
+ *	data upto the first bad sector is successfully transferred.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_do_partial(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_taskfile tf;
+	u64 begin, bad;
+	struct scatterlist *sg;
+	unsigned int good_bytes, n_elem, idx, len, stored_len, err_mask;
+	int dma_dir, rc;
+
+	/* determine initial good blocks and dma_dir */
+	begin = ata_tf_read_block(&qc->tf, qc->dev);
+	bad = ata_tf_read_block(&qc->result_tf, qc->dev);
+
+	if (bad < begin || begin + qc->nsect <= bad) {
+		ata_dev_printk(dev, KERN_WARNING, "bogus bad block reported "
+			       "begin=%llu nsect=%u bad=%llu, assuming %llu\n",
+			       (unsigned long long)begin, qc->nsect,
+			       (unsigned long long)bad,
+			       (unsigned long long)begin + qc->nsect / 2);
+		return 0;
+	}
+
+	good_bytes = (bad - begin) << 9;
+
+	if (!good_bytes)
+		return 0;
+
+	dma_dir = DMA_FROM_DEVICE;
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		dma_dir = DMA_TO_DEVICE;
+
+	/* we're gonna reuse sglist, store & clear existing mapping */
+	sg = qc->__sg;
+	n_elem = qc->orig_n_elem;
+
+	if (qc->flags & ATA_QCFLAG_DMAMAP)
+		ata_sg_clean(qc);
+
+	/* find boundary sg */
+	len = 0;
+	for (idx = 0; idx < n_elem; idx++) {
+		if (len + sg[idx].length > good_bytes)
+			break;
+		len += sg[idx].length;
+	}
+	BUG_ON(idx >= n_elem);
+
+	/* build TF */
+	ata_tf_init(dev, &tf);
+	rc = ata_build_tf(&tf, dev, begin, good_bytes >> 9,
+			  qc->tf.flags & (ATA_TFLAG_WRITE | ATA_TFLAG_FUA),
+			  ATA_TAG_INTERNAL);
+	if (rc < 0) {
+		ata_dev_printk(dev, KERN_ERR, "failed to build TF for "
+			       "partial IO (rc=%d)\n", rc);
+		return rc;
+	}
+
+	/* temporarily trim sg and perform partial IO */
+	stored_len = sg[idx].length;
+	sg[idx].length = good_bytes - len;
+
+	err_mask = ata_exec_internal_sg(dev, &tf, NULL, dma_dir, sg, idx + 1);
+
+	sg[idx].length = stored_len;
+
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR,
+			       "partial IO failed (err_mask=0x%x)\n", err_mask);
+		return -EIO;
+	}
+
+	ehc->has_partial_mask |= 1 << dev->devno;
+	return 0;
+}
+
+/**
+ *	ata_eh_hl_recover - highlevel command-aware recovery
+ *	@ap: target host port
+ *	@r_failed_dev: result parameter to indicate failing device
+ *
+ *	Highlevel command-aware recovery.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_hl_recover(struct ata_port *ap,
+			     struct ata_device **r_failed_dev)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	int tag;
+
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+		struct ata_device *dev = qc->dev;
+		int rc;
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+
+		if (dev->class == ATA_DEV_ATA) {
+			if (!(ehc->did_partial_mask & (1 << dev->devno)) &&
+			    (qc->flags & ATA_QCFLAG_IO) &&
+			    (qc->err_mask & AC_ERR_MEDIA) &&
+			    !(qc->err_mask & ~(AC_ERR_MEDIA | AC_ERR_DEV))) {
+				ehc->did_partial_mask |= 1 << dev->devno;
+				rc = ata_eh_do_partial(qc);
+				if (rc) {
+					*r_failed_dev = dev;
+					return rc;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -2030,6 +2168,11 @@ static int ata_eh_recover(struct ata_por
 		ehc->i.flags &= ~ATA_EHI_SETMODE;
 	}
 
+	/* perform highlevel recovery */
+	rc = ata_eh_hl_recover(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	/* suspend devices */
 	rc = ata_eh_suspend(ap, &dev);
 	if (rc)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d1b96a..b73bec7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -754,13 +754,14 @@ static void ata_gen_passthru_sense(struc
  */
 static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
+	struct ata_eh_context *ehc = &ap->eh_context;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
 	int verbose = qc->ap->ops->error_handler == NULL;
-	u64 block;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -779,20 +780,25 @@ static void ata_gen_ata_sense(struct ata
 		sb[1] &= 0x0f;
 	}
 
-	block = ata_tf_read_block(&qc->result_tf, dev);
-
-	/* information sense data descriptor */
-	sb[7] = 12;
-	desc[0] = 0x00;
-	desc[1] = 10;
-
-	desc[2] |= 0x80;	/* valid */
-	desc[6] = block >> 40;
-	desc[7] = block >> 32;
-	desc[8] = block >> 24;
-	desc[9] = block >> 16;
-	desc[10] = block >> 8;
-	desc[11] = block;
+	/* If partial transfer occurred, tell upper layer how many
+	 * bytes are completed.
+	 */
+	if (ehc->has_partial_mask & (1 << dev->devno)) {
+		u64 block = ata_tf_read_block(&qc->result_tf, dev);
+
+		/* information sense data descriptor */
+		sb[7] = 12;
+		desc[0] = 0x00;
+		desc[1] = 10;
+
+		desc[2] |= 0x80;	/* valid */
+		desc[6] = block >> 40;
+		desc[7] = block >> 32;
+		desc[8] = block >> 24;
+		desc[9] = block >> 16;
+		desc[10] = block >> 8;
+		desc[11] = block;
+	}
 }
 
 static void ata_scsi_sdev_config(struct scsi_device *sdev)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0d0ddea..b485d00 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -527,6 +527,8 @@ struct ata_eh_context {
 	int			tries[ATA_MAX_DEVICES];
 	unsigned int		classes[ATA_MAX_DEVICES];
 	unsigned int		did_probe_mask;
+	unsigned int		did_partial_mask;
+	unsigned int		has_partial_mask;
 };
 
 struct ata_port {
-- 
1.4.3.3


