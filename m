From: weiyj_lk@163.com
Subject: [PATCH] ata: fix return value check in ahci_seattle_get_port_info()
Date: Tue, 14 Jun 2016 00:26:49 +0000
Message-ID: <1465864009-26774-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:42459 "EHLO m12-14.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422645AbcFNA1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jun 2016 20:27:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_kzalloc() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/ahci_seattle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 6e702ab..1d31c0c 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -137,7 +137,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	u32 val;
 
 	plat_data = devm_kzalloc(dev, sizeof(*plat_data), GFP_KERNEL);
-	if (IS_ERR(plat_data))
+	if (!plat_data)
 		return &ahci_port_info;
 
 	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,


