Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AA1A76A4;
	Thu, 29 Aug 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938049; cv=none; b=bdJZvzNId979vUwzcp9MGECxRFql4hBOxHx0N57Ak9U9HlR7hBuh9065vncKAl83ohjPNN/4xv7I71eDo4iNRphofGGMDldS82Px1mL3sYnrg8TZZ94HYu/luDQQMAih1zfJFaql3cAKy8Ji1lNLg0AMKBRiOkolBkOBmkj1710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938049; c=relaxed/simple;
	bh=k5BAZnri9ofBt131jwbvdQzKNLiYOwKxPgpUF3hMAMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhsfcV4Bnvmt+G2J4PNmzV/WVaYlX7htrfywfCx6A8TpnWnKkNW3ISdQmFYwudy+DIbEPhqD4jKCVNqShqxwUr+NzbI5mqa249mlOzHMGkaGHIhOX2TUluTQIiY3tUbLGXSgG9tkHMAYRJkNPr020lA8vHRe+piZP6SupnG4qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wvhq36VSvzLqr5;
	Thu, 29 Aug 2024 21:25:19 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 572F118007C;
	Thu, 29 Aug 2024 21:27:24 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 21:27:24 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linus.walleij@linaro.org>, <s.shtylyov@omp.ru>, <dlemoal@kernel.org>,
	<cassel@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next 0/3] ata: Enable module autoloading
Date: Thu, 29 Aug 2024 13:19:04 +0000
Message-ID: <20240829131907.541466-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset aims to enable autoloading of some use modules. By 
registering MDT, the kernel is allowed to automatically bind modules to
devices that match the specified compatible strings.

Liao Chen (3):
  ata: pata_ftide010: Enable module autoloading
  ata: pata_ixp4xx: Enable module autoloading
  ata: sata_gemini: Enable module autoloading

 drivers/ata/pata_ftide010.c  | 1 +
 drivers/ata/pata_ixp4xx_cf.c | 1 +
 drivers/ata/sata_gemini.c    | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1

