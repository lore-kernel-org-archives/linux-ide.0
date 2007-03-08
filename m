From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_artop: Remove all the crud again and restore the cable
 method
Date: Thu, 8 Mar 2007 19:26:21 +0000
Message-ID: <20070308192621.49a360ea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55637 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932386AbXCHSWD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:22:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_artop.c linux-2.6.21-rc3-mm2/drivers/ata/pata_artop.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_artop.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_artop.c	2007-03-08 17:07:54.000000000 +0000
@@ -49,8 +49,6 @@
 
 	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -86,18 +84,28 @@
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 tmp;
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
 	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
+	return ata_std_prereset(ap, deadline);
+}
 
+/**
+ *	artop6260_cable_detect	-	identify cable type
+ *	@ap: Port
+ *
+ *	Identify the cable type for the ARTOp interface in question
+ */
+ 
+static int artop6260_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
 	pci_read_config_byte(pdev, 0x49, &tmp);
 	if (tmp & (1 << ap->port_no))
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap, deadline);
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
 /**
@@ -226,7 +234,7 @@
 /**
  *	artop6210_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
- *	@adev: um
+ *	@adev: Device whose timings we are configuring
  *
  *	Set DMA mode for device, in host controller PCI config space.
  *
@@ -334,6 +342,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6210_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -367,6 +376,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6260_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= artop6260_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
