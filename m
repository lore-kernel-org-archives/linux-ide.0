Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985304C0439
	for <linux-ide@vger.kernel.org>; Tue, 29 Sep 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671676; cv=none; b=GCwhpxB0goQyYWcnK3y/wJp4EG7tnHYqdHeAoKpAIcy8FxFCk+KEogF3t/3IV+BYcXlQxXO4/gNi9OaNKunZg9KevIHyYzv8UzYJMUYkn/yu5GJDNbvAYRF5mbhn0yfFGfLdgbB2FS1X8nahTM8ruqbevC08UNevkybD0Nj/Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671676; c=relaxed/simple;
	bh=Z4aGSRXczRWxkdMGTkXXVDynZbO9bk2DRirqQmRGrKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqGGv0LpU9WVGw1zFoRNPOqLuQ7rrV0apIp1FrzywqRDj+E0fQjm65wxEFRm9ky83deoJ+42sgitgW4CtheyS0BWuq3MkEcQySJvkE1V0sKKo+BRp9eFvHsLeLIrar06WfBF5HX7jjpPifhAZpKXs1uptDUCdfuG6slkpSWw9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs5vuhsY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs5vuhsY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1969980a91.2
        for <linux-ide@vger.kernel.org>; Tue, 29 Sep 2026 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671670; x=1791276470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L+b3HR+GEBXlqBxQ57YrkqhyM2+pU3HtshFJ6f9asNw=;
        b=Vs5vuhsYGAZtNsiShpDj+VfessnzJSHczMONyrlSQ2rW93j4IfrLHExmCzPGprAyac
         GJP6AAAD0hzauDlro0jawPeQTxe7pN0nkCggFQr9wkqYKbuLTwcthhUFlLblV9ZBVrSD
         D12x0Swv9fCoWn4jESaBL42Cd3/Kivhds1uhoLbrqUU//U25tGuh4PWnKRjLqcIs2r78
         nTrliG8EbzlkNMWBa/kPjFppQnxCia9Ze87WuQ4S4NycgOS/cZgjmitRR/nKsrbXtjSX
         kPSrmyO0ZnSGj+tiFLv4lSjr5mgKd9ejQD/kzwvC6vFTtMnXlfdel6UOHC2OpwN7NQBT
         ROww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671670; x=1791276470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+b3HR+GEBXlqBxQ57YrkqhyM2+pU3HtshFJ6f9asNw=;
        b=on7/x0qb2WCirlhmYR1atvSO3HGNmzvlkAyIpr0G3VIFdtaCq376Jg5yqaDS6P5k57
         zpdvfhExwNaIeEHrvHW1gk8OiQQwzenGtQvDTPU+WUuyzERIg04jR5H5+wQWB8VcMu/k
         VDiB+IHOwc4eLddehjbX9NV6Fo8lFO1vCpupdolBDjctk6oZZEcmZmv9TbI1ADiHjk1H
         yuRJ2442I74euCjVkb8L/lTBo7uTAwCxxwx8f93p/5ejip5k0eS4YalWQVYG/EcUQEkF
         s2lypIwacBGqwzZ1WX1e/Y5ojhQDO+MfK/5EC0UaMnHSuG3yhq4csfAbnBZcp96fWEDF
         lB4w==
X-Forwarded-Encrypted: i=1; AKwUvBwgw5QAo3OdHQggAiwUZI65l8rsrDHtDNYdZDrNo0FrjClFTO1RwidJIIFMA1q2CBBMUrIIzVyVrQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJE8rOBGzfD2493XBxKQg6N2gHvHYUP7raJsBJg06ccHYHixae
	eBM7qQ74D+cjDaov9xLRWMDOscXCN4gvOGEU21F62NvZl6jQG8ATNNR7
X-Gm-Gg: AYBFou1OV9OnNi1+zIAoJBKj2rNYp8o+ZaA/NB9y5nE2YgqQvhJOTG/GppIikszrI+1
	2MJOjxsJgM9EOUAklY3iGGQ6SpqaI2qLc9dCKdyYaL94uNKYe6R0TODhFjUnvpNPxl+K4GBvL7n
	6Z85nTrgrK89i2N9G5aBC3aBbwweAhCtg+8rUq2k1VcrJpte5wz2c5INEpvIbO85QhyTZnQfRru
	EETQT7sahAOW867Lq0GgKvP8ZASsjwE35lAACPn8ifsoN75k/39ntorKPpN0DiP/a6F/KARFSqQ
	P45/ZSFDo3Unsh976kd3U2kWOp9tXRhYnyru/zWtQSL8pHyc6Try8jI77GdFImtzij3+l3njOmL
	cor7/SNr3dvSxpL5q449sqT9uIwudKOkq41S7reLwKVEBJsUNkHuG6F4VZ5GWQzYqo+omv3U4yo
	Uar4ceikV3NAmWDdhhZBn4SBUnyAdCJTsCwTm68v2kGxlopc3VBx2UR32GcUnJHeEuZvDNasYHJ
	OIQC5M=
X-Received: by 2002:a17:90a:38e4:b0:3a0:b223:6830 with SMTP id 98e67ed59e1d1-3a0b2236c1dmr6514691a91.7.1790671670089;
        Tue, 29 Sep 2026 01:47:50 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49867a4b1sm4317440a91.11.2026.09.29.01.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:47:49 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] phy: core: Use EOPNOTSUPP for disabled blob return value
Date: Tue, 29 Sep 2026 16:47:38 +0800
Message-ID: <20260929084739.467082-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the phy subsystem uses ENOSYS for dummy blob functions,
it does not reflect the function state correctly. As kernel already
has EOPNOTSUPP for disabled blob function, replace ENOSYS with
EOPNOTSUPP for a clear return value. Also adapt the return value
changed in the following affect file:
- ata/libahci_platform.c
- drm/bridge/analogix/analogix_dp_core.c
- usb/dwc2/platform.c
- usb/dwc3/core.c

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
The related discussion for switch to EOPNOTSUPP is at
https://lore.kernel.org/linux-phy/20260907114837.2y55l7dfqqrgcka2@skbuf/

Changed from RFC:
- https://lore.kernel.org/linux-phy/20260922024724.191412-1-inochiama@gmail.com/
1. Merge all patch into one to avoid function break.
2. Improve libahci_platform's comment as Damien request.
---
 drivers/ata/libahci_platform.c                |  6 +--
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 drivers/usb/dwc2/platform.c                   |  2 +-
 drivers/usb/dwc3/core.c                       |  4 +-
 include/linux/phy/phy.h                       | 52 +++++++++----------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..b04789e7a23f 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -371,12 +371,10 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,

 	rc = PTR_ERR(hpriv->phys[port]);
 	switch (rc) {
-	case -ENOSYS:
+	case -EOPNOTSUPP:
 		/* No PHY support. Check if PHY is required. */
 		if (of_property_present(node, "phys")) {
-			dev_err(dev,
-				"couldn't get PHY in node %pOFn: ENOSYS\n",
-				node);
+			dev_err(dev, "Node %pOFn: PHY not supported\n", node);
 			break;
 		}
 		fallthrough;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 30c0c0b41d5a..8e26cd772482 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1360,7 +1360,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 			 * phy itself is not enabled, so we can move forward
 			 * assigning NULL to phy pointer.
 			 */
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dp->phy = NULL;
 			else
 				return ERR_PTR(ret);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ef0d73077034..62b663ef1504 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -243,7 +243,7 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 		ret = PTR_ERR(hsotg->phy);
 		switch (ret) {
 		case -ENODEV:
-		case -ENOSYS:
+		case -EOPNOTSUPP:
 			hsotg->phy = NULL;
 			break;
 		default:
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fd5c2cd36c59..6d253810c71f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1588,7 +1588,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb2_generic_phy[i])) {
 			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dwc->usb2_generic_phy[i] = NULL;
 			else
 				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
@@ -1605,7 +1605,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb3_generic_phy[i])) {
 			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dwc->usb3_generic_phy[i] = NULL;
 			else
 				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index ea47975e288a..3e84b54a4b03 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -314,14 +314,14 @@ static inline int phy_pm_runtime_get(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_pm_runtime_get_sync(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline void phy_pm_runtime_put(struct phy *phy)
@@ -332,35 +332,35 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_init(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_exit(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_power_on(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_power_off(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
@@ -368,7 +368,7 @@ static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 #define phy_set_mode(phy, mode) \
@@ -397,35 +397,35 @@ static inline int phy_reset(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_calibrate(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_notify_connect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_notify_disconnect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_configure(struct phy *phy,
@@ -434,7 +434,7 @@ static inline int phy_configure(struct phy *phy,
 	if (!phy)
 		return 0;

-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
@@ -443,12 +443,12 @@ static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 	if (!phy)
 		return 0;

-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline int phy_get_bus_width(struct phy *phy)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }

 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
@@ -458,12 +458,12 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)

 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *devm_phy_optional_get(struct device *dev,
@@ -476,7 +476,7 @@ static inline struct phy *devm_of_phy_get(struct device *dev,
 					  struct device_node *np,
 					  const char *con_id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *devm_of_phy_optional_get(struct device *dev,
@@ -490,7 +490,7 @@ static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
 						   struct device_node *np,
 						   int index)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline void of_phy_put(struct phy *phy)
@@ -507,27 +507,27 @@ static inline void devm_phy_put(struct device *dev, struct phy *phy)

 static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *of_phy_simple_xlate(struct device *dev,
 					      const struct of_phandle_args *args)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *phy_create(struct device *dev,
 				     struct device_node *node,
 				     const struct phy_ops *ops)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy *devm_phy_create(struct device *dev,
 					  struct device_node *node,
 					  const struct phy_ops *ops)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline void phy_destroy(struct phy *phy)
@@ -543,7 +543,7 @@ static inline struct phy_provider *__of_phy_provider_register(
 	struct phy * (*of_xlate)(struct device *dev,
 				 const struct of_phandle_args *args))
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline struct phy_provider *__devm_of_phy_provider_register(struct device
@@ -551,7 +551,7 @@ static inline struct phy_provider *__devm_of_phy_provider_register(struct device
 	struct phy * (*of_xlate)(struct device *dev,
 				 const struct of_phandle_args *args))
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }

 static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
--
2.55.0

