From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_opti: Restore cable method
Date: Thu, 8 Mar 2007 19:46:23 +0000
Message-ID: <20070308194623.0542d421@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52968 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933026AbXCHSmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:42:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_opti.c linux-2.6.21-rc3-mm2/drivers/ata/pata_opti.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_opti.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_opti.c	2007-03-08 16:33:45.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_opti"
-#define DRV_VERSION "0.2.8"
+#define DRV_VERSION "0.2.9"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -62,8 +62,6 @@
 
 	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -199,6 +197,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= opti_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
