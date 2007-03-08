From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_marvell: Restore cable methods and reapply lost bug
 fix
Date: Thu, 8 Mar 2007 19:41:27 +0000
Message-ID: <20070308194127.4439331c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59152 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932936AbXCHShS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:37:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_marvell.c linux-2.6.21-rc3-mm2/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_marvell.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_marvell.c	2007-03-08 16:28:50.000000000 +0000
@@ -20,7 +20,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_marvell"
-#define DRV_VERSION	"0.1.1"
+#define DRV_VERSION	"0.1.4"
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
@@ -53,22 +53,23 @@
 	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
+	return ata_std_prereset(ap, deadline);
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
-	return ata_std_prereset(ap, deadline);
+	BUG();
+	return 0;	/* Our BUG macro needs the right markup */
 }
 
 /**
@@ -124,6 +125,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= marvell_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= marvell_cable_detect,
 
 	/* BMDMA handling is PCI ATA format, use helpers */
 	.bmdma_setup		= ata_bmdma_setup,
