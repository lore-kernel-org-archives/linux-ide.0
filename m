From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.8-rc libata fixes
Date: Tue, 10 Aug 2004 16:42:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040810204245.GA22865@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:24798 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267551AbUHJUmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Aug 2004 16:42:49 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Two main fixes here:
* the obvious-a-fix, move MMIO unmap after last usage
* update sata_nv, because we removed support for this hardware
  from drivers/ide.  If this doesn't go in, then support will have
  disappered on users.  Also, it fixes a few bugs in addition to the new
  support.

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.6

This will update the following files:

 drivers/scsi/libata-core.c |    4 
 drivers/scsi/sata_nv.c     |  316 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 251 insertions(+), 69 deletions(-)

through these ChangeSets:

<achew@nvidia.com> (04/08/10 1.1954)
   [libata] unmap MMIO region _after_ last possible usage

<achew@nvidia.com> (04/08/10 1.1953)
   [libata sata_nv] support for hardware, bug fixes

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-08-10 16:40:44 -04:00
+++ b/drivers/scsi/libata-core.c	2004-08-10 16:40:44 -04:00
@@ -3252,10 +3252,10 @@
 	}
 
 	free_irq(host_set->irq, host_set);
-	if (host_set->mmio_base)
-		iounmap(host_set->mmio_base);
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
+	if (host_set->mmio_base)
+		iounmap(host_set->mmio_base);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-08-10 16:40:44 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-08-10 16:40:44 -04:00
@@ -20,6 +20,11 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.02
+ *     - Added support for CK804 SATA controller.
+ *
+ *  0.01
+ *     - Initial revision.
  */
 
 #include <linux/config.h>
@@ -35,7 +40,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.01"
+#define DRV_VERSION			"0.02"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -46,6 +51,7 @@
 #define NV_PORT1_SCR_REG_OFFSET		0x40
 
 #define NV_INT_STATUS			0x10
+#define NV_INT_STATUS_CK804		0x440
 #define NV_INT_STATUS_PDEV_INT		0x01
 #define NV_INT_STATUS_PDEV_PM		0x02
 #define NV_INT_STATUS_PDEV_ADDED	0x04
@@ -62,6 +68,7 @@
 					NV_INT_STATUS_SDEV_HOTPLUG)
 
 #define NV_INT_ENABLE			0x11
+#define NV_INT_ENABLE_CK804		0x441
 #define NV_INT_ENABLE_PDEV_MASK		0x01
 #define NV_INT_ENABLE_PDEV_PM		0x02
 #define NV_INT_ENABLE_PDEV_ADDED	0x04
@@ -80,30 +87,86 @@
 #define NV_INT_CONFIG			0x12
 #define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
 
+// For PCI config register 20
+#define NV_MCP_SATA_CFG_20		0x50
+#define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
+static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug(struct ata_host_set *host_set);
+static void nv_check_hotplug(struct ata_host_set *host_set);
+static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set);
+
+enum nv_host_type
+{
+	NFORCE2,
+	NFORCE3,
+	CK804
+};
 
 static struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ 0, } /* terminate list */
 };
 
+#define NV_HOST_FLAGS_SCR_MMIO	0x00000001
+
+struct nv_host_desc
+{
+	enum nv_host_type	host_type;
+	unsigned long		host_flags;
+	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
+	void			(*disable_hotplug)(struct ata_host_set *host_set);
+	void			(*check_hotplug)(struct ata_host_set *host_set);
+
+};
+static struct nv_host_desc nv_device_tbl[] = {
+	{
+		.host_type	= NFORCE2,
+		.host_flags	= 0x00000000,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{
+		.host_type	= NFORCE3,
+		.host_flags	= 0x00000000,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{	.host_type	= CK804,
+		.host_flags	= NV_HOST_FLAGS_SCR_MMIO,
+		.enable_hotplug	= nv_enable_hotplug_ck804,
+		.disable_hotplug= nv_disable_hotplug_ck804,
+		.check_hotplug	= nv_check_hotplug_ck804,
+	},
+};
+
+struct nv_host
+{
+	struct nv_host_desc	*host_desc;
+};
+
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -158,11 +221,10 @@
 irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
+	struct nv_host *host = host_set->private_data;
 	unsigned int i;
 	unsigned int handled = 0;
 	unsigned long flags;
-	u8 intr_status;
-	u8 intr_enable;
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
@@ -178,35 +240,11 @@
 				handled += ata_host_intr(ap, qc);
 		}
 
-		intr_status = inb(ap->ioaddr.scr_addr + NV_INT_STATUS);
-		intr_enable = inb(ap->ioaddr.scr_addr + NV_INT_ENABLE);
-
-		// Clear interrupt status.
-		outb(0xff, ap->ioaddr.scr_addr + NV_INT_STATUS);
-
-		if (intr_status & NV_INT_STATUS_HOTPLUG) {
-			if (intr_status & NV_INT_STATUS_PDEV_ADDED) {
-				printk(KERN_WARNING "ata%u: "
-					"Primary device added\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_PDEV_REMOVED) {
-				printk(KERN_WARNING "ata%u: "
-					"Primary device removed\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_SDEV_ADDED) {
-				printk(KERN_WARNING "ata%u: "
-					"Secondary device added\n", ap->id);
-			}
-
-			if (intr_status & NV_INT_STATUS_SDEV_REMOVED) {
-				printk(KERN_WARNING "ata%u: "
-					"Secondary device removed\n", ap->id);
-			}
-		}
 	}
 
+	if (host->host_desc->check_hotplug)
+		host->host_desc->check_hotplug(host_set);
+
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
 	return IRQ_RETVAL(handled);
@@ -214,41 +252,48 @@
 
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	else
+		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	else
+		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
-	int i;
+	struct nv_host *host = host_set->private_data;
 
-	for (i=0; i<host_set->n_ports; i++) {
-		u8 intr_mask;
+	// Disable hotplug event interrupts.
+	if (host->host_desc->disable_hotplug)
+		host->host_desc->disable_hotplug(host_set);
 
-		// Disable hotplug event interrupts.
-		intr_mask = inb(host_set->ports[i]->ioaddr.scr_addr +
-				NV_INT_ENABLE);
-		intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
-		outb(intr_mask, host_set->ports[i]->ioaddr.scr_addr +
-				NV_INT_ENABLE);
-	}
+	kfree(host);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
+	struct nv_host *host;
 	struct ata_probe_ent *probe_ent = NULL;
-	int i;
 	int rc;
 
 	if (!printed_version++)
@@ -275,6 +320,14 @@
 		goto err_out_regions;
 	}
 
+	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+
+	host->host_desc = &nv_device_tbl[ent->driver_data];
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -284,6 +337,7 @@
 				ATA_FLAG_SATA_RESET |
 				ATA_FLAG_SRST |
 				ATA_FLAG_NO_LEGACY;
+
 	probe_ent->port_ops = &nv_ops;
 	probe_ent->n_ports = NV_PORTS;
 	probe_ent->irq = pdev->irq;
@@ -298,8 +352,6 @@
 		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
 	probe_ent->port[0].bmdma_addr =
 		pci_resource_start(pdev, 4) | NV_PORT0_BMDMA_REG_OFFSET;
-	probe_ent->port[0].scr_addr =
-		pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
 
 	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
 	ata_std_ports(&probe_ent->port[1]);
@@ -308,37 +360,167 @@
 		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
 	probe_ent->port[1].bmdma_addr =
 		pci_resource_start(pdev, 4) | NV_PORT1_BMDMA_REG_OFFSET;
-	probe_ent->port[1].scr_addr =
-		pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
 
-	pci_set_master(pdev);
+	probe_ent->private_data = host;
 
-	rc = ata_device_add(probe_ent);
-	if (rc != NV_PORTS)
-		goto err_out_regions;
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+		unsigned long base;
 
-	// Enable hotplug event interrupts.
-	for (i=0; i<probe_ent->n_ports; i++) {
-		u8 intr_mask;
+		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
+				pci_resource_len(pdev, 5));
+		if (probe_ent->mmio_base == NULL)
+			goto err_out_free_ent;
+
+		base = (unsigned long)probe_ent->mmio_base;
+
+		probe_ent->port[0].scr_addr =
+			base + NV_PORT0_SCR_REG_OFFSET;
+		probe_ent->port[1].scr_addr =
+			base + NV_PORT1_SCR_REG_OFFSET;
+	} else {
+
+		probe_ent->port[0].scr_addr =
+			pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
+		probe_ent->port[1].scr_addr =
+			pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
+	}
 
-		outb(NV_INT_STATUS_HOTPLUG, probe_ent->port[i].scr_addr +
-						NV_INT_STATUS);
+	pci_set_master(pdev);
 
-		intr_mask = inb(probe_ent->port[i].scr_addr + NV_INT_ENABLE);
-		intr_mask |= NV_INT_ENABLE_HOTPLUG;
-		outb(intr_mask, probe_ent->port[i].scr_addr + NV_INT_ENABLE);
-	}
+	// Enable hotplug event interrupts.
+	if (host->host_desc->enable_hotplug)
+		host->host_desc->enable_hotplug(probe_ent);
+
+	rc = ata_device_add(probe_ent);
+	if (rc != NV_PORTS)
+		goto err_out_free_ent;
 
 	kfree(probe_ent);
 
 	return 0;
 
+err_out_free_ent:
+	kfree(probe_ent);
+
 err_out_regions:
 	pci_release_regions(pdev);
 
 err_out:
 	pci_disable_device(pdev);
 	return rc;
+}
+
+static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
+{
+	u8 intr_mask;
+
+	outb(NV_INT_STATUS_HOTPLUG,
+		(unsigned long)probe_ent->mmio_base + NV_INT_STATUS);
+
+	intr_mask = inb((unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	intr_mask |= NV_INT_ENABLE_HOTPLUG;
+
+	outb(intr_mask, (unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+}
+
+static void nv_disable_hotplug(struct ata_host_set *host_set)
+{
+	u8 intr_mask;
+
+	intr_mask = inb((unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+
+	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+
+	outb(intr_mask, (unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+}
+
+static void nv_check_hotplug(struct ata_host_set *host_set)
+{
+	u8 intr_status;
+
+	intr_status = inb((unsigned long)host_set->mmio_base + NV_INT_STATUS);
+
+	// Clear interrupt status.
+	outb(0xff, (unsigned long)host_set->mmio_base + NV_INT_STATUS);
+
+	if (intr_status & NV_INT_STATUS_HOTPLUG) {
+		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device added\n");
+
+		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device removed\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device added\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device removed\n");
+	}
+}
+
+static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
+{
+	u8 intr_mask;
+	u8 regval;
+
+	pci_read_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, regval);
+
+	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
+
+	intr_mask = readb(probe_ent->mmio_base + NV_INT_ENABLE_CK804);
+	intr_mask |= NV_INT_ENABLE_HOTPLUG;
+
+	writeb(intr_mask, probe_ent->mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static void nv_disable_hotplug_ck804(struct ata_host_set *host_set)
+{
+	u8 intr_mask;
+	u8 regval;
+
+	intr_mask = readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
+
+	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+
+	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
+
+	pci_read_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, regval);
+}
+
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
+{
+	u8 intr_status;
+
+	intr_status = readb(host_set->mmio_base + NV_INT_STATUS_CK804);
+
+	// Clear interrupt status.
+	writeb(0xff, host_set->mmio_base + NV_INT_STATUS_CK804);
+
+	if (intr_status & NV_INT_STATUS_HOTPLUG) {
+		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device added\n");
+
+		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Primary device removed\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device added\n");
+
+		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
+			printk(KERN_WARNING "nv_sata: "
+				"Secondary device removed\n");
+	}
 }
 
 static int __init nv_init(void)
