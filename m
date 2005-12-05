From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: use ata_exec_internal()
Date: Mon, 5 Dec 2005 17:28:35 +0900
Message-ID: <20051205082835.GB3451@htj.dyndns.org>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:3227 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbVLEI2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 03:28:41 -0500
Received: by zproxy.gmail.com with SMTP id 13so741740nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2005 00:28:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <439341C2.5090205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

This patch converts all users of libata internal commands to use
ata_exec_internal().

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jeff, I made a mistake while posting the previous patch.  The subject
line should say [PATCH 1/4] not [PATCH 1/3].  Sorry.

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-05 17:07:14.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-05 17:08:25.000000000 +0900
@@ -1200,9 +1200,8 @@ static void ata_dev_identify(struct ata_
 	u16 tmp;
 	unsigned long xfer_modes;
 	unsigned int using_edd;
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
 	int rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1223,40 +1222,26 @@ static void ata_dev_identify(struct ata_
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->dma_dir = DMA_FROM_DEVICE;
-	qc->tf.protocol = ATA_PROT_PIO;
-	qc->nsect = 1;
-
 retry:
+	ata_tf_init(ap, &tf, device);
+
 	if (dev->class == ATA_DEV_ATA) {
-		qc->tf.command = ATA_CMD_ID_ATA;
+		tf.command = ATA_CMD_ID_ATA;
 		DPRINTK("do ATA identify\n");
 	} else {
-		qc->tf.command = ATA_CMD_ID_ATAPI;
+		tf.command = ATA_CMD_ID_ATAPI;
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	tf.protocol = ATA_PROT_PIO;
 
-	if (rc)
-		goto err_out;
-	else
-		ata_qc_wait_err(qc, &wait);
+	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
+				     dev->id, sizeof(dev->id));
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->ops->tf_read(ap, &qc->tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	if (err_mask) {
+		if (err_mask & ~AC_ERR_DEV)
+			goto err_out;
 
-	if (qc->tf.command & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1269,13 +1254,9 @@ retry:
 		 * to have this problem.
 		 */
 		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
-			u8 err = qc->tf.feature;
+			u8 err = tf.feature;
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
-				qc->cursg = 0;
-				qc->cursg_ofs = 0;
-				qc->cursect = 0;
-				qc->nsect = 1;
 				goto retry;
 			}
 		}
@@ -2388,34 +2369,23 @@ static int ata_choose_xfer_mode(const st
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
+	struct ata_taskfile tf;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	qc->tf.command = ATA_CMD_SET_FEATURES;
-	qc->tf.feature = SETFEATURES_XFER;
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_NODATA;
-	qc->tf.nsect = dev->xfer_mode;
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	ata_tf_init(ap, &tf, dev->devno);
+	tf.command = ATA_CMD_SET_FEATURES;
+	tf.feature = SETFEATURES_XFER;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = dev->xfer_mode;
 
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
+		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2430,41 +2400,25 @@ static void ata_dev_set_xfermode(struct 
 
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
-
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
+	struct ata_taskfile tf;
 
-	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->dma_dir = DMA_FROM_DEVICE;
+	ata_tf_init(ap, &tf, dev->devno);
 
 	if (dev->class == ATA_DEV_ATA) {
-		qc->tf.command = ATA_CMD_ID_ATA;
+		tf.command = ATA_CMD_ID_ATA;
 		DPRINTK("do ATA identify\n");
 	} else {
-		qc->tf.command = ATA_CMD_ID_ATAPI;
+		tf.command = ATA_CMD_ID_ATAPI;
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->tf.flags |= ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_PIO;
-	qc->nsect = 1;
+	tf.flags |= ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_PIO;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
+			      dev->id, sizeof(dev->id)))
 		goto err_out;
 
-	ata_qc_wait_err(qc, &wait);
-
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	ata_dump_id(dev);
@@ -2473,6 +2427,7 @@ static void ata_dev_reread_id(struct ata
 
 	return;
 err_out:
+	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2486,10 +2441,7 @@ err_out:
 
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
+	struct ata_taskfile tf;
 	u16 sectors = dev->id[6];
 	u16 heads   = dev->id[3];
 
@@ -2500,26 +2452,18 @@ static void ata_dev_init_params(struct a
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	qc->tf.command = ATA_CMD_INIT_DEV_PARAMS;
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_NODATA;
-	qc->tf.nsect = sectors;
-	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	ata_tf_init(ap, &tf, dev->devno);
+	tf.command = ATA_CMD_INIT_DEV_PARAMS;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = sectors;
+	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
+		printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }

