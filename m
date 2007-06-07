From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core/sff: Fix multiple assumptions about DMA
Date: Thu, 7 Jun 2007 16:19:15 +0100
Message-ID: <20070607161915.2dbe3511@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57156 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754286AbXFGPOG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 11:14:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

The ata IRQ ack functions are only used when debugging. Unfortunately
almost every controller that calls them can cause crashes in some
configurations as there are missing checks for bmdma presence.

In addition ata_port_start insists of installing DMA buffers and pad
buffers for controllers regardless. The SFF controllers actually need to
make that decision dynamically at controller setup time and all need the
same helper - so we add ata_sff_port_start. Future patches will switch
the SFF drivers to use this.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 14:45:37.000000000 +0100
@@ -6888,6 +6946,7 @@
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
+EXPORT_SYMBOL_GPL(ata_sff_port_start);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_do_set_mode);
 EXPORT_SYMBOL_GPL(ata_data_xfer);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-sff.c linux-2.6.22-rc4-mm2/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-sff.c	2007-06-07 14:25:57.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ata/libata-sff.c	2007-06-07 14:31:24.000000000 +0100
@@ -80,25 +80,25 @@
 u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
 {
 	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
-	u8 host_stat, post_stat, status;
+	u8 host_stat = 0, post_stat = 0, status;
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
 		if (ata_msg_err(ap))
 			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
-	/* get controller status; clear intr, err bits */
-	host_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	iowrite8(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		 ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
-	post_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	if (ap->ioaddr.bmdma_addr) {
+		/* get controller status; clear intr, err bits */
+		host_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		iowrite8(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+			 ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 
+		post_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	}
 	if (ata_msg_intr(ap))
 		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
 			__FUNCTION__,
 			host_stat, post_stat, status);
-
 	return status;
 }
 
@@ -516,6 +516,27 @@
 		ata_bmdma_stop(qc);
 }
 
+/**
+ *	ata_sff_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table if the device
+ *	is DMA capable SFF.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+int ata_sff_port_start(struct ata_port *ap)
+{
+	if (ap->ioaddr.bmdma_addr)
+		return ata_port_start(ap);
+	return 0;
+}
+
 #ifdef CONFIG_PCI
 
 static int ata_resources_present(struct pci_dev *pdev, int port)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/include/linux/libata.h linux-2.6.22-rc4-mm2/include/linux/libata.h
--- linux.vanilla-2.6.22-rc4-mm2/include/linux/libata.h	2007-06-07 14:26:10.000000000 +0100
+++ linux-2.6.22-rc4-mm2/include/linux/libata.h	2007-06-07 14:38:07.000000000 +0100
@@ -783,6 +786,7 @@
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
+extern int ata_sff_port_start (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance);
 extern void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
 			  unsigned int buflen, int write_data);
