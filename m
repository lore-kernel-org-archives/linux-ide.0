Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042293;
	b=076O5ymLYDv8rBfE1o29PyCF6KdcDth2zLWovYBfvRHvEjHeIHolH/kr8SnzhV+nvLdl
	 K1IydWGv+dFZGbWzUEiFCavgkrzLDR4sjlwzuZWZ9xPx0gwMlMcnHPaE1ggKcQpQL5LYT
	 qJrEEPH5AKtpTnybmEzyovcgoniSSk+l7aP2nxjtYxPbv90+dXep57fF3NSC6MaVYHi5V
	 5W/dX64+6DfskCTfJlXNDzEAEnfZBlgChqJvV2i9L+U4UPSS2Dru33crSowe4lbHqA1Fv
	 PAhJf1z/bIH4Tfw046qonT2Zrs3YionJVd1/5G/438vSsbWZo4NeqwJnOwC4J3MRN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042293;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
	b=xa/cQyy3F7lOJFCqxGHADoEKjxcke+dHnUdGeNCzl9TeyaGrbQ5lXiTI8OD1sBK948aI
	 Xf3Ed99796NsvVJhYcIVf9LS06E9nJzp4UBfL2C1CvdMRUlxdmd010ym8eSRoEbF8m4Y0
	 Sx1U90Soh8IS9HYXQhxF6hipaoOliJd4APWSIk0G0BvaWP+eqq2EWPDZpbukU1xM0TsVR
	 r72div68GHCHOHEXR7hZNCjVg62nLgI9ippd+PKHwkn1hfGwsxgEAQ3Y42A26buU1CYwe
	 TiMH9exdXpTZmxxXP1CiZZj3HRKmBS1RYYDhKbh9GjXC9T9etyX8zAV/Y72c8M7kPUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="H0/Y/cJN";
	arc=none smtp.remote-ip=74.125.82.98
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2470606A329
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2470606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=H0/Y/cJN
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-1846bc43c28so3624052c88.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042292; x=1793647092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
        b=Q4lF1QqzzhcN4+vbraNvcYdNnVm3SOEdktEMcImmLwIgX1Y9SDAOfiqGBZN4bwF25p
         zACyPGpijKUZQvI8tVhQ+VSBrp+fRWlX2OVl7+6xNdqPuchSCUgJijsIwEAJA8J8Fv+e
         4Py3Yj/de1RK8k7EGRnSg0G1N6GLvPzLdClELX+acJyjgTFmNwmZZNlMQ4q5M/2ZibV8
         IfOaKSEZmV1kVZ3dxY17ckrzVBA+6dOtGq5vqOuUJLpsEGb49gCSuDHV92saXBnbS48a
         W0Jrfir2+DjiLtXrY0dYNDCJmWOE35ia4gXdC55zeZUCWdmygGDDNPol96fILVGc/Qkv
         t9Hg==
X-Forwarded-Encrypted: i=1; AKwUvBzrz9KY4FCrCcqa067QpEITJXroN3r7hQkn5z4NVH7BoYBVvgMC3qJ3v8ptYVpZKQaTNvIShOSzr3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIf5Z07MjHvRx6gxI8HiuoUp3jv/MGrCjZTGihVAGFGJgNDMRcD
	ekHACMVJsqjjJxIWvd0whlcHRmj+n+Tjooer0k05DoBQml3j5cPmsnKY8Gw6K3xJwTxEQ+hs+bD
	4EE7oGsEItcPTM/RG2I/d16hRsX7tqBz1/1VWpGKeq/3Vf1Js86La4WNulHcl3wm43aN8lTfr4R
	qs/pMf1vxutjdeh5O61BAqlarsg1R22UxoJT95ssfWYDIJ9YJDavbNAEBNLrsiu1dZEDpwAbTyr
	yE/J0FHoX2BB2kYvLLRwvA=
X-Gm-Gg: AYBFou1USs0tmG0M05xaQnHdOOqaK87xEjYHpIF07AdGkJUnEDBVRtCVqhoPOmud8YO
	FnmcgpAZ5RJWRMsVAOagGs7rqVUQ06h7Ajvulo1njauEm/9Bl3nq5T5kdvmkaYzfDUyVsu43o+c
	Bu2FXj/dshAnutTL2wCcjGyJn3Y7LMOAW5ig0saGd1ZlTNfS0Z/dYG7EDglw4SrazlfzuyusMi5
	PQt/RaRiF09wwMSKrb+42trdUsidFK5Lod6soxLji0GIvJavz+2a7YGObHTdUb8DT7ULGrj4Y2i
	a4VLpuS1MMA4iaRHFkhi3zzcKTYDTRKYPRmvmnSsskGZmZZsMhg3ktkzZ0m9Wpe93jClz0QEUqE
	mF/GpaNXl3LmRHbQM27O5FmNhoS5DHqIWF1QA3LxsXyakBHGYAXV1smb046UhHgvl++Sj/YN3F0
	hoN8BzjKZQq6xf9SifLbkg7nSMceapAvF4zxxxXvPY
X-Received: by 2002:a05:7022:43a0:b0:182:9071:3249 with SMTP id a92af1059eb24-19936b55bbfmr16085745c88.30.1793042291552;
        Mon, 26 Oct 2026 12:18:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-198a2a59770sm71628c88.17.2026.10.26.12.18.11
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b529a8610so79804976d6.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042290; x=1793647090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
        b=H0/Y/cJN7a7qauIF7IdrLCml7qvQ06gT9GI2jIst243tn4hvmjbpGyj0KfD4TmTkhj
         ZZ98Z2ZGRJDRfojvzaC9e0Vf5+ZbvD+a1irJ5vgjfMP8MZ+I0wKX3ibADwAKEq4VvJjZ
         03+AfNWRUeTih2PLMBYeDViIEub4amKWjOWhA=
X-Forwarded-Encrypted: i=1; AKwUvBwVq9o4Rbb7AnVce7u/g1RQm7ct57AxbtA1eGDC1Nf474T//yeaBt2y+MuQNcR14M4J+3O0CBKvhhY=@vger.kernel.org
X-Received: by 2002:ad4:5d42:0:b0:91c:6d30:7c2c with SMTP id 6a1803df08f44-91c6d307d76mr12445256d6.52.1793042289913;
        Mon, 26 Oct 2026 12:18:09 -0700 (PDT)
X-Received: by 2002:ad4:5d42:0:b0:91c:6d30:7c2c with SMTP id 6a1803df08f44-91c6d307d76mr12444746d6.52.1793042289436;
        Mon, 26 Oct 2026 12:18:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:08 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v3 3/6] ata: ahci_brcm: Initialize the NSP interface clock and reset
Date: Mon, 26 Oct 2026 12:16:15 -0700
Message-ID: <20261026191618.3178830-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
References: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The NSP probe path assumes firmware has enabled the SATA IDM interface
clock and released the core reset. The downstream iProc config_AHCI()
sequence explicitly performs both operations before accessing AHCI.
Without that setup, a cold boot can access an inactive controller.

Map the optional NSP IDM register region and enable the interface clock
before releasing reset, retaining the downstream settling intervals.
Perform the sequence at probe and resume before reconfiguring SATA.

Keep the resource optional so older device trees continue to rely on
firmware initialization.

Fixes: 3ee2e6dcaa35 ("ata: ahci_brcm: Add support for Broadcom NSP SoC")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..3b6ed56f3e95 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/ahci_platform.h>
+#include <linux/bcma/bcma_regs.h>
 #include <linux/compiler.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -83,6 +85,7 @@ enum brcm_ahci_quirks {
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
+	void __iomem *idm;
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
@@ -230,6 +233,25 @@ static u32 brcm_ahci_get_portmask(struct ahci_host_priv *hpriv,
 	return impl;
 }
 
+static void brcm_sata_init_idm(struct brcm_ahci_priv *priv)
+{
+	u32 data;
+
+	if (!priv->idm)
+		return;
+
+	/* Enable the interface clock before releasing the SATA core reset. */
+	data = readl(priv->idm + BCMA_IOCTL);
+	writel(data | BCMA_IOCTL_CLK, priv->idm + BCMA_IOCTL);
+	readl(priv->idm + BCMA_IOCTL);
+	usleep_range(1000, 2000);
+
+	data = readl(priv->idm + BCMA_RESET_CTL);
+	writel(data & ~BCMA_RESET_CTL_RESET, priv->idm + BCMA_RESET_CTL);
+	readl(priv->idm + BCMA_RESET_CTL);
+	usleep_range(1000, 2000);
+}
+
 static void brcm_sata_init(struct brcm_ahci_priv *priv)
 {
 	void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
@@ -376,6 +398,9 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Initialize the IDM before enabling the controller clocks. */
+	brcm_sata_init_idm(priv);
+
 	/* Make sure clocks are turned on before re-configuration */
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
@@ -453,6 +478,14 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	priv->version = (unsigned long)of_id->data;
 	priv->dev = dev;
 
+	/* Older NSP device trees rely on firmware to initialize the IDM. */
+	if (priv->version == BRCM_SATA_NSP &&
+	    platform_get_resource_byname(pdev, IORESOURCE_MEM, "idm")) {
+		priv->idm = devm_platform_ioremap_resource_byname(pdev, "idm");
+		if (IS_ERR(priv->idm))
+			return PTR_ERR(priv->idm);
+	}
+
 	priv->top_ctrl = devm_platform_ioremap_resource_byname(pdev, "top-ctrl");
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
@@ -493,6 +526,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Initialize the IDM before enabling the controller clocks. */
+	brcm_sata_init_idm(priv);
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.53.0

