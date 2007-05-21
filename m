From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata_piix: clean up
Date: Mon, 21 May 2007 15:15:51 +0100
Message-ID: <20070521151551.651e3836@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34680 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753689AbXEUOLp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:11:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

With cable methods in place we don't need a custom error handler for SATA
so get rid of it

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/ata_piix.c linux-2.6.22-rc1-mm1/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/ata_piix.c	2007-05-18 16:21:46.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/ata_piix.c	2007-05-18 16:46:34.000000000 +0100
@@ -155,7 +155,6 @@
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 static void piix_pata_error_handler(struct ata_port *ap);
-static void piix_sata_error_handler(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode (struct ata_port *ap, struct ata_device *adev);
@@ -364,7 +363,7 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= piix_sata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -641,12 +640,6 @@
 			   ata_std_postreset);
 }
 
-static void piix_sata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
-			   ata_std_postreset);
-}
-
 /**
  *	piix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
