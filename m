From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sata: ahci-da850: Fix some error handling paths in 'ahci_da850_probe()'
Date: Wed, 16 Aug 2017 07:31:03 +0200
Message-ID: <20170816053103.19773-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:38939 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdHPFbJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2017 01:31:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'rc' is known to be 0 at this point.
If 'platform_get_resource()' or 'devm_ioremap()' fail, return -ENOMEM
instead of 0 which means success.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/ata/ahci_da850.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 1a50cd3b4233..eb46cad4d514 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -216,12 +216,16 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		return rc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
+	if (!res) {
+		rc = -ENOMEM;
 		goto disable_resources;
+	}
 
 	pwrdn_reg = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pwrdn_reg)
+	if (!pwrdn_reg) {
+		rc = -ENOMEM;
 		goto disable_resources;
+	}
 
 	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
 
-- 
2.11.0

