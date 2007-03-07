From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc202xx_old: Cable detect clean up
Date: Wed, 7 Mar 2007 16:28:57 +0000
Message-ID: <20070307162857.270ba2b3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57159 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942AbXCGPZD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:25:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_pdc202xx_old.c linux-2.6.21-rc2-mm2/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_pdc202xx_old.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_pdc202xx_old.c	2007-03-06 23:40:02.000000000 +0000
@@ -22,45 +22,17 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_pdc202xx_old"
-#define DRV_VERSION "0.4.0"
+#define DRV_VERSION "0.4.2"
 
-/**
- *	pdc2024x_pre_reset		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generic probe init
- */
-
-static int pdc2024x_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-
-static void pdc2024x_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, pdc2024x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-
-static int pdc2026x_pre_reset(struct ata_port *ap)
+static int pdc2026x_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 cis;
 
 	pci_read_config_word(pdev, 0x50, &cis);
 	if (cis & (1 << (10 + ap->port_no)))
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
-
-	return ata_std_prereset(ap);
-}
-
-static void pdc2026x_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, pdc2026x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+		return ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -291,8 +263,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= pdc2024x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -325,8 +298,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= pdc2026x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= pdc2026x_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= pdc2026x_bmdma_start,
