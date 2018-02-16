From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pata_mpc52xx: Delete an error message for a failed memory
 allocation in mpc52xx_ata_probe()
Date: Fri, 16 Feb 2018 11:44:13 +0100
Message-ID: <b9749bf6-0bbb-2b2d-b946-aae893f3e305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 11:34:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_mpc52xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 9730125530f6..f1d352d5f128 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -738,7 +738,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	/* Prepare our private structure */
 	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
-		dev_err(&op->dev, "error allocating private structure\n");
 		rv = -ENOMEM;
 		goto err1;
 	}
-- 
2.16.1
