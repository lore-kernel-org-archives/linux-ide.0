From: akpm@linux-foundation.org
Subject: [patch 11/30] pata_sl82c105: Missing methods, cable
Date: Tue, 06 Mar 2007 02:37:59 -0800
Message-ID: <200703061037.l26AbxRq019490@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34497 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934056AbXCFKig (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Missing freeze, thaw, post_internal methods, also switch to new cable method
in passing.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_sl82c105.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/pata_sl82c105.c~pata_sl82c105-missing-methods-cable drivers/ata/pata_sl82c105.c
--- a/drivers/ata/pata_sl82c105.c~pata_sl82c105-missing-methods-cable
+++ a/drivers/ata/pata_sl82c105.c
@@ -58,7 +58,6 @@ static int sl82c105_pre_reset(struct ata
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -238,6 +237,7 @@ static struct ata_port_operations sl82c1
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sl82c105_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= sl82c105_bmdma_start,
_
