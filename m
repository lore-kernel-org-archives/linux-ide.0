From: akpm@linux-foundation.org
Subject: [patch 24/30] pata_cmd64x - various fixes
Date: Tue, 06 Mar 2007 02:38:09 -0800
Message-ID: <200703061038.l26Ac9rU019536@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34457 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934041AbXCFKiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

This driver still needs more work but for the moment

- It's a CMD not ATI driver
- Clean up code by using cable method

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_cmd64x.c |   34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff -puN drivers/ata/pata_cmd64x.c~pata_cmd64x-various-fixes drivers/ata/pata_cmd64x.c
--- a/drivers/ata/pata_cmd64x.c~pata_cmd64x-various-fixes
+++ a/drivers/ata/pata_cmd64x.c
@@ -75,13 +75,7 @@ enum {
 	DTPR1		= 0x7C
 };
 
-static int cmd64x_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static int cmd648_pre_reset(struct ata_port *ap)
+static int cmd648_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 r;
@@ -89,21 +83,8 @@ static int cmd648_pre_reset(struct ata_p
 	/* Check cable detect bits */
 	pci_read_config_byte(pdev, BMIDECSR, &r);
 	if (r & (1 << ap->port_no))
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
-
-	return ata_std_prereset(ap);
-}
-
-static void cmd64x_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, cmd64x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-static void cmd648_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cmd648_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+		return ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -304,8 +285,9 @@ static struct ata_port_operations cmd64x
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cmd64x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -338,8 +320,9 @@ static struct ata_port_operations cmd646
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cmd64x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -372,8 +355,9 @@ static struct ata_port_operations cmd648
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cmd648_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= cmd648_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
_
