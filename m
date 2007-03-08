From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_oldpiix: Restore cable method, re-correct comments
Date: Thu, 8 Mar 2007 19:45:32 +0000
Message-ID: <20070308194532.11500ddd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52964 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932997AbXCHSlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:41:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_oldpiix.c linux-2.6.21-rc3-mm2/drivers/ata/pata_oldpiix.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_oldpiix.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_oldpiix.c	2007-03-08 16:31:48.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_oldpiix"
-#define DRV_VERSION	"0.5.4"
+#define DRV_VERSION	"0.5.9"
 
 /**
  *	oldpiix_pre_reset		-	probe begin
@@ -45,7 +45,6 @@
 
 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -66,7 +65,7 @@
 /**
  *	oldpiix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
- *	@adev: um
+ *	@adev: Device whose timings we are configuring
  *
  *	Set PIO mode for device, in host controller PCI config space.
  *
@@ -256,6 +255,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= oldpiix_pata_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
