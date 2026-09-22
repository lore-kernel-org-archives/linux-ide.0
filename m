Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1E13B5B3
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045306; cv=none; b=FSaOp0lGOg9EOrFDFpa3yE2oPE6fE2kXYl0AQn24vRy5u49Nr5bvtHI7aV9VbwtT3DXWapHFEu09jHacvDMsPnOK4EbAbP6fM4DGEfehKOKyQ3zXf4iSoPdWo/rxSABYxL8oyGSDwr4pKs22/5hhSZwo/h1gW76mbvN6seUIZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045306; c=relaxed/simple;
	bh=EJ2P31Mop4LFkYlYUXipIp6N57OpGRj1yqrRk3odRS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sibl6NXdlbGHa8QJUiZeV6xEiGiJruQ183bL270f2d/iXEby51ksFVZdXO951Cb7q0uRELy5PRdkf2/BMvnNubhUmsNFE0coJTfkbt681sMLvlSK9JC5tGzDSMMPZivkMPuLZ8oOZxM+TvxFKpW5l8evOmy2ymOGcPKy9mul9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYRFahFj; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYRFahFj"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f20513so3025404b3a.0
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 19:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045303; x=1790650103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fqnxRDPGydfMihJ2OX+RSCvcoKZzlenNPZIcztBjRk=;
        b=MYRFahFjRk2z1BdH+H+7bCuD5vDdbX6PgGIYL91N+Xog3LidK6VUQ29WTKXcc7ozp2
         IyzaozvRbzggCl9LSSgzRwd4jiXn77c1DZKNNGeJ7m+pIpdodl7I86KCGrurBEzm5Snq
         Nx01W8xdOgmJcXOa6UawI+x5quwF82dLUTZkNnbOaepXVJ8j3255B7OrGAj+6H3W0HHr
         vGaR3CtCxUxA4Dc/BSL4RnXLuiR2qf0ZkQxqAAirphsCSFThxysF587kNHdJUmpEJOGa
         hfeCRlEJAdWc4oY3FGtMia1k/8YxZEBKrZfCkT7JmVQpVKOk1o5WXwFIJWeucdLZwJ13
         cFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045303; x=1790650103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fqnxRDPGydfMihJ2OX+RSCvcoKZzlenNPZIcztBjRk=;
        b=SO78a9WyguG2f67T3ho9sL+JCCjfSM5n67BGDGSLlVVXyW4JoaT70amWKKLAPXQPcp
         IHlJrIVWFc/aW3xaZvmlO6nTk2xtBpK6UDTpxqRdlQn+l+N9gqxkBK7R8DbCQThngN/5
         lKSifLCSI3brpL2cnBz7rf4gPfwNcKuJgekNR78yOT72H2KwdPGLo3w3UmyMrT6MJ5iz
         UXNJE/B4ogBBd4wtDzez5dYJ4omnPS4TaHtUlqLiYiLz0RklhtkPY2QmnKzmGzgOltvV
         5gcAWAmpogCpUR8kF8tZ5vbvPxXCh/48psFXXr7EX8W5QYyv3307vKFSFeKbZaslD2va
         5F1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxALOCJPTeQY9CQ1m5djdxA+01xuzk9x0ndG1HPQEu56NPETs6RAI0sFPcPVNlRFXpLl++r41QOpqk=@vger.kernel.org
X-Gm-Message-State: AFuF++mu5OcRXUDRn/BM4EfrZAW/F4TwWt34PjKtkEewoySFaYTf5L7a
	6p66oCo1AO/fqTSNvoqSNHMurylZFYlwoRTrUOQV/yvUXB91CxQAY2zK
X-Gm-Gg: AYBFou0xQoRggW/+0Z1QBvX7oHPYUaKx9uA6GCm5ulG0wopZqkWu5EZwD/uHtXhvutm
	CW2XGhqAt1HU9EgtpGNwF8LuZ+//ha6q00Ycj7WV4EisfU02+wDGpa5ME/iDK2ZlJ9gyvHpBql5
	4EFgzDtWeevoiSzwTowPKrMOJ3Ewacs8iu8mlU7XMJK0fBvA6uKQEkfqqMQYRApfXaD/RanMD0v
	GBUkd7cuhntYCqsxk75bTTIQndkEWQvJPQjU5GgBuP3qaVTDinKCytlEIuOvxFwCO05ue2ZgHAj
	yHQe2h2AvvRL+mkhstdY5NKmt+O1V/TAVS+rDWvPW2x+uFOtjeXWzkzP+2wN/FFK+KC6iG2qz3U
	BpwfX77rD5adSIY2TnzfF6l/C1rdpLvDYOSpEWai3qbvGDfXLadW2ksQi+I69XM8iuH7Z4Q5lLy
	N2ho93foLEU78ehw10Fvu1THV398KxCM4Oia5H+57URhFUXwGFD6KH/xK7r14WneN+dTGQo2d50
	CKN1fM=
X-Received: by 2002:a05:6a21:6282:b0:3dd:a197:7362 with SMTP id adf61e73a8af0-3dda1977457mr14288897637.59.1790045302885;
        Mon, 21 Sep 2026 19:48:22 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a18d4fsm115091a12.11.2026.09.21.19.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:48:22 -0700 (PDT)
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
Subject: [RFC PATCH 0/5] phy: core: Use EOPNOTSUPP for disabled blob return value
Date: Tue, 22 Sep 2026 10:47:15 +0800
Message-ID: <20260922024724.191412-1-inochiama@gmail.com>
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
EOPNOTSUPP for a clear return value.

Inochi Amaoto (5):
  phy: core: Use EOPNOTSUPP for disabled blob return value
  ata: libahci_platform: Adapt the return value changed for disabled
    blob
  usb: dwc2: Adapt the return value changed for disabled blob
  usb: dwc3: core: Adapt the return value changed for disabled blob
  drm: bridge: analogix/dp: Adapt the return value changed for disabled
    blob

 drivers/ata/libahci_platform.c                |  4 +-
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 drivers/usb/dwc2/platform.c                   |  2 +-
 drivers/usb/dwc3/core.c                       |  4 +-
 include/linux/phy/phy.h                       | 52 +++++++++----------
 5 files changed, 32 insertions(+), 32 deletions(-)

--
2.55.0

