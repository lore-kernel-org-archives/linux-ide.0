Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78E158877;
	Thu, 11 Jul 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686618; cv=none; b=sdQGN+0nHugZD/OYVHtOiC9kjXMGYsaOm83UvT5uQTjOChvfAzU1ajPYoKRz+nW9ORTY0l/ow4ctQ9irH/Zga0q0LZWrS4d8VomQ0uAq+24uByQfjcMy4cdmLd9glWs4ltemMaSXjdTWtrnqqQrtYHx0sRXgkmdO0iAUWKCe0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686618; c=relaxed/simple;
	bh=O/3ZVknaEDRf9FzsUJCjc+R3UBIFyGWcjetg4gOyhmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=idKBT92rhvHjTPrkKNglsyC23hliREVobE5bA5qhROsJUYQva71euw7X+Kav6vuAeen3YVZHl5IjLP7B96s9PQ649acmbGZfOxECHK+tJhK11MfWGBc4hhRo9q9yahk+aMhtZidgi3L4t1Eu/w0rgGskUsPfAQ+mPG6qL9MWD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B632F201B53;
	Thu, 11 Jul 2024 10:30:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87166201B42;
	Thu, 11 Jul 2024 10:30:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 97EC71820F57;
	Thu, 11 Jul 2024 16:30:12 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 4/4] ata: ahci_imx: Correct the email address
Date: Thu, 11 Jul 2024 16:11:58 +0800
Message-Id: <1720685518-20190-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Correct the email address of driver author.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 9147cd14f587e..f3b89a7df062c 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1041,6 +1041,6 @@ static struct platform_driver imx_ahci_driver = {
 module_platform_driver(imx_ahci_driver);
 
 MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
-MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
+MODULE_AUTHOR("Richard Zhu <hongxing.zhu@nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.37.1

