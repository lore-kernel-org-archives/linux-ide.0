From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata_generic: remove all the crud again and use cable
 methods
Date: Thu, 8 Mar 2007 19:21:38 +0000
Message-ID: <20070308192138.4bdf9e22@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43440 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752620AbXCHSRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:17:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/ata_generic.c linux-2.6.21-rc3-mm2/drivers/ata/ata_generic.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/ata_generic.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/ata_generic.c	2007-03-08 16:43:51.000000000 +0000
@@ -33,36 +33,6 @@
  */
 
 /**
- *	generic_pre_reset		-	probe begin
- *	@ap: ATA port
- *	@deadline: deadline jiffies for the operation
- *
- *	Set up cable type and use generic probe init
- */
-
-static int generic_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap, deadline);
-}
-
-
-/**
- *	generic_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *	@classes:
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-
-static void generic_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, generic_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	generic_set_mode	-	mode setting
  *	@ap: interface to set up
  *	@unused: returned device on error
@@ -145,8 +115,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= generic_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
