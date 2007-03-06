From: akpm@linux-foundation.org
Subject: [patch 19/30] pata_netcell: remove lots of crud by using the cable method
Date: Tue, 06 Mar 2007 02:38:05 -0800
Message-ID: <200703061038.l26Ac5Eo019518@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34461 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934037AbXCFKiV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_netcell.c |   31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff -puN drivers/ata/pata_netcell.c~pata_netcell-remove-lots-of-crud-by-using-the-cable-method drivers/ata/pata_netcell.c
--- a/drivers/ata/pata_netcell.c~pata_netcell-remove-lots-of-crud-by-using-the-cable-method
+++ a/drivers/ata/pata_netcell.c
@@ -16,33 +16,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_netcell"
-#define DRV_VERSION	"0.1.6"
-
-/**
- *	netcell_probe_init	-	check for 40/80 pin
- *	@ap: Port
- *
- *	Cables are handled by the RAID controller. Report 80 pin.
- */
-
-static int netcell_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	netcell_probe_reset - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void netcell_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, netcell_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
+#define DRV_VERSION	"0.1.7"
 
 /* No PIO or DMA methods needed for this device */
 
@@ -81,8 +55,9 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= netcell_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_80wire,
 
 	/* BMDMA handling is PCI ATA format, use helpers */
 	.bmdma_setup		= ata_bmdma_setup,
_
