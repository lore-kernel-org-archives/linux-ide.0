From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata fixes
Date: Sat, 30 Oct 2004 20:18:58 -0400
Message-ID: <20041031001858.GA2446@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:49861 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261441AbUJaAXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 20:23:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Fix rather ugly (and/or embarrassing) bugs in AHCI.

Some random guy popped up at a random time to kill a bug I've been
searching for, for over a week...  :)

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c         |   38 +++++++++++++++++++++++++++-------
 drivers/scsi/sata_promise.c |   48 ++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 32 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/10/30 1.2349)
   [libata ahci] bump version to 1.00

<mmelchior@xs4all.nl> (04/10/30 1.2348)
   [libata ahci] fix rather serious (and/or embarassing) bugs
   
   - Add definition for SActive register
   - Add most interrupt sources to default interrupt mask
   - Write low 32 bits of FIS address to PxFB, where they belong
   - Set command active bit in PxSACT before setting command issue bit in PxCI
   - Announce Sub Class Code in driver info message [IDE, SATA or RAID]
   
   and additionally, from me [jgarzik]:
   - ignore ports-implemented bitmap for now; it's a write-only register
     that silly BIOSen initialize incorreclty
   
   Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<tobias.lorenz@gmx.net> (04/10/30 1.2347)
   [libata sata_promise] s/sata/ata/
   
   100% cosmetic:  rename various symbols with 'sata' in them to 'ata',
   in preparation for addition of support for a PATA controller.
   
   Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2004-10-30 20:16:29 -04:00
+++ b/drivers/scsi/ahci.c	2004-10-30 20:16:29 -04:00
@@ -38,7 +38,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"0.11"
+#define DRV_VERSION	"1.00"
 
 
 enum {
@@ -90,6 +90,7 @@
 	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
 	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
+	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -116,6 +117,9 @@
 				  PORT_IRQ_HBUS_DATA_ERR |
 				  PORT_IRQ_IF_ERR,
 	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
+				  PORT_IRQ_CONNECT | PORT_IRQ_SG_DONE |
+				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_FIS |
+				  PORT_IRQ_DMAS_FIS | PORT_IRQ_PIOS_FIS |
 				  PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
@@ -329,8 +333,8 @@
 
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
 
 	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
 	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
@@ -672,10 +676,13 @@
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *mmio = (void *) ap->ioaddr.cmd_addr;
+	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
+
+	writel(1, port_mmio + PORT_SCR_ACT);
+	readl(port_mmio + PORT_SCR_ACT);	/* flush */
 
-	writel(1, mmio + PORT_CMD_ISSUE);
-	readl(mmio + PORT_CMD_ISSUE);	/* flush */
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
 }
@@ -774,8 +781,10 @@
 	}
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
+#if 0 /* BIOSen initialize this incorrectly */
 		if (!(hpriv->port_map & (1 << i)))
 			continue;
+#endif
 
 		port_mmio = ahci_port_base(mmio, i);
 		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
@@ -856,6 +865,8 @@
 	void *mmio = probe_ent->mmio_base;
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
+	u16 cc;
+	const char *scc_s;
 
 	vers = readl(mmio + HOST_VERSION);
 	cap = hpriv->cap;
@@ -869,8 +880,18 @@
 	else
 		speed_s = "?";
 
+	pci_read_config_word(pdev, 0x0a, &cc);
+	if (cc == 0x0101)
+		scc_s = "IDE";
+	else if (cc == 0x0106)
+		scc_s = "SATA";
+	else if (cc == 0x0104)
+		scc_s = "RAID";
+	else
+		scc_s = "unknown";
+
 	printk(KERN_INFO DRV_NAME "(%s) AHCI %02x%02x.%02x%02x "
-		"%u slots %u ports %s Gbps 0x%x impl\n"
+		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
 	       	,
 	       	pci_name(pdev),
 
@@ -882,7 +903,8 @@
 		((cap >> 8) & 0x1f) + 1,
 		(cap & 0x1f) + 1,
 		speed_s,
-		impl);
+		impl,
+		scc_s);
 
 	printk(KERN_INFO DRV_NAME "(%s) flags: "
 	       	"%s%s%s%s%s%s"
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-10-30 20:16:29 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-10-30 20:16:29 -04:00
@@ -73,7 +73,7 @@
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -85,7 +85,7 @@
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
-static Scsi_Host_Template pdc_sata_sht = {
+static Scsi_Host_Template pdc_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
@@ -104,7 +104,7 @@
 	.bios_param		= ata_std_bios_param,
 };
 
-static struct ata_port_operations pdc_sata_ops = {
+static struct ata_port_operations pdc_ata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
@@ -126,28 +126,28 @@
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
-		.sht		= &pdc_sata_sht,
+		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_ata_ops,
 	},
 
 	/* board_20319 */
 	{
-		.sht		= &pdc_sata_sht,
+		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_ata_ops,
 	},
 };
 
-static struct pci_device_id pdc_sata_pci_tbl[] = {
+static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -164,10 +164,10 @@
 };
 
 
-static struct pci_driver pdc_sata_pci_driver = {
+static struct pci_driver pdc_ata_pci_driver = {
 	.name			= DRV_NAME,
-	.id_table		= pdc_sata_pci_tbl,
-	.probe			= pdc_sata_init_one,
+	.id_table		= pdc_ata_pci_tbl,
+	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
 };
 
@@ -481,7 +481,7 @@
 }
 
 
-static void pdc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
 {
 	port->cmd_addr		= base;
 	port->data_addr		= base;
@@ -539,7 +539,7 @@
 	writel(tmp, mmio + PDC_SLEW_CTL);
 }
 
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
@@ -599,8 +599,8 @@
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
 
-	pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
-	pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
+	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
+	pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);
 
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
@@ -610,8 +610,8 @@
 	case board_20319:
        		probe_ent->n_ports = 4;
 
-		pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
@@ -645,22 +645,22 @@
 }
 
 
-static int __init pdc_sata_init(void)
+static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_module_init(&pdc_ata_pci_driver);
 }
 
 
-static void __exit pdc_sata_exit(void)
+static void __exit pdc_ata_exit(void)
 {
-	pci_unregister_driver(&pdc_sata_pci_driver);
+	pci_unregister_driver(&pdc_ata_pci_driver);
 }
 
 
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, pdc_sata_pci_tbl);
+MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
 
-module_init(pdc_sata_init);
-module_exit(pdc_sata_exit);
+module_init(pdc_ata_init);
+module_exit(pdc_ata_exit);
