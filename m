From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_marvell: Cable and reset fixes
Date: Wed, 7 Mar 2007 16:48:09 +0000
Message-ID: <20070307164809.5802649a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58366 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752038AbXCGPnw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:43:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

There are two changes here. Firstly we switch to a cable detect method,
secondly the old code forgot to call ata_std_prereset() but somehow
managed to work anyway. Fix the missing call.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_marvell.c linux-2.6.21-rc2-mm2/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_marvell.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_marvell.c	2007-03-06 23:35:28.000000000 +0000
@@ -20,7 +20,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_marvell"
-#define DRV_VERSION	"0.1.1"
+#define DRV_VERSION	"0.1.4"
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
@@ -52,22 +52,23 @@
 	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
+	return ata_std_prereset(ap);
+}
 
+static int marvell_cable_detect(struct ata_port *ap)
+{
 	/* Cable type */
 	switch(ap->port_no)
 	{
 	case 0:
 		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
-			ap->cbl = ATA_CBL_PATA40;
-		else
-			ap->cbl = ATA_CBL_PATA80;
-		break;
-
+			return ATA_CBL_PATA40;
+		return ATA_CBL_PATA80;
 	case 1: /* Legacy SATA port */
-		ap->cbl = ATA_CBL_SATA;
-		break;
+		return ATA_CBL_SATA;
 	}
-	return ata_std_prereset(ap);
+	BUG();
+	return 0;	/* Our BUG macro needs the right markup */
 }
 
 /**
@@ -123,6 +124,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= marvell_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= marvell_cable_detect,
 
 	/* BMDMA handling is PCI ATA format, use helpers */
 	.bmdma_setup		= ata_bmdma_setup,
