From: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 1/2] pata-it821x: use UDMA_OFF for Vortex86SX for clearness
Date: Fri, 21 May 2010 19:09:32 -0300
Message-ID: <1274479772-8631-1-git-send-email-otavio@ossystems.com.br>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49137 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758708Ab0EUWJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 May 2010 18:09:42 -0400
Received: by gyg13 with SMTP id 13so695023gyg.19
        for <linux-ide@vger.kernel.org>; Fri, 21 May 2010 15:09:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Otavio Salvador <otavio@ossystems.com.br>

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/ata/pata_it821x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 5cb286f..1b869b6 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -899,7 +899,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
 		.mwdma_mask = ATA_MWDMA2,
-		/* No UDMA */
+		.udma_mask = UDMA_OFF,
 		.port_ops = &it821x_rdc_port_ops
 	};
 
-- 
1.7.0.3.291.g5e4f6

