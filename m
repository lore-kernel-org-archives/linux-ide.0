From: akpm@linux-foundation.org
Subject: [patch 13/30] pata_ali: remove lots of code by using the cable_detect method
Date: Tue, 06 Mar 2007 02:38:00 -0800
Message-ID: <200703061038.l26Ac0Bc019496@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34495 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934055AbXCFKig (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_ali.c |   65 ++++-----------------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff -puN drivers/ata/pata_ali.c~pata_ali-remove-lots-of-code-by-using-the-cable_detect drivers/ata/pata_ali.c
--- a/drivers/ata/pata_ali.c~pata_ali-remove-lots-of-code-by-using-the-cable_detect
+++ a/drivers/ata/pata_ali.c
@@ -90,59 +90,6 @@ static int ali_c2_cable_detect(struct at
 }
 
 /**
- *	ali_early_error_handler	-	reset for eary chip
- *	@ap: ATA port
- *
- *	Handle the reset callback for the later chips with cable detect
- */
-
-static int ali_c2_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ali_c2_cable_detect(ap);
-	return ata_std_prereset(ap);
-}
-
-static void ali_c2_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ali_c2_pre_reset,
-			       ata_std_softreset, NULL,
-			       ata_std_postreset);
-}
-
-/**
- *	ali_early_cable_detect	-	cable detection
- *	@ap: ATA port
- *
- *	Perform cable detection for older chipsets. This turns out to be
- *	rather easy to implement
- */
-
-static int ali_early_cable_detect(struct ata_port *ap)
-{
-	return ATA_CBL_PATA40;
-}
-
-/**
- *	ali_early_probe_init	-	reset for early chip
- *	@ap: ATA port
- *
- *	Handle the reset callback for the early (pre cable detect) chips.
- */
-
-static int ali_early_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ali_early_cable_detect(ap);
-	return ata_std_prereset(ap);
-}
-
-static void ali_early_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, ali_early_pre_reset,
-				     ata_std_softreset, NULL,
-				     ata_std_postreset);
-}
-
-/**
  *	ali_20_filter		-	filter for earlier ALI DMA
  *	@ap: ALi ATA port
  *	@adev: attached device
@@ -366,8 +313,9 @@ static struct ata_port_operations ali_ea
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_early_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -402,8 +350,9 @@ static struct ata_port_operations ali_20
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_early_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -440,8 +389,9 @@ static struct ata_port_operations ali_c2
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_c2_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ali_c2_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -477,8 +427,9 @@ static struct ata_port_operations ali_c5
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_c2_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ali_c2_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
_
