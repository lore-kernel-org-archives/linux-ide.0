From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_rz1000: remove lots of crap by using cable method
Date: Thu, 1 Mar 2007 17:53:56 +0000
Message-ID: <20070301175356.21dac1e1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55289 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965360AbXCAQts (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:49:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_rz1000.c linux-2.6.21-rc2/drivers/ata/pata_rz1000.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_rz1000.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_rz1000.c	2007-03-01 15:05:56.540516648 +0000
@@ -21,35 +21,10 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_rz1000"
-#define DRV_VERSION	"0.2.3"
+#define DRV_VERSION	"0.2.4"
 
 
 /**
- *	rz1000_prereset		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generics
- */
-
-static int rz1000_prereset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	rz1000_error_handler		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA standard reset sequence
- */
-
-static void rz1000_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, rz1000_prereset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	rz1000_set_mode		-	mode setting function
  *	@ap: ATA interface
  *	@unused: returned device on set_mode failure
@@ -120,8 +95,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= rz1000_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
