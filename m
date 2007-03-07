From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ns87410: cable detect method
Date: Wed, 7 Mar 2007 16:22:07 +0000
Message-ID: <20070307162207.049af79d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48912 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751743AbXCGPR4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:17:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c linux-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c	2007-03-06 23:36:02.000000000 +0000
@@ -28,13 +28,13 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ns87410"
-#define DRV_VERSION "0.4.3"
+#define DRV_VERSION "0.4.6"
 
 /**
  *	ns87410_pre_reset		-	probe begin
  *	@ap: ATA port
  *
- *	Set up cable type and use generic probe init
+ *	Check enabled ports
  */
 
 static int ns87410_pre_reset(struct ata_port *ap)
@@ -47,7 +47,6 @@
 
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -177,6 +176,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ns87410_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ns87410_qc_issue_prot,
