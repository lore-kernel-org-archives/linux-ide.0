From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 16/27] ata: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 19:00:29 +0800
Message-ID: <1514026829-33341-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: ysxie@foxmail.com, Yisheng Xie <xieyisheng1@huawei.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/ata/pata_arasan_cf.c | 3 +--
 drivers/ata/pata_octeon_cf.c | 9 ++++-----
 drivers/ata/pata_rb532_cf.c  | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b4d5477..c046a56 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -827,8 +827,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
 
 	acdev->pbase = res->start;
-	acdev->vbase = devm_ioremap_nocache(&pdev->dev, res->start,
-			resource_size(res));
+	acdev->vbase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!acdev->vbase) {
 		dev_warn(&pdev->dev, "ioremap fail\n");
 		return -ENOMEM;
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index d3d851b..b653770 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -891,7 +891,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
-				cf_port->dma_base = (u64)devm_ioremap_nocache(&pdev->dev, res_dma->start,
+				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
 					of_node_put(dma_node);
@@ -909,8 +909,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
 		if (!res_cs1)
 			return -EINVAL;
 
-		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
-					   resource_size(res_cs1));
+		cs1 = devm_ioremap(&pdev->dev, res_cs1->start,
+				   resource_size(res_cs1));
 		if (!cs1)
 			return rv;
 
@@ -925,8 +925,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 	if (!res_cs0)
 		return -EINVAL;
 
-	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
-				   resource_size(res_cs0));
+	cs0 = devm_ioremap(&pdev->dev, res_cs0->start, resource_size(res_cs0));
 	if (!cs0)
 		return rv;
 
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 653b9a0..af57298 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -156,7 +156,7 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	info->gpio_line = gpio;
 	info->irq = irq;
 
-	info->iobase = devm_ioremap_nocache(&pdev->dev, res->start,
+	info->iobase = devm_ioremap(&pdev->dev, res->start,
 				resource_size(res));
 	if (!info->iobase)
 		return -ENOMEM;
-- 
1.8.3.1
