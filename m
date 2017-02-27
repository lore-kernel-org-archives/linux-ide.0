From: Belen Sarabia <belensarabia@gmail.com>
Subject: [PATCH] Delete redundant return value check of
 platform_get_resource()
Date: Mon, 27 Feb 2017 22:41:18 +0100
Message-ID: <20170227214118.GA2895@belen-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Delete error handling from the result of a call to platform_get_resource()
when the value is immediately passed to devm_ioremap_resource().

Signed-off-by: Belen Sarabia <belensarabia@gmail.com>
---
 drivers/ata/ahci_octeon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index ea865fe..5a44e08 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -38,11 +38,6 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
-		return -ENODEV;
-	}
-
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
1.9.1
