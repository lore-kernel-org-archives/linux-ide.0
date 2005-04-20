From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Instability
Date: Wed, 20 Apr 2005 10:30:44 +0800
Message-ID: <4265BED4.5010504@tw.ibm.com>
References: <200504191650.11926.fhenkel@hpce.nec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060702000708000706030801"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:24555 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261295AbVDTCbK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 22:31:10 -0400
In-Reply-To: <200504191650.11926.fhenkel@hpce.nec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fhenkel@hpce.nec.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702000708000706030801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Frank Henkel wrote:
> 
> Dear Jeff,
> 
> we have a stability problem under x86_64 Linux using the 
> sata_sil driver for the SiI 3512A dual port SATA onboard
> controller (BIOS Version 4.3.47) of the MSI MS-9145 Dual 
> Opteron (So940) MoBo.
> 
> The proprietary drivers from SiI don't match our kernel
> versions, so we rely on the sata_sil alternative.
> 
> What Linux distros I have tested:
> 
> Distro		Kernel              sata_sil Version
> - -------------------------------------------------------
> SuSE 9.3 x86_64	2.6.11.4-20a-smp    0.8
> - -------------------------------------------------------
> Scientific Linux CERN 3.0.4
>                 2.4.21-27.0.2.EL.cernsmp
>                                     0.54
> - -------------------------------------------------------
> RHEL WS3 U4     2.4.X (server crashed before information 
>                        was saved)   
> - -------------------------------------------------------
> 
> The problem is, that I a lot of console messages like
> 
>     ata1: status=0x51 { DriveReady SeekComplete Error }
>     ata1: error=0x04 { DriveStatus Error }
> 
> appear when data is written to disk.  And, suddenly, I/O 
> errors are reported and the system hangs.  In the case of
> RHEL WS3 U4 I lost the complete installation, because 
> fsck couldn't catch up all errors in the FS.
> 
> Do you know problems with this specific SATA controller?
> Do you have a solution (2.4 kernel)?
> Can I help you with more information to enhance the driver?
> 

Hi Frank,

Since you are running x86-64, I guess the problem might be similar to
the sg_dma_len() problem seen on ppc64:

http://marc.theaimsgroup.com/?l=linux-ide&m=111113103410355&w=2

Could you please try the attached patch, thanks.

Albert

--------------060702000708000706030801
Content-Type: text/plain;
 name="sg_dma_len2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sg_dma_len2.diff"

--- linux-2.6.5-SLES9_SP2_BRANCH_20050418161416/drivers/scsi/libata-core.c.ori	2005-04-19 15:34:14.000000000 +0800
+++ linux-2.6.5-SLES9_SP2_BRANCH_20050418161416/drivers/scsi/libata-core.c	2005-04-19 16:39:25.000000000 +0800
@@ -1054,6 +1054,7 @@
 	}
 
 	qc->waiting = &wait;
+	qc->private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1065,7 +1066,6 @@
 	else
 		wait_for_completion(&wait);
 
-	status = ata_chk_status(ap);
 	if (status & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
@@ -1918,6 +1918,7 @@
 	struct ata_queued_cmd *qc;
 	int rc;
 	unsigned long flags;
+	u8 status;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -1932,6 +1933,7 @@
 	qc->tf.nsect = dev->xfer_mode;
 
 	qc->waiting = &wait;
+	qc->private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -2071,7 +2073,7 @@
 	sg = qc->sg;
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg_dma_len(sg) = buflen;
+	sg->length = buflen;
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2101,11 +2103,12 @@
 	dma_addr_t dma_address;
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
-				     sg_dma_len(sg), dir);
+				     sg->length, dir);
 	if (dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
+	sg_dma_len(sg) = sg->length;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
@@ -2310,7 +2313,7 @@
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2333,13 +2336,29 @@
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = (bytes+1) >> 1; /* pad to word boundary */
+		unsigned int i;
+
+		DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
+
+		memset(&pad_buf, 0, sizeof(pad_buf));
+		for (i = 0; i < words; i++) {
+			ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
+		}
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	} 
+
 	sg = &qc->sg[qc->cursg];
 
-next_page:
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -2347,18 +2366,25 @@
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	/* don't overrun current sg */
+	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		printk(KERN_WARNING "ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n", 
+		       ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
 	buf = kmap(page) + offset;
 
-	bytes -= count;
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg_dma_len(sg)) {
+	if (qc->cursg_ofs >= sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2370,9 +2396,9 @@
 
 	kunmap(page);
 
-	if (bytes) {
-		if (qc->cursg_ofs < sg_dma_len(sg))
-			goto next_page;
+	if (bytes > count) {
+		bytes -= count;
+
 		goto next_sg;
 	}
 }
@@ -2475,8 +2501,7 @@
 	assert(qc != NULL);
 
 	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
+	DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
@@ -2527,6 +2552,7 @@
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int rc;
+	u8 status;
 
 	DPRINTK("ATAPI request sense\n");
 
@@ -2552,6 +2578,7 @@
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->waiting = &wait;
+	qc->private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -2745,6 +2772,7 @@
 
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
+	*((u8*)qc->private_data) = drv_stat;
 	return 0;
 }
 

--------------060702000708000706030801--


