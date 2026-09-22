Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3053B27C6
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045321; cv=none; b=ol8Y5gG9CU9jOthhhUjAUw52jOoj/DWv5Y6Tp/JwFoZcxY2WPoszk3uvtWCA0ovwLmkEYuP+lOdxx+FKFc5oFztZgG84T/8VOVecrigPo0s+2/EFiLWPnX6Mg5/XbIjGWtkljxXh2Du4R+WRnrrvGH8AXajyu8ZZpnJwOnFf8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045321; c=relaxed/simple;
	bh=QstOwR4MoLepqPhwXXcdqhaZXi3o+22oqo/jORxNnxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEZGdlqY7H+F5A+clLWceYbsBMWIOyFxtwvRWCwg5V4o2xl6elnu4wVT/TZxwhrv3yt6BvieXTVXLD5W7e/JDOwZjRLGpFijgUQZpzuQ9lOPoHlYWnL1LJhU1ny+JmcCPU8PSh8ZyjYf/hHHIpaQcmkrXVY809wZzNDph8DaTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmnDdwo6; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmnDdwo6"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f066d8so13479965ad.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045316; x=1790650116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQsnO6nBZnTmHd9o3wzHwpj6ldm3p0l1ScGQLsRwCts=;
        b=KmnDdwo6IDTvhGn9L1EHokueD8DwKYuaoRaNHR4rwKrUHeSLhPCBpVRz5Q/jjExCuI
         F1AN00FrJJI2uyWnnJdJRmjjKofMsb709IQhW8tcRghnwfY3wgJCvViBvpGIp5dAFyjP
         fO+v1GiNWQFn7gMTl3ZtMA0tPJ+j2drrKQcx0AABU6iFyeYA0YK6iVCF01eKljIWW/JY
         tIVW3fKE4KjYu7MuYLZfUroNHrXNA38bkGuB2kq4A6fdFKv1WKuJetgPZjsmDKCITGQr
         RqpaYMVdXO4gve1W36PQzGMcmQMJk7feF577pmkP0F9JW7ySESZ0UgPc5La/yJMxzi9S
         Rpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045316; x=1790650116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQsnO6nBZnTmHd9o3wzHwpj6ldm3p0l1ScGQLsRwCts=;
        b=Y9vEBR8aDekh0XrdbCxFOg21n8z2yosKLtO3wzlDasx6hyenIGaQWvDsFIeeXxG7yn
         J2rs6yxibptxjxPhPf8N7rvFcy5Td3JXQ85G5wT2CmLzBG3QgFYFv+Upek6NDt9gZBjS
         G2Z5x8BHRpimt0sVyux3faA3ZOrZiJlO5MpK9AgZqBJsB73Npjin2WPOAvnLrBXpX3sE
         q5zMvhlqOFfLpEhtRD/2uijiabEn9EOrMgFTNuTc1+WbsyOCLHzyFe00e2UNihUhRqQJ
         1HikOnGLZ9QDEOCkUM2dE9D/8bas2KTnVbZc/a+TwKUdwus51Y9Ru6Rusnn/DVvIIFCi
         O5AA==
X-Forwarded-Encrypted: i=1; AKwUvBw3K8UxGDe0y9gzBTbHgrL25+g6BtsX3fMX+DKkudF3avl06finAfvtzmXU7849dw8eGBSXGGLkYCk=@vger.kernel.org
X-Gm-Message-State: AFuF++ng2HCC1fOmGr8a9rKVADOx1bETZUkKEGdlz1k06WrQ/NoZBJPG
	6VMVUdMSStmssBN4nhikGcPDOC77AxGPSnSHw37MTguxWSsw86Pq32XJ
X-Gm-Gg: AYBFou1aGibbKVOzoBPrO8UHi9Ub4lHigw+IUgmIsA2Vydb+EkSqd6Hq5MUZ/5i53Ry
	O1W5X9Za1Pgq3asluQHgK16dhMexr4vlgmqLtlyX+9Aapl8IXgcmuckiqG1zISse+9QWihxO7vU
	uqap7LezhatbHQ0KszZP8rBTWpXkznLS/NDMACPRyyCn6EIou6vWYt+rtS7e8J3mM8VnQLYUX23
	EZd+nR0yxyBowpVkqRhH09/EDM2WluAfARNrd5VApB7xdHqtFgdLQAgcgEwMPf0W3Wc9A59yJHq
	XBVvVV1qECbROOg0VM703duI3IdSxM/vPSgE2tpHSONERqh6eJafIXVFteMMGhGzpLJt5OgtbWg
	ymB4HQaL8sKSsefJEcbqr+VGbxwKVMPOqgFpSgtmT2nvxkAA+tbm5ydMR+d90HLY2B6XZY+/OX2
	jPSmMTOMYOjoR41H7Jouatw5IcfDgjLeyeHS4KfWjxz2hgYZSY8YFj6x+FRPeHgT79BsDzgv2P+
	FyFoEQ1
X-Received: by 2002:a17:903:2ecf:b0:2dd:c100:251e with SMTP id d9443c01a7336-2df59a72ef5mr12835995ad.39.1790045316497;
        Mon, 21 Sep 2026 19:48:36 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d02e929sm1619035ad.33.2026.09.21.19.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:48:36 -0700 (PDT)
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
Subject: [RFC PATCH 5/5] drm: bridge: analogix/dp: Adapt the return value changed for disabled blob
Date: Tue, 22 Sep 2026 10:47:20 +0800
Message-ID: <20260922024724.191412-6-inochiama@gmail.com>
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

Check EOPNOTSUPP for disabled helper function as the change in phy core.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.55.0

