From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] pata_imx: print error message on platform_get_irq failure
Date: Fri, 30 Jun 2017 00:29:05 -0500
Message-ID: <20170630052905.GA30465@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

Print error message on platform_get_irq failure before return.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/ata/pata_imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index d4caa23..65bbf36 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -132,8 +132,10 @@ static int pata_imx_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
 		return irq;
+	}
 
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct pata_imx_priv), GFP_KERNEL);
-- 
2.5.0
