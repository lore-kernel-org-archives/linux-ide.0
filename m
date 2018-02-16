From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] pata_arasan_cf: Delete an error message for a failed
 memory allocation in arasan_cf_probe()
Date: Fri, 16 Feb 2018 16:57:33 +0100
Message-ID: <05b48a33-81ae-b1b1-428c-4a9a0c9a4fe8@users.sourceforge.net>
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:33185 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030613AbeBPP5o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 16 Feb 2018 10:57:44 -0500
In-Reply-To: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:01:12 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_arasan_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b4d54771c9fe..be5fbcedecbf 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -809,10 +809,8 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	}
 
 	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
-	if (!acdev) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!acdev)
 		return -ENOMEM;
-	}
 
 	if (pdata)
 		quirk = pdata->quirk;
-- 
2.16.1

