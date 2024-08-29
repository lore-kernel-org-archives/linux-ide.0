Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FC1A76A8;
	Thu, 29 Aug 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938050; cv=none; b=Z4cm/VDrR1lahJr6yXKWstj7odhBNNofdObBR0HAsIFq0vZik1kJFIEnfKjbVJsnECfsTvo4uU1lff4YKc2VBQ9IY+/lsG656ED3nwY1BIdrmgxGNCBS5tkJkZ8xc9waB4uRA15dspwUMbAjbtKEm9xCd5bfqlOaxEGjybML4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938050; c=relaxed/simple;
	bh=Yp/tN7CEqPIkgXcldULd7cSLCQTms+PybwmDb8efFdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6vV0DGGTOIrL6L1aNNJ7ozWuMTSebeL7PctSLWk2lxFsws8B/KUmvj8zQDztsS98QxZvJ+6pgJfPXFmBEwYeAk53RGx3VGaGQ1MkFHf1Gc9DB3GsfVlCD3BTcTLOKpPl0CxbaNs5/DYJISx1lQ/HuZYuY8HHYNVAOrZLFvSg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvhqT16ZVzpV0c;
	Thu, 29 Aug 2024 21:25:41 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id D6FB71401F2;
	Thu, 29 Aug 2024 21:27:24 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 21:27:24 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linus.walleij@linaro.org>, <s.shtylyov@omp.ru>, <dlemoal@kernel.org>,
	<cassel@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next 3/3] ata: sata_gemini: Enable module autoloading
Date: Thu, 29 Aug 2024 13:19:07 +0000
Message-ID: <20240829131907.541466-4-liaochen4@huawei.com>
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
 drivers/ata/sata_gemini.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 4c270999ba3c..f574e3c3f5b4 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -417,6 +417,7 @@ static const struct of_device_id gemini_sata_of_match[] = {
 	{ .compatible = "cortina,gemini-sata-bridge", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, gemini_sata_of_match);
 
 static struct platform_driver gemini_sata_driver = {
 	.driver = {
-- 
2.34.1

