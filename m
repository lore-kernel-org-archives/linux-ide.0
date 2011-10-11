From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5520: remove incorrect warning message
Date: Tue, 11 Oct 2011 20:00:44 +0200
Message-ID: <201110112000.44960.bzolnier@gmail.com>
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
Subject: [PATCH] pata_cs5520: remove incorrect warning message

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5520.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ata/pata_cs5520.c
===================================================================
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -148,10 +148,8 @@ static int __devinit cs5520_init_one(str
 	if (pcicfg & 2)
 		ppi[1] = &pi;
 
-	if ((pcicfg & 0x40) == 0) {
-		dev_warn(&pdev->dev, "DMA mode disabled. Enabling.\n");
+	if ((pcicfg & 0x40) == 0)
 		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
-	}
 
 	pi.mwdma_mask = id->driver_data;
 
