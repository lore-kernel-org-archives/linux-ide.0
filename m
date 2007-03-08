From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_radisys: Re-remove all the crap and switch back to
 cable methods
Date: Thu, 8 Mar 2007 22:56:07 +0000
Message-ID: <20070308225607.4fbb0cf7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51741 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030690AbXCHVvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 16:51:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <number6@the-village.bc.nu>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_radisys.c linux-2.6.21-rc3-mm2/drivers/ata/pata_radisys.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_radisys.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_radisys.c	2007-03-08 16:47:12.000000000 +0000
@@ -24,41 +24,12 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_radisys"
-#define DRV_VERSION	"0.4.1"
-
-/**
- *	radisys_probe_init		-	probe begin
- *	@ap: ATA port
- *	@deadline: deadline jiffies for the operation
- *
- *	Set up cable type and use generic probe init
- */
-
-static int radisys_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap, deadline);
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
@@ -249,8 +220,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= radisys_pata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
