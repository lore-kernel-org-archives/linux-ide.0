From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_amd: remove contamination added during cable_detect conversion
Date: Mon, 23 Apr 2007 02:04:38 +0900
Message-ID: <20070422170438.GK10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:13962 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161499AbXDVREo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:04:44 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1326581wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:04:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is added by added by cff63dfceb52c564fe1ba5394d50ab7d599a11b9
 - pata: cable methods.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/pata_amd.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 5a77e4e..536ee89 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -639,11 +639,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (type == 1 && rev > 0x7)
 		type = 2;
 
-#if defined(CONFIG_ATA_ACPI)
-	/* Prefer the ACPI driver for Nvidia hardware */
-	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA && ata_pata_acpi_present(pdev))
-		return -ENODEV;
-#endif
 	/* Check for AMD7411 */
 	if (type == 3)
 		/* FIFO is broken */
-- 
1.5.0.3

