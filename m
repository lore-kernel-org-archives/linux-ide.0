From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v3] pata_imx: print error message on platform_get_irq failure
Date: Fri, 30 Jun 2017 17:03:48 -0500
Message-ID: <20170630220348.GA15021@embeddedgus>
References: <20170630164737.Horde.XkAFPlkZTYgdXBu7_MH6YNz@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.51.35]:39661 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753130AbdF3WDv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 18:03:51 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 1CDF267DEEF
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 17:03:49 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20170630164737.Horde.XkAFPlkZTYgdXBu7_MH6YNz@gator4166.hostgator.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Print error message on platform_get_irq failure before return.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Print the return value of platform_get_irq on failure.

Changes in v3:
 Put back the blank line after the IF closing brace,
 which was accidentally removed in v2.

 drivers/ata/pata_imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index d4caa23..cdae3c0 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -132,8 +132,10 @@ static int pata_imx_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
 		return irq;
+	}
 
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct pata_imx_priv), GFP_KERNEL);
-- 
2.5.0

