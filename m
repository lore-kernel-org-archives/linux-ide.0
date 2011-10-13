From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] pata_oldpiix: enable parallel scan
Date: Thu, 13 Oct 2011 16:03:34 +0200
Message-ID: <201110131603.34443.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_oldpiix: enable parallel scan

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
earlier references:
https://lkml.org/lkml/2011/2/8/111
https://lkml.org/lkml/2010/2/18/275

 drivers/ata/pata_oldpiix.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_oldpiix.c
===================================================================
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -258,7 +258,8 @@ static int oldpiix_init_one (struct pci_
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
-	return ata_pci_bmdma_init_one(pdev, ppi, &oldpiix_sht, NULL, 0);
+	return ata_pci_bmdma_init_one(pdev, ppi, &oldpiix_sht, NULL,
+				      ATA_HOST_PARALLEL_SCAN);
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
