From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.19-rc4-mm2] sata_sis: slave support on SiS965
Date: Wed, 8 Nov 2006 09:57:00 +0100
Message-ID: <200611080957.00349.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:28121 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1754461AbWKHI5E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 03:57:04 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

SiS965 and SiS180 chips must support slave mode,
SiS965L and SiS964 chips must not support slave mode.

SCR_STATUS for SATA ports in powerdown state fixed.
Now returning 0x0113 instead of 0x0117. Avoids problem
on detecting sata_sis controller.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/sata_sis.c	2006-11-04 22:54:37.000000000 +0100
+++ b/drivers/ata/sata_sis.c	2006-11-07 21:32:31.000000000 +0100
@@ -173,7 +173,7 @@
 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
-	return val|val2;
+	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
@@ -212,7 +212,7 @@
 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
 		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
-	return val | val2;
+	return (val | val2) &  0xfffffffb;
 }
 
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
@@ -239,7 +239,7 @@
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
-	u32 genctl;
+	u32 genctl, val;
 	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
@@ -285,17 +285,24 @@
 	if (ent->device != 0x182) {
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			dev_printk(KERN_INFO, &pdev->dev,
-				   "Detected SiS 180/181 chipset in SATA mode\n");
+				   "Detected SiS 180/181/964 chipset in SATA mode\n");
 			port2_start = 64;
 		}
 		else {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181 chipset in combined mode\n");
 			port2_start=0;
+			pi.flags |= ATA_FLAG_SLAVE_POSS;
 		}
 	}
 	else {
-		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182 chipset\n");
+		pci_read_config_dword ( pdev, 0x6C, &val);
+		if (val & (1L << 31)) {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965 chipset\n");
+			pi.flags |= ATA_FLAG_SLAVE_POSS;
+		}
+		else
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965L chipset\n");
 		port2_start = 0x20;
 	}
 

