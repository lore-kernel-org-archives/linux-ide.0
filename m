From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] alim15x3: remove stale warning about ATI RS100 northbridge
Date: Thu, 8 May 2008 23:04:12 +0200
Message-ID: <200805082304.12386.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52525 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759296AbYEHUuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:50:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so633182fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 13:50:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |    8 --------
 1 file changed, 8 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -522,17 +522,9 @@ static const struct ide_port_info ali15x
  
 static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	static struct pci_device_id ati_rs100[] = {
-		{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100) },
-		{ },
-	};
-
 	struct ide_port_info d = ali15x3_chipset;
 	u8 rev = dev->revision, idx = id->driver_data;
 
-	if (pci_dev_present(ati_rs100))
-		printk(KERN_WARNING "alim15x3: ATI Radeon IGP Northbridge is not yet fully tested.\n");
-
 	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
 	if (rev <= 0xC4)
 		d.host_flags |= IDE_HFLAG_NO_LBA48_DMA;
