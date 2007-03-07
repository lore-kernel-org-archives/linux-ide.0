From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_it821x: Clean up by using cable methods
Date: Wed, 7 Mar 2007 16:18:36 +0000
Message-ID: <20070307161836.68c60eb0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57080 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751828AbXCGPOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:14:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_it821x.c linux-2.6.21-rc2-mm2/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_it821x.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_it821x.c	2007-03-06 23:35:28.000000000 +0000
@@ -80,7 +80,7 @@
 
 
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.3.4"
+#define DRV_VERSION "0.3.6"
 
 struct it821x_dev
 {
@@ -113,31 +113,6 @@
 static int it8212_noraid;
 
 /**
- *	it821x_pre_reset	-	probe
- *	@ap: ATA port
- *
- *	Set the cable type
- */
-
-static int it821x_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	it821x_error_handler	-	probe/reset
- *	@ap: ATA port
- *
- *	Set the cable type and trigger a probe
- */
-
-static void it821x_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, it821x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	it821x_program	-	program the PIO/MWDMA registers
  *	@ap: ATA port
  *	@adev: Device to program
@@ -666,8 +641,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= it821x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -702,8 +678,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= it821x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= it821x_passthru_bmdma_start,
