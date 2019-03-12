From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 4/9] drivers: ata: ahci_xgene: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:19:29 +0100
Message-ID: <1552382374-28789-4-git-send-email-info@metux.net>
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
 drivers/ata/ahci_xgene.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7e157e1..99c622c 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -752,7 +752,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
-	struct resource *res;
 	const struct of_device_id *of_devid;
 	enum xgene_ahci_version version = XGENE_AHCI_V1;
 	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
@@ -772,31 +771,25 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
 	/* Retrieve the optional IP mux resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
-	if (res) {
-		void __iomem *csr = devm_ioremap_resource(dev, res);
-		if (IS_ERR(csr))
-			return PTR_ERR(csr);
-
-		ctx->csr_mux = csr;
+	ctx->csr_mux = csr = devm_platform_ioremap_resource(pdev, 4);
+	if (IS_ERR(ctx->csr_mux)) {
+		dev_info(&pdev->dev, "cant get ip mux resource (optional)");
+		ctx->csr_mux = NULL;
 	}
 
 	of_devid = of_match_device(xgene_ahci_of_match, dev);
-- 
1.9.1
