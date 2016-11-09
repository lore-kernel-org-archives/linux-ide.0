From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 4/4] pata: imx: support controller modes up to PIO4
Date: Wed,  9 Nov 2016 02:56:38 +0200
Message-ID: <20161109005638.17691-5-vz@mleia.com>
References: <20161109005638.17691-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50590 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932322AbcKIA4n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 8 Nov 2016 19:56:43 -0500
In-Reply-To: <20161109005638.17691-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

Having timing settings for all supported by the controller PIO modes
now it is possible to expand its PIO mask.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/ata/pata_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 8f13c9f..d4caa23 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -160,7 +160,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	ap = host->ports[0];
 
 	ap->ops = &pata_imx_port_ops;
-	ap->pio_mask = ATA_PIO0;
+	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
 	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.10.2

