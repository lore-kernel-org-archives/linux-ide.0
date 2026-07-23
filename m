Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D836F901
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833986; cv=none; b=jj48kVly66F1WnklPcB5RHRO1xJmVagdCmZ4IS/5gQNjbkPdhKYkjZy+AIb1Lg8vcilK8WJqDixOQNznnc88R++/NQC/oPCGHApznXJ/7uA8rjJsAq9sxM2SWv8fv7uwgS+jyS6/6L5qmDwUdduHNwpVPeIKOc+Cx92P/QnqtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833986; c=relaxed/simple;
	bh=qIYhyFMm8ZkAnEifeEZILDs8zeE6roEPdbjvxoTZ+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PE/JmlQKo0JbJNM/k6bWyrZ8PYSk3G8CeW2aJCpIDNQ/pbdo4fNn3/9PPApap2ngnrA6rcNys8F08Zy+Csq0KghaNYA3euaa0F4R2wwJVmbEMsOqAOsecwWSB+19SmUxZeZMvfCYqaIiolrVauz68zfy7+8XmvsKpANhj2+Z5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cygelzo1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cygelzo1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf50c6f235so14224715ad.0
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784833984; x=1785438784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=apccZsPdPUzjdUN/B9litPObvaZZXYJcoMOK0Da9NHw=;
        b=cygelzo1Cd0qSVreYwy0laeHDpe2Lw9aTIvRz/T0nxSMsjKJ1jyGhop60HAb/ta3aC
         9F/IOudED5vjkJGa4JgKsali7GudjanC+clfMEyZOqj0iZo36StNUiUtIUf2nS+woYKI
         IOCRO1eSmweJgpjmEXgW7hzC/daT4d6Wn6LaHbvJxgXg+r9hZS6lyNvv/DxVAvHNIWN8
         iz9fVvMdjo6+99H0zFzNXm1MZ0jwv4gp3BKodi9wjovKIaQqUJfXlfB9JsKjW8Hxa7yQ
         7OLi2B6wWxlEj3lxo+o3sk9ZOSM6iIfZIWpy52mSImbAbaU9eiw1quzFxPAF8XIm44ik
         8PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833984; x=1785438784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=apccZsPdPUzjdUN/B9litPObvaZZXYJcoMOK0Da9NHw=;
        b=isgBvyGkYlCXI87be7SBHncWD/ga/z49rUfBrdfEwLJalR2mQLabGxpxBLIK7DgJyH
         gU0A4xOHqXX9yoTnkf0sNDyvJEOn02CYU6AaWkgt639Yvk1ZRiwAm4k7r/4hGgBXr4gp
         SgSWGJC2TWCb/JgBKpZ15kloAUgoW9VSPy4EE0NbazoOEC9u6MwRwDGKKdWszpiPtP6j
         A37K0jJq92ptpmrqz1kkBc9dbPQnNLGHdKBiNQ+aJ1gq449s3nmfDEEIzjE/Ioq0R2Gd
         knK7D8WbZs/mIe38t8bvdFvLp0c2WBdgTl8fWDjnhAAmiqQgBaAMxoFh4wK2b7UoiZMd
         Tl7Q==
X-Gm-Message-State: AOJu0YwuLQrPtF34kokY7Cjg1ZzourXEDmqkrlNZBDtghSp4CODvZsKk
	VFeAQBNrTNrP8BBL/Ypryd5qw2LA/7QAfFHZ+bKReuqvWk4+590uamhft/VoBA==
X-Gm-Gg: AR+sD10p0IQIiq5iktS7aj0xH8f1uhxDWMp5T6NspE42TkgpC4q8at3pz0bVqjdOP2Y
	QinVa0VGhGqATAlAuRv2l4KUx21K6j+JQg9UM/2/I5ywI0WkjL/oWUXuq9+K/tvcTf0NEWE+HJW
	IqXkQeP5jtvTRBJ4gfQ6LNYX+SWWyvEh59Y/nzQOMmeUCtqH5VV989894I7p1tWAaiEFPGqnBA6
	o7e1Ttx3pBUuOKMm00gO6NZPUS6dKkl9GYyobe0E0xu4TXPoa8lway7I53twHwwISGONUpmypqA
	HIZzoasAd4wpDneIBtOFmEelePYFKoHHST2esXGbOXjLFh8PbqEnAs9E86SXvoA7cNr9Ii4qTXW
	ofd9MWEa6WAqkx43vpN7kXyG9ZVY7V1eSpNZzbSYhNKXqQiAxyy4sq8DzTyPrALcQmxlnVQ/16I
	kmOGQMz/BAALt/aOel/IRmzQm8RIZAlSVDlWUVKevBf5iPFdmZdQrAyFOC0XFHoLGC58DqrL2/3
	PJc2j/PKUK88ZzgtB2RBkfmhgN0fi2nxxCHdXvcriljUyTSte0j6jc=
X-Received: by 2002:a17:903:37c8:b0:2ca:7131:cace with SMTP id d9443c01a7336-2cfa74e3b19mr49772015ad.31.1784833983950;
        Thu, 23 Jul 2026 12:13:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8edea703sm39057785ad.0.2026.07.23.12.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:13:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rafal Prylowski <prylowski@metasoft.pl>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_ep93xx: fix endianness bug in trailing byte transfer
Date: Thu, 23 Jul 2026 12:13:02 -0700
Message-ID: <20260723191302.139580-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep93xx_pata_data_xfer() handles a trailing odd byte by reading/writing
a full 16-bit word and extracting the first byte.  The current code
uses cpu_to_le16()/le16_to_cpu() wrapping, but then assigns through a
u8 pointer (*pad), truncating the value.

On the READ path, *pad = cpu_to_le16(...) truncates the u16 to u8.
On little-endian this happens to give the right byte, but on big-endian
cpu_to_le16() puts the valid byte in the upper 8 bits and truncation
keeps the lower 8 bits (zeros), losing the data.

On the WRITE path, le16_to_cpu(*pad) zero-extends pad[0] (u8) to u16
(0x00BB) and then on big-endian byte-swaps to 0xBB00.  The hardware then
receives 0x00 as the first byte instead of 0xBB.

The readl()/writel() calls inside ep93xx_pata_read_data() and
ep93xx_pata_write_data() already handle endianness correctly, so the
trailing byte can just use the raw read/write value directly without
the cpu_to_le16/le16_to_cpu wrappers.  Remove the pad[] array and
simplify.

Fixes: 2fff27512600f9ad ("PATA host controller driver for ep93xx")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607231521.gvhnJpOG-lkp@intel.com/
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add kernel bot fixes tags
 drivers/ata/pata_ep93xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 339ee5e43e9f..558f9cf95e6e 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -499,19 +499,12 @@ static unsigned int ep93xx_pata_data_xfer(struct ata_queued_cmd *qc,
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
-		unsigned char pad[2] = { };
-
 		buf += buflen - 1;
 
 		if (rw == READ) {
-			*pad = cpu_to_le16(
-				ep93xx_pata_read_data(
-					drv_data, IDECTRL_ADDR_DATA));
-			*buf = pad[0];
+			*buf = ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA);
 		} else {
-			pad[0] = *buf;
-			ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
-					  IDECTRL_ADDR_DATA);
+			ep93xx_pata_write_data(drv_data, *buf, IDECTRL_ADDR_DATA);
 		}
 		words++;
 	}
-- 
2.55.0

