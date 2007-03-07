From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_serverworks: Cable detect and comment fix
Date: Wed, 7 Mar 2007 16:50:55 +0000
Message-ID: <20070307165055.4fe802d8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40403 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751939AbXCGPqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:46:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

- Switch to cable_detect method
- Correct name of driver in initial comments

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_serverworks.c linux-2.6.21-rc2-mm2/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_serverworks.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_serverworks.c	2007-03-06 23:36:26.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * ata-serverworks.c 	- Serverworks PATA for new ATA layer
+ * pata_serverworks.c 	- Serverworks PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@redhat.com>
  *
@@ -137,14 +137,14 @@
 };
 
 /**
- *	serverworks_pre_reset		-	cable detection
+ *	serverworks_cable_detect	-	cable detection
  *	@ap: ATA port
  *
  *	Perform cable detection according to the device and subvendor
  *	identifications
  */
 
-static int serverworks_pre_reset(struct ata_port *ap) {
+static int serverworks_cable_detect(struct ata_port *ap) {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct sv_cable_table *cb = cable_detect;
 
@@ -152,8 +152,7 @@
 		if (cb->device == pdev->device &&
 		    (cb->subvendor == pdev->subsystem_vendor ||
 		      cb->subvendor == PCI_ANY_ID)) {
-			ap->cbl = cb->cable_detect(ap);
-			return ata_std_prereset(ap);
+			return cb->cable_detect(ap);
 		}
 		cb++;
 	}
@@ -162,11 +161,6 @@
 	return -1;	/* kill compiler warning */
 }
 
-static void serverworks_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, serverworks_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	serverworks_is_csb	-	Check for CSB or OSB
  *	@pdev: PCI device to check
@@ -339,8 +333,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= serverworks_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= serverworks_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -374,8 +369,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= serverworks_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= serverworks_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
