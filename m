From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sil680: cable detect
Date: Wed, 7 Mar 2007 16:30:30 +0000
Message-ID: <20070307163030.3291f044@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33669 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751948AbXCGP0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:26:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Much the same as the others except we have to keep our own error_handler
methods as the chip has bus reset registers that we need to poke.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_sil680.c linux-2.6.21-rc2-mm2/drivers/ata/pata_sil680.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_sil680.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_sil680.c	2007-03-06 23:36:26.000000000 +0000
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sil680"
-#define DRV_VERSION "0.4.5"
+#define DRV_VERSION "0.4.6"
 
 /**
  *	sil680_selreg		-	return register base
@@ -91,12 +91,6 @@
 		return ATA_CBL_PATA40;
 }
 
-static int sil680_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = sil680_cable_detect(ap);
-	return ata_std_prereset(ap);
-}
-
 /**
  *	sil680_bus_reset	-	reset the SIL680 bus
  *	@ap: ATA port to reset
@@ -119,7 +113,7 @@
 
 static void sil680_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, sil680_pre_reset, sil680_bus_reset, NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, ata_std_prereset, sil680_bus_reset, NULL, ata_std_postreset);
 }
 
 /**
@@ -257,6 +251,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sil680_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= sil680_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
