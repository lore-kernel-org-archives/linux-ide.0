From: akpm@linux-foundation.org
Subject: [patch 20/30] pata_radisys - switch to cable method to cleanup code, correct cable type
Date: Tue, 06 Mar 2007 02:38:06 -0800
Message-ID: <200703061038.l26Ac65W019521@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34466 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934044AbXCFKiX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_radisys.c |   37 ++++-------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff -puN drivers/ata/pata_radisys.c~pata_radisys-switch-to-cable-method-to-cleanup-code drivers/ata/pata_radisys.c
--- a/drivers/ata/pata_radisys.c~pata_radisys-switch-to-cable-method-to-cleanup-code
+++ a/drivers/ata/pata_radisys.c
@@ -24,40 +24,12 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_radisys"
-#define DRV_VERSION	"0.4.1"
-
-/**
- *	radisys_probe_init		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generic probe init
- */
-
-static int radisys_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-}
-
-
-/**
- *	radisys_pata_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *	@classes:
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void radisys_pata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, radisys_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
+#define DRV_VERSION	"0.4.4"
 
 /**
  *	radisys_set_piomode - Initialize host controller PATA PIO timings
- *	@ap: Port whose timings we are configuring
- *	@adev: um
+ *	@ap: ATA port
+ *	@adev: Device whose timings we are configuring
  *
  *	Set PIO mode for device, in host controller PCI config space.
  *
@@ -248,8 +220,9 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= radisys_pata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
_
