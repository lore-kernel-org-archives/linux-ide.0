From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc6+mboxjeff 3/3] sata_sis: fixed handling for IDE-emulation of ID 1183
Date: Sat, 30 Jun 2007 04:11:05 +0200
Message-ID: <200706300411.05359.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbXF3CNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 22:13:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

The PCI-ID 1183 is used for SATA-ports in PATA-emulation.
This mode is handled now by pata_sis. This mode is not fully
compatible to SiS 5513/18, so the PCI-ID entry is not moved
to pata_sis. This fixes problems with SiS968.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/sata_sis.c	2007-06-30 02:42:43.000000000 +0200
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
 

