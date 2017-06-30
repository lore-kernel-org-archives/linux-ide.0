From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] sata_highbank: fix error return code in
 ahci_highbank_probe()
Date: Fri, 30 Jun 2017 16:20:38 -0500
Message-ID: <20170630212038.GA10222@embeddedgus>
References: <20170630050306.GA17486@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630050306.GA17486@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

platform_get_irq() returns an error code, but the sata_highbank
driver ignores it and always returns -EINVAL. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.
Also, notice that platform_get_irq() no longer returns 0 on error.

Print error message and propagate the return value of platform_get_irq
on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Rewrite commit message. 

 drivers/ata/sata_highbank.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index aafb8cc..1419cf9 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -483,9 +483,9 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+	if (irq < 0) {
+		dev_err(dev, "failed to get IRQ: %d\n", irq);
+		return irq;
 	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-- 
2.5.0
