From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ide: device/vendor confusion
Date: Sun, 15 Feb 2009 22:53:09 +0100
Message-ID: <49988EC5.40704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:12684 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZBOVxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 16:53:09 -0500
Received: by nf-out-0910.google.com with SMTP id d21so183675nfb.21
        for <linux-ide@vger.kernel.org>; Sun, 15 Feb 2009 13:53:07 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Device and vendor ids were confused

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 69660a4..77267c8 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -166,7 +166,7 @@ static unsigned int init_chipset_amd74xx(struct pci_dev *dev)
 	 * Check for broken FIFO support.
 	 */
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-	    dev->vendor == PCI_DEVICE_ID_AMD_VIPER_7411)
+	    dev->device == PCI_DEVICE_ID_AMD_VIPER_7411)
 		t &= 0x0f;
 	else
 		t |= 0xf0;
