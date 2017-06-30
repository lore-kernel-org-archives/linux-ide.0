From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 16:08:06 -0500
Message-ID: <20170630210806.GA9391@embeddedgus>
References: <20170630153403.Horde.3zkFbygqW5UQlds6qsIxmGz@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630153403.Horde.3zkFbygqW5UQlds6qsIxmGz@gator4166.hostgator.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

platform_get_irq() returns an error code, but the sata_rcar driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly. Also,
notice that platform_get_irq() no longer returns 0 on error.

Print error message and propagate the return value of platform_get_irq
on failure.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Rewrite commit message.

 drivers/ata/sata_rcar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index ee98447..769bfdd 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -872,8 +872,10 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -EINVAL;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+		return irq;
+	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sata_rcar_priv),
 			   GFP_KERNEL);
-- 
2.5.0
