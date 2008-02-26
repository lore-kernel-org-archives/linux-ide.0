From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata: "I do not think it means, what you think it means."
Date: Tue, 26 Feb 2008 16:05:08 +0000
Message-ID: <20080226160508.5d358ab4@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58421 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbYBZQP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 11:15:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

When masking mask out the modes that are unsupported not the ones that
are supported. This makes life happier. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_hpt366.c linux-2.6.25-rc2-mm1/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_hpt366.c	2008-02-19 11:01:37.000000000 +0000
+++ linux-2.6.25-rc2-mm1/drivers/ata/pata_hpt366.c	2008-02-26 12:47:49.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.1"
+#define DRV_VERSION	"0.6.2"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -180,9 +180,9 @@
 		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
 		if (hpt_dma_blacklisted(adev, "UDMA3", bad_ata66_3))
-			mask &= ~(0x07 << ATA_SHIFT_UDMA);
+			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
-			mask &= ~(0x0F << ATA_SHIFT_UDMA);
+			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_hpt37x.c linux-2.6.25-rc2-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_hpt37x.c	2008-02-19 11:03:00.000000000 +0000
+++ linux-2.6.25-rc2-mm1/drivers/ata/pata_hpt37x.c	2008-02-26 11:09:11.000000000 +0000
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.9"
+#define DRV_VERSION	"0.6.11"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -281,7 +281,7 @@
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
-			mask &= ~(0x1F << ATA_SHIFT_UDMA);
+			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
@@ -297,7 +297,7 @@
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
-			mask &= ~ (0x1F << ATA_SHIFT_UDMA);
+			mask &= ~ (0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_serverworks.c linux-2.6.25-rc2-mm1/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.25-rc2-mm1/drivers/ata/pata_serverworks.c	2008-02-19 11:03:00.000000000 +0000
+++ linux-2.6.25-rc2-mm1/drivers/ata/pata_serverworks.c	2008-02-26 12:48:49.000000000 +0000
@@ -226,7 +226,7 @@
 
 	for (i = 0; (p = csb_bad_ata100[i]) != NULL; i++) {
 		if (!strcmp(p, model_num))
-			mask &= ~(0x1F << ATA_SHIFT_UDMA);
+			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
