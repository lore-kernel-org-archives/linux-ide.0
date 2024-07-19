Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEB12F37C;
	Fri, 19 Jul 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368883; cv=none; b=SgppeGVnUNbf1rcDU1pKP2nHvRu+chfRtcvAcXaNWjeTzevw29+mCQaWVIS3zqD9AYqQ9hmNOzkXfFWceXyTibPsCnLm+pC9HUvXWGQBSHVrIob/NH7e8YZ0rn0q3ZaPvjXtb2KlWvkwSM0yrHifG73tNvinurUqc46Rkk9ENKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368883; c=relaxed/simple;
	bh=C0eCYxM9f6+BdrE6tJ6vyDLxjginwXe9VOii4c1AMw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZgWmhIJyemaLYo92+TMDmHhjNCobEiz20e90dhkOyseqNvLVIHRQurmrFUXy/FMTshY0xoWUD2ZXWPe41dWPS5wDSRQ2WF7NYd+8RHXpEVeanD7PQVBOXOWm17IZTcYZ2psxKlcPgW0ZoI15PCRmNXoqaNvjaSOgTXRWCMRcjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71D7E2015E7;
	Fri, 19 Jul 2024 08:01:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41954202707;
	Fri, 19 Jul 2024 08:01:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F2E01820F57;
	Fri, 19 Jul 2024 14:01:18 +0800 (+08)
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
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM AHCI SATA
Date: Fri, 19 Jul 2024 13:42:14 +0800
Message-Id: <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Since i.MX8QM AHCI SATA only has 32bits DMA capability.
Add 32bits DMA limit here.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 4dd98368f8562..e94c0fdea2260 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -827,6 +827,9 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
 {
+	if (!(dev->bus_dma_limit))
+		dev->bus_dma_limit = DMA_BIT_MASK(32);
+
 	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
 	if (IS_ERR(imxpriv->sata_phy))
 		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
-- 
2.37.1

