Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65E1FB1
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950634; cv=none; b=hAFAGsz5fwCFvfKecirgBDneAmLIBQ/Bl1mMx0YJii4InF9dBpP8txczQ5fC3wK+yrMBAKV/gkzCmNpq5kf5p0ozBb9yzu5KG3/Fj6LQunO0mdqAALlDl/nZdjvqiGn4C8E6VDpcS0FM94EpH7Mp7cyiriqUAsGJH2EOuHHz9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950634; c=relaxed/simple;
	bh=w/9M2QgwkVPiRS8CDzjSMO00HokeAKC2CYYbJHcfJKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=isavtysi0lPdk1Az0pflYWUVY1bAEuGXEyZvYWJSsSnh3Iyv2NfQz+C+LIvAUWGAuOvwr/eKTqTkn9jOG/8ht5MK8zugDVLXNFb4XgnGVDU1bDVEDVP5NoWu+CoHkQOtiS+MEVYzx3yS5OmpEoeSJf+7KruOTN0NwrdYsCFDMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVMpJSNO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVMpJSNO"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88973b6965so18320a12.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950633; x=1783555433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcHM/gFu1oM8rR1G/bYduYRn2VScz5XDrbc+19vhlU0=;
        b=aVMpJSNOD0hdZ0CXZO8FvoHjiND7R2Py9Pg/rVdBdRNpi3peJePiwr/J/u7f4ChBe8
         9ElepgOfNtj5LUIYfsJpqiODBFyz9wmfxoXMg9UtETzdmgV0TyeB0DpB5MRG4RZ4pcpS
         p6iOHiVyeB+cVwaaAhu0zawEQi983hmTO+bXu53ra46mmmscR01Cv4US5Cbo1QKN1mm/
         jaW+JS52XE84aXm59RpKwqDsj4L7w+ChnkHuXL29qUOTFayjnkub2wfLeIpu4jHp0yqj
         7HbAkvJ4rA1ZkfwFyxiKUq5vXIssG85CwKrQFT+3YIlE43HuC7o9paJypxrtzsGnYbRI
         WAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950633; x=1783555433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcHM/gFu1oM8rR1G/bYduYRn2VScz5XDrbc+19vhlU0=;
        b=hvLHG+l70Z8G/Y4yCeiTiAVEXuZlsiCEa+YHNy6EXrzDOrSB/NXUQbiQkJNHT9i3SH
         h5YYKikD3Wl9f7YCauVq5fS/VRspBH2G5dtLu1GiZUBg9Ku+qiMc0JXgV62qbwLTczQ1
         HOUP35cbRsF4pbLf92Wau/2RKHmH3N0hpKlhHM/Un6sjSQuTfAUxReblJKWVAvAM6uBM
         mHFH0CtGsMOgEyP1gnIR4ZOqZ1vW7GW3XyL+DxfXbftR57rw585tXSxTWF6Tnl855xf1
         RTlleb/adeGgV6tyH6D7YYCbdE+JwflfiHLnfH5/bCwFX/EYWLA55AmIPEdBYdBu5VLb
         E29g==
X-Gm-Message-State: AOJu0YzKpqKwpKzj0ykJOpsdLDi7cmU2CL9GFCmFeBezTAjFHSDFbIWa
	1I/5rdlaJiqeO6v3q7NEktoz7Q30tqiiNPXxaC4VoT4MCcn34yQrR7ufdN+VZw==
X-Gm-Gg: AfdE7cmmF2sNEHBWFOV7HTo/qHCHtdQ00bi2jdUGNEGroHqT7I0BJ1vUq4I6Jt8HH3j
	gObxavL0P8Ruscol01JR1MAJlKxEhIEq8T88zzh6U6vztwmIVq+kTdWEXw2/LfpUcVpmZONKfNR
	Np9rFM9Iuz7ZGWPnrCtAFiB9Gm99u4pwLwaByExOeMIKcnLpto7D8sFMT9hSB7WN6tyZ9W9uNIl
	TkUcGEbx9whJxjVP9BemciMPRZ2KHjhwJ8KYPNspGbH0MJQchB9IziM9b1Pg2ZYl9dHgcjNIN50
	W6Qg9CdcvH1M4oz12cbv5bsCzc+dzcXAtJfrkN97PhaTfeVa4WrzHFLepYdMhQqaojTVOSG50oL
	xZl3bYQCoWoOJapZQPsM53Ha8hjCcS51ODQnjqiid0tzXCFQ0DkalEgA+jITGaR4lg2HMIvs8rk
	m9/rLQ8QOf7iAQ3wsVpbS9DvQOofzBHFp+Hq9SilWE1XXa/Mdg8Er3biChpcgyCII/XpIFO599O
	Eft3AzGmQ==
X-Received: by 2002:a17:902:e54c:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2ca53f73fefmr61680875ad.9.1782950632644;
        Wed, 01 Jul 2026 17:03:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/8] ata: sata_dwc_460ex: cleanups and interrupt ordering fix
Date: Wed,  1 Jul 2026 17:03:42 -0700
Message-ID: <20260702000350.68331-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the sata_dwc_460ex driver by replacing legacy OF
APIs with their modern device-property and platform-device counterparts,
converting old DMA resource teardown to devm-managed cleanup, fixing a
latent interrupt-ordering bug, and dropping a redundant stack copy of
port_info.

Patch 4 fixes a real issue: sata_dwc_enable_interrupts() was called
before the IRQ handler was registered, so a probe failure or an
asserted interrupt could trigger an unhandled irq storm.

v2: sashiko fixes.

Rosen Penev (8):
  ata: sata_dwc_460ex: use device_property_present()
  ata: sata_dwc_460ex: use platform_get_irq()
  ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
    registered
  ata: sata_dwc_460ex: drop redundant struct copy of port_info
  ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in
    interrupt handler
  ata: sata_dwc_460ex: disable SATA interrupts on device removal
  ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
  ata: sata_dwc_460ex: use devm for old DMA resource lifetime management

 drivers/ata/sata_dwc_460ex.c | 99 ++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

--
2.55.0

