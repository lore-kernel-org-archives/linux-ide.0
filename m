From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: old rev of Sil 3112 causes hang
Date: Mon, 28 Feb 2005 16:39:32 -0500
Message-ID: <42238F94.2010402@pobox.com>
References: <d98308d552fc858dbbcd5fb9f34c9619@iomega.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030409000703070405010506"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22494 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261759AbVB1Vjv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 16:39:51 -0500
In-Reply-To: <d98308d552fc858dbbcd5fb9f34c9619@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030409000703070405010506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gary Poppitz wrote:
> Another tidbit to save somebody some time. We had a SiiG SC-SAT212 SATA 
> card that caused our system to hang. It uses the Silicon Image 3112.
> 
> Turns out it was sending interrupts back after a IDENTIFY_DEVICE command 
> which the driver ignored. This caused the irq to be shut off and then we 
> were hung.

Does this patch have any effect on the earlier rev card?

Overall, I think it is probably wise to simply update libata to avoid 
polling on SATA.

	Jeff



--------------030409000703070405010506
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.44 vs edited =====
--- 1.44/drivers/scsi/sata_sil.c	2005-02-17 19:43:51 -05:00
+++ edited/drivers/scsi/sata_sil.c	2005-02-23 21:27:18 -05:00
@@ -65,6 +65,7 @@
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_tf_load(struct ata_port *ap, struct ata_taskfile *tf);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -130,7 +131,7 @@
 static struct ata_port_operations sil_ops = {
 	.port_disable		= ata_port_disable,
 	.dev_config		= sil_dev_config,
-	.tf_load		= ata_tf_load,
+	.tf_load		= sil_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
@@ -197,6 +198,69 @@
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
+
+static void sil_irq_enable(struct ata_port *ap, int disable)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	u32 tmp, new;
+	u32 bit = 1 << (22 + ap->port_no);
+
+	tmp = readl(mmio + SIL_SYSCFG);
+	if (disable)
+		new = tmp | bit;
+	else
+		new = tmp & ~bit;
+	if (new != tmp)
+		writel(new, mmio + SIL_SYSCFG);
+}
+
+static void sil_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		sil_irq_enable(ap, tf->ctl & ATA_NIEN);
+		writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
 
 static void sil_post_set_mode (struct ata_port *ap)
 {

--------------030409000703070405010506--
