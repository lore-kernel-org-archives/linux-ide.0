From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_artop: Cable detect methods
Date: Wed, 7 Mar 2007 16:14:30 +0000
Message-ID: <20070307161430.26e3faa9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46500 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751693AbXCGPKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:10:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_artop.c linux-2.6.21-rc2-mm2/drivers/ata/pata_artop.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_artop.c	2007-03-06 23:06:26.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_artop.c	2007-03-06 17:20:22.000000000 +0000
@@ -49,8 +49,6 @@
 
 	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -85,18 +83,28 @@
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 tmp;
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
 	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
+	return ata_std_prereset(ap);
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
-	return ata_std_prereset(ap);
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
 /**
@@ -225,7 +233,7 @@
 /**
  *	artop6210_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
- *	@adev: um
+ *	@adev: Device whose timings we are configuring
  *
  *	Set DMA mode for device, in host controller PCI config space.
  *
@@ -333,6 +341,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6210_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -366,6 +375,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6260_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= artop6260_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
