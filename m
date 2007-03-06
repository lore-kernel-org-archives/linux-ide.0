From: akpm@linux-foundation.org
Subject: [patch 25/30] pata_hpt3x3: clean up by using cable method
Date: Tue, 06 Mar 2007 02:38:10 -0800
Message-ID: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34496 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934050AbXCFKig (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_hpt3x3.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff -puN drivers/ata/pata_hpt3x3.c~pata_hpt3x3-clean-up-by-using-cable-method drivers/ata/pata_hpt3x3.c
--- a/drivers/ata/pata_hpt3x3.c~pata_hpt3x3-clean-up-by-using-cable-method
+++ a/drivers/ata/pata_hpt3x3.c
@@ -25,25 +25,6 @@
 #define DRV_NAME	"pata_hpt3x3"
 #define DRV_VERSION	"0.4.2"
 
-static int hpt3x3_probe_init(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	hpt3x3_probe_reset	-	reset the hpt3x3 bus
- *	@ap: ATA port to reset
- *
- *	Perform the housekeeping when doing an ATA bus reeset. We just
- *	need to force the cable type.
- */
-
-static void hpt3x3_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, hpt3x3_probe_init, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	hpt3x3_set_piomode		-	PIO setup
  *	@ap: ATA interface
@@ -139,8 +120,9 @@ static struct ata_port_operations hpt3x3
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt3x3_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
_
