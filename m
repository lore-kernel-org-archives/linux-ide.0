From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_via: cable detection
Date: Wed, 7 Mar 2007 16:34:10 +0000
Message-ID: <20070307163410.230a87e1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33751 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbXCGP3y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:29:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Because the sata_via driver handles PATA and SATA ports on the 6421 it
also ends up with duplicated chunks of code that can be eliminated using
the cable_detect method. Generally SATA drivers don't need/want this as
they are set correctly by libata simply because they declare themselves
as SATA.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/sata_via.c linux-2.6.21-rc2-mm2/drivers/ata/sata_via.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/sata_via.c	2007-03-06 23:06:26.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/sata_via.c	2007-03-06 18:23:21.000000000 +0000
@@ -78,8 +78,7 @@
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void svia_noop_freeze(struct ata_port *ap);
 static void vt6420_error_handler(struct ata_port *ap);
-static void vt6421_sata_error_handler(struct ata_port *ap);
-static void vt6421_pata_error_handler(struct ata_port *ap);
+static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
 static int vt6421_port_start(struct ata_port *ap);
@@ -172,8 +171,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= vt6421_pata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= vt6421_pata_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -203,8 +203,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= vt6421_sata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_sata,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -330,35 +331,15 @@
 				  NULL, ata_std_postreset);
 }
 
-static int vt6421_pata_prereset(struct ata_port *ap)
+static int vt6421_pata_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
 	pci_read_config_byte(pdev, PATA_UDMA_TIMING, &tmp);
 	if (tmp & 0x10)
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
-	return 0;
-}
-
-static void vt6421_pata_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, vt6421_pata_prereset, ata_std_softreset,
-				  NULL, ata_std_postreset);
-}
-
-static int vt6421_sata_prereset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_SATA;
-	return 0;
-}
-
-static void vt6421_sata_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, vt6421_sata_prereset, ata_std_softreset,
-				  NULL, ata_std_postreset);
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
