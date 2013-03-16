From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] drivers: ata: Use resource_size function
Date: Sat, 16 Mar 2013 16:32:11 +0200
Message-ID: <1363444332-379-1-git-send-email-gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>
List-Id: linux-ide@vger.kernel.org

Use resource_size function instead of explicit computation.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 drivers/ata/pata_octeon_cf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index ff2e57f..e73bef3 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -926,7 +926,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 			goto free_cf_port;
 		}
 		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
-					   res_cs1->end - res_cs1->start + 1);
+					   resource_size(res_cs1));
 
 		if (!cs1)
 			goto free_cf_port;
-- 
1.7.9.5
