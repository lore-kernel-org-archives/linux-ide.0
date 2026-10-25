Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899879;
	b=ee+n8rBkZqiJMvrkJ2AC1zeCplA2PMmniERa+SB4V+xI0ZWtYW8/2nLlHhCXpdP+R3OE
	 w5pTLOYZ1xl68Bf1DKNmmxdMkPPpfpLE3Ilapr6011m8QZmBaE3wLOw2gldtWiAzztTpL
	 M5SmIsHc7zWGLEnQGnoue//QRmoHkh3jH9Qx3FXEhOiVew0JltLltp91Q8lHw5HjDuthU
	 A9XjXBaFqA+a7yl/EWTIhKvkDa7njp6mp0crwU+1blDBcNsD0CGBdh8iyznpBp6sflYi6
	 0KgRFPebWl7xdTV1TnGJD6WDjvMkBRr8GfxY+G6n6WeP3PmxXrTXT2cGxIFXSlf7IZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
	b=qV9m1l5n80Ltl5hcfFwP818zGBFaIrYBz5jCIRBRgX8nXv1W3al4FoPN6crjDCupM8/u
	 S1e9QZqo5EJnvnlfiLl2D1bQePM+V5LYpQsd3cyan0YEwv7NJCc6U5DVnveT0R6fPOUUh
	 X/BAkis+B05ghSLs3MVkb0dKDA49aQMlE9klbeWMwyeckOQ1FpH4vkFkj73Y1nA8PzEj6
	 Wjhbn/aMOBWZXEY75bi7itMJxSBxuGJSjSyaF2DZUfUuKoEEDaLCEH0tVwySslbMMwMRH
	 CfBx/IbcEJJuYn7too+DhSLFfVFQGduyJMTxlgpniJJdBcSuTTmAUFVsb64qWBSkhOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Vw2qb8eu;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A48606A324
	for <linux-ide@vger.kernel.org>; Sun, 25 Oct 2026 03:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A48606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Vw2qb8eu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea7190aea1so9001975ad.1
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2026 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899873; x=1793504673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
        b=Vw2qb8euRlJUMv45mYZE9Io8oRd7Avf9nw74WzUdB1H/4vBSaXMrLJjfphc9q+wfya
         sFdmWtZ/ZANGnObXe/kZiRxWie0Cl/PvMqqXrmKT5CJTBND1p83Pn/55Zi35T1UF+BO5
         5qPNXgM7l/OmB84SlIpdL5CnFJL+Sf8LtUmF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899873; x=1793504673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
        b=SiNqIRIh8sAOCEWwETxj12E+d7AcqTi1BTBIc1dohLziSidpeSNVgWr5x1hdH9fbpe
         pc2r7ERg6MPdOI9txmP673eUh6RaBfGMY8TSu1k8uufcyNNmWg/WzPtg6V/GJfr5nmEP
         m8wiwL5y0/wUBfZR9pPAqlCNXgWPMLoYELHJKzt4ORHE34CK03KrUsK9g11XoJXo6DbS
         rkSVSlRiUuB55qKxNWcc7sUddY7zcluCIcunxG43TEB3N7kOqO4kxMURYTjqP1WKKUb0
         Pv6NPJcyZj+TS6tTcgow+VdnZMqWO5eP51LPbtPbHW9J0oyOmhRp98nVJo32jW07ugts
         XMXQ==
X-Forwarded-Encrypted: i=1; AKwUvBx10USGMeg/hpbnxxHo1p3QFpkDYpqNSzw+2ZsInRpBRgGdb9mQEozr6VmEdwQmJeGUSKIcJ0RTABg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwet71PAc0CrOsv+bht0aF7ZFYS8W+h4g83uZSp9K9wQ7LWAaI
	8d/6SZkk4k7fGD9U+InzWXLrNxgtnj4UIK23k1jMrPAKlQgmQUJF+UcQV85HtHV72KA=
X-Gm-Gg: AYBFou125B45zotuNQ834kUVchlusGrX85mSn5IkKOQGfwdE1aLSTGCh6JdVLG56bEV
	tVDyegmn9M6DfdS+ozx3VdGYcqX2C4UVyau3RiQqWR/8LfnRKd/CAU29UkvrY6W3ST69JmOJUks
	nJgAqHx4hZIhfCvUuQF5krz18on96Kmeoqzde7pLlgK42GZYimR8j2YkXTtwRBpQ7qpXciVlh/I
	dwuwGxRu30Vu3dsmmuyw42+aOZy67DUTIox9as77hl0QFBzP+DI6on1GMtOw05BYfuXLuQO8Gv7
	P2D2fT4/+NZBqOKeMIxyZ3/fV45tIfm7gDOsNRVR801cAE7EMYsH0cq+g8zlAW6ZjvjuAOSbNpr
	KbcLS3oLhfy8T5yr/0j9NA6gmynJGvyvRMiSr6EhxGwe1Jh+Zjn9ns88rF1UyMaQ3TKxM2ysI5i
	qAHu95/jlYTrqrtZWdYyGypLIPb+el1M+ncNsGMbKxM+cxgc/bGPsfzAKvGt95T12islRokPfK9
	aFitkEUIMpVWi2n+32YD5+SO807pG44Mu/7C4MuQKL9KKBI9kx/BGSJDRJViPFeix9As9PbeJp7
	5bPyaODQifJRGoNPeAY=
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3adeb197eafmr2837181a91.64.1792899873454;
        Sat, 24 Oct 2026 20:44:33 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:32 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Colton Pawielski <colton.pawielski@gmail.com>
Subject: [PATCH v2 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
Date: Sun, 25 Oct 2026 12:44:10 +0900
Message-ID: <20261025034410.808796-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025034410.808796-1-daniel@0x0f.com>
References: <20261025034410.808796-1-daniel@0x0f.com>
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

The landisk defconfig currently has a similar but incorrect IDE
driver selected so IDE doesn't work out of the box on the models
that use a PCI IDE controller.

Select the right one.

Fixes: b7aaf16d10bd ("sh: remove CONFIG_IDE from most defconfig")
Reviewed-by: Florian Fuchs <fuchsfl@gmail.com>
Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/sh/configs/landisk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 2b7e10c9acee..6b5ec1f3ad71 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -28,7 +28,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA=y
 CONFIG_ATA_GENERIC=y
-CONFIG_PATA_ATP867X=y
+CONFIG_PATA_ARTOP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-- 
2.55.0

