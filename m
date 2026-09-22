Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264A39061C
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045313; cv=none; b=h0vAGSNRj98uGbXc3HiRah3diL9AwtCi4iNXRLhl6VvaUci6fcdI+5hYAJFXiTKHbfJrIZbmGa/KigFojm3Ri8WdfREham3famsVpnFl0G1TAfDGNuLGq9DtUgx9tc7w30tcyIFRvlxFq81TWJWlBCkE1DXjDJX2Y4bc7psnuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045313; c=relaxed/simple;
	bh=vvm8Ml9q1Tf4TVKcptL0B8794cZemUp57P1StvY2U7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2i7vCYdYxp+Rb3MHyWrQ1CcWS6I4xAeLZAce7+xLHYhZOAbj9XLu/NCYLooUPMQqXdS3aPkdHvtUzdXvhOTP3URneccrvKcypWFC0SH3+GDXEAYMP8qrO/skuvdPCFoYaO/A9/BQxYKX1raP2blnD0NdQTTqLQTtL8jmiY6BhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJpWcoYr; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJpWcoYr"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso3100940b3a.0
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045311; x=1790650111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WX6Mfh4l0Vw/8UzDpK6UHvwa+BQE0w9TDFZftgIIYk=;
        b=eJpWcoYr2eVCiZ6mOXAfw2vs9peOC+u5k+0YHTIriryDMf8FeAZqar1+S5IjUZwikm
         BDvqTjtlZ1JAfo/ta7I5P60RQc0EKtTPgFtUJIqW6agSSMYGr7gLMH3ItXisYU1dCoZx
         lv7Jzv/PIQIBjF+bdJqurU9/D3fbrAaKQKToesk3V9ePrJaRMwLnxWl0dBuiAog/negb
         qNlaZWzyALeXQLY3r3OOmRVQr7du00gZZ7U56wG2UaxduMWOHRTv59Rhu2DbH0zYDpLe
         +FPTilEDNXJj/nMcQPtj2tTFXKIUraNOz2JvE+ZD8RJtosfGLSHSpw8HgMH+IToSd4tv
         Aj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045311; x=1790650111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WX6Mfh4l0Vw/8UzDpK6UHvwa+BQE0w9TDFZftgIIYk=;
        b=H7LNuU+5IqDW4LnYXpyYQkswEW680a5+6GUEt4JQf2TVup6BF8Zmzclh80d+xvFAH2
         Yl8Dd4bgy8k/ANpOE3yy/E3nuPHlRUrqfacZWQAFbAH5Ac10HD8aFrhuPFZf52otJ9Sp
         1N7likfrzmHJEr3rXEJyV9kkZdYTVDQcpfpLqdUVK8lf3RhmrWvXD361hgyNsSKwI3cn
         LmK2roW82IcfPXHWhvE1V5W26+xDHwnn0dUPSca2nQg9nED8kEuprwQ57IVgtvRiADM5
         TPtNOdZUrN1x38qIlDQjrg9O0fMYcXb7oyqHBw1AIFacWcNaKNrhdTnBUwgAwzOiT8WN
         /MKw==
X-Forwarded-Encrypted: i=1; AKwUvBy8XNn6y9QaPB9zXsVRPNoCbib0/3t0NmTEt8zLTctipFQy0ZUSQSSWDX+hhCtnHr22+IiVPlpi9OM=@vger.kernel.org
X-Gm-Message-State: AFuF++kN/KGuD7yjw0RpjnuLmB/M4B3e1OKsGSOLm2ybUhnlTH/dgJlC
	DqXtJm4acBvj4IINhy29tEckSbgphbIMu+c9dGew3Nwb519kQgfc/ekX
X-Gm-Gg: AYBFou0/fF4/Lq2HliMjLq6RgWW3yNg9MdUc04Gv11vcES+kYGaiwwDSwQOh0auEprd
	snkVwWzNcps0xkhmEaY3kKcLP/hs4jFNOnUPwhJaS2I3HLy4y78sWzufUHvT524dFt9K2cWzGuw
	0jgv99GdN+LKrkehSxT6imNaqmUtzciPEg348Qw2sXnHHfnbPIZptEZqAC/Sel8Il2ErArd3bmR
	qd0fPhyL3E9XvdXxX/76Q+eQIF7tFswiAy/xhmrHfbfbdzKjHE4+RxwDv/axCh6/MUhsRDAACez
	O2oX0frcEJ7fZtKyawy+tZxFk/93HhZ/vpI2YcHRo57Fsd2BKSCWaCIHdpEOtftLrTgNlmm4nxD
	mOPhfaT9NQAMPf6k3JtDwQoiTuJszKKvNyN8bZHH5p6sLCf0vx5gWjW3cbPl6RiNphTGhzLA2Tw
	97fpC6bApTK3kGdC5ZMpGRGc/mBkOZwjzxrbXv4uFKi/fniTO5geHVlk17LH3nZmw37jXR
X-Received: by 2002:a05:6a00:278d:b0:879:ffd9:126d with SMTP id d2e1a72fcca58-879ffd91ae4mr6025072b3a.15.1790045311312;
        Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c336aba96sm112998b3a.61.2026.09.21.19.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] usb: dwc2: Adapt the return value changed for disabled blob
Date: Tue, 22 Sep 2026 10:47:18 +0800
Message-ID: <20260922024724.191412-4-inochiama@gmail.com>
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
 drivers/usb/dwc2/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.55.0

