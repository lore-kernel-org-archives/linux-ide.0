Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DE13777E;
	Mon, 12 Aug 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429286; cv=none; b=m3let9vShY57EPj6ybd/PQPy48JHGZdAJ+tV25oq3VYNnhrnUUGjLqqvHnMyhvzsBlcak4uLtRzBvnpFXaqR0WfK6qJKgIf5L3dCsQMXAobpSU15Dsk84gAnJ4BkscKtNYxPklZnXPYLAhywaKVlFPFrAi1WRgcMK1BhvR1ekaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429286; c=relaxed/simple;
	bh=dgRhjLH6tGDPWNE74f5pCiBxkPlq+UxZLDft1Q3D5/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=odC52EQpD0trCBwJ26BUu5VvTxkG4D2kZghearWI1WdUWIixplzuiwBXDBk0i1mRD/T93rNmNu5MKuHGfBBgOfoPg4E6qs8KODjWtgXUKO+7D/psqoS+EzbMy9xcotnTsX2JIX89IXEaffENqo88Niyh/o8qqImRFGpmMZGpSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 628AE1A0FC2;
	Mon, 12 Aug 2024 04:21:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A89B1A0FC1;
	Mon, 12 Aug 2024 04:21:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 93968183ACAC;
	Mon, 12 Aug 2024 10:21:15 +0800 (+08)
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
Subject: [PATCH v6 3/5] ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA
Date: Mon, 12 Aug 2024 10:00:53 +0800
Message-Id: <1723428055-27021-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
References: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

i.MX8QM AHCI SATA doesn't need set AHB clock rate to config the vendor
specified TIMER1MS register.

Set AHB clock rate only for i.MX53 and i.MX6Q.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ata/ahci_imx.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 75258ed42d2ee..4dd98368f8562 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -872,12 +872,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(imxpriv->sata_ref_clk);
 	}
 
-	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(imxpriv->ahb_clk)) {
-		dev_err(dev, "can't get ahb clock.\n");
-		return PTR_ERR(imxpriv->ahb_clk);
-	}
-
 	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
 		u32 reg_value;
 
@@ -937,11 +931,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		goto disable_clk;
 
 	/*
-	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
-	 * and IP vendor specific register IMX_TIMER1MS.
-	 * Configure CAP_SSS (support stagered spin up).
-	 * Implement the port0.
-	 * Get the ahb clock rate, and configure the TIMER1MS register.
+	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL.
+	 * Set CAP_SSS (support stagered spin up) and Implement the port0.
 	 */
 	reg_val = readl(hpriv->mmio + HOST_CAP);
 	if (!(reg_val & HOST_CAP_SSS)) {
@@ -954,8 +945,19 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
 	}
 
-	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	if (imxpriv->type != AHCI_IMX8QM) {
+		/*
+		 * Get AHB clock rate and configure the vendor specified
+		 * TIMER1MS register on i.MX53, i.MX6Q and i.MX6QP only.
+		 */
+		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
+		if (IS_ERR(imxpriv->ahb_clk)) {
+			dev_err(dev, "Failed to get ahb clock\n");
+			goto disable_sata;
+		}
+		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
+		writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	}
 
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
 				      &ahci_platform_sht);
-- 
2.37.1

