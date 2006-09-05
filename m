From: "David Wang" <touch@sis.com>
Subject: RE: [PATCH] sata_sis: support for SiS 966 chipset
Date: Tue, 5 Sep 2006 11:35:49 +0800
Message-ID: <OF2F3C31A1.49B55782-ON482571E0.00136E7E@sis.com.tw>
References: <44FB5A80.3030303@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sism01.sis.com ([203.67.208.22]:52653 "EHLO sism01.sis.com")
	by vger.kernel.org with ESMTP id S965127AbWIEDcY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 23:32:24 -0400
In-Reply-To: <44FB5A80.3030303@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Uwe Koziolek' <uwe.koziolek@gmx.net>
Cc: "'inux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>

Hello Uwe,

Thanks for you reply.
I sent the patch to you again.
Hope it is okay.
Do you need a referenced board for testing ?

David
--------------
diff -Nura a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2006-08-24 05:16:33.000000000 +0800
+++ b/drivers/scsi/sata_sis.c	2006-09-05 11:08:58.000000000 +0800
@@ -71,6 +71,9 @@
 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },

+	{ PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },

 	{ }	/* terminate list */
 };
 
@@ -126,7 +129,7 @@
 static struct ata_port_info sis_port_info = {
 	.sht		= &sis_sht,
 	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-			  ATA_FLAG_NO_LEGACY,
+			  ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
 	.udma_mask	= 0x7f,
@@ -140,15 +143,37 @@
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int
sc_reg, int device)
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int
sc_reg, struct pci_dev *pdev)
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
+	u32 val = 0;
 
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
+			case 0x0182:
+			case 0x1182:
+			case 0x1183:
+				addr += SIS182_SATA1_OFS;
+				break;
+			case 0x1180:
+				/*
+				 *  If hw_id == 0x1180
+				 *  read PCI offset 64h, bit 28 to decide
what the chip is.
+				 *  This is the only way to tell SiS966 from
SiS966L.
+				 *  1: 966L port0 = c0h, port1 = e0h
+				 *  0: 966  port0 = c0h, port1 = d0h
+				 */
+				pci_read_config_dword(pdev, 0x64, &val);
+				if (val & (1 << 28))
+					addr += SIS182_SATA1_OFS; /* SB-966L
*/
+				else
+					addr += SIS180_SATA1_OFS; /* 966 */
+				break;					
+		}
 	}
 
 	return addr;
@@ -157,7 +182,7 @@
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg,
pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
 	u32 val, val2 = 0;
 	u8 pmr;
 
@@ -168,16 +193,19 @@
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
(pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
-
-	return val|val2;
+		
+	/* Due to the port status is ORed with two SATA ports.
+	   The unused SATA port might be powered down by BIOS.
+	   We need to mask 0x3 to report the correct value */
+	return (val|val2) & 3U;
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32
val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr,
pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
 	u8 pmr;
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -187,7 +215,7 @@
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
(pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))	
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
@@ -207,10 +235,14 @@
 
 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x182) || (pdev->device == 0x1182) 
+		|| (pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))
 		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
-
-	return val | val2;
+		
+	/* Due to the port status is ORed with two SATA ports.
+	   The unused SATA port might be powered down by BIOS.
+	   We need to mask 0x3 to report the correct value */
+	return (val|val2) & 3U;
 }
 
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32
val)
@@ -227,7 +259,8 @@
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+		if ((pdev->device == 0x182) || (pdev->device == 0x1182) 
+			|| (pdev->device == 0x1183) ||(pmr &
SIS_PMR_COMBINED))
 			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
 }
@@ -241,11 +274,29 @@
 	struct ata_port_info *ppi;
 	int pci_dev_busy = 0;
 	u8 pmr;
-	u8 port2_start;
+	u8 port2_start = 0;
+	u8 progintf;
+	u16 classCode;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION
"\n");
 
+	/* check if the device's programming interface 09h,
+	   is compatibility mode
+	*/
+	pci_read_config_word(pdev, 0x0A, &classCode);
+	if (classCode == 0x0101) {
+		pci_read_config_byte(pdev, 0x09, &progintf);
+		if ((progintf & 0x5) == 0) {
+			dev_printk(KERN_INFO, &pdev->dev,
+				"SiS-%x IDE device is compatibiltiy mode.
Ignore it\n", 
+				ent->device);
+			dev_printk(KERN_INFO, &pdev->dev,
+				"Try to change BIOS setting with native
mode..\n");
+			rc = -1;
+			return rc;
+		}
+	}
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -275,6 +326,10 @@
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 
+	/* 0x1180 does not provide SCRs mapping. Set the CFGSCR Flag */

+	if (ent->device == 0x1180)	
+		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
+		
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
@@ -287,21 +342,31 @@
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	if (ent->device != 0x182) {
-		if ((pmr & SIS_PMR_COMBINED) == 0) {
-			dev_printk(KERN_INFO, &pdev->dev,
+	switch (ent->device) {
+		case 0x0180:
+		case 0x0181:
+			if ((pmr & SIS_PMR_COMBINED) == 0) {
+				dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181 chipset in SATA
mode\n");
-			port2_start = 64;
-		}
-		else {
-			dev_printk(KERN_INFO, &pdev->dev,
+				port2_start = 64;
+			}
+			else {
+				dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181 chipset in combined
mode\n");
-			port2_start=0;
-		}
-	}
-	else {
-		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182
chipset\n");
-		port2_start = 0x20;
+				port2_start = 0;
+ 		  	}		
+			break;
+			
+		case 0x0182:			
+		case 0x1182:
+		case 0x1183:
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS
182/1182/1183 SATA controller\n");
+			port2_start = 0x20;		
+			break;
+			
+		case 0x1180:
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1180
SATA controller\n");
+			break;
 	}
 
 	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {


