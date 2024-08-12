Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36948130AC8;
	Mon, 12 Aug 2024 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429287; cv=none; b=QZTf+gT+EKiJwMVx5A1hXnxTk5JwLgjVD2jsp1Hgo7I07xAkqkdmcNJvAD+ej9I1bTs2sSXFQjvrcrYU1wFvzKHJWm7WX3MeznRCMjpfoMHzERQeZT12SK+lrgy/yxBkpF5UkZ8z5FAngcfwxU6DJAmXIm6TKwCKcwbqbF9V+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429287; c=relaxed/simple;
	bh=/JXWBnJlNYEenrxsCG9z297Bgw8dHahHm7dGXp2Z6HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NoVK8zRYW3AS88OY4wMbvgTNQNVQ99OlQsV5sJE4l4I/wDjRHopdRN6BDlWBjLb5mO73CdUpeZ+j/BBEAFT6l6SisgMD3FvE27CFrfBJfMqzw7QPHtYvLD3XGxdVKkAhNX+AXVLCL7v8Ye9C6l2XSrJNd1z7vN/tqp9AmcnFizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C03D1A0FC1;
	Mon, 12 Aug 2024 04:21:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 033151A07FC;
	Mon, 12 Aug 2024 04:21:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F679183AC0B;
	Mon, 12 Aug 2024 10:21:16 +0800 (+08)
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
Subject: [PATCH v6 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Mon, 12 Aug 2024 10:00:54 +0800
Message-Id: <1723428055-27021-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
References: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The RXWM(RxWaterMark) sets the minimum number of free location within
the RX FIFO before the watermark is exceeded which in turn will cause
the Transport Layer to instruct the Link Layer to transmit HOLDS to the
transmitting end.

Based on the default RXWM value 0x20, RX FIFO overflow might be observed
on i.MX8QM MEK board, when some Gen3 SATA disks are used.

The FIFO overflow will result in CRC error, internal error and protocol
error, then the SATA link is not stable anymore.

To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 4dd98368f8562..627b36cc4b5c1 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -45,6 +45,10 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
+	/* IMX8QM SATA specific control registers */
+	IMX8QM_SATA_AHCI_PTC			= 0xc8,
+	IMX8QM_SATA_AHCI_PTC_RXWM_MASK		= GENMASK(6, 0),
+	IMX8QM_SATA_AHCI_PTC_RXWM		= 0x29,
 };
 
 enum ahci_imx_type {
@@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	phy_power_off(imxpriv->cali_phy0);
 	phy_exit(imxpriv->cali_phy0);
 
+	/* RxWaterMark setting */
+	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+	val &= ~IMX8QM_SATA_AHCI_PTC_RXWM_MASK;
+	val |= IMX8QM_SATA_AHCI_PTC_RXWM;
+	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+
 	return 0;
 
 err_sata_phy_exit:
-- 
2.37.1

