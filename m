Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0A18C933;
	Thu, 31 Jul 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948962; cv=none; b=Yyh0zHfgjLEYnPod3AwGFDoxtHPcWQ5C4L6+gUUhEOCLZ7bX/bT39UEKG85hP40bOHKzxuvIklXcEXnJ6732wrFV/DxE2kBKaCM9rCxI6VBoa5sdpuZsaumVhh3qzmy7S2Z2IcZ+Nj6E9uzmw8fMriM3jmaLkq9HxPuan6hTSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948962; c=relaxed/simple;
	bh=PlGHV2FaRjELuf7o65hmJb8XBrnL3PXiqC/Y2oDVAr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KMTlFNAUYoDd45YpWGtxtt+S/9GNmnN44knPjLfct9tpCiKFflWyXdjkqa8CM+90XpqIk24Dh4/uw0I3TTyZlGTJTqiwp9o3IHA0Yo81UFa+5xH70u+ZSftVrnJu+7LBmhzs2biRbSaGiCPjg9VA2C51EWyyc4YB3MZnR2ZxXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWl09WZY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWl09WZY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b77673fd78so68725f8f.0;
        Thu, 31 Jul 2025 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753948959; x=1754553759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/t3e+x49wtPkWQFIoIWG71R3Sa9zVUVooSjuWeuz04=;
        b=JWl09WZY+3GS/hLxiQnB40ebIPuyyA4CixF8moWEXqtN7pd/FCn+ImmhwxgT3vz/1S
         KLcv19scCNxHJL5ot9oMZopN8+OnfEzD08Js5tOcodLQBc9bCZTKCUoGt8L9euvqC9Je
         JWbvMwVGbnvhM0j1RZ1b0a0Ns2qPvh9bfPYq6i731/DLi4tljx8UWk915p/FbIkozFFI
         +d4V5fNYnSbzkzszIqnr/Bx13C78gzks//CgRnVumYSImuLO+OS1VratRhTKohFRbwbg
         74aSJTMsADfo66tJG3Is6P53DapBNSMH9la6/0HG0chra5tFEMlvhCnScG7CA6Ukf+SY
         9DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948959; x=1754553759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/t3e+x49wtPkWQFIoIWG71R3Sa9zVUVooSjuWeuz04=;
        b=GR0MBkUYFUCI8hV58ZW8R9dSggsVbc3DrJxD/BevK13IPkIjDFCggUHICXEoC3lkpD
         yN5zgO48jdU72ly8lKJwTt2qR/dNv3YWvxLH78Is4R5m2Ery0Gy3ebD7gGpgnGch/qEd
         NFQD/uuHChQWvugh4bK6Elk0GQScw4ou+ysAFZ5ZnaGOZPorZoxcbZTCdZ52q+hgsUjl
         aIckB11wJudu1ucJSOBfYnyiUFT9Ju5GqTfHswIyXGDDAHLD105+VNHQdlWcjWyMCn6f
         MFEPV4B3SNtNP294zOzx8YLm7ivnuRT1vLPc053XbivOcboO4+BYJn6yVL54vXPYmS58
         IzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyRLwWizOzDvRoMh1w09PvU6rSP/usB/Vlu3wq9+oT65ph8+ar/S/6hFoLsNL+0kcTgKDl5X7vkErz3cdR@vger.kernel.org, AJvYcCXB1UIF5Fv5cycG4z5HfxDPbnigiVgeifxZBqDsmI89VdLtsy8sTH5DQthnYa6d9zwp4+4WhuiCl4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XR7zi75MRILRmAimtctQ/r+6nFkzsgAClQgmcWu5s6GI9ktz
	NtKYJP3tUIqm41Jz0WK2Bq8IcxzjSk3wFYeKkn0krTltkNmFrX3NzEt+Cm0TB9kLQ9Tc+A==
X-Gm-Gg: ASbGncuzq36LzMNgV29vdndRFdhXkbiUZdxiVT7TZa+SDRBuezXubWs2yph4Y8LkQ0D
	TyFJMFlnCzJxY2g8ooPkedccg3iESBiu5OvueB5CtKYuPghnmkJGZ7VyR1ZY0If4cA5KpqYbXQW
	JirvXer2fPAK20bW1iyxvRkGD4JUcryLM8Od9JP1FZaIfuRA5ctglXYPFdq8gWSI2r/GuOwfHyv
	CM+XV1B9LHuffwob6kXQzqhXHsdVt1grvesqXYH3r2JBG9PJqA2fW/FoL2wp39PN49XiY9kmWiH
	dGnmfljTR3gBi8J/JyKSPw6Y5v6bBniMj/Pk06RzL/TqUgAyc6egJ15OLq3bDiGIaNeaHqixeyj
	n/+iQDHQ+x8GFi5QHSyDQ
X-Google-Smtp-Source: AGHT+IGbGg2iGs3EXQeEyvQHMksthS8sLUBenVO0pV8N/V9V2SA84vP4SZAFTfECw7Qjzs78F/6clg==
X-Received: by 2002:a05:6000:1788:b0:3b7:9af4:9c75 with SMTP id ffacd0b85a97d-3b79af49ce5mr2004852f8f.30.1753948958834;
        Thu, 31 Jul 2025 01:02:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45895377708sm53368065e9.8.2025.07.31.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:02:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] ata: pata_pdc2027x: Remove space before newline and abbreviations
Date: Thu, 31 Jul 2025 09:02:03 +0100
Message-ID: <20250731080203.2119000-1-colin.i.king@gmail.com>
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
messages. Remove the spaces. Capitalize pio, udma, mdma.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: As per Damien Le Moal's suggestion, capitalize pio, udma, mdma.

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
+	ata_port_dbg(ap, "Set PIO regs...\n");
 
 	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 	ctcr0 &= 0xffff0000;
@@ -308,7 +308,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
 	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
+	ata_port_dbg(ap, "Set to PIO mode[%u]\n", pio);
 }
 
 /**
@@ -341,7 +341,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		}
 
-		ata_port_dbg(ap, "Set udma regs... \n");
+		ata_port_dbg(ap, "Set UDMA regs...\n");
 
 		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 		ctcr1 &= 0xff000000;
@@ -350,14 +350,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
 		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);
+		ata_port_dbg(ap, "Set to UDMA mode[%u]\n", udma_mode);
 
 	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
 		   (dma_mode <= XFER_MW_DMA_2)) {
 		/* Set the MDMA timing registers with value table for 133MHz */
 		unsigned int mdma_mode = dma_mode & 0x07;
 
-		ata_port_dbg(ap, "Set mdma regs... \n");
+		ata_port_dbg(ap, "Set MDMA regs...\n");
 		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 
 		ctcr0 &= 0x0000ffff;
@@ -366,7 +366,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 
 		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
 
-		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);
+		ata_port_dbg(ap, "Set to MDMA mode[%u]\n", mdma_mode);
 	} else {
 		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
 	}
-- 
2.50.0

