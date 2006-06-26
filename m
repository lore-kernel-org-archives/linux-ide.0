From: Tejun Heo <htejun@gmail.com>
Subject: Re: More information on ATI IXP failure in git9
Date: Mon, 26 Jun 2006 11:10:11 +0900
Message-ID: <20060626021011.GB21435@htj.dyndns.org>
References: <200606252359.27671.ak@suse.de> <449F1AEE.700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:3224 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965000AbWFZCJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 22:09:58 -0400
Received: by py-out-1112.google.com with SMTP id t32so1300682pyc
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 19:09:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <449F1AEE.700@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Andi Kleen <ak@suse.de>

On Sun, Jun 25, 2006 at 07:23:26PM -0400, Jeff Garzik wrote:
> Andi created a patch at my suggestion:
> http://one.firstfloor.org/~andi/sil-debug
> 
> and that got him mounting the device, but the EH was still giving him 
> much pain:
> http://one.firstfloor.org/~andi/sata-error-loop
> 
> It looks like some condition isn't getting ack'd...

Weird.  To me, it almost seems like BMDMA2 is lying about whether it
generated interrupt or not.  e.g. It's sharing IRQ w/ another device,
but when the other device raises interrupt, BMDMA2 says it generated
the IRQ.

Once frozen, new EH does pretty good job of clearing status and the
interrupts seem too sporadic to be unacked IRQ.

Andi, can you pleaes try the following patch?  It makes sata_sil print
more data on errors and disables SATA PHY IRQ.

Thanks.

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..cd96891 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -341,8 +341,11 @@ static void sil_scr_write (struct ata_po
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	u32 bmdma;
 	u8 status;
 
+	bmdma = readl(ap->host_set->mmio_base + sil_port[ap->port_no].bmdma);
+
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
 		u32 serror;
 
@@ -363,11 +366,18 @@ static void sil_host_intr(struct ata_por
 			ap->eh_info.serror |= serror;
 		}
 
+		ata_port_printk(ap, KERN_ERR,
+				"SIL freeze 1, bmdma=%x bmdma2=%x serr=%x\n",
+				bmdma, bmdma2, serror);
 		goto freeze;
 	}
 
-	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN)) {
+		ata_port_printk(ap, KERN_ERR,
+				"SIL freeze 2, bmdma=%x bmdma2=%x\n",
+				bmdma, bmdma2);
 		goto freeze;
+	}
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
@@ -398,13 +408,18 @@ static void sil_host_intr(struct ata_por
 	case HSM_ST:
 		break;
 	default:
+		ata_port_printk(ap, KERN_ERR, "SIL hsm 1, bmdma=%x bmdma2=%x\n",
+				bmdma, bmdma2);
 		goto err_hsm;
 	}
 
 	/* check main status, clearing INTRQ */
 	status = ata_chk_status(ap);
-	if (unlikely(status & ATA_BUSY))
+	if (unlikely(status & ATA_BUSY)) {
+		ata_port_printk(ap, KERN_ERR, "SIL hsm 2, bmdma=%x bmdma2=%x\n",
+				bmdma, bmdma2);
 		goto err_hsm;
+	}
 
 	/* ack bmdma irq events */
 	ata_bmdma_irq_clear(ap);
@@ -475,7 +490,7 @@ static void sil_thaw(struct ata_port *ap
 	ata_bmdma_irq_clear(ap);
 
 	/* turn on SATA IRQ */
-	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+	/*writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);*/
 
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
