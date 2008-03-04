From: akpm@linux-foundation.org
Subject: [patch 3/3] pata: "I do not think it means, what you think it means."
Date: Tue, 04 Mar 2008 15:16:17 -0800
Message-ID: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52858 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934935AbYCDXRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 18:17:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

When masking mask out the modes that are unsupported not the ones that are
supported.  This makes life happier.

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_hpt366.c      |    6 +++---
 drivers/ata/pata_hpt37x.c      |    6 +++---
 drivers/ata/pata_serverworks.c |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff -puN drivers/ata/pata_hpt366.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_hpt366.c
--- a/drivers/ata/pata_hpt366.c~pata-i-do-not-think-it-means-what-you-think-it-means
+++ a/drivers/ata/pata_hpt366.c
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.1"
+#define DRV_VERSION	"0.6.2"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -180,9 +180,9 @@ static unsigned long hpt366_filter(struc
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
diff -puN drivers/ata/pata_hpt37x.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_hpt37x.c
--- a/drivers/ata/pata_hpt37x.c~pata-i-do-not-think-it-means-what-you-think-it-means
+++ a/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.9"
+#define DRV_VERSION	"0.6.11"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -281,7 +281,7 @@ static unsigned long hpt370_filter(struc
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
-			mask &= ~(0x1F << ATA_SHIFT_UDMA);
+			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
@@ -297,7 +297,7 @@ static unsigned long hpt370a_filter(stru
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
-			mask &= ~ (0x1F << ATA_SHIFT_UDMA);
+			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
diff -puN drivers/ata/pata_serverworks.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_serverworks.c
--- a/drivers/ata/pata_serverworks.c~pata-i-do-not-think-it-means-what-you-think-it-means
+++ a/drivers/ata/pata_serverworks.c
@@ -226,7 +226,7 @@ static unsigned long serverworks_csb_fil
 
 	for (i = 0; (p = csb_bad_ata100[i]) != NULL; i++) {
 		if (!strcmp(p, model_num))
-			mask &= ~(0x1F << ATA_SHIFT_UDMA);
+			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(adev, mask);
 }
_
