From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt3x3: Switch back to cable method and re-remove all
 the crap
Date: Thu, 8 Mar 2007 19:35:34 +0000
Message-ID: <20070308193534.4f5f31b6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34200 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932697AbXCHSb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:31:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x3.c linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x3.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x3.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x3.c	2007-03-08 16:46:20.000000000 +0000
@@ -25,25 +25,6 @@
 #define DRV_NAME	"pata_hpt3x3"
 #define DRV_VERSION	"0.4.2"
 
-static int hpt3x3_probe_init(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap, deadline);
-}
-
-/**
- *	hpt3x3_probe_reset	-	reset the hpt3x3 bus
- *	@ap: ATA port to reset
- *
- *	Perform the housekeeping when doing an ATA bus reeset. We just
- *	need to force the cable type.
- */
-
-static void hpt3x3_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, hpt3x3_probe_init, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	hpt3x3_set_piomode		-	PIO setup
  *	@ap: ATA interface
@@ -139,8 +120,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt3x3_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
