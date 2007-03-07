From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_triflex: cable detect
Date: Wed, 7 Mar 2007 16:31:31 +0000
Message-ID: <20070307163131.2f411093@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33694 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbXCGP1Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:27:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_triflex.c linux-2.6.21-rc2-mm2/drivers/ata/pata_triflex.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_triflex.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_triflex.c	2007-03-06 23:36:26.000000000 +0000
@@ -43,7 +43,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_triflex"
-#define DRV_VERSION "0.2.7"
+#define DRV_VERSION "0.2.8"
 
 /**
  *	triflex_prereset		-	probe begin
@@ -63,7 +63,6 @@
 
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -214,6 +213,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= triflex_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= triflex_bmdma_start,
