Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F014D28F;
	Sat, 31 Aug 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089426; cv=none; b=vCWAYtlNA2J5S39VhZiPkGv+mKtJJrvAlNr52nAavs22Kkjfkuyt7IHRj6KbK7IZW3fPCUZkD5GAEjVAzhXkz/9d1kyNttj9s+YijvZZHkG8p/+OPlayH5mpkiIJ79+vPIrF/P/+YHkrJUbDdG/5oMzKnNQcIJSrl9bCfZgyotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089426; c=relaxed/simple;
	bh=KgC5JsQG+0Ud0hlCnsyxlnt7nbCvOatRrH3PTQNqGcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQcEAYcXoWrJ25OkFIoHG/lhDgt0Iv99o++Rm64cZ5J4u02spIxadUsyTNFLYd02tKxfHYOeo93kThUVAFhmuIG6NYS/osSYrdlME0DaAdO8HSSTmxpYbaQYy8xk7mJWzzH7LGCt9XA1vmWAuR4Ii+24n0WCGV8a7lG+I5UEvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwmrC5Jj3z1j7LR;
	Sat, 31 Aug 2024 15:30:03 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 909A21400D7;
	Sat, 31 Aug 2024 15:30:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:30:18 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <s.shtylyov@omp.ru>, <linus.walleij@linaro.org>, <dlemoal@kernel.org>,
	<cassel@kernel.org>
Subject: [PATCH -next v2 3/3] ata: sata_gemini: Enable module autoloading
Date: Sat, 31 Aug 2024 07:21:58 +0000
Message-ID: <20240831072158.789419-4-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831072158.789419-1-liaochen4@huawei.com>
References: <20240831072158.789419-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

