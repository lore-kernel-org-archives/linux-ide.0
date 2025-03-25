Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A791FAC34
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918179; cv=none; b=cCUTmLQLmCXDThnWaged8MbKkA/1lwpF4jTSMIXRYfs86ehozwHsc91Kfdls4GZehwlKJcTvthBVQH0sFTznlLgUW0lwrF1QEkiR2PJHeV8SMzWUcBrbG7uJEdebWUGKvBEbAS7bcxSiuN3dBVK21vgNjTS4P44sQ1seEp0KvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918179; c=relaxed/simple;
	bh=K6y6CroS6Xt4/WH9z9fgmP5lzXPYUcLLss85ai4Zzho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4VQDioR9wZNEofNArUSjt5mxcLGzm1qtjKLwFzQmRjtxVWk8O1Lgegu3+a1WWKQmotghNwBYRTvcneSd1yD1x79RU4V0mpfLDv4s7bBBl0DWeAkAYsE1pPiHInvanjXuxm6MyzLJBbPS2tTwpKgUUBO3GClX6GXDp0JYBBBdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1FjYnvv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1FjYnvv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso50051665e9.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918175; x=1743522975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6ckCGEaHAtDt1IPzanimIwIw7z55113j5Mi11WoTOo=;
        b=R1FjYnvvo6NFmAuSqJRAburAy/MfAfp3cEBgxKWPPwwLmyT5qjQ4n9fCEo09XHNdwv
         vdMJoBZOUliVEaZkWj17rcYUKLc/q1u+J8UX52vjvWf0z7Jqapx6k7uadfnibv9WCzvX
         WQbnpk9ziogsoyTPuqdIjvnX3OHzfjuxLiYYMQj9xsc/lCwiPAfmTdPZK4vK/ITl0yrr
         gF/Jhg5UbxASlYa697MNwAmDyMSePn2eCmnXzPeO/E2RVsgEM4+4WQgPS1i5Rl1LdX5O
         e5yMrAsjkGfSfvXCxOmTcdSkHp1s4mP0eUbA4wj/2V4iF5wEie2iCZUe9B5NpCg2/1gA
         XGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918175; x=1743522975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6ckCGEaHAtDt1IPzanimIwIw7z55113j5Mi11WoTOo=;
        b=CYNTJcYyA0tw+hQtnrkJyI/PqiO6sYyZqoXdNza+X/2kCWut3f6khSrn3jvsumb7W5
         m6rYeQgnYB6Gm0H5r5MZdPfc8ber7LLnQR3zvMAG7yAutTeLuUMeFltjH+uDwNNYYS1o
         nGaJ7evqm8MURLTqek/cUeOavu4VpWS/Xv8+sSBBwV9wHTCDLh6NEhHQNIrW6F3jmWHX
         /f+jKS1TDAHTLtgFwkos95kR2fNy8oiBi/k47QYtEikmuA4uJvZ1gxf0VW71L5UHSxao
         AoXved02U5/fLWvkQvvfJ9dYG2OrswiucLKJkqC8vAI2uoNkHOUgc4AFwIZTBn7KCy8A
         9qAw==
X-Gm-Message-State: AOJu0YziYCavwWSwcNbfMaGcox5RjT+5uqMOTxnVwRSxhBqHI9tmfka/
	wh+T5Y330lMUEfKHLvIphwx83st7EakYwp40ctKm9DkiA4VRURcK
X-Gm-Gg: ASbGncucwe+RnvDEaaQSdySIZfaUQAlZasDoKF/EWl5hFSGfB2rWYwBDdvnbAYw4LZP
	5m73K3vW6KToXDQ2abBlR53yYH9hS6owko2pW+7f3oicV8dJa+EIq5hBqvHyYuLXpLKpk+7j7Tk
	3oXWx/vGsX0JgVgpKbsisVRvGMpxCZ0AMKd31jRdkAIkZlLaE4E9AexPrER+5D2WVtVybLEIUYo
	T35mxohyPJuDqvgDWcreA4Dyaqsx0gJ3dNXXhbwP7nGxPtzPgCRDKLUozmrmMAwML1BpvELfCno
	GvB0WMgEKucLFnemfqyk5dnkLAUAlO/NgD/6xog90Ng=
X-Google-Smtp-Source: AGHT+IEijUARtkG5JnZ2jehRYwPfu3cm//HMigb61e+SvkFVAGQ0AeGru+s6k47DVYMpAfkSBnRl8Q==
X-Received: by 2002:a5d:6d82:0:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-3997f937cc1mr16782815f8f.38.1742918174715;
        Tue, 25 Mar 2025 08:56:14 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:eead:4845:67bf:e110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9df6bsm153448925e9.31.2025.03.25.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:56:14 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Date: Tue, 25 Mar 2025 16:56:11 +0100
Message-Id: <20250325155613.352680-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
the CS-Lab Warp series of Amiga boards.

Changes in v4:
 - refactor pata_cswarp_data_xfer()
 - ioremap WARP_OFFSET_ATA region

Changes in v3:
 - suppress a comment
 - properly return ata_host_activate() error code

Change in v2:
 - fix style, remove duplicate swap macro, driver version, etc
 - rework the zorro attach mechanism
 - remove the unnecessary zorro ids refactor

Paolo Pisati (2):
  ata: pata_cswarp: Add Amiga cslab ata support
  m68k: defconfig: enable PATA_CSWARP

 arch/m68k/configs/amiga_defconfig |   1 +
 arch/m68k/configs/multi_defconfig |   1 +
 drivers/ata/Kconfig               |  11 ++
 drivers/ata/Makefile              |   1 +
 drivers/ata/pata_cswarp.c         | 185 ++++++++++++++++++++++++++++++
 5 files changed, 199 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

-- 
2.34.1

