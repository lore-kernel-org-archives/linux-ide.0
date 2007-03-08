From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_via: Use cable detect methods
Date: Thu, 8 Mar 2007 23:10:40 +0000
Message-ID: <20070308231040.1616cedf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60440 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030755AbXCHWGc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:06:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_via.c linux-2.6.21-rc3-mm2/drivers/ata/sata_via.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_via.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/sata_via.c	2007-03-08 17:07:21.000000000 +0000
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
@@ -331,35 +332,15 @@
 				  NULL, ata_std_postreset);
 }
 
-static int vt6421_pata_prereset(struct ata_port *ap, unsigned long deadline)
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
-static int vt6421_sata_prereset(struct ata_port *ap, unsigned long deadline)
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
