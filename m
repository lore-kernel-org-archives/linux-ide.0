From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sil680: Restore cable detect methods
Date: Thu, 8 Mar 2007 23:00:48 +0000
Message-ID: <20070308230048.0f5fb3b7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50103 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030699AbXCHV4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 16:56:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sil680.c linux-2.6.21-rc3-mm2/drivers/ata/pata_sil680.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sil680.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_sil680.c	2007-03-08 17:06:00.000000000 +0000
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sil680"
-#define DRV_VERSION "0.4.5"
+#define DRV_VERSION "0.4.6"
 
 /**
  *	sil680_selreg		-	return register base
@@ -91,22 +91,16 @@
 		return ATA_CBL_PATA40;
 }
 
-static int sil680_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = sil680_cable_detect(ap);
-	return ata_std_prereset(ap, deadline);
-}
-
 /**
  *	sil680_bus_reset	-	reset the SIL680 bus
  *	@ap: ATA port to reset
+*	@classes:
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the SIL680 housekeeping when doing an ATA bus reset
  */
 
-static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes,
-			    unsigned long deadline)
+static int sil680_bus_reset(struct ata_port *ap, unsigned int *classes, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
@@ -121,7 +115,7 @@
 
 static void sil680_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, sil680_pre_reset, sil680_bus_reset, NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, ata_std_prereset, sil680_bus_reset, NULL, ata_std_postreset);
 }
 
 /**
@@ -259,6 +253,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sil680_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= sil680_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
