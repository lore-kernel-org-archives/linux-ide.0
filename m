From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.19-rc6-mm2] sata_sis: support SiS966/966L
Date: Mon, 4 Dec 2006 01:34:42 +0100
Message-ID: <200612040134.42688.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:9910 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1760170AbWLDAeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 19:34:46 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

The SiS966/966L has different PCI-IDs for native mode and AHCI mode.
The SiS966 supports four SATA ports only in native mode.

Added additional PCI-ID 0x0183 for SiS965/965L.

this patch is based on the code from David Wang from SiS Corporation published on SiS Website.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/sata_sis.c	2006-11-26 21:45:29.000000000 +0100
+++ b/drivers/ata/sata_sis.c	2006-12-04 00:49:01.000000000 +0100
@@ -42,7 +42,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sis"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.7"
 
 enum {
 	sis_180			= 0,
@@ -67,9 +67,12 @@
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VDEVICE(SI, 0x180), sis_180 },
-	{ PCI_VDEVICE(SI, 0x181), sis_180 },
-	{ PCI_VDEVICE(SI, 0x182), sis_180 },
+	{ PCI_VDEVICE(SI, 0x0180), sis_180 },		/* SiS 964/180 */
+	{ PCI_VDEVICE(SI, 0x0181), sis_180 },		/* SiS 964/180 */
+	{ PCI_VDEVICE(SI, 0x0182), sis_180 },		/* SiS 965/965L */
+	{ PCI_VDEVICE(SI, 0x0183), sis_180 },		/* SiS 965/965L */
+	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/966L */
+	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L */
 
 	{ }	/* terminate list */
 };
@@ -142,24 +145,32 @@
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, int device)
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, struct pci_dev *pdev)
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
 
 	if (port_no)  {
-		if (device == 0x182)
-			addr += SIS182_SATA1_OFS;
-		else
-			addr += SIS180_SATA1_OFS;
+		switch (pdev->device) {
+			case 0x0180:
+			case 0x0181:
+				addr += SIS180_SATA1_OFS;
+				break;
+
+			case 0x0182:
+			case 0x0183:
+			case 0x1182:
+			case 0x1183:
+				addr += SIS182_SATA1_OFS;
+				break;
+		}
 	}
-
 	return addr;
 }
 
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
 	u32 val, val2 = 0;
 	u8 pmr;
 
@@ -170,7 +181,8 @@
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
 	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
@@ -179,7 +191,7 @@
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
 	u8 pmr;
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -189,7 +201,8 @@
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
@@ -209,7 +222,8 @@
 
 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
 	return (val | val2) &  0xfffffffb;
@@ -229,7 +243,8 @@
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
 }
@@ -243,7 +258,7 @@
 	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
-	u8 port2_start;
+	u8 port2_start = 0x20;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -282,28 +297,42 @@
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	if (ent->device != 0x182) {
+	switch (ent->device) {
+	case 0x0180:
+	case 0x0181:
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181/964 chipset in SATA mode\n");
 			port2_start = 64;
-		}
-		else {
+		} else {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181 chipset in combined mode\n");
 			port2_start=0;
 			pi.flags |= ATA_FLAG_SLAVE_POSS;
 		}
-	}
-	else {
+		break;
+	
+	case 0x0182:
+	case 0x0183:
 		pci_read_config_dword ( pdev, 0x6C, &val);
 		if (val & (1L << 31)) {
 			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965 chipset\n");
 			pi.flags |= ATA_FLAG_SLAVE_POSS;
-		}
-		else
+		} else {
 			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965L chipset\n");
-		port2_start = 0x20;
+		}
+		break;
+
+	case 0x1182:
+	case 0x1183:
+		pci_read_config_dword(pdev, 0x64, &val);
+		if (val & 0x10000000) {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966L SATA controller\n");
+		} else {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966 SATA controller\n");
+			pi.flags |= ATA_FLAG_SLAVE_POSS;
+		}
+		break;
 	}
 
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);

