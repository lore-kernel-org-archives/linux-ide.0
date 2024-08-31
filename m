Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD940763F8;
	Sat, 31 Aug 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089430; cv=none; b=P7Gta0dYpczX/jMl93z9M7Ed+5p5zJWhcpW0Y/B6D833eBrtinL0EHiOpwdrz5QrifhDzoXL8FpTNgS9gZOqJT1A6/3ZclPY5VKDEZxB2YwLCLde5G8bGkTiI/Z5pdv3iSyQS9s0RW4EQdiBzXgFoKfcq2d4ZtA9twKpy1r3uFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089430; c=relaxed/simple;
	bh=OwPkCG1hjPtfQhuBwcbqpj5W/rfBtASoOkbNTlc4dS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIh900X+m6FRCaC9bmIwhvoS9Eg3bUXzntVpIcZUKFkT9c4i5+sOA/02MQNCyPfZMfzt3gOTMSqjpkEa0+jNIDfUZJqpNOARC8GVbx/UF0LOeEZ7fdJ7WHwSL9hUyoKa4qngaiPEBb3qHx0GI9FIgmBXyECxloh5yK4R3SME2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwmqV1B0KzyQjl;
	Sat, 31 Aug 2024 15:29:26 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 6547C18006C;
	Sat, 31 Aug 2024 15:30:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:30:18 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <s.shtylyov@omp.ru>, <linus.walleij@linaro.org>, <dlemoal@kernel.org>,
	<cassel@kernel.org>
Subject: [PATCH -next v2 2/3] ata: pata_ixp4xx: Enable module autoloading
Date: Sat, 31 Aug 2024 07:21:57 +0000
Message-ID: <20240831072158.789419-3-liaochen4@huawei.com>
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

