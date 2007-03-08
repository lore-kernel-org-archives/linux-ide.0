From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ns87410: Restore cable detect method
Date: Thu, 8 Mar 2007 19:44:38 +0000
Message-ID: <20070308194438.7f37979d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52960 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933012AbXCHSk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:40:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ns87410.c linux-2.6.21-rc3-mm2/drivers/ata/pata_ns87410.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ns87410.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_ns87410.c	2007-03-08 17:11:36.000000000 +0000
@@ -28,14 +28,14 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ns87410"
-#define DRV_VERSION "0.4.3"
+#define DRV_VERSION "0.4.6"
 
 /**
  *	ns87410_pre_reset		-	probe begin
  *	@ap: ATA port
  *	@deadline: deadline jiffies for the operation
  *
- *	Set up cable type and use generic probe init
+ *	Check enabled ports
  */
 
 static int ns87410_pre_reset(struct ata_port *ap, unsigned long deadline)
@@ -48,7 +48,6 @@
 
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -178,6 +177,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ns87410_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ns87410_qc_issue_prot,
