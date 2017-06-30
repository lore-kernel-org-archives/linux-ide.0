From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] pata_imx: print error message on platform_get_irq failure
Date: Fri, 30 Jun 2017 16:30:56 -0500
Message-ID: <20170630213056.GA12695@embeddedgus>
References: <20170630052905.GA30465@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.193.11]:48104 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753022AbdF3VbA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 17:31:00 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 067C0847E4
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 16:30:58 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20170630052905.GA30465@embeddedgus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Print error message on platform_get_irq failure before return.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Print the return value of platform_get_irq on failure.

 drivers/ata/pata_imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index d4caa23..66fb1ab 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -132,9 +132,10 @@ static int pata_imx_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
 		return irq;
-
+	}
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct pata_imx_priv), GFP_KERNEL);
 	if (!priv)
-- 
2.5.0

