Received: from mail-pj2-f24.google.com (mail-pj2-f24.google.com [74.125.227.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E03AD527
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045309; cv=none; b=C/Z4NxUYnFOo9rTRipxOLLiLqrfxF6BOiANEXuIleBs4UsHOOV1f7hYTfiI1J2GHH+pW1HEE8Gn3Y5kF+d8ALZfkgzLp2jSLyzjgS4RizHzULF+Xd4a8OqEnu27+yE6dblwCBM7TQsuqZVISOWXSOeyHUhGKrWYuYgTLwkKPMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045309; c=relaxed/simple;
	bh=m+AN/nSnittfS7skBB0p70xNsEqxKz293x5ahIUFk18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAykrULE4wxNwGni8NODTN2NHUtPhQl7lev0MbmF5YfQP2NEiXGLaPfwDOEcz9nKZOmKZ5EapC32hMBRrV38gLHt+NiDwpBPNh3XkEePoySTA+V6B9k2czdBzIR8Br6s7nt2aAUfE4Rz8cNTtxi+7a0f21nqYMOPwKJo2ZSt+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lauhI5Oa; arc=none smtp.client-ip=74.125.227.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lauhI5Oa"
Received: by mail-pj2-f24.google.com with SMTP id d9443c01a7336-2dd77300816so10732915ad.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045306; x=1790650106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=273RPbWG7jPvSKiSM2cb6VF23JcSKRk4gJRjLYycPbI=;
        b=lauhI5OaeXiurHd2DGFYGE5vFjZ58rZP9V4u/K0RR5dqfEiLPGZI3Z139jKNkki+Oy
         gu+xFIk05Y5oWM1sePDiEJNkywc0f8O+s0k9LBmrZ8TQgUj6c41ztLpPxW8lzXC0Ii8D
         n+edPFN9t4c2SK6aGKHueQwHF3lbrbFVEXAIf0iOvU6BOxhSyWsguQBOQV+SW57EepaH
         ee39BgQrOARriLFbfF5t4i6JyrArx91ZToH0Tg+Hh0UpieCrHa5vQpSeXb/k//KhzmC7
         7gybHymNk2giwZw0rUqzCPiDGVWPoaEOQxv9ziDBqV+bkNxr2HLOuE4WIvkK+NNvYLY4
         p/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045306; x=1790650106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=273RPbWG7jPvSKiSM2cb6VF23JcSKRk4gJRjLYycPbI=;
        b=jrsqeTi8DxVIUr+6tGRIVjrjFq+DfO8qC5MkcllCOY9kYmtcl8EpuKAqkqvYx9qerJ
         JneccyDUSHk0lVHOfRVEViQUC/VdLpo9sTMPM+NGDJwlhoFhPMad1T0ibB0SQmBPgoKF
         zxhdsPGKVJEjK1JfYYBvhKlrJPQXoaWSSQ93rk+o8txT3OOxX3EYBj18lyLpYSW26Kvh
         M5A2Owk1q4mmizESkSzJ0SRq8izXoL2v+5XMA8a8zLrgKGZXsBreUCrrCx7tOE7iUY0J
         85L29rCIHbMn3ZZFU+eMUJIlUSqz6y7VpBX+PVXNC+dqFNi9N50nBHQr5Qe25Q3x/j04
         WcBA==
X-Forwarded-Encrypted: i=1; AKwUvBxfd9DP0GyllNR9NOYsx1l/WtXMHKSDitC7ZiFohfW3aLyh6E9WICtLB6AYo5QJUngascghRgJ7sIU=@vger.kernel.org
X-Gm-Message-State: AFuF++nhM+L8z6gz4MEV3mj4fpyyCPH2sucD/K7dibpFx2dhRfKJ5xtr
	ftQcCcYCulHW9ls9iOae5UV+zZ0egxoKd0ySb3EVRwqP4eNnBea/YmNu
X-Gm-Gg: AYBFou0SFvTQQ4gf7TqbIPNDFNOU3r+DikYION0s8qOuFfdd/lVa9ml08SYKkFQOblE
	NiH8w/QuXVoLYimWYxbHCKWBAWldlScggMvrv7gLYFhe9Zz41Yi8Kpwds9FrK/jLbAXZQutwI6x
	mGE9fNUXVIbQ2sswmPtJfXQitosNATNpZ9eLdpmZtzx7dL8hHAo8MZcsUqaGyoPeo4x12YeztZB
	71y4PDFJKC2Y2nL9q1OBOhQ+mUG6zl3Xe3fcl0XAxrge/8yGpl9HyUJjphDKWyu+bNr/Y42B5qW
	DNHeK6ImjVtSRzb4EezKsHkpkATB7yFINqWSp6Qk9z+28Co1XdVVoyv22oo73cUqgXZ4FDvIaBA
	7ybt8z5uR/BVPO56AgWqCvw1j7Ajw2bdwoB7Xvdvzp7S9ofYiYqCcBWO7M1U0wHJl798G7TWaU+
	hRb+3C/F8xCBVp76/MAvASaeWogE716KKx0SHWcth5cjNQmwv2vsRtd9CVOKP7H8E1RsrOiA==
X-Received: by 2002:a17:902:e54d:b0:2df:42af:2fab with SMTP id d9443c01a7336-2df59a5a817mr14138975ad.34.1790045305892;
        Mon, 21 Sep 2026 19:48:25 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d02eb4fsm1636465ad.37.2026.09.21.19.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:48:25 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob return value
Date: Tue, 22 Sep 2026 10:47:16 +0800
Message-ID: <20260922024724.191412-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922024724.191412-1-inochiama@gmail.com>
References: <20260922024724.191412-1-inochiama@gmail.com>
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
EOPNOTSUPP for a clear return value.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

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

