From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Wed, 12 Nov 2008 17:15:58 +0900
Message-ID: <491A90BE.9030005@kernel.org>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030605000200060601020409"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49039 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYKLIQ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 03:16:28 -0500
In-Reply-To: <90e002e7b2d47cad80ff952a2a81f0e7@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Guntsche <mike@it-loops.com>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

This is a multi-part message in MIME format.
--------------030605000200060601020409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Michael Guntsche wrote:
> On Wed, 12 Nov 2008 11:34:19 +0900, Tejun Heo <tj@kernel.org> wrote:
> 
>> Looks like we screwed up phantom device detection somewhere.  Michael,
>> can you please apply the attached patch and report kernel boot log?
> 
> Here the relevant dmesg output
> 
> ata_piix 0000:00:07.1: version 2.12
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
> ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
> ata1: XXX devmask=3
> ata1.00: XXX sff_dev_classify present=1 hdiag=0 tf=01:00:00 class=1
> ata1.01: XXX sff_dev_classify present=2 hdiag=0 tf=01:00:00 class=1
> ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
> ata1.00: 66055248 sectors, multi 16: LBA
> ata1.00: configured for MWDMA2
> ata2: XXX devmask=1
> ata2.00: XXX sff_dev_classify present=1 hdiag=0 tf=01:14:eb class=3
> ata2.01: XXX sff_dev_classify present=0 hdiag=1 tf=ff:00:00 class=1
> ata2.01: XXX status=0x1 hdiag=1
> ata2.01: NODEV after polling detection
> ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
> ata2.00: configured for MWDMA2

Can you please test the attached patch?

Thanks.

-- 
tejun

--------------030605000200060601020409
Content-Type: text/x-patch;
 name="phantom-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="phantom-fix.patch"

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b47394..9859705 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1083,7 +1083,6 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 
 /**
  *	ata_sff_hsm_move - move the HSM to the next state.
- *	@ap: the target ata_port
  *	@qc: qc on going
  *	@status: current device status
  *	@in_wq: 1 if called from workqueue, 0 otherwise
@@ -1091,9 +1090,11 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
  *	RETURNS:
  *	1 when poll next status needed, 0 otherwise.
  */
-int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-		     u8 status, int in_wq)
+int ata_sff_hsm_move(struct ata_queued_cmd *qc, u8 status, int in_wq)
 {
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags = 0;
 	int poll_next;
@@ -1227,10 +1228,15 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				if (likely(status & (ATA_ERR | ATA_DF)))
+				if (likely(status & (ATA_ERR | ATA_DF))) {
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else {
+
+					if (!(ehc->sff_devmask &
+					      (1 << dev->devno)))
+						qc->err_mask |=
+							AC_ERR_NODEV_HINT;
+				} else {
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
@@ -1359,7 +1365,7 @@ fsm_start:
 	}
 
 	/* move the HSM */
-	poll_next = ata_sff_hsm_move(ap, qc, status, 1);
+	poll_next = ata_sff_hsm_move(qc, status, 1);
 
 	/* another command or interrupt handler
 	 * may be running at this point.
@@ -1593,7 +1599,7 @@ inline unsigned int ata_sff_host_intr(struct ata_port *ap,
 	/* ack bmdma irq events */
 	ap->ops->sff_irq_clear(ap);
 
-	ata_sff_hsm_move(ap, qc, status, 0);
+	ata_sff_hsm_move(qc, status, 0);
 
 	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
 				       qc->tf.protocol == ATAPI_PROT_DMA))
@@ -1969,25 +1975,26 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		      unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
-	unsigned int devmask = 0;
 	int rc;
 	u8 err;
 
 	DPRINTK("ENTER\n");
 
 	/* determine if device 0/1 are present */
+	ehc->sff_devmask = 0;
 	if (ata_devchk(ap, 0))
-		devmask |= (1 << 0);
+		ehc->sff_devmask |= (1 << 0);
 	if (slave_possible && ata_devchk(ap, 1))
-		devmask |= (1 << 1);
+		ehc->sff_devmask |= (1 << 1);
 
 	/* select device 0 again */
 	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
-	rc = ata_bus_softreset(ap, devmask, deadline);
+	DPRINTK("about to softreset, devmask=%x\n", ehc->sff_devmask);
+	rc = ata_bus_softreset(ap, ehc->sff_devmask, deadline);
 	/* if link is occupied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
 		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
@@ -1996,10 +2003,10 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 
 	/* determine by signature whether we have ATA or ATAPI devices */
 	classes[0] = ata_sff_dev_classify(&link->device[0],
-					  devmask & (1 << 0), &err);
+					  ehc->sff_devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
 		classes[1] = ata_sff_dev_classify(&link->device[1],
-						  devmask & (1 << 1), &err);
+					ehc->sff_devmask & (1 << 1), &err);
 
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 1266924..1458ce8 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1406,7 +1406,7 @@ static unsigned int bfin_ata_host_intr(struct ata_port *ap,
 	/* ack bmdma irq events */
 	ap->ops->sff_irq_clear(ap);
 
-	ata_sff_hsm_move(ap, qc, status, 0);
+	ata_sff_hsm_move(qc, status, 0);
 
 	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
 				       qc->tf.protocol == ATAPI_PROT_DMA))
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 031d7b7..061f471 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -413,7 +413,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	ata_sff_irq_clear(ap);
 
 	/* kick HSM in the ass */
-	ata_sff_hsm_move(ap, qc, status, 0);
+	ata_sff_hsm_move(qc, status, 0);
 
 	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
 		ata_ehi_push_desc(ehi, "BMDMA2 stat 0x%x", bmdma2);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 59b0f1c..0a14022 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -639,6 +639,9 @@ struct ata_eh_context {
 	u8			saved_xfer_mode[ATA_MAX_DEVICES];
 	/* timestamp for the last reset attempt or success */
 	unsigned long		last_reset;
+#ifdef CONFIG_ATA_SFF
+	unsigned int		sff_devmask;
+#endif
 };
 
 struct ata_acpi_drive
@@ -1511,8 +1514,7 @@ extern unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
 extern u8 ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
-extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			    u8 status, int in_wq);
+extern int ata_sff_hsm_move(struct ata_queued_cmd *qc, u8 status, int in_wq);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_host_intr(struct ata_port *ap,

--------------030605000200060601020409--
