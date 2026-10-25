Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899870;
	b=dEex84H+0CMGTJszrYUVt7OiexWYHA0NPXjUz4N26/P7SSIAyL8KgCYtSxIxQ/PIqtcd
	 hvcr8MM99KAJONPUE84B0a6yKs0WM0kz167IP6JREWKWnGUbhOwOefuDjjU9sV4ZUMP2N
	 bWOrWM4uYhtT+Vo26g56B52s46ZIQZscrYkFIsgCLXq1UPzpXCUj5zzYYn4GGl653aRHh
	 Spq81zcciILJpW3EkHOIgSWm2+etrfdOhsMynx2gc4vZDJkQDSEpkDY8nSWniMMADj2eV
	 XUOTafEkTRUzF61hUwV2VN+Cn2re+UvOdFYxoeIdkkT/UEXSHpuVRx5NT1oQlkdddkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
	b=ucfioV1fi6qjUQ1pfMWgzgQIHIUwRMuBzLD3+kFH0dR+vPF38PJ85OBFPsQyQ5kGYoUP
	 YuyL5W0kTOpccl7FCiBSYqpXk0bhCuf9Mr3akIn/7iJqK+GIHlZPjJ3eydZ1P2zaN7Agj
	 1v9s4F+PLp1sTo4iYhUqHPBGkwN0cs+1VMlNMK5XG10mdBG/Tuh/3C++m/iMy6cOuMPiO
	 1iDCfDNKlVp9XDhAh844/328AF9edWHr2MRRyuDlPB2cEazyTdrNzWbOB7WUH+SlTc0xf
	 qL5LiwpxLwK5Y6NY45XIWdVjtlgGUqX4VPOgvTFqGYvGvjicss/q0kBjPgIeJrp+M0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=CL7gqfoP;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA21606A31A
	for <linux-ide@vger.kernel.org>; Sun, 25 Oct 2026 03:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=CL7gqfoP
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1013419a91.2
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2026 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899870; x=1793504670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
        b=CL7gqfoPzAf0tKBE0R1WzWUpkrnFaZ2UOXiQwKa0WMzt8aEPjF91xBjWat5xV5T+UV
         3xAT+B3LVuDLTuK1PC9dQfBryj+1VYqYqEu2VXv+RpbVcYOuoi038JF+BNpeqi2qNWoZ
         bDdKNZFypMWBgcZPIYeEMVdbIDuoBLmlEtobY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899870; x=1793504670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
        b=WYatVYN/AnS0IJBGKiQMkFaknOkTcCHgBYNF3X03aoCFjlmYmU8+cE4SdGrAeTqBlJ
         aq9Tmevhq0uNqT/kFXs2LxsJW0PVZzirLJcoPnLIbQ49Ma8HguBMEVCAbAstH3jWqvWS
         q2dzSvAxPTWScSL+TeSL5ubMfxqJDbDKhmvA4IA2lJgmkhvt4lkQcyRGMFgpVuzAZfgh
         w/l5PlNaitHuYDTa9E9gTJct5l1knY/t9AfwGt+FfxP8mw0tI+G6K53AcRMGfnpWRSf1
         MvWHdsUwRSRwwuusyQUJcg5DUdVoY2yQ8Ae1q/CmfJcAPXKFVXWYgVRy3C/RDYUo1z8E
         lh5A==
X-Forwarded-Encrypted: i=1; AKwUvBz0mqoVe64ZFBqVA2kCx8GPSlhgEb2m+6h3Po9bGR7qOkD0SyeH4TnJWMauSgPIfdGmW8RK4l18cUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUw1YoxB6bZPDl30/+jjGpxSag6p6Zgc3fe3y2IIGC55T5N0XR
	+b6RzaaN7sOgl3SXKEbhNsdPttTWb8mfZejSMW+duxokfu7vBDizlDvXHcFLI9PepJU=
X-Gm-Gg: AYBFou2uZLLf/xoHuPtVDNGFiLDoKFXs4Kld4yuxxWEAliJOx0cZEpY0a71lhenSUpG
	yIBqcKLwXguoYlNGGMqf0AlLBcikZFGyOYppz3pclvS6lW06ZdouS92WaKNyvUH+XyB8D3vVRFq
	TjiGhF3uV5MF50XgKJq6J+PbAWAaJiVhjudodhOVsq9n39g5nN9Q+BWeCBWB569PcmP8oDeVG+a
	n849k/e9M7os5BIp5CJykxO4ITsha7H5IwkZHroOQl/ybEsB72WPM9FHz5N9KheranPn1mJ1eud
	lsQ0varNW3bzTlxWzfq2ZXm+rBmkZ1bDHNgXz9ZiD+/+iG8362Xz5z7EY9sZoBkqSuiD/ZBBWy9
	7QgJpxNwuGKRosuFctoG2le3pCLP1J5u+mctYq/th59R/uvlSwTejZfWPxY+CutXplzaKYKF/Zl
	kkSPfjDteOe8wZcKmKPtkVvKfGKCwpkaoxkz/S9ItiuR/Mukus8tRacqhAfMAvIQEfoYxVb623f
	euimTjVubUSibArVj+bhx5AThICSBQravcEcNOGKPM2sc21Nbnsq25G2fHusPvE6jRyWRFSzBDa
	JHQuf688UlPVBIp2V8k=
X-Received: by 2002:a17:90b:274a:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3adeb0fbb29mr2728664a91.46.1792899870088;
        Sat, 24 Oct 2026 20:44:30 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:29 -0700 (PDT)
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
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2 1/2] ata: pata_artop: read the ATP865 mode register through pci_iomap
Date: Sun, 25 Oct 2026 12:44:09 +0900
Message-ID: <20261025034410.808796-2-daniel@0x0f.com>
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

Tested-by: Florian Fuchs <fuchsfl@gmail.com> # on PX-EH40L (LANDISK HDL-U, ATP865 1191:0009 rev 10)
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/ata/pata_artop.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 9f8d41639a62..7c5e778d19cc 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -390,6 +390,8 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &artop6260_ops,
 	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
+	void __iomem *bmdma;
+	u8 cfg;
 	int rc;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
@@ -406,10 +408,17 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[0] = &info_626x;
 		break;
 	case 2:		/* 6280 or 6280 + fast */
-		if (inb(pci_resource_start(pdev, 4)) & 0x10)
+		bmdma = pci_iomap(pdev, 4, 1);
+		if (!bmdma)
+			return -ENOMEM;
+
+		cfg = ioread8(bmdma);
+		if (cfg & 0x10)
 			ppi[0] = &info_628x_fast;
 		else
 			ppi[0] = &info_628x;
+
+		pci_iounmap(pdev, bmdma);
 		break;
 	}
 
-- 
2.55.0

