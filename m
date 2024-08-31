Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE60136E28;
	Sat, 31 Aug 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089424; cv=none; b=tFzfrf50spBdpuW30gdO+6bizd28gzuLSgaZemsvUbDOu9llaF5i7OUaFHnXYvVIJ1rj24LI9DDtpvzGAD2kJthNz6A1s+csTU7TdlmBtwnR7fUcqEu6UIpwp/Gd7wm4+di+NS4rr1ZW6SrHQ7fLo9Qkky2p6IJYX1fhqlOiUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089424; c=relaxed/simple;
	bh=k5BAZnri9ofBt131jwbvdQzKNLiYOwKxPgpUF3hMAMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGFtZtWu8PUSyBK2lAiDl22L74LVatGzqT4UW2MKHj9T/CX17bz+95bVSE9AxjOWCqvMMKZg6y+x9+QKNhgmqSjy+MZcldhpM8janVm5PEFY4MoCliomId8bYhVfEZ0KW4IQTRN4wxppN7+F2h6FCbsBwKR7CuYx+FMMqts1fSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwmpC1Qxpz1xtr9;
	Sat, 31 Aug 2024 15:28:19 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 174BF180043;
	Sat, 31 Aug 2024 15:30:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:30:17 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <s.shtylyov@omp.ru>, <linus.walleij@linaro.org>, <dlemoal@kernel.org>,
	<cassel@kernel.org>
Subject: [PATCH -next v2 0/3] ata: Enable module autoloading
Date: Sat, 31 Aug 2024 07:21:55 +0000
Message-ID: <20240831072158.789419-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
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

