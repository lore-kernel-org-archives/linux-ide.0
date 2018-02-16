From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pata_samsung_cf: Delete an error message for a failed memory
 allocation in pata_s3c_probe()
Date: Fri, 16 Feb 2018 11:08:18 +0100
Message-ID: <b757fb06-dde6-b1f6-77fa-f5301fb6fec1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:56831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933129AbeBPKIh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 16 Feb 2018 05:08:37 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 10:55:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_samsung_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 50801c40b029..bb96dc35950d 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -505,10 +505,8 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 	cpu_type = platform_get_device_id(pdev)->driver_data;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		dev_err(dev, "failed to allocate memory for device data\n");
+	if (!info)
 		return -ENOMEM;
-	}
 
 	info->irq = platform_get_irq(pdev, 0);
 
-- 
2.16.1

