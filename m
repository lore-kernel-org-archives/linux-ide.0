From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] pata_cs5536.c bugfix
Date: Wed, 13 Feb 2008 01:41:44 -0500
Message-ID: <yq1abm5pdcn.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:61501 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYBMGmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 01:42:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org


Fix speed negotiation for secondary device.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

diff -r 9f5ca67cc28f drivers/ata/pata_cs5536.c
--- a/drivers/ata/pata_cs5536.c	Mon Feb 11 20:52:01 2008 -0800
+++ b/drivers/ata/pata_cs5536.c	Tue Feb 12 08:52:43 2008 -0500
@@ -40,7 +40,7 @@
 #include <asm/msr.h>
 
 #define DRV_NAME	"pata_cs5536"
-#define DRV_VERSION	"0.0.6"
+#define DRV_VERSION	"0.0.7"
 
 enum {
 	CFG			= 0,
@@ -153,8 +153,8 @@ static void cs5536_set_piomode(struct at
 	struct ata_device *pair = ata_dev_pair(adev);
 	int mode = adev->pio_mode - XFER_PIO_0;
 	int cmdmode = mode;
-	int dshift = ap->port_no ? IDE_D1_SHIFT : IDE_D0_SHIFT;
-	int cshift = ap->port_no ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
+	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	int cshift = adev->devno ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
 	u32 dtc, cast, etc;
 
 	if (pair)
@@ -201,7 +201,7 @@ static void cs5536_set_dmamode(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 dtc, etc;
 	int mode = adev->dma_mode;
-	int dshift = ap->port_no ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
 
 	if (mode >= XFER_UDMA_0) {
 		cs5536_read(pdev, ETC, &etc);
