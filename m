Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039372;
	b=sqmKC8W1YmoufOI0fY/vDnisRqJBplXiqOmF+PabULOTWIFQ5PEFzbNnBuSIJpfSMC/e
	 jvQ0rRF8XjxM7m4Kk3s12BuFbEObQQKz0lM280bjlmT0Z+sdrsYm2KTZBXu/64cyVnpRx
	 /4rHG9jgOW0CMReaPNeKFFzkSc16rxwxvUoBiSzC1WBX9sEsRmsukw9gpuLGbBJInHpZH
	 GfgSJkiJK/vOpyRA6WH5UR6lIKA9on2EZIgftpVtwuMQ2eC/bFyxZO6XYrOlbiThGWLxh
	 R/pjL/QmbNWCY/VEgrE70h7byNrcMAA6U00TnUr71k0cCKHfj6IOSkWPe3+VwQ/x9Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039372;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=mvtMFeEgqCOciHeQyrJ9AYtTF4EED76l0h+Ctv+GHTw=;
	b=WNKEEbeQquRc9YfBgivUW8aBW06+rnwaNI1lOstLinT9jB+dPzg571I4S3Mkdr8iov/K
	 qufZKqSNOsOPtjX5JxjaHV262JJxfm7Z4xcqLvyI55VKnJU4TGJ6G7kACUCBuSf7G3UF/
	 Y0kDfoEbDDH4/CSF7bD96ZxODlY9LZK3mPcH4DcK5FPdva7nDBRhS4cwCdzqAUt2ffpCi
	 SRGpOGa/5YmLBb36kzKV23KUlP2VdltnyKeriUMB62ckV/3duwgaQj9bLax/vcLa1x8ie
	 NzP2mng/OW4V+K9k3bGieoRBLcJfJoQnXMTEu/JsDv9teqn9hFVgQRjKbNGipGhcEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LIOJVQOW;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA51606A328
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA51606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LIOJVQOW
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2231754a91.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039371; x=1793644171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvtMFeEgqCOciHeQyrJ9AYtTF4EED76l0h+Ctv+GHTw=;
        b=2mjVAVgR7O0JDJUSABQ9Rm85Y1U72iDXzOiTmkCCdiI6phqlSClH6AINME7KlVUZxs
         7yNG1vMwxYy3i97NUmekVAfDAQjy8TuzatarP3jkF8JAbVi0e1WpU+lINfDcOJ8AyDVU
         rAvQFx9fYoRDAKI26A+8xsB0pLXs2/4zsQ8LSrT0fi2/D+wngW6Qg9a6oJ9H6AB9jMqX
         RJ/R5w3FjtOO34e1HqZsq9kPYjeAu4bl6osqdBPuBcTyQEt1Z4f3IbcIs5ybo6Gu1Avc
         PnkmYwYyLvbI/7daXdBa7EWhWzSREal/E1SagYlGNKLJNevPwBV/+GomwXJJMsqxUh7X
         jD0w==
X-Forwarded-Encrypted: i=1; AKwUvBwIuTJkzOSYBNpK2xoR3h+R2qbLNQoWyo8LXCd+iuhzvGnRtsiYZ4DLoEFaZStvHrxSBtdN7+FjtMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQgz8SOdwIE6vHIXd96sbG656D8XdTHisdEh3iUtu+LTpJ9epZ
	EraSQeQSlgBRQmo/L1/3QU/RvZVkxnHr8PrPMlEaJ/Yq7atO9qJ0ERGJl5ptfTbPJZVQU0Ik+vo
	3SRX/CdVAgrZmfr4DE5Dbz2zNJCmvVI4iFD7FOhbK+ifyUyw8U94x4gkyapbV6aBObMJ3VJxhE0
	+Z8FmvXeFQUvekb+VIEEIhhI8XNXGnjaFU2EGOrqlYOV6OYyiPz0KBRRRTDAmhe8nDFL9Cm0+zK
	j3dGThSJoP+lpnaAMfr
X-Gm-Gg: AYBFou1Wgg7NoZri4udY0h9UIsnrGB2DCxVZt1kL3NW6Htx9QlR5o+ga5qYVHJhQM12
	ge2ba0F4fD2UrfwK+wK2JYlyZUVzRuNgsafge7dbIhsTHYYYvgVr8sLR/Ys7z6DEHsieDSwp7qb
	0gFllYnna5BdGLbE9LbZ1TxFzpo/+YaK1YuLvhRZW1AzMpcUS7t8z4XD/Axg9Q1rcB3njEnC0VJ
	cYfT2hdWMNoojTaZl4paOWpn54siQ4KKYGPZySuUyH5whEmtmudYiT6Mm+pM80G+O7aoRtZE1Yp
	iyEFEORu7P6xrFlHwfkScuOXPTVI7TNReZrOSduIk/PIaiX8ZyVqmRGwTcb4Xuy7D4T17RHjkSS
	KuB/fU+CyEGFd1rMzVVlAuzRLRNzw1yY9/UdZEVg/4VMEK8jBOPc2B9obZglaaz61g2VRjWEsKs
	YvFHm1gmeWt5FQAmQNC/SbKHBrPo8EubaBcKnakQe/
X-Received: by 2002:a17:90a:c88c:b0:3ac:7c4d:8be1 with SMTP id 98e67ed59e1d1-3adeb1622d2mr6058045a91.62.1793039371189;
        Mon, 26 Oct 2026 11:29:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dbad7sm251071a91.2.2026.10.26.11.29.30
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so5741734eec.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039370; x=1793644170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvtMFeEgqCOciHeQyrJ9AYtTF4EED76l0h+Ctv+GHTw=;
        b=LIOJVQOWEm+yBjrPuVXalbtBdskNsAKvaNT5yoKyNwbTpn+54ucSCM8hMN+E727FAZ
         eNjzVHvY8XO/SyJfAcM6yqUY3P12srdSQG0Y3tGf345Hth/6mHpJAdP0Lhg4/kNPxru5
         xNbzYX35LbfCHfPBkSQlkUjPrby9yXmyK2WRM=
X-Forwarded-Encrypted: i=1; AKwUvByXOlkCDjImACSUDHdBG3P3liPb9nDlYwWIBCdLr5B/XdnyFv/9InJy8iX3C1o3FIkNICTYkU8tOyk=@vger.kernel.org
X-Received: by 2002:a05:7301:1525:b0:369:a113:756f with SMTP id 5a478bee46e88-369e850d487mr10690509eec.34.1793039369607;
        Mon, 26 Oct 2026 11:29:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1525:b0:369:a113:756f with SMTP id 5a478bee46e88-369e850d487mr10690462eec.34.1793039368795;
        Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
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
Subject: [PATCH v2 3/6] ata: ahci_brcm: Initialize the NSP interface clock and reset
Date: Mon, 26 Oct 2026 11:28:53 -0700
Message-ID: <20261026182856.3168686-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
References: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
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
 drivers/ata/ahci_brcm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..2ed60806b671 100644
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
+	/* Enable the interface clock before taking the SATA core out of reset. */
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
@@ -369,6 +391,8 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
+	brcm_sata_init_idm(priv);
+
 	ret = reset_control_deassert(priv->rcdev_ahci);
 	if (ret)
 		return ret;
@@ -453,6 +477,14 @@ static int brcm_ahci_probe(struct platform_device *pdev)
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
@@ -493,6 +525,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	brcm_sata_init_idm(priv);
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.53.0

