Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01A247288;
	Wed, 30 Jul 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873731; cv=none; b=ZNmmdN6CDlBd27XqmFFCQ+0ifPeUgSKHO8TU19mOaox2gvmH0Pfdc/LRpyofM80kQizlwEftAu27fkZRw0AbQbCfvLggBzzpoS7i/H6kPC3+7Ni+/xP8Hsu0jnnSV6++Up7Vyqo0XUB6mNHXlHqwN2teXQolvROLxh9VkMARKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873731; c=relaxed/simple;
	bh=RoLJnQozFWK43ppspJbYpqg+u7TzOrTIZOodc+YISH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZkOnN6xAu4bRMWFrt8Q0t45JhG4jQzmGJkxAEKhf5vWuHPQeYu4BrXGunMIuEdEc22YXvPaX+GEb7aj+5xCKYHDiEdDsLZdgs2ji8nWoo1gce2I7Jz14rT+nxVcgFPXY0USG/uwv3oIP5P+KcJcq3oYE87amqoZf2Y7JH0/uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSPalW7A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSPalW7A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560d176f97so66650795e9.0;
        Wed, 30 Jul 2025 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753873728; x=1754478528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2q8WrhjBc7VacaHSLhz1rs+M3m5pRzrL7XkZf88Ozwk=;
        b=FSPalW7Ae71JGuTFpdBRbG2OFlZ/Gg6jiHdTV0ytQHiKY/JrD3G7TvXPRY8FXB38lE
         h6bVMcku5KNGJg2NP1fjJGmCXry3Ni8PWkheqBzPscM/lMbl8FfjPecbPKdlJ9hpYW86
         iNiP9eDgCxzbgNP4t6sfcff8NXIWj9mqFCcg125MUKgBJTNMhFkGLNBfuVjnXeiE9KXY
         llRLNyi6C6TAu/TGdCHSIMlc0Hbj1Xe8Ly7EBzE90pUaRAAaUps4LsA/ibY7J47jgcip
         O0+FHpU6krv2T2gI4d3psqy4yB0U3ntcVYGSgmRMEDSOVHRMff+oVKaNWDJWSvDcLHeb
         3aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873728; x=1754478528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2q8WrhjBc7VacaHSLhz1rs+M3m5pRzrL7XkZf88Ozwk=;
        b=p/ggiV/WMEvIMr3NNTRMOaTxXarcsko6A5BqcGQU3GR1FXw2GV8ITe0Tg+8WxSQVRk
         UGXFCPJO+IgNfSorrWrawgO7r2gbrUxlt3qyavzHKDarUATbvKgLLANTecTwM9IkXX3U
         IBld3QEJhFcnHNjCKJ1YqxESJO2WM2k+DjPZol+rgk5g7/QhD8DXsqvIjr8Yxj6S39C2
         4gy/+xcmN536KsIy2bV4uXp6D9/BNikDxEU53/c4mJa6oj7vGsIbVzFpBMo85JZ3H9yQ
         Rx1ETTIwyPVS3gAuU6PT9vHAvxARK4vlLcb8w/ni0edS+a86qB3CoxIaXbNIPetRE7te
         H4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVCzCqy7wmMvqaGyeIx5MQK9n4/wEmd8dq9yxlkduRKRRrLdw2MbicVG4RxbXAEUWzU/4LYHWEqdILjKd41@vger.kernel.org, AJvYcCXBsCosiPcouNzI83JmHrPtG+JhDi7iEC0McVsuVSWd0shT8pysDtdGenS8pyQJ+CfVIb7o/ANR5m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbPcsprI9Xv/KBS2cq6oGdZlobmAwq0XYix2s5cY4RiFHdNh7
	yl9XPexm+iHbTVP4pGmzr7XRsVUhbmEMiylxI04tFHGZEEOPWRJ33HatiH1osbXTKtY=
X-Gm-Gg: ASbGncsDaJyytmiA9HFzVnjGjQxdPtqQvz1LK3fGPpT47sBYcaUGpD2t7ibqL058EOJ
	KTP3+IFMPtcKpRYfSVMcoslfZxiIXyBfnWvovUlPyJ+Y/fRnr3FdjpSNJrhh/l6RBTWxg1Dfrcw
	zMYFN6iTF7aKnVhJP/ArgLpzY/9x6+684wTm4n12pehcHtDbF3fB3F+cuAePYrxtjqr5j+kFr6T
	kGG0M1lu9D1hUWgZlwoo5PktIVxRVtOerBn+UbAE/DspeHT9DWertAvKbhOGGcVbWvVgAe0KAbY
	zT1EbEqeeRBXT37gONW551YtVkyOCWZuw4nzHq7Rui17QCk2LcXFkF8RjIDtL3rag7WE9pGVbGk
	dibAVMZBQdBmiYGLINqve
X-Google-Smtp-Source: AGHT+IEHc7wmGuvWhxpMYD5KIlYCAs0sbsk210txy29GihaENfganDmxAKrvOzif6C3bn4g2V9JjCg==
X-Received: by 2002:a05:600c:5195:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45892b9da2dmr30364905e9.10.1753873727712;
        Wed, 30 Jul 2025 04:08:47 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589536acc9sm22884785e9.6.2025.07.30.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:08:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ata: pata_pdc2027x: Remove space before newline
Date: Wed, 30 Jul 2025 12:08:13 +0100
Message-ID: <20250730110813.2059223-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in handful of ata_port_dbg
messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/pata_pdc2027x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d792ce6d97bf..021b38ed794d 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -295,7 +295,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	}
 
 	/* Set the PIO timing registers using value table for 133MHz */
-	ata_port_dbg(ap, "Set pio regs... \n");
+	ata_port_dbg(ap, "Set pio regs...\n");
 
 	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 	ctcr0 &= 0xffff0000;
@@ -308,7 +308,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
 	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
+	ata_port_dbg(ap, "Set to pio mode[%u]\n", pio);
 }
 
 /**
@@ -341,7 +341,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		}
 
-		ata_port_dbg(ap, "Set udma regs... \n");
+		ata_port_dbg(ap, "Set udma regs...\n");
 
 		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 		ctcr1 &= 0xff000000;
@@ -350,14 +350,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
 		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);
+		ata_port_dbg(ap, "Set to udma mode[%u]\n", udma_mode);
 
 	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
 		   (dma_mode <= XFER_MW_DMA_2)) {
 		/* Set the MDMA timing registers with value table for 133MHz */
 		unsigned int mdma_mode = dma_mode & 0x07;
 
-		ata_port_dbg(ap, "Set mdma regs... \n");
+		ata_port_dbg(ap, "Set mdma regs...\n");
 		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 
 		ctcr0 &= 0x0000ffff;
@@ -366,7 +366,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 
 		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
 
-		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);
+		ata_port_dbg(ap, "Set to mdma mode[%u]\n", mdma_mode);
 	} else {
 		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
 	}
-- 
2.50.0

