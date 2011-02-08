From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/20] pata_oldpiix: enable parallel scan
Date: Tue, 08 Feb 2011 13:25:27 +0100
Message-ID: <20110208122527.19110.18002.sendpatchset@linux-mhg7.site>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>From 0343103ea4e3f8c35f938d9198f3ea265755ea6a Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 8 Feb 2011 12:39:27 +0100
Subject: [PATCH 15/20] pata_oldpiix: enable parallel scan

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_oldpiix.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 845ede1..819192d 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -222,7 +222,8 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_bmdma_init_one(pdev, ppi, &oldpiix_sht, NULL, 0);
+	return ata_pci_bmdma_init_one(pdev, ppi, &oldpiix_sht, NULL,
+				      ATA_HOST_PARALLEL_SCAN);
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
-- 
1.7.1
