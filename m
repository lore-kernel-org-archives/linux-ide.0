From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 6/9] drivers: ata: pata_bk3710: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:19:31 +0100
Message-ID: <1552382374-28789-6-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/pata_bk3710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
index fad95cf..92b036d 100644
--- a/drivers/ata/pata_bk3710.c
+++ b/drivers/ata/pata_bk3710.c
@@ -291,7 +291,6 @@ static void pata_bk3710_chipinit(void __iomem *base)
 static int __init pata_bk3710_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
-	struct resource *mem;
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *base;
@@ -310,15 +309,13 @@ static int __init pata_bk3710_probe(struct platform_device *pdev)
 	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
 	ideclk_period = 1000000000UL / rate;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		pr_err(DRV_NAME ": failed to get IRQ resource\n");
 		return irq;
 	}
 
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1
