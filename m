From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cs5535: re-remove all the crap and switch to the cable
 detect method
Date: Thu, 8 Mar 2007 19:31:41 +0000
Message-ID: <20070308193141.3ad08c07@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60505 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932583AbXCHS1d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:27:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_cs5535.c linux-2.6.21-rc3-mm2/drivers/ata/pata_cs5535.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_cs5535.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_cs5535.c	2007-03-08 16:45:57.000000000 +0000
@@ -39,7 +39,7 @@
 #include <asm/msr.h>
 
 #define DRV_NAME	"cs5535"
-#define DRV_VERSION	"0.2.11"
+#define DRV_VERSION	"0.2.12"
 
 /*
  *	The Geode (Aka Athlon GX now) uses an internal MSR based
@@ -70,37 +70,22 @@
 #define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL)==0x00009172 )
 
 /**
- *	cs5535_pre_reset	-	detect cable type
+ *	cs5535_cable_detect	-	detect cable type
  *	@ap: Port to detect on
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for ATA66 capable cable. Return a libata
  *	cable type.
  */
 
-static int cs5535_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int cs5535_cable_detect(struct ata_port *ap)
 {
 	u8 cable;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, CS5535_CABLE_DETECT, &cable);
 	if (cable & 1)
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap, deadline);
-}
-
-/**
- *	cs5535_error_handler		-	reset/probe
- *	@ap: Port to reset
- *
- *	Reset and configure a port
- */
-
-static void cs5535_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cs5535_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+		return ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -206,8 +191,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cs5535_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= cs5535_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
