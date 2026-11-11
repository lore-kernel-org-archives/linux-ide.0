Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415058;
	b=QdHGMvvQR6slM/3fyjkd6mc9de7nqw3YegFabqiFvcCB9RSpAccX59kT2TONzv3Oez1q
	 2orsziuJvgi/PHvLED/WhLc3vAzFMkenVSSD/47vHuXwh1K1MQlfs4bb3GE17a5fN9MEE
	 oim+/F95KlsMQNUTr+28iItpc8aZaS7E0s19/4BG39sWdPSVhU0ceKusEnzhBTeSMco4O
	 wjrS1t+bSlpfJaV0TISjyHiEHCNLOU7qtLRbgTTb9sZnGA41l9AKuAXas2HF3U26yntUg
	 tSSRaAqq3YuWd+wEoHzMNirkHSYh/3WNFE/Pkc4EMmnwdLqA49npPq7V3qorCMTPJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JV2UV74dkWO5TgZQL2wBeL3Mgq/3k9N3hqWRtljHlY4=;
	b=GOr5hZDTXaNdh3h6UdbQ+4WwfJp7ST8X8xxZr1laH9KAINa66MwqFRjVgWSNvd/mYCl2
	 0rJaMRhAS4BktggkAedcSXdUz2KfVdb7pyRSv9ddWCDzhwcKmxgwsAzDfxHZSMLn5QjuA
	 aLf3n9GgMF9t2mPJUYDBXsDTBA1ktjRfBo3nHAQfukdJYWxnqee8/XHSAgBNuoeT9m7Pp
	 CVZ3Gl4IZiRVSAC4LfjP11rkrphUdP3HM963hkqeLQGN+N+wIvGrwP1/E/S0+PsWTdWS5
	 4KOEo1bxzrbDvH8IeRHIhH7LpuON8C1ZzRM0N+vxSeGuDtMCRAICIHkNX0i93ih1VAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ2ipB1R;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88005606A324
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88005606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ2ipB1R
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so33790115e9.3
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415057; x=1795019857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JV2UV74dkWO5TgZQL2wBeL3Mgq/3k9N3hqWRtljHlY4=;
        b=bZ2ipB1RKdEdNK11Wq43EH7/lLyFWBuVKBQmrHtn4K2X1zPEOaVlrQfMRi2LrOreua
         bfV/JqG3QsG31QYJkGooDpfSFTY28XT2Oi6s9OVjXZWti8wCt5b9AyJKV+7c53y8jGye
         ul8HxBa6YJ8B28+RYSEV0A79O9DRB+XtNFVlMTuc7ZKYKKPF5YBhyy8WdQ1Fo3/hotyf
         bEM7fs9bhjYPgvAZS4fy7syzE+HQG2wDHR1FQW8QAZN3ByrdhC/mmFzSjRGRtl7CGNQf
         hkHNA5FMmk6Qx4eH7h1Ijqjz4bydpAGXgt/i7wPUVO20K5WcQoyrmdeHIrdvmMAFdpAO
         sHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415057; x=1795019857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JV2UV74dkWO5TgZQL2wBeL3Mgq/3k9N3hqWRtljHlY4=;
        b=dFGrCaX5JO+AmAA7Yg9rQAmNtOCIX1fEeMZFRrHFl/F28ijZ8cNhZb0wmTxlWitTaU
         JXCt53xY8yeRhciKn03xZFNmJO+ms3N38sWCRlBXUjDtpIgb/AcUB5pycc8GgR1P0vvC
         aNG6ZjNL9MKGVBGVtFPDGj+g++OrSV1ebFSI4adHY9jsJOznVChYNQAkp9TVb70NqyB9
         QHjMn9142oZlWUCkjyyiRDAGrQ9nD3kCn9u9IxSWqdmhQmNCeKRkdOpxajZOIpEAPLP6
         nGYbrzQPEdAuuRg+H34apfE1H93gf9weKMvroj6DHIGdFGamHhG2VsUoUhKzrTQoECY6
         goxQ==
X-Forwarded-Encrypted: i=1; AL+hErE4z736+Raoh9F9GF0TwGevJq6tLr9eanxHYggBICJMvrI24anFdSHCIIKf/cz+JJpoWkxx4FAOrVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OVQc85dAl/+VIi21dVb9t5bebgR5gUzwm2yTm1PRjc08Ju/Go
	CMcRy+oXvDZW9g/xYej7YoCxqqfF5glA+paF5e2xyAYxsF0b/YNtiatp
X-Gm-Gg: AYBFou33eHJSAMpIUxyJ6TjNEbrQk7QPs7pRWQQSZ7qxSJpCl/ceYvhjY+RNvmeIkIj
	kjHNuTVot0RUf/phfp0/t/4+WJRW8VK7E9504uVLxe2KNTayshmGoZtI0CHfZlfIuAquO26rO2b
	WpNaUb3gVPTMJ5oRuXlFG1h9kelnZeEft9N44YCMvYsfWkF19gvbe720YGBaaDNXr7FgrYmCb3D
	IgJ4ybgCzbQVLxkFEl99wecD+mkt1PYFRzItGD6fDUPL/KN4nYm14sIpEBfvZg2rMSnnqDqYYP/
	rFpwProATvSjeHc8AR9pEuTYAmT0L5HS3SXQ2axd7dWmveHiifgVpNBIq5bzf+RsYSoQfW9iFTv
	vPv+Ztip2b6nRKy49+g04xSXoCwmaZOq/nuvqEwMJtWCB3GBmOwOoQbkX0zxNbXdPc+RL6VUdTW
	wKDlwHyrC1NGIpXs0vEDkkP++IKUDifW7PEYNupbxZhLHMYpX14WFhviY3EihFq8/bryRYooErD
	pxMJGbsLKHIKc9nWEw/5IAuz/pk186e0OxqhUTvzSBGc1qJZKkKUAgU7/2tGWdyp15zO7HMQXy4
	YM6XE0fDecJGDCytcR2GqLEZ6TRSkAdeo4A5okrrCKUEBl57kmBUolEt5UZvp/JuNm0haMGemM5
	7wKAUqlTIrz6UyRiGHPfu1vnmB4g29Bhca58=
X-Received: by 2002:a05:600c:3b01:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4ba09344911mr53668455e9.1.1794415056383;
        Wed, 11 Nov 2026 08:37:36 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c377fdsm9925377f8f.21.2026.11.11.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:35 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 0/7] zorro: add a CS-Lab Warp 1260 MFD
Date: Wed, 11 Nov 2026 17:37:27 +0100
Message-ID: <20261111163735.227286-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The CS-Lab Warp 1260 is an A1200 trapdoor multifunction accelerator: it
contains a 68060, an FPGA, an ARM co-processor and several sub-devices
hanging off them. The 68k drives the IDE interface and the RTG display
controller directly, through the FPGA; the ARM owns most of the rest -
USB, SD card, WiFi, audio, the Kickstart slots, the CPU clock, fan
control and the board telemetry - and the 68k reaches it through a
dual-port RAM mailbox.

pata_cswarp, merged in 7.4-rc1, binds the board's Zorro device for the
IDE window alone. This series puts an mfd parent on the device
instead, hands the IDE window to pata_cswarp as a cell, and uses the
mailbox for a first set of board functions, exposed as sysfs
attributes on the Zorro device:

  1-3  the mfd parent, pata_cswarp as its first cell, defconfig
  4    the dual-port RAM command channel and the board identity
  5-7  voltages and temperatures, fan duty cycle, Kickstart slot
       selection

The layout - an mfd parent in drivers/zorro/ handing cells to the
function drivers - is modelled on Geert's Zorro MFD experiments [1],
which were the inspiration for this series.

The RFC [2] got no replies, so its questions still stand:

- Geert, does this fit where you wanted to take the Zorro MFD work?
  Should the parent stay in drivers/zorro/, as in your experiments,
  or move to drivers/mfd/? Lee, I have Cc'd you for this one.
- Would you rather see the voltages, temperatures and fan in hwmon
  than as plain sysfs attributes?
- Writing kickslot makes the ARM reset the machine on the spot. Is a
  sysfs attribute acceptable for that?

Changes since the RFC:
- Rebased on v7.4-rc2, which has pata_cswarp and its defconfig patch.
- Dropped the WiFi configuration patch. The board commits the SSID and
  the passphrase together when the passphrase arrives, so writing the
  passphrase alone clears the SSID: two independent attributes cannot
  express that.
- Documented the attributes in
  Documentation/ABI/testing/sysfs-driver-warp-mfd and added a
  MAINTAINERS entry.
- Created the attributes through .driver.dev_groups.
- pata_cswarp: mapped the cell with devm_ioremap_resource().
- The store callback takes a size_t count, the driver includes what it
  uses, and the probe banner prints the board window with %pR.

Tested on a Warp 1260 (firmware 20.27) on top of v7.4-rc2. Every patch
builds warp-mfd and pata_cswarp with W=1 for m68k.

I wrote the original version of this driver myself, by hand. An LLM
coding assistant came in later: it was used to review that code
against CS-Lab's AmigaOS sources, to write several of the fixes folded
into these patches and the ABI documentation, to split the work into
this series and to draft the commit messages. I reviewed every change
and tested the result on my Warp 1260.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd
[2] https://lore.kernel.org/r/20261021172910.134838-1-p.pisati@gmail.com

Paolo Pisati (7):
  zorro: warp mfd: add the CS-Lab Warp multifunction parent
  ata: pata_cswarp: bind to the Warp mfd cell instead of the Zorro
    device
  m68k: defconfig: enable WARP_MFD
  zorro: warp mfd: add the dual-port RAM command channel and expose the
    board identity
  zorro: warp mfd: expose the voltage and temperature sensors
  zorro: warp mfd: expose the fan duty cycle
  zorro: warp mfd: expose the Kickstart slot selection

 .../ABI/testing/sysfs-driver-warp-mfd         |  53 ++
 MAINTAINERS                                   |   8 +
 arch/m68k/configs/amiga_defconfig             |   1 +
 arch/m68k/configs/multi_defconfig             |   1 +
 drivers/ata/Kconfig                           |   2 +-
 drivers/ata/pata_cswarp.c                     |  48 +-
 drivers/zorro/Kconfig                         |  30 ++
 drivers/zorro/Makefile                        |   2 +
 drivers/zorro/warp-mfd.c                      | 473 ++++++++++++++++++
 drivers/zorro/warp-mfd.h                      | 148 ++++++
 10 files changed, 734 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-warp-mfd
 create mode 100644 drivers/zorro/warp-mfd.c
 create mode 100644 drivers/zorro/warp-mfd.h


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

