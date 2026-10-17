Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263A3D4126
	for <linux-ide@vger.kernel.org>; Sat, 17 Oct 2026 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210481; cv=none; b=ckRYJW3DLuUZX4ga04IE994MlipnTCJFfNjMjWnx/z8hYIE9XCX/gJDe4QUKIP3IaO6gV2AgoIpXTsddaj/60jjHcPv2caTWR8/QeiNYqeIRCIhiYbgpylWQFW05Lk3uEs7S400KQ8q/5f456dWlhyFBIE3HDjPmfOu686qwFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210481; c=relaxed/simple;
	bh=NqySz2E/JSZOr5SjYr43G9CD36sDZm2WAVtIjCeYOsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AF/kpoevRTAgWW/1udb8X0MwtoHIEf0qKcDPho1ab1r0TMluLfN0PX/ap0fCfF9TpFuXCHzQERq7J6KqmMZVYjtFJZtR6J0F4/x98OrWs+8bSoVH8S9xFwB1MqtuLjNtQEbvs5JBP70S81hYa78EyyUEzDGRm9vbtQqNO+VEvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=bLq57M+F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="bLq57M+F"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so460329a91.0
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2026 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210480; x=1792815280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpOuznd4WHUcHDSy+mj+fYIUFYiq9dGMf1wtGAT9+I4=;
        b=bLq57M+F0+ewhS6C2yWyBS+p6M12IleOPIOJzegIC/ig3XtfLaOBO6JqOEX15ySD6G
         hBmg/A/WiQQdl6WnJPEsGMRe7zzt+UrQpeDo4ZVNDrRHOwla2mHQD5h6rp/D/Fm0pTex
         9f7eObfh2+nLJ43PE1w2hhSnL0rJicbzPzJgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210480; x=1792815280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpOuznd4WHUcHDSy+mj+fYIUFYiq9dGMf1wtGAT9+I4=;
        b=L9R6Ph3I1ws+V/Y1KBsJ5lTnDfzh7MLligYfAysB4DqkozuE+CXb8dYtG9cMxEXupa
         8n/Seqzx1FG3G9ImCnWAUDp6Pwu90yBm02MtXDpfeHEbQmfj9qmr5WA/JqIX0Tmsq9bI
         chsSBMmV50RhZqLeaMrJbXP4/A5KRoZB25pxIN9PCUMUvYplN4XdiidbzmibXEYBVi66
         mWTPWUkYq5ut/nWZY6rkSwYKRWOpy3NBPHLGSAnxWne9pNzbH9y7nFCLcA3JGzx4Nmuh
         cjRC5lpJu3XNrOXNOzJb41ma7ZSp2g6Jl9S7Pl0oyhh2M44iPQhh+O/tZEyxXsGfDtyL
         j2Uw==
X-Forwarded-Encrypted: i=1; AKwUvByw2fc6krAt2+IcE54kqksz0XVCWiQ9uFrFz6mPH0+IZAVkjwh64vPV/NikxOkpJlejsZPRyoLTb1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh0hBf8JGxGgJV3bMBFvdukgDs7gmd0w/p6HCamQZpjpqWekOr
	rBymtlZcJZYwlt9YiVYw4Qcaa1mGWRmLdwyF2HuxWe+Mec5CWf8C+6yNfgqTIM9QsG0=
X-Gm-Gg: AYBFou2uXTJibT90uRn4LtzTWMoLT9ifyEUQXDn8+K/orwZjibfyKVHg3gTbkoDA+/J
	ayj87Pr80qheIFmWet9bPuqOjd1xSZdvBS93r1mk/38Rixs2LtpossNyq11O995jR939lp5QB1J
	iVZ0G92+hxrpU1rtpvEO5hGzbYTPinv6wC04ufH5F2+pUDxPbAUcT6pMvYvSIvI7dKPF85+WPid
	bSADzKj8shfoHj+byrpnBAoFuhAInRR2pGRZvACRnGsMLS6RqoT5zQHpfhcMJHJNzC/V0hgrRjP
	RsamQtIw84edGcx9+s7g1KkT/IusJzls5kUU+Xyn3OuszMWutG9fFArk3Fs2dB1AL7zR9WW61cg
	I0K7lPs3BKgaOL8dR6hjdAP+3zGjXwE1M0LwrCLUWxaPfHgs2/KQJGJ1xOL5VFraVcpZolw/XlK
	EUiTFmrSYH9le2NegQ6Nfm803ygaYWoTc4KWdmrxauQblSYDaGcyMjDufovPSv/0mFFCBZYp5I2
	4tB7EsbOZ3EPmUqfDWNgvZF5O+/cyErx0LdkKR+e5OJHEhBkUU=
X-Received: by 2002:a17:90b:574b:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3acef1455e2mr1103745a91.21.1792210479754;
        Fri, 16 Oct 2026 21:14:39 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:39 -0700 (PDT)
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
Subject: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register through pci_iomap
Date: Sat, 17 Oct 2026 13:14:18 +0900
Message-ID: <20261017041419.311921-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

artop_init_one() probes the 6280's "fast" bit with inb() on the raw
start address of BAR 4.  That address is a PCI I/O address, which is
only a usable port number on platforms whose I/O port base maps PCI I/O
space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
dereferences that address:

  BUG: unable to handle kernel paging request at 00001400
  PC is at artop_init_one+0x10e/0x170

Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
the BMDMA registers later on.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/ata/pata_artop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 9f8d41639a62..351ff4c8e48e 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -405,13 +405,21 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 	case 1:		/* 6260 */
 		ppi[0] = &info_626x;
 		break;
-	case 2:		/* 6280 or 6280 + fast */
-		if (inb(pci_resource_start(pdev, 4)) & 0x10)
+	case 2: {	/* 6280 or 6280 + fast */
+		void __iomem *bmdma = pci_iomap(pdev, 4, 1);
+		u8 cfg;
+
+		if (!bmdma)
+			return -ENOMEM;
+		cfg = ioread8(bmdma);
+		pci_iounmap(pdev, bmdma);
+		if (cfg & 0x10)
 			ppi[0] = &info_628x_fast;
 		else
 			ppi[0] = &info_628x;
 		break;
 	}
+	}
 
 	BUG_ON(ppi[0] == NULL);
 
-- 
2.55.0

