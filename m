Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581441;
	b=AAskuHn8+o5ojehvkn0C1o1AqdEMr/RIRb90K9bat8H79WlXUBYfqj+5ExaROG1nsxzd
	 J+tgSjsIn9UwHrrmYKqUK8oP00OIv9lB69Ufy4Ekjqw2y0XbO3wuwYcAB08X8/xWujfHa
	 /vTVxeL36qGzcVjfoXKiy8cCI8wHneRFhhKZObUVXi1B4qwUgvxd+kD8QoMW7n4r4+kQI
	 /9nY/yk6f8w9N39WWKgpMDA7ZxKSmx8parMJQUqTVMwymc8j39H3O3acQv2OPIBlPULmB
	 LLCqjFpx+ewbYSavT6Or8frHy+6zWsirjZ7cvRUeyxwcjPdfWMkUnhONDkluDvwz4wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
	b=w6vVokJVFR6J4YewxgGKxdgHguZ3QE9HTuLAYzvRTFEtmK3Cya+Ne7Xbq+MF9f9NgHEn
	 p2rZvaz9w7BvDPZZsTWmAkmLh1qoX1XuS64j8zIt7ViYI4wvi/wXHwAeMCXjKG/1ldlNN
	 F5dgWWjfXJjhH7mkVSOAVJe8jkAjfp0yfw8jDPHuxfzZgLT2yiU1goFeBASPqoK9c1x06
	 Q1/X0DWlYpHZtgaVkpr/4cRajJzPW62vc9rounPX4vE5PZCfRMzmbw25vWScDEtH+8gcR
	 vncHrv0EALk9ulnOePH78dvYb2t/ej4KNC1MfNPquWyXhnG4KQ8Z1TvKHIJ5HXf5Glw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoAvfN9g;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF3606A334
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDF3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoAvfN9g
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f02ee04378so42050135ad.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581439; x=1796186239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
        b=hoAvfN9gzx2LyLk/gEV2pCQQvL2eHN7Ybl9S9sseLNfnxe3TLOcWzkEHsO7H6i52Z8
         ITIu0vs7T0b8u7ysTdtMP3BWhjQlfdDNdds8EuQtokuuaolNc47LQgMP5JHrlNBrvvNY
         q9gGurHUD/mXM8g3m3m4nnxtcS3ZNNq1GBaQ7k8tfmyG0pdFAYOWPER24dpLCCp52kf3
         DDrkI4f/Kew96kmDkgo7bik5bil4SFvJCzb0Eipy3PVqHi4pPc4ymxRehHa7UcOcivEg
         4C0+klwghxMs7IUhkeI6brCl6T5Hh7pBcL0nbKwnipb1PZLIUD0kE2x12R/M4CRr3dYs
         M4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581439; x=1796186239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
        b=CQQvPmt7ivmopYIM3ZzcUMKobt/tpJUP84DYYZxdnufPYRXZO0Sj3g7K3O/WTXvswn
         cjcPBRGOTNWwCckGfrMJDqxAkDcj8ImPhYCGpAModKfPpZEzs+r6B60Rwbn2JJh3WBzc
         qmmf2/wBWapdHByntuZrIw72BdYmyQh25oodE3kYgdVY9q7UX60JUnBpYpJ4rPp647Cm
         16SK64XoK/vf7jTiKCBaNiItp2GfNemBGi+cyKr9iSeWBoSViGA+lBjS9v3pIpRA8oT2
         Rl59IZWlz5v8rJsOgsY7eDbQLG0iiVu9vxWy9M8U2cmn8IPT3twklVQfL9sCbpLd6M3c
         sjQw==
X-Forwarded-Encrypted: i=1; AL+hErEabfHCCDdjxjMK6sbE6VtMw87pS9o3pGgEp2QkCTF52rYZIuHA5kdYQ6UYueghSf7htI6Ij5wQJgo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZHO1iLmP/pX2YZcyHLhbwD80M8Voc4cVoIc+JZmzknbgbzzqK
	6NUThGFaIwKlXEBRMdzaWwEcmHe5N02oFpzexwXzm0YSSmuKltn4jyJQ
X-Gm-Gg: AZFdTZcASjqUYkk3gU84KAJLzOWJsBF//qtihNpBM74NLyylzAWzBTzKlnAJAJvpEB7
	p93uGbuoFZMu/Nf2bebrVwIIFq9lWTx88Jkan8FleDTT2BiGTbaX/LBYwGq7QToS8vvOJGNPvNC
	FFFcTOO5/3mc9m5zbJ82mmJeWnCbUGTinoXCBm88EOa9Ysy4/pfsTUNoG6aJIl5HjZz168AYsQV
	ZkzsvV89cDh/x4rrsovER69Et7AQD5PIvhfEsP1LSMCV22lEZ0IyOKL5FFEkVs5EZNx6tC8hzAr
	SifrvrExQx6ADdJDREgEcoXOiSlrDejRpdP1cbGI7TcfgFaq2Z6p276zA53xzTvNLukmhqKkWcH
	pIhhbX0y2rcx+6rl/A4wzuZjAx8QovXNMo4hmNLYbsCTjowJ7MO3dupMXnDPnJXMHyr9sPdX+v+
	8ZhiCTlZHbzoQI8WbDWI9ZFDqOdOPvpRix2N5RRtOXVPSmE0k6MwjdzqL5GeVcvGvqbxE+1Qetw
	+ThfO8FknUGHMjaA/VGu/lnJ6IRhoVwht7Sor3PYjKK/KEQmYj/0uutAtVVMIPkWD7CXiCjJl8Q
	3AZaMW6ZfvUIHtXFOT+O8lYFHek=
X-Received: by 2002:a17:902:dacc:b0:2ed:472:b9d6 with SMTP id d9443c01a7336-2f03efb1397mr182475285ad.2.1795581439561;
        Tue, 24 Nov 2026 20:37:19 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm78614345ad.54.2026.11.24.20.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:19 -0800 (PST)
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
Subject: [PATCH v5 1/8] phy: core: Add common helper to add phy phandle device link
Date: Wed, 25 Nov 2026 12:36:32 +0800
Message-ID: <20261125043639.249525-2-inochiama@gmail.com>
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

It is very common for adding a device link for phy phandle
for device managed phy helper functions. So add a common
helper for future reuse.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-core.c | 46 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 597e6b234f5e..b7550ca37e66 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -606,6 +606,27 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+/**
+ * phy_add_device_link() - Associate the phy with the device
+ * @dev: the device consuming the PHY
+ * @phy: the PHY supplied to @dev
+ *
+ * Add a device link with @dev as the consumer and @phy as the
+ * PHY supplier.
+ */
+static void phy_add_device_link(struct device *dev, struct phy *phy)
+{
+	struct device_link *link;
+
+	if (!phy)
+		return;
+
+	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link)
+		dev_dbg(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+}
+
 /**
  * _of_phy_get_with_args() - lookup and obtain a reference to a phy by of_phandle_args
  * @args: of_phandle_args to the phy
@@ -805,7 +826,6 @@ struct phy *phy_get(struct device *dev, const char *string)
 {
 	int index = 0;
 	struct phy *phy;
-	struct device_link *link;
 
 	mutex_lock(&phy_provider_mutex);
 	if (dev->of_node) {
@@ -833,10 +853,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 
 	get_device(&phy->dev);
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
@@ -912,7 +929,6 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -927,10 +943,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 		return phy;
 	}
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 	return phy;
 }
@@ -982,7 +995,6 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -1006,10 +1018,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	*ptr = phy;
 	devres_add(dev, ptr);
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
@@ -1059,7 +1068,6 @@ EXPORT_SYMBOL_GPL(phy_get_by_of_node);
 struct phy *devm_phy_get_by_of_node(struct device *dev, struct device_node *np)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -1073,10 +1081,8 @@ struct phy *devm_phy_get_by_of_node(struct device *dev, struct device_node *np)
 
 	*ptr = phy;
 	devres_add(dev, ptr);
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+
+	phy_add_device_link(dev, phy);
 
 	return phy;
 }
-- 
2.56.1

