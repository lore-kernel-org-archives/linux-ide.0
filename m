Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE512D21B
	for <linux-ide@vger.kernel.org>; Sat, 17 Oct 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210479; cv=none; b=nx0zrrgBnKeOZ6YtscgdY7Mx4Cqdd4UHmx2Ho03IXM5Bpxc9EVHcMNSJWaT0kAn/xhQOwRZzJRACrCmsQW30tEZgRv2tzuxBqBCKq+om9QSSWE2vLmoe+4n9rGqu4g/h2cj5PHskMZI2SxmscLwixXq1XiGfhKmQUneGft84Aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210479; c=relaxed/simple;
	bh=BriZC6DxZrhy5N7Op3EpDAZGaSlOcuqXDcaA1Y4+xCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dq0aZ0LqMyu4U5/v/nXun8IJoXiAk7ZhLCzT8kSEMP6NqNuKsunDXpxqnxavbf1Pt8W4lZZIh7OHgjHxTvDrYnxs0Zgf7ds6Rk2RoUvTe9/+l5xTOyLivPDY4DDa87DF44U4D/JP418lP5mT3+mKEE7lMnN/MM+t7PhwP6FD26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=PGcCkczt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="PGcCkczt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd3310348d2so815758a12.1
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210476; x=1792815276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OgDC/ta2AGryucvreeu/Kd0cvPv9S+G98Vpr8co/uPw=;
        b=PGcCkcztfa5r4uN7V6QPvbDFLghssh2OuFlAn4J05CUR91MWPaKo1q6rwRTERkeaLg
         MeCJ9cAF51qR71En2k5PJ7qm40c5ZkLEBtnfRY65lm4EWR9ndAYdzQdf1US/8knN9H7h
         qiGrG0ouUaEy6kKPNdT5Ye+KfM7BJNvyMXyfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210476; x=1792815276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgDC/ta2AGryucvreeu/Kd0cvPv9S+G98Vpr8co/uPw=;
        b=mr9vLJlJuHYpMu2Xyc+kPU3hG4QHpDlSw0hjjK3tHxJD3LtOl+wRtFG4j7O2zwJEcL
         EWF8udH+8gEi+mY2rFBt3B/YXZJgdB6KSicQveSMI8SQ1/RsTUO1X5+KHazEW04eYrVk
         3r/TB+w/JEUgjip8tMKHuyb/NNPvATZJxOx0djc/Q4WnDnjSxEHCkhi7QbrG73nx7jti
         +FBTi0whofFKLD9G+q/YEkJFVFqVZQyZQbb0L7vC15+PWHvtVJw/V0L/pfNwN4YRF6fn
         QG/Q6MiucU6pICV60hgi4abqKwdZU4L8rnvG1vPxzr8a1lVf9xNGbfLgEcCpH4G/02dc
         Zdnw==
X-Forwarded-Encrypted: i=1; AKwUvBzAj9sX8+fft4eaoQn6opYGsyxDpfPkygIhNlO2ZjYniSz2Ms2mt16Ur5jjB/IiVLxtC3eatJxAtVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJybKszWtFgvh0Rcr0rRat6AMyDH7abKsh9Obz+4SKSr/aI5izK
	XxV9j0LWC83n2MXueOB5rCouE9bW0QDDJCc6kLuKsdQ8J0ybEo+lcuu1uoNHpTrPznk=
X-Gm-Gg: AYBFou1aB6WRqnWEfOG4hbdN3krJgO+9melucEI01hHEvALhGy0ypEB5eukIT2+hFys
	A9/IyWtJdl2RoQem726Do6N9Igyj6c+2GTZdFVg0e0aLjmQuSyeMx6T94Qo6nw9Fx8sYyEE3UCh
	uD7efGTw+9dLOFFoBthl0IvHGiIIJAbSi9rvJtiG8oIm2LgACT2CykEWlA2TXgxVqaf6pUwQGfs
	Gu/76mAs5C7xzpIgFwheu5YjGNO5l/aFWAHjNNi8vLYQ/A5Auboi4J7HWCEEUbD1MsB9LTj8irs
	PULHzs6eGlZBGdk1q2bk/pksHD4P2tANnrIACOVwNEbRVbi2UGCukI1SXl869UuGZBOVsg0Vl57
	ZADMc2iFWFs8K9Alr/4LYKqSlL8VTbKxpOfkHZBKCJCtGgTyImq/7H1b4ICNN5bwXPDL+KOgYUA
	mzMp6O3JJ957bu+Mx/TLfn2tRqrBxoQZEN8euRwnEljzz8FzH2PMN+6a7Fx+VZdf9i+kOb61vtx
	coBZf7iFgmyXzVJHh9faI6rSEBESVhUkZPJyaNo
X-Received: by 2002:a17:90b:4c92:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3acef55d641mr1125765a91.36.1792210476334;
        Fri, 16 Oct 2026 21:14:36 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:35 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/2] sh: Fix IDE on landisk
Date: Sat, 17 Oct 2026 13:14:17 +0900
Message-ID: <20261017041419.311921-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I dug out my landisk to look at kexec for Geert. Since I'm lazy and
LLMs are good at fixing bitrot I let my LLM work out how to get
it to boot again.

There are some other issues (perf is apparently borken, there are
some issues with the decompresor and big kernels..) but this
seems to be the only thing stopping it booting with the defconfig.

Disclaimer since we don't need to give LLM tags anymore:
- LLM debugged the issue.
- It has been checked on real hardware.
- I have checked the IDE driver patch, cleaned it up and
  cleaned out massive walls of text that LLMs seem to like
  to add but I have left its summary of the issue in the commit
  message.

Daniel Palmer (2):
  ata: pata_artop: read the ATP865 mode register through pci_iomap
  sh: landisk_defconfig: enable PATA_ARTOP for the ATP865

 arch/sh/configs/landisk_defconfig |  2 +-
 drivers/ata/pata_artop.c          | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.55.0

