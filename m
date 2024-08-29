Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5261A76B7;
	Thu, 29 Aug 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938049; cv=none; b=YhCvSxh4bXzX0fT8GMKhzCpcpILpcVEYvYxqV0OmUAM10WUDinJ2eee472g2qevfXYoqO66a7TLSHUS9J1YD3ZaQ+IDM1gM7sTI5jPNlTugovkyVEWWJykBEuHwKpNEv4CA0UQT/TJgYtyMTbI9gDFXu5NKG/Brd/D/kAQCMckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938049; c=relaxed/simple;
	bh=C+UvIVig5oBTlH4/D6JT9X+95t3qFuBC0b3nWcw824w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqf2of9P62Ow8G+jwou+3L+Szs9TSKotHEBstPE+4Mu0Pr73QZiAOqAAbQjMTw269Hl7nRvZcW0oJerjtr04dlDTfy3YM/jPSJjtiNbnOrBHr9bW/QkpBXthLGoq2cbXZ7dYXb9skEJXDbWiazpkqp8snuvwIrgKvcUW5JPRY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wvhrs0kT0zyR5w;
	Thu, 29 Aug 2024 21:26:53 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id A68121402CA;
	Thu, 29 Aug 2024 21:27:24 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 21:27:24 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linus.walleij@linaro.org>, <s.shtylyov@omp.ru>, <dlemoal@kernel.org>,
	<cassel@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next 2/3] ata: pata_ixp4xx: Enable module autoloading
Date: Thu, 29 Aug 2024 13:19:06 +0000
Message-ID: <20240829131907.541466-3-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829131907.541466-1-liaochen4@huawei.com>
References: <20240829131907.541466-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/ata/pata_ixp4xx_cf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 246bb4f8f1f7..8a9ee828478f 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -290,6 +290,7 @@ static const struct of_device_id ixp4xx_pata_of_match[] = {
 	{ .compatible = "intel,ixp4xx-compact-flash", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, ixp4xx_pata_of_match);
 
 static struct platform_driver ixp4xx_pata_platform_driver = {
 	.driver	 = {
-- 
2.34.1

