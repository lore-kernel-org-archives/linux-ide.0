Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4200763F8;
	Sat, 31 Aug 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089426; cv=none; b=YdYBQ+kELSvT2XAR8owBlZ+JWZd3WHOu/HLBKS1yrfSDniyUhOTNZv4U+aHlVIZio/c/53OtejggGHtOZ4AgzX86p3Sm+xEtUkLUSWuKBDWZ5Yn/fxZGI+EPE9MOs9anwc0gyIEE4YiUZfTvsvfbBNTPdX8nraNrnmyMCGkE9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089426; c=relaxed/simple;
	bh=YBlDp7MO1i86Rk/g1Cgo8rs8FFnQHBCKMHi0mv5hi+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4kQXir1VjDUrYNJKlfcK5aROzoAAEHlROfdfFWcuikUOcGXfV1aI5LEYad5TnQa/UOo7lp5zBUTZL0wuTzbDlQZVJ8hv/V7s3SKpfqvqR3w1qSBgQnX2dS66RSIzYqc/XZS3+Z9WDqeib9Tp7O8dcflgkepOwdTWNPKFmzbFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wwmks1zqCzQr4D;
	Sat, 31 Aug 2024 15:25:25 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BD591800CF;
	Sat, 31 Aug 2024 15:30:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:30:18 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <s.shtylyov@omp.ru>, <linus.walleij@linaro.org>, <dlemoal@kernel.org>,
	<cassel@kernel.org>
Subject: [PATCH -next v2 1/3] ata: pata_ftide010: Enable module autoloading
Date: Sat, 31 Aug 2024 07:21:56 +0000
Message-ID: <20240831072158.789419-2-liaochen4@huawei.com>
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
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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

