From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sl82c105: Restore cable detect method
Date: Thu, 8 Mar 2007 23:02:52 +0000
Message-ID: <20070308230252.1b83a6a2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54287 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030696AbXCHV6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 16:58:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sl82c105.c linux-2.6.21-rc3-mm2/drivers/ata/pata_sl82c105.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sl82c105.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_sl82c105.c	2007-03-08 16:47:50.000000000 +0000
@@ -59,7 +59,6 @@
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -239,6 +238,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sl82c105_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= sl82c105_bmdma_start,
