Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581447;
	b=IglcNhYd7Ux42ucZKgPB5MpSCLTj7aEx+k6rzommljxmjb4e0bCa1UVta5bLajAXHtaK
	 KtSVRlBbnFypgASHizZEfdUs/rlsElhBSg1u6FQP4CNcFDV8eiorbvpVPxuLYLsVpQA8m
	 oWwLBqnK2+bBCNGLOS5MPdQIE/afMHGSu6JtBx0uj/LbxrrUCzU+h+uAxL40qcMk0GHJK
	 R+l7v0vOvDhcqoVOBzu7fOtmVdeG/E/BruTqLm4jATMEtcGy+v6FoEPAokHGyvdUSuD//
	 yEDWfFBxupp9uSIn1ppR8m8+XaSwxP6zse4J49jZw27hZw2zoy0nbgfmwzOwNGNo6Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
	b=qz0TbxQD3GmyZHFophPFRAYT43UiERvFCH8blLX3ah8bG/CqmgvAkhGRQmbGM/j1tlL2
	 qXcb6YbwcTm4U9qiu1X2cWPh4pGxU9skddMOt/VjgNZfYZ+HalMKj+IIvOpj1AGJAtAZh
	 2vS8kPjoVDoBF60eYZnlAnvf7wkJQKcosHtYxwWn8gCm6tw80WDx7zxonULC/h8teGoYo
	 cvtdV29+dvSBRT1KyWSsHuxf6cIgoL9VxuCkj1AePwu1s0xmqGfJFP5G7bfptiNaEYpsB
	 GEpFU6ipJlzV8/9rfnvl7kznirzFM2Ta8CwrhxdKSabnU8DjZNWR8sKFnoWNWBXsNAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr15ZfdJ;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF56606A330
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF56606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr15ZfdJ
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso2246230a12.3
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581446; x=1796186246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
        b=dr15ZfdJEWlFKiosbX0D7l9+7/idGVhRa4u95t0s+U28EotPIPmyI2a+lnKcCTISn3
         S83ipJQLhVZoPma58S0CxFaXppQbCjP0Df0vV2D9+SStuKA+umIhNW7QQSUz9lHe2Ljb
         jC8mQgsMmwAU2d2AxJRP/InN8vIA/0f6/ymJPD+J2WOGQbtKCNFmm5AeybuSWmkAqwtJ
         jIdyrqVbnPcE7hN5G8f+I5n0ge8+/Vx/orLpolDiqFu8ZMF8EES03C5sS6pL+Mi4eIYv
         3LE3GQ2ZuqbVwZ1kE2IaFXX67bbSv/y592kweeth4OlvGf2uRDCZKlXbvbJ/nm771M+P
         1F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581446; x=1796186246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
        b=1+u6t0OJ/QI17dtzil4MkhI76wRI6tR9S/RKzSz7Z/69zXdb2ye3V0707/dQPG5Nvm
         vEiom6QlUf2nwJ4pUVjMFm4DPeUMNXCR0TPDnwtl7jqEdGqTGnx/QvyywekUpSF2MdeL
         tb+tQKAd1er/bcNfjvK7O2dDm2K+CA7xlbZkTIpx6Xjl+rmBXrcfte6HFFIWjvtD2gAA
         +tbL1ioLBSXC6EvdxmnZ8fy6aN159agXidreLXzkTT/S64O1XCaqQZFwsfl93P/e5LUq
         dkLR/GnGloiGLOFHMg2aD0VkUBaRNkFvTl3Dp7zKx6UTV+E8Nm30GR9RWRoAGI8pIjO2
         3h3Q==
X-Forwarded-Encrypted: i=1; AL+hErFVPyC+Mq3TWv+OHv5kAXCqDSyazTIXrpzbROn2PspU5a6n1/B1tAseqzpTYwzD8sACkTVx9IEAc5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iLf9IKiLyW7a3LVQPleld+sqjRrZKFZEQ5iQhWWKBPV030b3q
	7PNNws1fJF/mlFhJVTfJK+JjSbgETH3EMMLHvrRtPfVjt9Qm9YTsuWGv
X-Gm-Gg: AZFdTZeg2dUREdAP2qcBOsgz41GlpCOMQHFxVsKsuSlwJ9s0CBrGPeNhTQlQ+5ifGL0
	dhx9yVP3gWd2MgOtEoYVCYqdg3p8RjrEVjXTjrgrIgeRFzodqvs6ztLz74YrIRW8Ilaq84zqjsV
	9wJE1SxqByaa5qqRg+LsYag+we8KUcJf3HAQn5Z8xTtO5FSq3V0iGHtB8HaJwWdV9uhzDCMmM96
	l7KSr/lCV3bgBUOBshhTSdPi+fd4cPTOM3W6mZJKyJo73yvpJob1ArzsPwxva/6IUy3Yxocvs7J
	bWAu/Y2z/G2VSVZipWm5deEaC75fnWK0Xrpz7P/JRD3siud3ckbrWiFLGrrTVatVg37TmFcCJ+R
	2ZV1e1+5lps8mMwgsZo6b5NVUC5J54rWxV7JtkVI4Nh77pRzA3FIYxLbBFHXoEzEffV+8AhNKPb
	imZPIpG1NB5rHUgaqH0c09QCXwYgXxGXxcDs5m8amNNFHlI/LnMl+6YBM0bRKbearL1jeNsRb8z
	1dfDe0UlqShye44y1Yg4D2R/iFHk1qdZOIf6zSu4mMqTQ0R8ZHMglNiksHLJlqx5UwNFPu85Zdz
	7uQlFPTmuNUJaRLsRELAVfqxumE=
X-Received: by 2002:a17:90b:4a48:b0:3b1:4018:bfdd with SMTP id 98e67ed59e1d1-3b41c7d5cc7mr13865555a91.7.1795581446160;
        Tue, 24 Nov 2026 20:37:26 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm30506154a91.8.2026.11.24.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:25 -0800 (PST)
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
Subject: [PATCH v5 3/8] phy: core: Make phy_put() ignore NULL and error pointers
Date: Wed, 25 Nov 2026 12:36:34 +0800
Message-ID: <20261125043639.249525-4-inochiama@gmail.com>
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

Add NULL and error pointer check to the phy_put(), so it can ignore
any bad and empty pointer, this will simplify the release handler
of the bulk data API.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/phy/phy-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index efbd7e139dce..5004d28b167a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -780,6 +780,9 @@ EXPORT_SYMBOL_GPL(of_phy_put);
  */
 void phy_put(struct device *dev, struct phy *phy)
 {
+	if (IS_ERR_OR_NULL(phy))
+		return;
+
 	device_link_remove(dev, &phy->dev);
 	of_phy_put(phy);
 }
-- 
2.56.1

