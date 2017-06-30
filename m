From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] sata_highbank: fix error return code in ahci_highbank_probe()
Date: Fri, 30 Jun 2017 00:03:06 -0500
Message-ID: <20170630050306.GA17486@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

Propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/ata/sata_highbank.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index aafb8cc..2fc451c 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -483,9 +483,9 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-- 
2.5.0
