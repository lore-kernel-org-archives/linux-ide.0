Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745437DADD
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045315; cv=none; b=E99cR1RWGFFO+vdaNhNiJMS/dN3ToRKcudysSo0TkNmbNASvEg33xKa7K2gOFkuRoHiuS+XDuWjKhR2bBG/4DtahIfdS2M/5OxH8GpgyJjSJeF24im9aw4zj2AALHXNbA+BpwlI3nTMqbgv7UJ3lxLfcbUwGjo5UrOhmSMzhxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045315; c=relaxed/simple;
	bh=stmJOODU+Gnhhw3HiNjW7TxChO7ziDyF3KPhjuQ4+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq9B4lEgKShFfx3thCi4CJvK8mkKSCD2PPKR2LXBaaJv8A0lIGAmOhyyNSCdLnlPtPPj23L3qwHFSwe3U5nPmyZbMiY5ypJWiWiqz9RGrm0fuHU+yzK3HpbajC8xQTKQY4gKLcO7FfDfhmXCLPKEYFFjnpb5+uOxo/JR/b69iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3Eo3Wda; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Eo3Wda"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so33194235ad.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045314; x=1790650114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26rOLZ6VAdNb1QMWubw0rV33TxsyOkNQWkVFzg0YEAw=;
        b=h3Eo3WdaF41QW4/183DmG5ceX5mLNuuJjV7+t7zkBFa9ndGjsBU+eJtOKnUYpK3dS/
         FRKnQyj22Yenvy2DhNlf6U2UDASw3uqISP5gn90zvykTTl4dkxTVRgqJps+/Fad1NJk3
         fH0b7EJDYgBdNbnpXG+8r6SnYbNt5+M98muPsArxymyvoxc+/4O4BzHN7axg+xP04XsZ
         vWp0KM7HDf7zmyKDgmc0M+VFMzjr+yHgWP46U9dD493spzgNE6yD9rmAlCSotEEk1wph
         IxVnjpfH7eE6iPJfQilkpCYpBTr1hUvWTcj8bi8/EVDQYQ144+KYZL7VfrigO+TJfZ6f
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045314; x=1790650114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=26rOLZ6VAdNb1QMWubw0rV33TxsyOkNQWkVFzg0YEAw=;
        b=iAr9O/Y2TzPupIaViujDLQ4B/ZLm7lGtA4PTxQC+FB3FzSqoIRRoD5xwDBioqsOWtX
         lsSK+CzMFN5ZN+BYXOY0yQei+FGJCzlKotpPg5L3jW/3tB27fsI8z+hmeblltZlI6rgT
         M/TsKHOdYu7otB5Padeb15tQXVBQx3wuyoQxZxbWrTXiu4FpZOa09jTiUiVWzk7GQ0xA
         qhyABB4rk14ljHLNLWnmWi0gvqIEsKcojlLmycuMODo9LhRZFN/bEWNFXDslfpGfTVEh
         KMcauWYwHeJr08e2mXNdBfNADUgow7ZKLUigYCp0OJyzxNMK2dANMclyeTk32IDbEr5Y
         OL3w==
X-Forwarded-Encrypted: i=1; AKwUvBy7pJ9Y06vO2kXK0nitjfndv6Ga3OaJz1yAmHijObu7qIgBqCRDAyQ7WlXuyXrKZXUWCOAoMnkKpWo=@vger.kernel.org
X-Gm-Message-State: AFuF++nK7NMelkeRVqq/LivSn9FgkEWZBvQxmGqit4EFA/nMqJReGK1m
	Qbi8f4JyaN8Qk8esfvoylMJSaYk+MNp2SXqXRDd+FNe3FKeHpS1Ry+53
X-Gm-Gg: AYBFou0UnRE9LIIZ7dQ8dr1M516v61frFaafyVT2DHEYMk6P9uDh9SXo9WSx+YI9Ora
	gmrQkVt4hTVdiivO7oq9ELGI3127ctMXdRAsMTZn+U9PrRXnCWPGDYsy3UgcQH5dEVqXQK9Rp5d
	dZKJ9B6GvSfZiUScvE6StEX+8Bm53vpGDLiAU1eMCcH/c26iENNT/do/DtnUm6NoVN0/Bx8CN6s
	IDJkVX8YpJQ1HdErLwCZJeUkzMPqj8uLnmdZblh/+IyYQcXGmk0Q618p3F/2C8SCZuyB8Mloas2
	JRAqOKdZORYZYJBwQG+4AD4Q+RVz9WagAFy/F33cDHDu+ZvErmRIK7oJUM5Ooxi6v+STWEsTxML
	XmpxTDsa9OUKcXhfs+qCutoOBZwtBhu27TBMfAi+1ZzIirJI0SF8p7xNhA7xNbTKgi+ef9iXeqC
	L16DfrOTy2EnVXqQN+HLWFXIJ9E/4f0Kf5Miz10VhBIp+flFQ51TZwLwLD1qhCud/e1RtBMg==
X-Received: by 2002:a17:902:c402:b0:2d7:3f6e:5cb9 with SMTP id d9443c01a7336-2ddb1b7a04cmr194077855ad.8.1790045313882;
        Mon, 21 Sep 2026 19:48:33 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d06808csm1648645ad.83.2026.09.21.19.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:48:33 -0700 (PDT)
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
Subject: [RFC PATCH 4/5] usb: dwc3: core: Adapt the return value changed for disabled blob
Date: Tue, 22 Sep 2026 10:47:19 +0800
Message-ID: <20260922024724.191412-5-inochiama@gmail.com>
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
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.55.0

