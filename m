From: Komuro <komurojun-mbn@nifty.com>
Subject: [PATCH: kernel 2.6.16-rc6] CMD643 does not support DMA
Date: Sun, 19 Mar 2006 10:58:51 +0900
Message-ID: <20060319105851.3c1414ee.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userg503.nifty.com ([202.248.238.83]:43697 "EHLO
	userg503.nifty.com") by vger.kernel.org with ESMTP id S1751223AbWCSCIS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Mar 2006 21:08:18 -0500
Received: from asus.host.name (eaoska170162.adsl.ppp.infoweb.ne.jp [219.116.19.162])by userg503.nifty.com with SMTP id k2J28Cil017283
	for <linux-ide@vger.kernel.org>; Sun, 19 Mar 2006 11:08:12 +0900
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,

cmd64x.c :CMD643 does not support DMA.

Signed-off-by: komurojun-mbn@nifty.com

--- linux-2.6.16-rc6/drivers/ide/pci/cmd64x.c.orig	2006-03-18 20:24:04.000000000 +0900
+++ linux-2.6.16-rc6/drivers/ide/pci/cmd64x.c	2006-03-18 20:26:49.000000000 +0900
@@ -725,8 +725,11 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (dev->device == PCI_DEVICE_ID_CMD_643)
+	if (dev->device == PCI_DEVICE_ID_CMD_643) {
 		hwif->ultra_mask = 0x80;
+		hwif->mwdma_mask = 0x80;
+		hwif->swdma_mask = 0x80;
+	}
 	if (dev->device == PCI_DEVICE_ID_CMD_646)
 		hwif->ultra_mask = (class_rev > 0x04) ? 0x07 : 0x80;
 	if (dev->device == PCI_DEVICE_ID_CMD_648)


Best Regards
Komuro
