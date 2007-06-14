From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc4]: libata: PATA-mode fixes for sis_sata
Date: Thu, 14 Jun 2007 23:40:43 +0200
Message-ID: <200706142340.44068.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752381AbXFNVnB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jun 2007 17:43:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, yulin@starsoftcomm.com, micha.biermann@gmx.de

Changed PATA handler for PATA-ports used by sata_sis.
This patch was originally submitted by Jeff Garzik.

Added PCI-ID 1180 for SiS966 Controller in pata_sis.
The 1180 mode is fully compatible to other SiS PATA-controller.

The PCI-ID 1183 is SATA in PATA-emulation, but not fully compatible
to SiS5513/5518. sata_sis.c is forwarding this ID to pata_sis.
1183 is not working if simply added to pata_sis.
This handling fixes issues with SiS968.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/pata_sis.c	2007-06-14 22:41:34.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-06-12 22:15:04.000000000 +0200
@@ -560,6 +560,40 @@
 	.port_start		= ata_port_start,
 };
 
+static const struct ata_port_operations sis_133_for_sata_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= sis_133_set_piomode,
+	.set_dmamode		= sis_133_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= sis_133_cable_detect,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
+
+	.port_start		= ata_port_start,
+};
+
 static const struct ata_port_operations sis_133_early_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= sis_100_set_piomode,
@@ -733,13 +767,20 @@
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.port_ops	= &sis_66_ops,
 };
-const struct ata_port_info sis_info133 = {
+static const struct ata_port_info sis_info133 = {
 	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
+const struct ata_port_info sis_info133_for_sata = {
+	.sht		= &sis_sht,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.pio_mask	= 0x1f,	/* pio0-4 */
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &sis_133_for_sata_ops,
+};
 static const struct ata_port_info sis_info133_early = {
 	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
@@ -749,7 +790,7 @@
 };
 
 /* Privately shared with the SiS180 SATA driver, not for use elsewhere */
-EXPORT_SYMBOL_GPL(sis_info133);
+EXPORT_SYMBOL_GPL(sis_info133_for_sata);
 
 static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 {
@@ -975,6 +1016,7 @@
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
 	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
+	{ PCI_VDEVICE(SI, 0x1180), },	/* SiS 1180 */
 
 	{ }
 };
--- a/drivers/ata/sata_sis.c	2007-06-14 22:41:34.000000000 +0200
+++ b/drivers/ata/sata_sis.c	2007-06-12 22:16:11.000000000 +0200
@@ -72,8 +72,8 @@
 	{ PCI_VDEVICE(SI, 0x0181), sis_180 },		/* SiS 964/180 */
 	{ PCI_VDEVICE(SI, 0x0182), sis_180 },		/* SiS 965/965L */
 	{ PCI_VDEVICE(SI, 0x0183), sis_180 },		/* SiS 965/965L */
-	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/966L */
-	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L */
+	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/680 */
+	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L/968/680 */
 
 	{ }	/* terminate list */
 };
@@ -161,7 +161,6 @@
 			case 0x0182:
 			case 0x0183:
 			case 0x1182:
-			case 0x1183:
 				addr += SIS182_SATA1_OFS;
 				break;
 		}
@@ -183,8 +182,8 @@
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
-	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
+	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
 	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
@@ -203,8 +202,8 @@
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
-	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
+	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
@@ -224,8 +223,8 @@
 
 	val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
 
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
-	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
+	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
 		val2 = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
 	return (val | val2) &  0xfffffffb;
@@ -245,8 +244,8 @@
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
-		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
+		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
+		    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
 			iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
 }
@@ -293,11 +292,11 @@
 		/* The PATA-handling is provided by pata_sis */
 		switch (pmr & 0x30) {
 		case 0x10:
-			ppi[1] = &sis_info133;
+			ppi[1] = &sis_info133_for_sata;
 			break;
 
 		case 0x30:
-			ppi[0] = &sis_info133;
+			ppi[0] = &sis_info133_for_sata;
 			break;
 		}
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
@@ -324,14 +323,14 @@
 		break;
 
 	case 0x1182:
+		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/966/680 SATA controller\n");
+		pi.flags |= ATA_FLAG_SLAVE_POSS;
+		break;
+
 	case 0x1183:
-		pci_read_config_dword(pdev, 0x64, &val);
-		if (val & 0x10000000) {
-			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966L SATA controller\n");
-		} else {
-			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966 SATA controller\n");
-			pi.flags |= ATA_FLAG_SLAVE_POSS;
-		}
+		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1183/966/966L/968/680 controller in PATA mode\n");
+		ppi[0] = &sis_info133_for_sata;
+		ppi[1] = &sis_info133_for_sata;
 		break;
 	}
 
--- a/drivers/ata/sis.h	2007-06-14 22:41:34.000000000 +0200
+++ b/drivers/ata/sis.h	2007-06-09 22:30:43.000000000 +0200
@@ -2,4 +2,4 @@
 struct ata_port_info;
 
 /* pata_sis.c */
-extern const struct ata_port_info sis_info133;
+extern const struct ata_port_info sis_info133_for_sata;

