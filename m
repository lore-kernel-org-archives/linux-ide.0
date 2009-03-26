From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: [PATCH] Removing PCI dependency of ahci and making it amba bus
	compatible
Date: Thu, 26 Mar 2009 19:30:26 +0530
Message-ID: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:6413 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbZCZOA3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 10:00:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so660013rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 07:00:27 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Currently  ahci driver assumes that the SATA controller is hooked up
to the PCI. There are couple of devices like Synopsis Designware SATA
controller with ahci sits on AHB interface and not on PCI. This patch
is currently tied up to our platform and I have removed PCI dependent
calls from the the driver. I still have to make it bus independent.
Please review the patch and let me know if its fine.

All comments are welcome. Also please note that this is not
replacement of the existing ahci.c file I am going to create a new
file for ahci_ahb.c But for review, I have compared against ahci.c
Thanks


Signed-off-by: Sagar Borikar <sagar.borikar@gmail.com>
---

 drivers/ata/Kconfig       |   10 +
 drivers/ata/Makefile      |    2
 drivers/ata/ahci.c        |  412 ++++++++--------------------------------------
 drivers/ata/libata-core.c |   14 +
 include/linux/libata.h    |    2
 5 files changed, 97 insertions(+), 343 deletions(-)


--- drivers/ata/ahci.c.orig	2009-03-26 16:22:26.000000000 +0530
+++ drivers/ata/ahci.c	2009-03-26 17:13:29.000000000 +0530
@@ -34,7 +34,6 @@

 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
@@ -45,9 +44,15 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <asm/arch/socr_map.h>
+#include <asm/arch/peripherals/socr_sata.h>
+#include <linux/amba/bus.h>
+#include <asm/arch/irqs.h>

 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"3.0"
+#define DRV_VERSION	"4.0"
+
+static int amba_base;

 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
@@ -237,7 +242,7 @@ struct ahci_port_priv {

 static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int ahci_init_one(struct pci_dev *pdev, const struct
pci_device_id *ent);
+static int ahci_init_one(struct amba_device *pdev, const struct amba_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -443,142 +448,25 @@ static const struct ata_port_info ahci_p
 		.port_ops	= &ahci_ops,
 	},
 };
-
-static const struct pci_device_id ahci_pci_tbl[] = {
-	/* Intel */
-	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
-	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
-	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
-	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
-	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
-	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
-	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
-	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
-	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
-
-	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
-	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
-
-	/* ATI */
-	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb600 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb600 }, /* ATI SB700/800 */
-
-	/* VIA */
-	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
-	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
-
-	/* NVIDIA */
-	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad3), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad4), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad5), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad6), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad7), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad8), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
-
-	/* SiS */
-	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
-
-	/* Marvell */
-	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
-
-	/* Generic, PCI class code for AHCI */
-	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
-
-	{ }	/* terminate list */
+static const struct amba_id ahci_ids[] = {
+	{0x0000000, 0x01010101, board_ahci},
 };

-
-static struct pci_driver ahci_pci_driver = {
-	.name			= DRV_NAME,
-	.id_table		= ahci_pci_tbl,
+static int __devexit  ahci_amba_remove(struct amba_device *pdev)
+{
+	amba_set_drvdata(pdev, NULL);
+	amba_release_regions(pdev);
+	ata_amba_remove_one(pdev);
+}
+static struct amba_driver ahci_amba_driver = {
+	.drv			= {
+		.name		= "AHCI-AMBA",
+	},
+	.id_table		= ahci_ids,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM
-	.suspend		= ahci_pci_device_suspend,
-	.resume			= ahci_pci_device_resume,
-#endif
+	.remove			= ahci_amba_remove,
 };

-
 static inline int ahci_nr_ports(u32 cap)
 {
 	return (cap & 0x1f) + 1;
@@ -587,9 +475,9 @@ static inline int ahci_nr_ports(u32 cap)
 static inline void __iomem *__ahci_port_base(struct ata_host *host,
 					     unsigned int port_no)
 {
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = host->iomap[0];

-	return mmio + 0x100 + (port_no * 0x80);
+	return mmio + (port_no * 0x80);
 }

 static inline void __iomem *ahci_port_base(struct ata_port *ap)
@@ -612,10 +500,12 @@ static inline void __iomem *ahci_port_ba
  *	LOCKING:
  *	None.
  */
-static void ahci_save_initial_config(struct pci_dev *pdev,
+static void ahci_save_initial_config(struct amba_device *pdev,
 				     struct ahci_host_priv *hpriv)
 {
-	void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
+
+	amba_base = ioremap(pdev->res.start, SZ_4K);
+	void __iomem *mmio = amba_base;
 	u32 cap, port_map;
 	int i;

@@ -709,7 +599,7 @@ static void ahci_save_initial_config(str
 static void ahci_restore_initial_config(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = amba_base;

 	writel(hpriv->saved_cap, mmio + HOST_CAP);
 	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
@@ -1033,10 +923,9 @@ static int ahci_deinit_port(struct ata_p
 	return 0;
 }

-static int ahci_reset_controller(struct ata_host *host)
+static int ahci_reset_controller(struct ata_host *host, struct
amba_device *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = amba_base;
 	u32 tmp;

 	/* we must be in AHCI mode, before using anything
@@ -1073,19 +962,10 @@ static int ahci_reset_controller(struct
 	/* some registers might be cleared on reset.  restore initial values */
 	ahci_restore_initial_config(host);

-	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		u16 tmp16;
-
-		/* configure PCS */
-		pci_read_config_word(pdev, 0x92, &tmp16);
-		tmp16 |= 0xf;
-		pci_write_config_word(pdev, 0x92, tmp16);
-	}
-
 	return 0;
 }

-static void ahci_port_init(struct pci_dev *pdev, struct ata_port *ap,
+static void ahci_port_init(struct amba_device *pdev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
 {
@@ -1113,27 +993,14 @@ static void ahci_port_init(struct pci_de
 	writel(1 << port_no, mmio + HOST_IRQ_STAT);
 }

-static void ahci_init_controller(struct ata_host *host)
+static void ahci_init_controller(struct ata_host *host,
+		struct amba_device *pdev)
 {
-	struct ahci_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = amba_base;
 	int i;
 	void __iomem *port_mmio;
 	u32 tmp;

-	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
-		port_mmio = __ahci_port_base(host, 4);
-
-		writel(0, port_mmio + PORT_IRQ_MASK);
-
-		/* clear port IRQ */
-		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
-		if (tmp)
-			writel(tmp, port_mmio + PORT_IRQ_STAT);
-	}
-
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];

@@ -1722,7 +1589,7 @@ static irqreturn_t ahci_interrupt(int ir
 	VPRINTK("ENTER\n");

 	hpriv = host->private_data;
-	mmio = host->iomap[AHCI_PCI_BAR];
+	mmio = host->iomap[0];

 	/* sigh.  0xffffffff is a valid return from h/w */
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1794,7 +1661,7 @@ static void ahci_freeze(struct ata_port

 static void ahci_thaw(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = ap->host->iomap[0];
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -1899,65 +1766,6 @@ static int ahci_port_resume(struct ata_p
 	return 0;
 }

-#ifdef CONFIG_PM
-static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
-{
-	const char *emsg = NULL;
-	int rc;
-
-	rc = ahci_deinit_port(ap, &emsg);
-	if (rc == 0)
-		ahci_power_down(ap);
-	else {
-		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
-		ahci_start_port(ap);
-	}
-
-	return rc;
-}
-
-static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
-	u32 ctl;
-
-	if (mesg.event == PM_EVENT_SUSPEND) {
-		/* AHCI spec rev1.1 section 8.3.3:
-		 * Software must disable interrupts prior to requesting a
-		 * transition of the HBA to D3 state.
-		 */
-		ctl = readl(mmio + HOST_CTL);
-		ctl &= ~HOST_IRQ_EN;
-		writel(ctl, mmio + HOST_CTL);
-		readl(mmio + HOST_CTL); /* flush */
-	}
-
-	return ata_pci_device_suspend(pdev, mesg);
-}
-
-static int ahci_pci_device_resume(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(host);
-		if (rc)
-			return rc;
-
-		ahci_init_controller(host);
-	}
-
-	ata_host_resume(host);
-
-	return 0;
-}
-#endif

 static int ahci_port_start(struct ata_port *ap)
 {
@@ -2030,43 +1838,33 @@ static void ahci_port_stop(struct ata_po
 		ata_port_printk(ap, KERN_WARNING, "%s (%d)\n", emsg, rc);
 }

-static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
+static int ahci_configure_dma_masks(struct amba_device *pdev, int using_dac)
 {
 	int rc;

-	if (using_dac &&
-	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-			if (rc) {
-				dev_printk(KERN_ERR, &pdev->dev,
-					   "64-bit DMA enable failed\n");
-				return rc;
-			}
-		}
-	} else {
-		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-		if (rc) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "32-bit DMA enable failed\n");
-			return rc;
-		}
-		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-		if (rc) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "32-bit consistent DMA enable failed\n");
-			return rc;
-		}
+	if (using_dac) {
+		/* Port 0;*/
+		writel( SOCR_BITMSK_RXABL_P0 | SOCR_BITMSK_TXABL_P0 | \
+				( ( 0xA << SOCR_BITMSK_TXTS_P0_SHFT ) | \
+				  ( 0xA << SOCR_BITMSK_RXTS_P0_SHFT) ) \
+				, amba_base + \
+				( SOCR_PORT0_REG_DMA_CONTROL_REGISTER - \
+				  SOCR_SATA_CONTROLLER_BASE ) );
+		/* Port 1;*/
+		writel( SOCR_BITMSK_RXABL_P0 | SOCR_BITMSK_TXABL_P0 | \
+			( ( 0xA << SOCR_BITMSK_TXTS_P0_SHFT ) | \
+			 ( 0xA << SOCR_BITMSK_RXTS_P0_SHFT ) ) \
+			, amba_base + \
+			( SOCR_PORT1_REG_DMA_CONTROL_REGISTER - \
+			  SOCR_SATA_CONTROLLER_BASE ) );
 	}
 	return 0;
 }

-static void ahci_print_info(struct ata_host *host)
+static void ahci_print_info(struct ata_host *host, struct amba_device *pdev)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = host->iomap[0];
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
 	u16 cc;
@@ -2084,15 +1882,7 @@ static void ahci_print_info(struct ata_h
 	else
 		speed_s = "?";

-	pci_read_config_word(pdev, 0x0a, &cc);
-	if (cc == PCI_CLASS_STORAGE_IDE)
-		scc_s = "IDE";
-	else if (cc == PCI_CLASS_STORAGE_SATA)
 		scc_s = "SATA";
-	else if (cc == PCI_CLASS_STORAGE_RAID)
-		scc_s = "RAID";
-	else
-		scc_s = "unknown";

 	dev_printk(KERN_INFO, &pdev->dev,
 		"AHCI %02x%02x.%02x%02x "
@@ -2152,38 +1942,12 @@ static void ahci_print_info(struct ata_h
  * afterward.  If signature FIS isn't received soon, ATA class is
  * assumed without follow-up softreset.
  */
-static void ahci_p5wdh_workaround(struct ata_host *host)
-{
-	static struct dmi_system_id sysids[] = {
-		{
-			.ident = "P5W DH Deluxe",
-			.matches = {
-				DMI_MATCH(DMI_SYS_VENDOR,
-					  "ASUSTEK COMPUTER INC"),
-				DMI_MATCH(DMI_PRODUCT_NAME, "P5W DH Deluxe"),
-			},
-		},
-		{ }
-	};
-	struct pci_dev *pdev = to_pci_dev(host->dev);

-	if (pdev->bus->number == 0 && pdev->devfn == PCI_DEVFN(0x1f, 2) &&
-	    dmi_check_system(sysids)) {
-		struct ata_port *ap = host->ports[1];
-
-		dev_printk(KERN_INFO, &pdev->dev, "enabling ASUS P5W DH "
-			   "Deluxe on-board SIMG4726 workaround\n");
-
-		ap->ops = &ahci_p5wdh_ops;
-		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
-	}
-}
-
-static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int ahci_init_one(struct amba_device *pdev, const struct amba_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info pi = ahci_port_info[ent->driver_data];
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	struct ata_port_info pi = ahci_port_info[0];
+		const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
@@ -2195,42 +1959,16 @@ static int ahci_init_one(struct pci_dev

 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
-
-	/* acquire resources */
-	rc = pcim_enable_device(pdev);
+	
+	rc = amba_request_regions(dev, "sata");
 	if (rc)
 		return rc;
-
-	rc = pcim_iomap_regions(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
-	if (rc == -EBUSY)
-		pcim_pin_device(pdev);
-	if (rc)
-		return rc;
-
-	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-	    (pdev->device == 0x2652 || pdev->device == 0x2653)) {
-		u8 map;
-
-		/* ICH6s share the same PCI ID for both piix and ahci
-		 * modes.  Enabling ahci mode while MAP indicates
-		 * combined mode is a bad idea.  Yield to ata_piix.
-		 */
-		pci_read_config_byte(pdev, ICH_MAP, &map);
-		if (map & 0x3) {
-			dev_printk(KERN_INFO, &pdev->dev, "controller is in "
-				   "combined mode, can't enable AHCI mode\n");
-			return -ENODEV;
-		}
-	}
-
+	
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
 	hpriv->flags |= (unsigned long)pi.private_data;

-	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
-		pci_intx(pdev, 1);
-
 	/* save initial config */
 	ahci_save_initial_config(pdev, hpriv);

@@ -2240,13 +1978,14 @@ static int ahci_init_one(struct pci_dev

 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
-
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
 	if (!host)
 		return -ENOMEM;
-	host->iomap = pcim_iomap_table(pdev);
+	/*Assign the iomap to ata_host. Memory should be used from the resource
+	/pool allocated for the device.*/
+	host->iomap = amba_base;
 	host->private_data = hpriv;
-
+	
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		void __iomem *port_mmio = ahci_port_base(ap);
@@ -2267,41 +2006,36 @@ static int ahci_init_one(struct pci_dev
 			ap->ops = &ata_dummy_port_ops;
 	}

-	/* apply workaround for ASUS P5W DH Deluxe mainboard */
-	ahci_p5wdh_workaround(host);
-
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
 		return rc;

-	rc = ahci_reset_controller(host);
+	rc = ahci_reset_controller(host,pdev);
 	if (rc)
 		return rc;

-	ahci_init_controller(host);
-	ahci_print_info(host);
-
-	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ahci_interrupt, IRQF_SHARED,
-				 &ahci_sht);
+	ahci_init_controller(host,pdev);
+	ahci_print_info(host,pdev);
+	return ata_host_activate( host, IRQ_SOCR_SATA_CONTROLLER, \
+			ahci_interrupt, IRQF_PERCPU, &ahci_sht );
 }

 static int __init ahci_init(void)
 {
-	return pci_register_driver(&ahci_pci_driver);
+	return amba_driver_register (&ahci_amba_driver);
 }

 static void __exit ahci_exit(void)
 {
-	pci_unregister_driver(&ahci_pci_driver);
+	amba_driver_unregister (&ahci_amba_driver);
 }


 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("AHCI SATA low-level driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, ahci_pci_tbl);
+MODULE_DEVICE_TABLE(amba, ahci_ids);
 MODULE_VERSION(DRV_VERSION);

 module_init(ahci_init);
--- drivers/ata/Kconfig.orig	2009-03-26 19:09:10.000000000 +0530
+++ drivers/ata/Kconfig	2009-03-25 19:00:13.000000000 +0530
@@ -42,7 +42,15 @@ config ATA_ACPI

 config SATA_AHCI
 	tristate "AHCI SATA support"
-	depends on PCI
+	depends on PCI
+	help
+	  This option enables support for AHCI Serial ATA.
+
+	  If unsure, say N.
+
+config SOCR_AHCI
+	tristate "AHCI SATA support for SOCR based on AHB interface"
+	depends on ARCH_SOCR
 	help
 	  This option enables support for AHCI Serial ATA.

--- drivers/ata/libata-core.c.orig	2009-03-26 19:09:52.000000000 +0530
+++ drivers/ata/libata-core.c	2009-03-26 19:00:27.000000000 +0530
@@ -66,6 +66,9 @@
 #include <asm/byteorder.h>
 #include <linux/cdrom.h>

+#ifdef CONFIG_ARCH_SOCR
+#include <linux/amba/bus.h>
+#endif
 #include "libata.h"


@@ -7344,10 +7347,17 @@ void ata_pci_remove_one(struct pci_dev *
 {
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
-
 	ata_host_detach(host);
 }
+#ifdef CONFIG_ARCH_SOCR
+void ata_amba_remove_one(struct amba_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	ata_host_detach(host);

+}
+#endif
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 {
@@ -7668,7 +7678,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
-
+EXPORT_SYMBOL_GPL(ata_amba_remove_one);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
--- drivers/ata/Makefile.orig	2009-03-26 19:10:53.000000000 +0530
+++ drivers/ata/Makefile	2009-03-25 19:00:13.000000000 +0530
@@ -1,7 +1,7 @@
-
 obj-$(CONFIG_ATA)		+= libata.o

 obj-$(CONFIG_SATA_AHCI)		+= ahci.o
+obj-$(CONFIG_SOCR_AHCI)		+= ahci_ahb.o
 obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
 obj-$(CONFIG_ATA_PIIX)		+= ata_piix.o
 obj-$(CONFIG_SATA_PROMISE)	+= sata_promise.o
--- include/linux/libata.h.orig	2009-03-26 19:11:59.000000000 +0530
+++ include/linux/libata.h	2009-03-26 19:14:18.000000000 +0530
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 #include <linux/acpi.h>
+#include <linux/amba/bus.h>

 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -959,6 +960,7 @@ static inline const struct ata_acpi_gtm
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif

+extern void ata_amba_remove_one(struct amba_device *pdev);
 #ifdef CONFIG_PCI
 struct pci_dev;

-------

Thanks
Sagar
