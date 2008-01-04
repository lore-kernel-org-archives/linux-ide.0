From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc202xx_old: Further fixups
Date: Fri, 4 Jan 2008 00:08:49 +0000
Message-ID: <20080104000849.588592ea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38816 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756850AbYADAKm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 19:10:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Turns out distros always enabled burst mode and it is pretty essential so
do the same. Also sort out the post DMA mode restore properly.

My 20263 card now seems happy but needs some four drive tests done yet
(when I've persuaded the kernel not to hang in the edd boot code if I
plug them in ..)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.24-rc6-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2008-01-02 16:04:19.000000000 +0000
+++ linux-2.6.24-rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2008-01-02 16:13:14.000000000 +0000
@@ -214,8 +214,8 @@
 	/* Flip back to 33Mhz for PIO */
 	if (adev->dma_mode >= XFER_UDMA_2)
 		iowrite8(ioread8(clock) & ~sel66, clock);
-
 	ata_bmdma_stop(qc);
+	pdc202xx_set_piomode(ap, adev);
 }
 
 /**
@@ -232,6 +232,17 @@
 	adev->max_sectors = 256;
 }
 
+static int pdc2026x_port_start(struct ata_port *ap)
+{
+	void __iomem *bmdma = ap->ioaddr.bmdma_addr;
+	if (bmdma) {
+		/* Enable burst mode */
+		u8 burst = ioread8(bmdma + 0x1f);
+		iowrite8(burst | 0x01, bmdma + 0x1f);
+	}
+	return ata_sff_port_start(ap);
+}
+
 static struct scsi_host_template pdc202xx_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -312,7 +323,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_sff_port_start,
+	.port_start	= pdc2026x_port_start,
 };
 
 static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
