Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED63803D6
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249730; cv=none; b=RvFmn5z72TBlCtFVaML7XUWuMnB2fHADfKVd1UahQQeVE5iCaTCCE6cZnIZuDWkwSVer7GEQwow2au179vTO39In0HbfZS5XLEyoYScc1JRoHVjFrhnurtAHTNzzJldgUoLex51eI7O1lVT4ojYz0f099Ucl62aJOQZaj4eZDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249730; c=relaxed/simple;
	bh=e74+mO3o8yFR5T4aqUaigSBYb4srPz5o/JdlXm4KiHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5cpdHQM9Y88oeHVstQaz2JE+KhZzuyYby+agUyg6JvJwHrAuQjcSbXXSvib4p7wkEdQT1iL1vlEGl9dpEuxY+GYuaPtX5ieO81fFs/qJgxKUG5N/mnr0SrEKMDkQdKXgUgMJQ4Z66Bx6d/0UZYLX1XTj7fWNRyJJ3bw/A/ui9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L46TD4UV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L46TD4UV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so4584965e9.0
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781249725; x=1781854525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2qiEs7KRoM05F9e6f99tVJfUrCWRjcFNOBIPGO+LI=;
        b=L46TD4UVVbshCrh2Fpmrl0+30UCyD3WHpmd5nDHNqOXjRESjc0BfWStV6WUEaNbC+6
         VrFI76P9EVz85SZ+KxDcyr+oJ5F3jW/waSaDJgBYqFDhrNiR8vXDunl7KS4bFED5o4D5
         iYk0RgEjeznjm7SgDPJIcmejf0oE2RQfWUsOTorRxMFB+pR+jjI7GNeZcS506fqQJ9Ba
         2AJdlthH9DVi+84XnzuNUUzhWRsrtyczotBnAQ3L/KXFPzsJKiYUSQNT02gcX9pPISA8
         7aBp3PzjEpNh86tQAfigKU7DCfyJn63owwCbKgY9WRnKf9v6Nv0mp7RMolZOAKvdF1am
         WkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249725; x=1781854525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd2qiEs7KRoM05F9e6f99tVJfUrCWRjcFNOBIPGO+LI=;
        b=PY6fyOzdpmL02AValUBeh2PoTlmRD9uh8ZNs/xAL2lckD+5LNK9ph9mJXTPd1TwdVS
         YeegS6yeMvGny6w0xsQm7U4BcMtfXxqGzl2yIkSOINLSH+duXgQ55cMZ4Qxluxo+4nBD
         bFmdWB4e1ySARKRp5ag0BK/9k5xlM7FBFJS9mKx6rTvPFq9y2TodH+q52RIVLxDKl9yu
         CdJ7Zt6qrDRKISkCphpjoIf3Eo4Qnk8keUE/ra3vtSLrMeZkl0NyXRqQ7Atgz7/oHEHW
         N41SW5EAX7DkZWJvCH2pRQYpNcBOS4pG6qx+FBFthuAc0rl8HKBrZUZH6vG2UWiVIDGO
         3HKg==
X-Gm-Message-State: AOJu0Yy9JtWgVyHQyqkBJXtjlSGrRuOC7EoVrwcY0qgqJ88t2EWryE+4
	XgOkPYvwsu3pvFVTmz1GIVsjh+BRuRq1YQmf9d8vv1nsk9+EXIHnc9DC64Yi90hvCXo=
X-Gm-Gg: Acq92OErNlFkfHP8RcBgXolAeqNenZoPjicDVbcEY0c1HiUS+HpAoXb7xNESMpBeOxc
	jYp5ipVXc8uMXu/rGtQ+rPYWGLkskK6K9Ic4DURaOwgylTd54JH/a1B0Ayb7WQJcK1KVgyMuaUw
	PubU8UQjTYku1uF6iEkKjl5VYQgNxjcqPRatNNUhSXPg0NnANCfzhr1NP6V/Widxj6rt1JgvKm2
	1tSP5pvOEdYtDS89A/yGF9ovgjDnGyoVctdwDUknl/jOD3Z1CmqnwINH5Et9OZFZhDArrj3EzPt
	FoMVYsz36XiNRZUWpJMYj2ye8BKa+a2J0TZEvdQWmVrYTnr32ai7V1AK8yIGMzvP712lY38E4ry
	GmX5SaEWovxxC/bIzeeXMOY+cVUXGkfiZLpDKiJTmLQfpBEx9yimvM3hjBsn66pwBfsrrwCFIkG
	mRKpQ6c3ZT4XgViJv2HCAvqvQ9pYO/YNBMtoj4+5EQ/JVQF2BHbNBeFEuLPbbWzC6zFj5jsfAcD
	MK18IapyPfV6Q==
X-Received: by 2002:a05:600c:4fc5:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-490ec3388c8mr19393335e9.0.1781249725036;
        Fri, 12 Jun 2026 00:35:25 -0700 (PDT)
Received: from localhost (p200300f65f47db040e4e5c1e98e7f0ff.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e4e:5c1e:98e7:f0ff])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f26f309sm3814490f8f.14.2026.06.12.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:35:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ata: Consistently define pci_device_ids using named initializers
Date: Fri, 12 Jun 2026 09:35:10 +0200
Message-ID: <cover.1781248922.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=e74+mO3o8yFR5T4aqUaigSBYb4srPz5o/JdlXm4KiHY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqK7auttCkLwMoFwIX+gqTgQXzhncruqR/RIO4t ZlkPKLVFB6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaiu2rgAKCRCPgPtYfRL+ TuCJB/9GLUjiDQRgYu6jQqyrVWAF49vUi2fleVBPyfdaeKxS9zo6fjFkD2rIxSmAUQGZ1rc1jJk AkkISXk31pVPAgUG+t6S0/rbiVfmK1lOnveQoOs6/HroYuLEiY9+xoQFvmc5VSW1RUZtitl493u 7SQm/wC52cRC0l/1TRHW4oxUrz9n+zZtiMUsxZ0dAVbRDJej6pD1MGdarXM+RJokyEyJ8yZVrW8 Tme3ve/fTXYAxdvy03xjXbjQFJspqHcQHLtlo1vGJTcXg/C8dgosfe3P6Jju5Wba+S3lY/WIFDP v4PdS+iUIwzqtwvPwAddEU6xkX26sfx5M9c3wVz+qD3gsxXj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

(implicit) v1 of this series can be found at
https://lore.kernel.org/linux-ide/20260430170612.510869-2-u.kleine-koenig@baylibre.com

Damien asked to rework the patch adding more line breaks to make the
resulting lines shorter. I didn't rewrap all arrays, only those that
appeared too long to me; the longest line I kept is:

+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), .driver_data = GENERIC },

which is short enough to not trigger a checkpatch warning.

I also split the patch in two, in the first patch there are all hunks
that remove explicit assignments of zero, that are not used in the
respective drivers. That doesn't introduce changes to the resulting binary,
because the compiler fills in these zeros.

I didn't add the Reviewed-by: tag for Damien because I'm not completely
sure that the rework really matches what he intended and I did some more
changes.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  ata: Drop unused assignments of pci_device_id driver data
  ata: Use named initializers for pci_device_id arrays

 drivers/ata/acard-ahci.c        |    8 +-
 drivers/ata/ahci.c              | 1626 ++++++++++++++++++++++++-------
 drivers/ata/ata_piix.c          |  532 ++++++----
 drivers/ata/pata_acpi.c         |    5 +-
 drivers/ata/pata_amd.c          |   88 +-
 drivers/ata/pata_artop.c        |   11 +-
 drivers/ata/pata_atp867x.c      |    6 +-
 drivers/ata/pata_cmd640.c       |    4 +-
 drivers/ata/pata_cmd64x.c       |   11 +-
 drivers/ata/pata_jmicron.c      |    7 +-
 drivers/ata/pata_macio.c        |   12 +-
 drivers/ata/pata_ninja32.c      |   14 +-
 drivers/ata/pata_opti.c         |    7 +-
 drivers/ata/pata_pdc2027x.c     |   15 +-
 drivers/ata/pata_pdc202xx_old.c |   13 +-
 drivers/ata/pata_sch.c          |    2 +-
 drivers/ata/pata_serverworks.c  |   13 +-
 drivers/ata/pata_sis.c          |    1 -
 drivers/ata/pata_via.c          |   19 +-
 drivers/ata/pdc_adma.c          |    3 +-
 drivers/ata/sata_mv.c           |   34 +-
 drivers/ata/sata_nv.c           |   29 +-
 drivers/ata/sata_promise.c      |   34 +-
 drivers/ata/sata_qstor.c        |    3 +-
 drivers/ata/sata_sil.c          |   15 +-
 drivers/ata/sata_sil24.c        |   15 +-
 drivers/ata/sata_sis.c          |   12 +-
 drivers/ata/sata_svw.c          |   15 +-
 drivers/ata/sata_sx4.c          |    3 +-
 drivers/ata/sata_uli.c          |    7 +-
 drivers/ata/sata_via.c          |   17 +-
 drivers/ata/sata_vsc.c          |   14 +-
 32 files changed, 1870 insertions(+), 725 deletions(-)


base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
-- 
2.47.3

