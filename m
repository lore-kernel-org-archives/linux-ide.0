Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581462;
	b=ashK8OZEXRGyjK3TN1RRX6Xcd/NWTWwmeP9po9PNkkyeboNxZ3Y7L/bNVonFNszDBJz/
	 v6YnTpxQdy3LophwNtPVCx0dS5sIb3gSgcUrR1TpGUaHg4pWOkCukZjdsqsXCCH7gSx+i
	 Bb6qvLdb9mRqPpOWv4onMrkC8+EqAD//JXCRBRdD4ymJEy4tAYpx4LRv0dYQvw1R+QwrK
	 djGkOc6MqB7fScKANBQCt+/V1BGINihurI4qKbtbEUjxBT9rClQuIB1e34OxKCs8sHAzz
	 5Q8FGWfPhAyzro4hqV5KSRmfCAuL0vElS1tI4yXJ9wgq9WP1jV8VU6qoeHCXAdkPyHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
	b=CxQBNpri380HXHxEsmiLRTk/nCb8PiI8UOaBE9pR/dOwScwfEUFZ3J5KeBd9+ZC3wUUx
	 92HYKLXG/gD52P7qaMQepNj8A3ubZLDWRYQI0IrcuQepTMUKBx005VT3XjVnUj1T2fi2s
	 JhukObMOCKNRU56+Mvgb9TpzDNKQ/K43lhAVhdvGX3xSwBnNzFsru2GWPbK51CtWrn1QD
	 93vEXOInBBz/YZdjRcmrRvL33x08aOI+G6aGRlm3i376l5kKK80tPiecutMQUuNTHyl+1
	 0go9wN1y4bdZ6JtuwGSNgiP4xkus08oavJ72b11HzYxyaJeASgPqqVjpR7xD9IwMmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZwfXs4;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECD606A338
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FECD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZwfXs4
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f05b465cd1so27562235ad.3
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581462; x=1796186262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
        b=ydZwfXs4itqQiYJPjgaUOOO0SQIyr1DBTGTbktl7OG2/yC5Dblolhcn3IS42km/rf+
         tVkzDsddKnEt2tLiPCLnhOg/KKr6yW0dYeWYUUgzJl+Ubn1XLTHgYqH3xvldlSDKy2rA
         mD+BT3arUSXfXqCSlhE6qWm+2gP4E+jZ5pXeU9aQeWLR3wE4JdQZxV7uIxsB3wpYRzBa
         VYiMQTNNXsMnGgJYUeP9YCSVmibS06kpZzwaCLjiheizhm32L19Q8c0lXmlLsUeVVl9T
         Jt/d2ovu1QdMREbgiVNGZzR+No7PtC13I9Il5FbUY3Vu+/PQ+P1iBCilGgZUYlrjlKzo
         ZWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581462; x=1796186262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
        b=n3uzl4QPiQrHEIytt2uxl5SuDbbBlow/QqCBVy9nqVCOv7SkqV3WenA7J2gLtJDOcy
         S9+ITTIT7G+gQLFhYOakTFoYQJ6iCNKijszKABRgG6vIgm9Pc2vXEqPwCThMRwB4yv7D
         BFp/oyqGf1AlAu3tYPy7nb7nho39xx50kzTXiv6U0Jemu+on/Lugc0uURtEt7tk/3oQT
         TvpQp7aqUyh5vni3cm/xjjS+2yhfSmmCQ66+KYBuU0LAjcSoMHQjNnBlTibkB7HRE8sE
         XwZBz2DNmQ92PFh997cbfOKEvGR369HU/0Hkg1GoNc6aTTXw84g81yTcJ+5OOY7BxpW5
         WKnQ==
X-Forwarded-Encrypted: i=1; AL+hErGfgsE74RB5rVsn7CyTk3Yel/GtC738MXnonGLpIZaLuF/wKZS4akci+CtBCEqnjLXgfZFMd4QQ4OQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9scS+6Ew/7WYtLc0StDc0fC1NrlJQqdZ0lcOZwC02vni1SP8TG
	1hXiLWPkZcriXD6Tb08/kzLFycsiVau0ygcd1yVwdNQzfl4fqDGHh+D/
X-Gm-Gg: AZFdTZe1fb9mDH6lPhskalbtLXq3PvFNtCPHPX7Ou01K+P0zY3xII0fZr/ZuwhZ01s6
	RJcijbvaqS/wEwMWe9OwQdQsDTe3ooDeIjYaSxxpdexlnlk7qRwqSsZxohAoD27rJsFobtFh/5l
	0IaLAUqZaWC9nA1CNlBinUyUUTMOwe0Ff9EneA9Auuz+AyL1Hbu4IOzgEkZj87UDU2urgCBqkVZ
	iHGHBJT7xDXGtsUefFBNKTIyS0v0N14RBu9RbtiRMIVyUfgKs8Ir5qKZeORZf1L47wgZsHp2Ob3
	wIDQPpoLTu/YBe7UfLIdLjhz/eZCc5Ap2gUI1dQG9KX8rSThQTdxyS0Hn+/IJy0Om3qEXCKBPlf
	cp5crek5n58NWHEzLrobSwIZN+ROY0jj84cTUltjd0a3BzFe0v1m0JBd6WwyQmPsqWwYnGVFu9M
	YETZE8bfxoVcVpD51f4SO7bMawflCuU4+VsolXgCCfKXZWr61vI2qjO8paBrJLbBQ+OQYdHYjQ4
	KpiJxu92efxcDvbotPxGxPFJQRv7T0MEt75JTWxARqmThh4cw0Q4zeOrD8PnUZjuZAk7R3H6Tgm
	mjC4crFWpa9kkllWCQcDnCj0Axg1JKnBS1x7Qx0Cf4hFpp++
X-Received: by 2002:a17:903:294f:b0:2ed:630:40ad with SMTP id d9443c01a7336-2f03f11826cmr93907705ad.19.1795581461579;
        Tue, 24 Nov 2026 20:37:41 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm78350235ad.16.2026.11.24.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:41 -0800 (PST)
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
Subject: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration PHYs
Date: Wed, 25 Nov 2026 12:36:39 +0800
Message-ID: <20261125043639.249525-9-inochiama@gmail.com>
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

The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
impedance calibration. Store these calibration PHYs in a bulk array
and acquire them by name with devm_phy_bulk_get().

Initialize both calibration PHYs before powering them on in lane order,
then keep the SATA PHY initialization, mode selection and power-on
separate. Use the bulk helpers to release the calibration PHYs after
SATA startup and to unwind failures without repeating power-off after
a failed bulk power-on.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/ata/ahci_imx.c | 57 ++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6aaa18e29abc..18faa033e44f 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -25,6 +25,8 @@
 
 #define DRV_NAME "ahci-imx"
 
+#define NUM_CALIPHY		2
+
 enum {
 	/* Timer 1-ms Register */
 	IMX_TIMER1MS				= 0x00e0,
@@ -66,8 +68,7 @@ struct imx_ahci_priv {
 	struct clk *ahb_clk;
 	struct regmap *gpr;
 	struct phy *sata_phy;
-	struct phy *cali_phy0;
-	struct phy *cali_phy1;
+	struct phy_bulk_data cali_phys[NUM_CALIPHY];
 	bool no_device;
 	bool first_time;
 	u32 phy_params;
@@ -428,30 +429,20 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	 * Initialize the first two lane PHYs here, although only the
 	 * third lane PHY is used by SATA.
 	 */
-	ret = phy_init(imxpriv->cali_phy0);
+	ret = phy_bulk_init(NUM_CALIPHY, imxpriv->cali_phys);
 	if (ret) {
 		dev_err(dev, "cali PHY init failed\n");
 		return ret;
 	}
-	ret = phy_power_on(imxpriv->cali_phy0);
+	ret = phy_bulk_power_on(NUM_CALIPHY, imxpriv->cali_phys);
 	if (ret) {
 		dev_err(dev, "cali PHY power on failed\n");
-		goto err_cali_phy0_exit;
-	}
-	ret = phy_init(imxpriv->cali_phy1);
-	if (ret) {
-		dev_err(dev, "cali PHY1 init failed\n");
-		goto err_cali_phy0_off;
-	}
-	ret = phy_power_on(imxpriv->cali_phy1);
-	if (ret) {
-		dev_err(dev, "cali PHY1 power on failed\n");
-		goto err_cali_phy1_exit;
+		goto err_cali_phy_exit;
 	}
 	ret = phy_init(imxpriv->sata_phy);
 	if (ret) {
 		dev_err(dev, "sata PHY init failed\n");
-		goto err_cali_phy1_off;
+		goto err_cali_phy_off;
 	}
 	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
 	if (ret) {
@@ -465,10 +456,8 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	}
 
 	/* The cali_phy# can be turned off after SATA PHY is initialized. */
-	phy_power_off(imxpriv->cali_phy1);
-	phy_exit(imxpriv->cali_phy1);
-	phy_power_off(imxpriv->cali_phy0);
-	phy_exit(imxpriv->cali_phy0);
+	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
+	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
 
 	/* RxWaterMark setting */
 	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
@@ -480,14 +469,10 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 
 err_sata_phy_exit:
 	phy_exit(imxpriv->sata_phy);
-err_cali_phy1_off:
-	phy_power_off(imxpriv->cali_phy1);
-err_cali_phy1_exit:
-	phy_exit(imxpriv->cali_phy1);
-err_cali_phy0_off:
-	phy_power_off(imxpriv->cali_phy0);
-err_cali_phy0_exit:
-	phy_exit(imxpriv->cali_phy0);
+err_cali_phy_off:
+	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
+err_cali_phy_exit:
+	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
 
 	return ret;
 }
@@ -839,19 +824,19 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
 {
+	int ret;
+
 	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
 	if (IS_ERR(imxpriv->sata_phy))
 		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
 				     "Failed to get sata_phy\n");
 
-	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
-	if (IS_ERR(imxpriv->cali_phy0))
-		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
-				     "Failed to get cali_phy0\n");
-	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
-	if (IS_ERR(imxpriv->cali_phy1))
-		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
-				     "Failed to get cali_phy1\n");
+	imxpriv->cali_phys[0].id = "cali-phy0";
+	imxpriv->cali_phys[1].id = "cali-phy1";
+
+	ret = devm_phy_bulk_get(dev, NUM_CALIPHY, imxpriv->cali_phys);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get cali_phy\n");
 	return 0;
 }
 
-- 
2.56.1

