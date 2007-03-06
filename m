From: akpm@linux-foundation.org
Subject: [patch 15/30] pata_cypress: clean up by using cable_detect method
Date: Tue, 06 Mar 2007 02:38:02 -0800
Message-ID: <200703061038.l26Ac2Zb019503@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34467 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934042AbXCFKiX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_cypress.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff -puN drivers/ata/pata_cypress.c~pata_cypress-clean-up-by-using-cable_detect-method drivers/ata/pata_cypress.c
--- a/drivers/ata/pata_cypress.c~pata_cypress-clean-up-by-using-cable_detect-method
+++ a/drivers/ata/pata_cypress.c
@@ -41,17 +41,6 @@ enum {
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
-static int cy82c693_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static void cy82c693_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cy82c693_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	cy82c693_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -156,8 +145,9 @@ static struct ata_port_operations cy82c6
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cy82c693_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
_
