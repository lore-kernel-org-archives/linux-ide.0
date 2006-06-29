From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 3/9] ata_piix.c conversion
Date: Thu, 29 Jun 2006 18:09:52 +0200
Message-ID: <20060629160952.GD23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:177 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750841AbWF2QLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

This converts the relevant places of ata_piix.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

--- libata-dev/drivers/scsi/ata_piix.c.orig	2006-06-28 09:28:59.000000000 +0200
+++ libata-dev/drivers/scsi/ata_piix.c	2006-06-29 17:34:55.000000000 +0200
@@ -474,7 +474,7 @@ static int piix_pata_prereset(struct ata
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
-		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
+		ata_port_printk(ap, ATA_MSG_DRV, "port disabled. ignoring.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
@@ -515,7 +515,8 @@ static int piix_sata_prereset(struct ata
 	u8 pcs;
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
+	ata_port_printk(ap, ATA_MSG_CMD, 
+			"ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
 	/* enable all ports on this ap and wait for them to settle */
 	for (i = 0; i < 2; i++) {
@@ -544,11 +545,11 @@ static int piix_sata_prereset(struct ata
 	if (!(ap->flags & PIIX_FLAG_AHCI))
 		pci_write_config_byte(pdev, ICH5_PCS, pcs);
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+	ata_port_printk(ap, ATA_MSG_CMD, "ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
 	if (!present_mask) {
-		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
+		ata_port_printk(ap, ATA_MSG_DRV, "SATA port has no device.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
@@ -642,7 +643,7 @@ static void piix_set_dmamode (struct ata
 	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	DPRINTK("reg4042 = 0x%04x\n", reg4042);
+	ata_port_printk(ap, ATA_MSG_CMD, "reg4042 = 0x%04x\n", reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
@@ -741,7 +742,8 @@ static int __devinit piix_check_450nx_er
 	u8 rev;
 	int no_piix_dma = 0;
 
-	while((pdev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev)) != NULL)
+	while((pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 
+				PCI_DEVICE_ID_INTEL_82454NX, pdev)) != NULL)
 	{
 		/* Look for 450NX PXB. Check for problem configurations
 		   A PCI quirk checks bit 6 already */
@@ -755,9 +757,11 @@ static int __devinit piix_check_450nx_er
 			no_piix_dma = 2;
 	}
 	if (no_piix_dma)
-		dev_printk(KERN_WARNING, &ata_dev->dev, "450NX errata present, disabling IDE DMA.\n");
+		dev_printk(KERN_WARNING, &ata_dev->dev, 
+				"450NX errata present, disabling IDE DMA.\n");
 	if (no_piix_dma == 2)
-		dev_printk(KERN_WARNING, &ata_dev->dev, "A BIOS update may resolve this.\n");
+		dev_printk(KERN_WARNING, &ata_dev->dev, 
+				"A BIOS update may resolve this.\n");
 	return no_piix_dma;
 }
 

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

