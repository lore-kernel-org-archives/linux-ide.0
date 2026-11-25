Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581459;
	b=lHNBj/B9V5hMaI0r+67Ooh1bOsLabQWqF9UdoemW3BeGlBqUyqamRR+I+ansm+l/gosg
	 SwqEaaSAdE06ZFMNjnDTaldCa2qZu4YgW8mu5g/KNiGecs6dOTh70wwG5OBMfxmR1Hvnu
	 KJxbmil5QHsHY9art9YvWGIPCh+3LiayHpN+zMKTXFZoawYtzVexLOb0M8oE7bSXUJs5j
	 zCjNaEdZBFSshKurotdWtlRISXAajtTNGrR8EhzOwIgOM5RKOBCf6lZeZq61RBTweoa3c
	 wN6F15alks33dexi0YKzibe4pBeamddYejEqYuWu3GKLyVODrUTZLQFdEA2KScuqczQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
	b=Icc5O17Enmth8pSGdmKTciuouV93zViCofL2konxI8gK7nH0zB6vVFTvA67i6yd+iPaG
	 +bsN4MsFUeOH3xSJOmRvy3IWTDVAoQ+NUZvFG3L34hhOYljMMR0XSJ1aeWOZuRzax7K4T
	 VMPC9I3e3D8KyTbb6TRL4AMLWjmDhisaYBP21Rn5hAXQ2khCLOP1bmbgEipH6hTauv/bG
	 wdXC5znG7dxjp7r6BQYYJId+SzsKDsnAr9/W0YPNoPzJ9AXO73QFng2DVCdis1qs8K3pd
	 bULJn1BcAKb7XNaAGd5ir95pYTsGwbAbYBmVt+T/gU+7G+EQhmy/eOvwAiHfm6IWk3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvonKtza;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F6606A330
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479F6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvonKtza
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so2527940b3a.2
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581459; x=1796186259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
        b=pvonKtzaM5Wyk4CZmuG+bv1luP4hRBIDQlwZ3sKoJ36e/Bw3Y4pRek8KjQ7VDVbOo7
         fZgx1adpdLIdwu9BI4YXoD96CZ2EPF9WIVytdfCMZr4pBIS5N0UjXJ4WzZ8iaVc4bUYr
         Rg7BbMaiaQz2/7Y2q1E4ywyZYY/NCR1VDPe+98ERZ2tVtDV3IXkNWj2XEZAaH8u/pVuQ
         0O4Zm9DQCMMjbkvdSz0unPleqkuBZdvObOkeckPbpazhirEi6Uxidtszq1puuOqiejDH
         a8tu6JrDzUXppBdFxHJH68yoMHym6z+0S1tLAu0YzEfJ6hAp6icPFSiWAMMwOqtvfFva
         uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581459; x=1796186259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
        b=lBrQN0dYOOD/BhIilLXbQB4K/FhikaFSL/uS1rUL1KW8Ms0JPrh0ZE20tThnU2aC6s
         DmB8rKbO7prMMCQFLuyRZLTm33DgEtJhfj1NPNP/buSz/4Kn2tmSrSnupeLnMXydNbqa
         9OPUlY7PPoMFk00GzcRrAW7N+YBbrDpWLAiiSoTjmO/R3D/jl7xv1YG14VnbpAl4nAIN
         HjfQGR7hqfnzVoN/8kJ2xK4jUzr6SKolRzYbuxnMRQGXIoY/gCpZbyxnh0a8fE1giL3F
         PfB7wOCQuwJk5XqFtIyu99p6Ngp6AOE4mt4NIafyW9yvcVQngWIoGxG72RFvCADNK+qx
         IdEg==
X-Forwarded-Encrypted: i=1; AL+hErErkRof4iK01eHhYApcTuvVPtf2qYEp5TY8lq6KAdAidM7bU/kCDv0dn2BGH7eZJNjXQlkk3felzpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z96yqq/7iQQdDFKo0sFkpa9wICNGEOP9FgMvbWhhqPrU7j+5oCk
	th5sB88SVneSVWBHeMseCJLRD81d5XIZBn4/Pt+Wc8TNx7wgv9Xq8v8D
X-Gm-Gg: AZFdTZfL+LmQHVUz0+p1dw3Ig9d5t97gcnPk/Xx/sIyWkSip49q+eD1ADoGVkFg/pr4
	aPCAGSY7pDDkRmihsB2gtZRgfwZZJkH3AfMM6NNctMpntIRKiNxGmGEXTu7O51U69YfLmxpKRgN
	bFEhoh9veJnHTnRNTOgBjufVxXTJN7JGysXtK6sGTMzauRar2LelLYHRXOXL0qBbTO59eYqkf6V
	vaj3g224/TxMc/IkLbbdXCLeAAKchFn5XLjrQMeumBfOU3Os67t6kbenFFMGgdpCc51Zp1c9Ozi
	ktwdXM3lUlH9dvDp1m/L++jV8R+yR5Tr7gjaqO757CKqpQb88ovrGJo+LUvksajHX75sWNlQQzV
	5+pRH/arw/ZU4hG3B2jGac4a3g4RTihpXlOm56Li/GBY+X4i8jzMRdhNrBtwGLkKzjNAv+v8/1i
	PEJaKTxGZ2XUgZ8Pi7BevVpLm+larNG+2O+IZy1/ArqHPd4dzFQwqD9YxUbrD6iXeh69INPJZkH
	LWEUaZtzQWyGLqha4Qz6nfvPBcOYodFtOVPEem9vHS8nMJX8M0HnKnc9PB/8er2kG/Lq3eCHKAl
	+oA2qCN6l94EKmZ8UfOJmqw8NoI=
X-Received: by 2002:a05:6a00:c311:20b0:8c8:e7ae:5ab2 with SMTP id d2e1a72fcca58-8c8e7ae5b89mr11374449b3a.53.1795581458605;
        Tue, 24 Nov 2026 20:37:38 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c86d821637sm8324761b3a.0.2026.11.24.20.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:38 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Rhys Tumelty <rhys@tumelty.co.uk>,
	Manikandan K Pillai <mpillai@cadence.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Hans Zhang <18255117159@163.com>,
	Yao Zi <me@ziyao.cc>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 7/8] PCI: cadence: Use phy bulk data api to simplifiy the logic
Date: Wed, 25 Nov 2026 12:36:38 +0800
Message-ID: <20261125043639.249525-8-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125043639.249525-1-inochiama@gmail.com>
References: <20261125043639.249525-1-inochiama@gmail.com>
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

According the document of cadence PCI controller, it use multiple
phys for multi-lane setup, so replace the loop of phy operation
with phy bulk apis.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 62 +++++--------------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 +-
 2 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 0ac980249941..8ed2a679625d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -179,39 +179,22 @@ EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
-	int i = pcie->phy_count;
-
-	while (i--) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
+	phy_bulk_power_off(pcie->phy_count, pcie->phy);
+	phy_bulk_exit(pcie->phy_count, pcie->phy);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
 
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i < pcie->phy_count; i++) {
-		ret = phy_init(pcie->phy[i]);
-		if (ret < 0)
-			goto err_phy;
+	ret = phy_bulk_init(pcie->phy_count, pcie->phy);
+	if (ret)
+		return ret;
 
-		ret = phy_power_on(pcie->phy[i]);
-		if (ret < 0) {
-			phy_exit(pcie->phy[i]);
-			goto err_phy;
-		}
-	}
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
+	ret = phy_bulk_power_on(pcie->phy_count, pcie->phy);
+	if (ret)
+		phy_bulk_exit(pcie->phy_count, pcie->phy);
 
 	return ret;
 }
@@ -221,10 +204,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 {
 	struct device_node *np = dev->of_node;
 	int phy_count;
-	struct phy **phy;
-	int i;
+	struct phy_bulk_data *phy;
 	int ret;
-	const char *name;
 
 	phy_count = of_property_count_strings(np, "phy-names");
 	if (phy_count < 1) {
@@ -233,31 +214,18 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 		return 0;
 	}
 
-	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
-	for (i = 0; i < phy_count; i++) {
-		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i])) {
-			ret = PTR_ERR(phy[i]);
-			goto err_phy;
-		}
-	}
+	phy_count = devm_phy_bulk_get_all(dev, &phy);
+	if (phy_count < 0)
+		return phy_count;
+	else if (phy_count == 0)
+		return -ENODEV;
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
-		goto err_phy;
-
-	return 0;
-
-err_phy:
-	while (--i >= 0)
-		devm_phy_put(dev, phy[i]);
+		devm_phy_bulk_put_all(dev, phy);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 4a96e1869e53..3cde29592331 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -274,7 +274,7 @@ struct cdns_pcie {
 	bool			             is_rc;
 	bool				     is_hpa;
 	int			             phy_count;
-	struct phy		             **phy;
+	struct phy_bulk_data		     *phy;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	int				     max_link_speed;
-- 
2.56.1

