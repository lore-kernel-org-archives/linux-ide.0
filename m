From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] pata_imx: convert ata_dev_printk() to ata_dev_info()
Date: Mon, 3 Dec 2012 23:38:58 -0500
Message-ID: <CAPgLHd8ZnTQSMypEXbLav8=ruuLvaNiGoj2L2yY7bNaT5ADQGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:32972 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2LDEi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 23:38:59 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so422534qad.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 20:38:58 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, arnaud.patard@rtp-net.org
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using ata_dev_info() instead of ata_dev_printk().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/pata_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 87bb05b..7d40b52 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -60,7 +60,7 @@ static int pata_imx_set_mode(struct ata_link *link, struct ata_device **unused)
 			val &= ~PATA_IMX_ATA_CTRL_IORDY_EN;
 		__raw_writel(val, priv->host_regs + PATA_IMX_ATA_CONTROL);
 
-		ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
+		ata_dev_info(dev, "configured for PIO\n");
 	}
 	return 0;
 }


