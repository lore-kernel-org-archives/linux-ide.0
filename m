From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: kill SATA_PATA_SHARING register handling
Date: Fri, 21 Sep 2007 17:55:44 +0900
Message-ID: <20070921085544.GE10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:3595 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXIUIzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 04:55:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so914554wah
        for <linux-ide@vger.kernel.org>; Fri, 21 Sep 2007 01:55:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

The SATA_PATA_SHARING register doesn't have anything to do with the
SATA part of the controller.  It indicates whether an extern SATA PHY
is attached to the PATA part of the controller and if so how it is
wired.  As the PATA part is driven by pata_via, sata_via has no reason
to care about that.  Also, pata_via should work fine under all
configurations.

This patch removes unnecessary attach failures.  It seems recent via
chipsets are defaulting to different values or are actually connected
to SATA PHY triggering this more often.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_via.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f075702..1dc9b4f 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -57,7 +57,6 @@ enum {
 	SATA_CHAN_ENAB		= 0x40, /* SATA channel enable */
 	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
 	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
-	SATA_PATA_SHARING	= 0x49, /* PATA/SATA sharing func ctrl */
 	PATA_UDMA_TIMING	= 0xB3, /* PATA timing for DMA/ cable detect */
 	PATA_PIO_TIMING		= 0xAB, /* PATA timing register */
 
@@ -68,7 +67,6 @@ enum {
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
 	SATA_EXT_PHY		= (1 << 6), /* 0==use PATA, 1==ext phy */
-	SATA_2DEV		= (1 << 5), /* SATA is master/slave */
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -508,7 +506,6 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_host *host;
 	int board_id = (int) ent->driver_data;
 	const int *bar_sizes;
-	u8 tmp8;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -517,19 +514,10 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (board_id == vt6420) {
-		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
-		if (tmp8 & SATA_2DEV) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "SATA master/slave not supported (0x%x)\n",
-		       		   (int) tmp8);
-			return -EIO;
-		}
-
+	if (board_id == vt6420)
 		bar_sizes = &svia_bar_sizes[0];
-	} else {
+	else
 		bar_sizes = &vt6421_bar_sizes[0];
-	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||
