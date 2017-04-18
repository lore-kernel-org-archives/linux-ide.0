From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT] sata: rcar_sata: Reset SATA PHY on resume
Date: Tue, 18 Apr 2017 16:02:53 +0900
Message-ID: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38557 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdDRHDX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Apr 2017 03:03:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

In the case where power is cut on suspend the SATA PHY state needs to be
suspended on resume.

This is the case on the Salvator-X board with the r8a7795 or r8a7796 SoC.
In that environment it has been observed that SATA partitions cannot not be
accessed on resume.

Based on work by Khiem Nguyen.

Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile and boot tested only
---
 drivers/ata/sata_rcar.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 5d38245a7a73..4f4f7788a6cf 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -969,16 +969,9 @@ static int sata_rcar_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
-	void __iomem *base = priv->base;
 
 	clk_prepare_enable(priv->clk);
-
-	/* ack and mask */
-	iowrite32(0, base + SATAINTSTAT_REG);
-	iowrite32(0x7ff, base + SATAINTMASK_REG);
-	/* enable interrupts */
-	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
-
+	sata_rcar_init_controller(host);
 	ata_host_resume(host);
 
 	return 0;
-- 
2.7.0.rc3.207.g0ac5344

