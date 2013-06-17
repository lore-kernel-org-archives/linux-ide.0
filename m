From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
Date: Mon, 17 Jun 2013 17:52:46 +0800
Message-ID: <1371462767-16630-3-git-send-email-r65037@freescale.com>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34845 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3FQJux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 05:50:53 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2611231pbb.36
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2013 02:50:53 -0700 (PDT)
In-Reply-To: <1371462767-16630-1-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

imx6q contains the Synopsys AHCI SATA controller which shares
ahci_platform driver with other controllers.

This patch updates the DT compatible list for ahci_platform,
and enable the imx6q ahci sata support.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/ata/ahci_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7a8a284..61f2142 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
+	{ .compatible = "snps,imx-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.5.4

