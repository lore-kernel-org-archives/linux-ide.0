Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755E747F
	for <linux-ide@vger.kernel.org>; Tue, 27 Aug 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744007; cv=none; b=ozA1nP/6OCotaA/tCS5PjvaHVs0sGYmq5vJPBPwVp6gKGDPLtbhyDFo4pn4tNVg6de2ee9zmHy7a8Yg1ir/pBU5XU3qs5+cCH2Zf/9hJ7x+Fk+04y0stZYUcyTav/u/CAtyQcJkokTaIfOJW9iRwN869ydYzKvhRl5J3J6DvVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744007; c=relaxed/simple;
	bh=2p2Yq/g6Rl3Ihb63QT5IW9FQmFw+33XuMaB1VJCEI2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XV1qNSRnHrB37eyhK+cfl/IxwNlK4kxBTvzYjuUU5/BZMtzwAYWQ/QRQ/IfstmYyau21LhWwLenxhG86Xfn6iOVTlNpk3/Ya9muPAWYFuInBet6U31PWBZs/O4Lm7ORb9FKR5wLjtUCURsfeLPdBi6GUvlLWdJRQgKUwNn/rz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtK50150Nz13nHW;
	Tue, 27 Aug 2024 15:32:36 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id CA85A1800FF;
	Tue, 27 Aug 2024 15:33:22 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:33:22 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] ata: libata: Use devm_platform_ioremap_resource_byname() helper function
Date: Tue, 27 Aug 2024 15:20:05 +0800
Message-ID: <20240827072005.45181-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

platform_get_resource_byname() and devm_ioremap_resource() can be
replaced by devm_platform_ioremap_resource_byname(), which can
simplify the code logic a bit, No functional change here.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/ata/ahci_brcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 70c3a33eee6f..2f16524c2526 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -437,7 +437,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -451,8 +450,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	priv->version = (unsigned long)of_id->data;
 	priv->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl");
-	priv->top_ctrl = devm_ioremap_resource(dev, res);
+	priv->top_ctrl = devm_platform_ioremap_resource_byname(pdev, "top-ctrl");
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-- 
2.17.1

