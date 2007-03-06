From: akpm@linux-foundation.org
Subject: [patch 12/30] ata_generic: Remove lots of code using the new cable_detect method
Date: Tue, 06 Mar 2007 02:37:59 -0800
Message-ID: <200703061038.l26AbxXr019493@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34499 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934057AbXCFKih (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

(And correct the cable type to unknown while we are at it)

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ata_generic.c |   32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff -puN drivers/ata/ata_generic.c~ata_generic-remove-lots-of-code-using-the-new-cable_detect drivers/ata/ata_generic.c
--- a/drivers/ata/ata_generic.c~ata_generic-remove-lots-of-code-using-the-new-cable_detect
+++ a/drivers/ata/ata_generic.c
@@ -33,35 +33,6 @@
  */
 
 /**
- *	generic_pre_reset		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generic probe init
- */
-
-static int generic_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
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
@@ -144,8 +115,9 @@ static struct ata_port_operations generi
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= generic_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
_
