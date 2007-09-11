From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/10] serverworks: remove dead code from svwks_set_dma_mode()
Date: Tue, 11 Sep 2007 23:37:43 +0200
Message-ID: <200709112337.43081.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:27297 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXIKVkT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1152nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -157,13 +157,6 @@ static void svwks_set_dma_mode(ide_drive
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
 
-	/* If we are about to put a disk into UDMA mode we screwed up.
-	   Our code assumes we never _ever_ do this on an OSB4 */
-	   
-	if(dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4 &&
-		drive->media == ide_disk && speed >= XFER_UDMA_0)
-			BUG();
-
 	pci_read_config_byte(dev, (0x56|hwif->channel), &ultra_timing);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
