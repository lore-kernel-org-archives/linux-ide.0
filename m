From: weiyj_lk@163.com
Subject: [PATCH] ahci: imx: add missing clk_disable_unprepare() on error in imx_sata_enable()
Date: Wed, 30 Jul 2014 08:54:07 +0800
Message-ID: <1406681647-24808-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:44545 "EHLO m12-18.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430AbaG3AyW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2014 20:54:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@freescale.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return from
imx_sata_enable() in the phy reset error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/ahci_imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index cac4360..7767325 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -265,7 +265,7 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 		ret = imx_sata_phy_reset(hpriv);
 		if (ret) {
 			dev_err(dev, "failed to reset phy: %d\n", ret);
-			goto disable_regulator;
+			goto disable_clk;
 		}
 	}
 
@@ -273,6 +273,8 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 
 	return 0;
 
+disable_clk:
+	clk_disable_unprepare(imxpriv->sata_ref_clk);
 disable_regulator:
 	if (hpriv->target_pwr)
 		regulator_disable(hpriv->target_pwr);

