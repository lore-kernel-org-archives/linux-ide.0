From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] pata_arasan_cf: Delete an unnecessary variable
 initialisation in arasan_cf_probe()
Date: Fri, 16 Feb 2018 16:59:01 +0100
Message-ID: <3b6bfa0f-3356-2fb9-07ae-bf52c1ccc47e@users.sourceforge.net>
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:43723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030647AbeBPP7M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 16 Feb 2018 10:59:12 -0500
In-Reply-To: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:28:23 +0100

The local variable "ret" will eventually be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index be5fbcedecbf..ebecab8c3f36 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -796,7 +796,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 quirk;
 	irq_handler_t irq_handler = NULL;
-	int ret = 0;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
2.16.1

