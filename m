From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_via: Use cable_detect method
Date: Wed, 7 Mar 2007 16:56:54 +0000
Message-ID: <20070307165654.0094eabd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38768 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751972AbXCGPwu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:52:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

We end up shifting a few bits of logic around in this driver but the
basic change is the same.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_via.c linux-2.6.21-rc2-mm2/drivers/ata/pata_via.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_via.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_via.c	2007-03-06 23:36:26.000000000 +0000
@@ -62,7 +62,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.3.1"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -135,16 +135,23 @@
  */
 
 static int via_cable_detect(struct ata_port *ap) {
+	const struct via_isa_bridge *config = ap->host->private_data;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 ata66;
 
+	/* Early chips are 40 wire */
+	if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
+		return ATA_CBL_PATA40;
+	/* UDMA 66 chips have only drive side logic */
+	else if((config->flags & VIA_UDMA) < VIA_UDMA_100)
+		return ATA_CBL_PATA_UNK;
+	/* UDMA 100 or later */
 	pci_read_config_dword(pdev, 0x50, &ata66);
 	/* Check both the drive cable reporting bits, we might not have
 	   two drives */
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
-	else
-		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA40;
 }
 
 static int via_pre_reset(struct ata_port *ap)
@@ -156,22 +163,10 @@
 			{ 0x40, 1, 0x02, 0x02 },
 			{ 0x40, 1, 0x01, 0x01 }
 		};
-
 		struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
 		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->port_no]))
 			return -ENOENT;
 	}
-
-	if ((config->flags & VIA_UDMA) >= VIA_UDMA_100)
-		ap->cbl = via_cable_detect(ap);
-	/* The UDMA66 series has no cable detect so do drive side detect */
-	else if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA_UNK;
-
-
 	return ata_std_prereset(ap);
 }
 
@@ -327,6 +322,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= via_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -362,6 +358,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= via_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
