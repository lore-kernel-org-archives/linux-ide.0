From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] pata_rdc: remove unused variable in rdc_init_one()
Date: Mon, 22 Oct 2012 16:55:50 +0800
Message-ID: <CAPgLHd8BwN0GxMbcT+7A5DRVD16zJoqOvL2YScccQOXYZXWZ+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64375 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab2JVIzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2012 04:55:51 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1075295qaa.19
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 01:55:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable port_flags is initialized but never used
otherwise, so remove the unused variable.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/pata_rdc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 32a3499..e71f998 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -327,7 +327,6 @@ static int __devinit rdc_init_one(struct pci_dev *pdev,
 	struct device *dev = &pdev->dev;
 	struct ata_port_info port_info[2];
 	const struct ata_port_info *ppi[] = { &port_info[0], &port_info[1] };
-	unsigned long port_flags;
 	struct ata_host *host;
 	struct rdc_host_priv *hpriv;
 	int rc;
@@ -337,8 +336,6 @@ static int __devinit rdc_init_one(struct pci_dev *pdev,
 	port_info[0] = rdc_port_info;
 	port_info[1] = rdc_port_info;
 
-	port_flags = port_info[0].flags;
-
 	/* enable device and prepare host */
 	rc = pcim_enable_device(pdev);
 	if (rc)

