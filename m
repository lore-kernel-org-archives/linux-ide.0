From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] pata_arasan_cf: add missing clk_disable_unprepare() on
 error path
Date: Thu, 21 Nov 2013 11:07:09 +0800
Message-ID: <CAPgLHd_C+KmJXd1oB4=tsGR66BGXgzFds5aicjxDjeKepxFLsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:51283 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3KUDHL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 22:07:11 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so100508bkz.11
        for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2013 19:07:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh.linux@gmail.com, tj@kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return
from cf_init() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/pata_arasan_cf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index e88690e..73492dd 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -319,6 +319,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 	ret = clk_set_rate(acdev->clk, 166000000);
 	if (ret) {
 		dev_warn(acdev->host->dev, "clock set rate failed");
+		clk_disable_unprepare(acdev->clk);
 		return ret;
 	}
 

