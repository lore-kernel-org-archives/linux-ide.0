From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: Re: [PATCH 2.6.9-libata1-dev 1/2] sata_promise: pdc20619 support
Date: Sat, 30 Oct 2004 17:03:41 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1099148621.3976.10.camel@server.lorenz.priv>
References: <1098489319.2992.48.camel@server.lorenz.priv>
	 <41838CB4.6090100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:52398 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261251AbUJ3PDo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 11:03:44 -0400
In-Reply-To: <41838CB4.6090100@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

> Can I ask you to do one further task on this patch:  split it up into 
> two patches:  1) rename s/sata/ata/ symbols, etc.  2) implement pdc20619 
> supports
sure, here comes patch one.

This patch is just s/sata/ata...

Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>

--- a/drivers/scsi/sata_promise.c	2004-10-30 16:31:01.000000000 +0200
+++ b/drivers/scsi/sata_promise.c	2004-10-30 16:44:04.000000000 +0200
@@ -73,7 +73,7 @@
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -87,7 +87,7 @@
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
-static Scsi_Host_Template pdc_sata_sht = {
+static Scsi_Host_Template pdc_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
@@ -106,7 +106,7 @@
 	.bios_param		= ata_std_bios_param,
 };
 
-static struct ata_port_operations pdc_sata_ops = {
+static struct ata_port_operations pdc_ata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
@@ -128,28 +128,28 @@
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
-		.sht		= &pdc_sata_sht,
+		.sht		= &pdc_ata_sht,
 		.host_flags	= /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
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
@@ -166,10 +166,10 @@
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
 
@@ -258,7 +258,7 @@
 	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
 	tmp = readb(mmio);
-	
+
 	if (tmp & 0x01)
 	{
 		ap->cbl = ATA_CBL_PATA40;
@@ -267,13 +267,13 @@
 	else
 		ap->cbl = ATA_CBL_PATA80;
 }
-		
+
 static void pdc_pata_phy_reset(struct ata_port *ap)
 {
 	pdc_pata_cbl_detect(ap);
 
 	ata_port_probe(ap);
-	
+
 	ata_bus_reset(ap);
 }
 
@@ -511,7 +511,7 @@
 }
 
 
-static void pdc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
 {
 	port->cmd_addr		= base;
 	port->data_addr		= base;
@@ -569,7 +569,7 @@
 	writel(tmp, mmio + PDC_SLEW_CTL);
 }
 
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
@@ -630,8 +630,8 @@
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
 
-	pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
-	pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
+	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
+	pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);
 
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
@@ -644,8 +644,8 @@
 	case board_20319:
        		probe_ent->n_ports = 4;
 
-		pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
@@ -659,15 +659,15 @@
 		if (!(tmp & 0x80))
 		{
 			probe_ent->n_ports = 3;
-			
-			pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+
+			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
 
 			probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;
-			
+
 			printk(KERN_INFO DRV_NAME " PATA port found\n");
 		}
 		else
-       			probe_ent->n_ports = 2;
+			probe_ent->n_ports = 2;
 		break;
 	default:
 		BUG();
@@ -695,22 +695,22 @@
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


