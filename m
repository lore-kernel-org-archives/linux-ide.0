From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_netcell: re-remove all the crud
Date: Thu, 8 Mar 2007 19:43:45 +0000
Message-ID: <20070308194345.6bab7a35@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52956 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933001AbXCHSjg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:39:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_netcell.c linux-2.6.21-rc3-mm2/drivers/ata/pata_netcell.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_netcell.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_netcell.c	2007-03-08 16:46:53.000000000 +0000
@@ -16,34 +16,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_netcell"
-#define DRV_VERSION	"0.1.6"
-
-/**
- *	netcell_probe_init	-	check for 40/80 pin
- *	@ap: Port
- *	@deadline: deadline jiffies for the operation
- *
- *	Cables are handled by the RAID controller. Report 80 pin.
- */
-
-static int netcell_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap, deadline);
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
 
@@ -82,8 +55,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= netcell_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_80wire,
 
 	/* BMDMA handling is PCI ATA format, use helpers */
 	.bmdma_setup		= ata_bmdma_setup,
