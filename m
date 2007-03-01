From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_radisys - switch to cable method to cleanup code,
 correct cable type
Date: Thu, 1 Mar 2007 17:52:40 +0000
Message-ID: <20070301175240.4930ba27@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965378AbXCAQsd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_radisys.c linux-2.6.21-rc2/drivers/ata/pata_radisys.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_radisys.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_radisys.c	2007-03-01 15:05:41.102863528 +0000
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
@@ -246,8 +218,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= radisys_pata_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
