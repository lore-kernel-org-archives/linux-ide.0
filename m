From: akpm@linux-foundation.org
Subject: [patch 22/30] pata_rz1000: remove lots of crap by using cable method
Date: Tue, 06 Mar 2007 02:38:07 -0800
Message-ID: <200703061038.l26Ac7u7019530@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34493 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934054AbXCFKic (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_rz1000.c |   30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff -puN drivers/ata/pata_rz1000.c~pata_rz1000-remove-lots-of-crap-by-using-cable-method drivers/ata/pata_rz1000.c
--- a/drivers/ata/pata_rz1000.c~pata_rz1000-remove-lots-of-crap-by-using-cable-method
+++ a/drivers/ata/pata_rz1000.c
@@ -21,35 +21,10 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_rz1000"
-#define DRV_VERSION	"0.2.3"
+#define DRV_VERSION	"0.2.4"
 
 
 /**
- *	rz1000_prereset		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generics
- */
-
-static int rz1000_prereset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	rz1000_error_handler		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA standard reset sequence
- */
-
-static void rz1000_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, rz1000_prereset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	rz1000_set_mode		-	mode setting function
  *	@ap: ATA interface
  *	@unused: returned device on set_mode failure
@@ -122,8 +97,9 @@ static struct ata_port_operations rz1000
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= rz1000_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
_
