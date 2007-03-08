From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_mpiix: restore cable type method
Date: Thu, 8 Mar 2007 19:43:00 +0000
Message-ID: <20070308194300.2d1d513e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52952 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932997AbXCHSiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:38:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_mpiix.c linux-2.6.21-rc3-mm2/drivers/ata/pata_mpiix.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_mpiix.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_mpiix.c	2007-03-08 17:12:02.000000000 +0000
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.5"
+#define DRV_VERSION "0.7.6"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -53,7 +53,6 @@
 
 	if (!pci_test_config_bits(pdev, &mpiix_enable_bits))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -185,6 +184,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= mpiix_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= mpiix_qc_issue_prot,
