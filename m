From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ahci: imx: fix the error handling in imx_ahci_probe()
Date: Sat, 7 Dec 2013 14:00:19 +0800
Message-ID: <CAPgLHd-okGke6OMBe2yaX3NdoDFtcN-47bFfcSRL-8h_7nnmYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:37842 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab3LGGAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Dec 2013 01:00:20 -0500
Received: by mail-bk0-f54.google.com with SMTP id v16so610456bkz.41
        for <linux-ide@vger.kernel.org>; Fri, 06 Dec 2013 22:00:19 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, marex@denx.de
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Release alloced resources instead of direct return from
imx_ahci_probe() in the error handling case.

Fixes: 4a23d1793f8e ('ahci: imx: Add i.MX53 support')
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/ahci_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 2daa288..dd4d6f7 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -331,7 +331,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		if (IS_ERR(imxpriv->gpr)) {
 			dev_err(dev,
 				"failed to find fsl,imx6q-iomux-gpr regmap\n");
-			return PTR_ERR(imxpriv->gpr);
+			ret = PTR_ERR(imxpriv->gpr);
+			goto err_out;
 		}
 
 		/*

