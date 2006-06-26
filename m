From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: disable hotplug interrupts on two ATI IXPs
Date: Mon, 26 Jun 2006 21:23:52 +0900
Message-ID: <20060626122352.GA10140@htj.dyndns.org>
References: <200606252359.27671.ak@suse.de> <200606260818.46672.ak@suse.de> <449F9D78.7070503@gmail.com> <200606261113.30316.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:59239 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWFZMXh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 08:23:37 -0400
Received: by wr-out-0506.google.com with SMTP id 57so40179wri
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 05:23:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200606261113.30316.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some SATA controllers embedded in ATI IXPs seem to have broken
SATA_IRQ bit in their bmdma2 registers which is always stuck at 1.
This makes the driver believe that there has been a hotplug event and
freeze the port whenever there's an interrupt thus failing all
commands.

This patch disables SATA_IRQ for those controllers.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Andi, can you please verify this patch works?  Jeff, if Andi confirms
it, please push this to Andrew & Linus.  I'll contact SIMG and try to
find another way around this.  Also, can somebody test 0x437a?

Thanks.

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..cd20b03 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -52,6 +52,7 @@ enum {
 	/*
 	 * host flags
 	 */
+	SIL_FLAG_NO_SATA_IRQ	= (1 << 28),
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
@@ -62,8 +63,9 @@ enum {
 	 * Controller IDs
 	 */
 	sil_3112		= 0,
-	sil_3512		= 1,
-	sil_3114		= 2,
+	sil_3112_no_sata_irq	= 1,
+	sil_3512		= 2,
+	sil_3114		= 3,
 
 	/*
 	 * Register offsets
@@ -123,8 +125,8 @@ static const struct pci_device_id sil_pc
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
 	{ }	/* terminate list */
 };
 
@@ -217,6 +219,16 @@ static const struct ata_port_info sil_po
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
+	/* sil_3112_no_sata_irq */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_MOD15WRITE |
+				  SIL_FLAG_NO_SATA_IRQ,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
+	},
 	/* sil_3512 */
 	{
 		.sht		= &sil_sht,
@@ -437,6 +449,10 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
+		/* turn off SATA_IRQ if not supported */
+		if (ap->flags & SIL_FLAG_NO_SATA_IRQ)
+			bmdma2 &= ~SIL_DMA_SATA_IRQ;
+
 		if (bmdma2 == 0xffffffff ||
 		    !(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
@@ -474,8 +490,9 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ata_bmdma_irq_clear(ap);
 
-	/* turn on SATA IRQ */
-	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+	/* turn on SATA IRQ if supported */
+	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
+		writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
 
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
