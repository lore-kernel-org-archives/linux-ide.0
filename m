From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Wed, 23 Jul 2008 15:42:27 +0100
Message-ID: <20080723144227.253944199@fluff.org>
References: <20080723144226.807475493@fluff.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hull.simtec.co.uk ([78.105.113.97]:33125 "EHLO
	ivanova.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752232AbYGWPa1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 11:30:27 -0400
Content-Disposition: inline; filename=simtec/simtec-libata-deal-with-unmapped-irqs.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>

The Simtec CATS board is an example of an ALI M5229 that
is not correclty supported by libata as the pdev->irq field
has no valid interrupt set. This is due to the legacy IRQ
check in ata_pci_sff_activate_host() only checking to see 
if the device class is legacy, not that the IRQ has been
setup.

Change ata_pci_sff_activate_host() to try the legacy IRQ
numbers (which works correctly) when the dev->irq has not
been set. The current check for !legacy_mode && dev->irq
does not deal with devices that are not in legacy mode
but do not have mapped interrupts.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt2/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.26-quilt2.orig/drivers/ata/libata-sff.c	2008-07-23 15:11:36.000000000 +0100
+++ linux-2.6.26-quilt2/drivers/ata/libata-sff.c	2008-07-23 15:11:48.000000000 +0100
@@ -2702,7 +2702,7 @@ int ata_pci_sff_activate_host(struct ata
 
 		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
 		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
-	} else if (legacy_mode) {
+	} else if (legacy_mode || !pdev->irq) {
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
 					      irq_handler, IRQF_SHARED,

-- 
