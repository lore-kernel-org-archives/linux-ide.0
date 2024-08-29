Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029481A76AB;
	Thu, 29 Aug 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938049; cv=none; b=O5O2lWsC0APyfAEVhqjTP5pVarHDOkMnX8Icws361TyzorERB8gTvcBn2yFC0Vbpu0+mupRC93vxccm1ogfr5FWiqjiFqsYaGuipIPl4X0RKIJ279GjC8Eq0CpJ2XJdiefLVe580mHqdeNbwBYScHoJavJsJcLwl9jj9ygbXt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938049; c=relaxed/simple;
	bh=4JAMTgTmgBy/Um25o9gTb/7RdFwbK3E7BMGNsxuUPII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfgbU5/ZhenfOOdV6fsYd3HXT0BHXS3pH+DiYLtwufwZXFaq3t3+xb7JbDwyTgDCYPikhq0AeLyXPsbTh+9iIkgVPZgB1kj1rfIQd8Dy8Xf/NBHdGuRMNHDZ5jIPkdMVYhTsp5Ym1tGqRuxozffYbS2F8xON2iTS1noOD9l4Jq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvhqS5VkczpSt5;
	Thu, 29 Aug 2024 21:25:40 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 791DA1401E0;
	Thu, 29 Aug 2024 21:27:24 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 21:27:24 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linus.walleij@linaro.org>, <s.shtylyov@omp.ru>, <dlemoal@kernel.org>,
	<cassel@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next 1/3] ata: pata_ftide010: Enable module autoloading
Date: Thu, 29 Aug 2024 13:19:05 +0000
Message-ID: <20240829131907.541466-2-liaochen4@huawei.com>
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
 drivers/ata/pata_ftide010.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 4d6ef90ccc77..73a9a5109238 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -549,6 +549,7 @@ static const struct of_device_id pata_ftide010_of_match[] = {
 	{ .compatible = "faraday,ftide010", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, pata_ftide010_of_match);
 
 static struct platform_driver pata_ftide010_driver = {
 	.driver = {
-- 
2.34.1

