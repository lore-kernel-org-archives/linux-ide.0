From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #1
Date: Thu, 13 May 2004 21:33:58 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A42206.8070405@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030205030900090006090804"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61649 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264352AbUENBeN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 21:34:13 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Pat LaVarre <p.lavarre@ieee.org>

This is a multi-part message in MIME format.
--------------030205030900090006090804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


While it was fresh on the brain, I messed around with it a bit.

Pat, I hope you don't take offense.  Working with you got me thinking 
about how to transform libata, which was very helpful.

There will probably be at least one more patch coming, fixing up the 
atapi protocol completion code.

	Jeff




--------------030205030900090006090804
Content-Type: text/plain;
 name="patch.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.1"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 20:35:48-04:00 jgarzik@redhat.com 
#   [libata] add new ->bmdma_setup hook
#   
#   In order to support some new taskfile protocols, particularly ATAPI,
#   the setup-and-start-DMA hook needs to be split into its component
#   pieces, 'setup' and 'start'.
#   
#   For PCI IDE-style controllers, most of the code is moved into the
#   'setup' portion, with the 'start' portion only flipping a single
#   bit in hardware.
# 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/ata_piix.c	Thu May 13 21:28:09 2004
@@ -136,6 +136,7 @@
 
 	.phy_reset		= piix_pata_phy_reset,
 
+	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
@@ -158,6 +159,7 @@
 
 	.phy_reset		= piix_sata_phy_reset,
 
+	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/libata-core.c	Thu May 13 21:28:09 2004
@@ -2445,6 +2445,7 @@
 
 	case ATA_PROT_DMA:
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* initiate bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 		break;
 
@@ -2465,14 +2466,14 @@
 }
 
 /**
- *	ata_bmdma_start_mmio -
- *	@qc:
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2496,8 +2497,24 @@
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	u8 dmactl;
 
 	/* start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
 	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
@@ -2514,14 +2531,14 @@
 }
 
 /**
- *	ata_bmdma_start_pio -
- *	@qc:
+ *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2544,8 +2561,23 @@
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
 
 	/* start host DMA transaction */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	outb(dmactl | ATA_DMA_START,
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
@@ -3475,7 +3507,9 @@
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_promise.c	Thu May 13 21:28:09 2004
@@ -74,6 +74,7 @@
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void pdc_dma_setup(struct ata_queued_cmd *qc);
 static void pdc_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
@@ -111,6 +112,7 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_phy_reset,
+	.bmdma_setup            = pdc_dma_setup,
 	.bmdma_start            = pdc_dma_start,
 	.fill_sg		= pdc_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -429,6 +431,12 @@
 	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
+}
+
+static void pdc_dma_setup(struct ata_queued_cmd *qc)
+{
+	/* nothing for now.  later, we will call standard
+	 * code in libata-core for ATAPI here */
 }
 
 static void pdc_dma_start(struct ata_queued_cmd *qc)
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_sil.c	Thu May 13 21:28:09 2004
@@ -129,6 +129,7 @@
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
 	.post_set_mode		= sil_post_set_mode,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_sis.c	Thu May 13 21:28:09 2004
@@ -98,6 +98,7 @@
 	.check_status		= ata_check_status_pio,
 	.exec_command		= ata_exec_command_pio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_svw.c	Thu May 13 21:28:09 2004
@@ -231,6 +231,7 @@
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_sx4.c	Thu May 13 21:28:09 2004
@@ -146,6 +146,7 @@
 
 
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void pdc20621_dma_setup(struct ata_queued_cmd *qc);
 static void pdc20621_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
@@ -197,6 +198,7 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_20621_phy_reset,
+	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
 	.fill_sg		= pdc20621_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -567,6 +569,12 @@
 #else
 static inline void pdc20621_dump_hdma(struct ata_queued_cmd *qc) { }
 #endif /* ATA_VERBOSE_DEBUG */
+
+static void pdc20621_dma_setup(struct ata_queued_cmd *qc)
+{
+	/* nothing for now.  later, we will call standard
+	 * code in libata-core for ATAPI here */
+}
 
 static void pdc20621_dma_start(struct ata_queued_cmd *qc)
 {
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_via.c	Thu May 13 21:28:09 2004
@@ -106,6 +106,7 @@
 
 	.phy_reset		= sata_phy_reset,
 
+	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	Thu May 13 21:28:09 2004
+++ b/drivers/scsi/sata_vsc.c	Thu May 13 21:28:09 2004
@@ -213,6 +213,7 @@
 	.exec_command		= ata_exec_command_mmio,
 	.check_status		= ata_check_status_mmio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Thu May 13 21:28:09 2004
+++ b/include/linux/libata.h	Thu May 13 21:28:09 2004
@@ -335,6 +335,7 @@
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 	void (*fill_sg) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
@@ -397,7 +398,9 @@
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, unsigned int done_late);

--------------030205030900090006090804--

