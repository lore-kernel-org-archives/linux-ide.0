Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B135C1B5
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564332; cv=none; b=VqZAvzUdMDfErPQmPsgTzGtUrnkWtiIRkvslVUs8VviT+BAu4gYfofXRwPgwm8TL/G5bcJqJZcILgSK7Ra0HonFfjiCbK/VmYI9+DhZwhDXTMnblesVFK3vqyKmAXaKSbRXILOLH31SP9N5gZywsbZI4qGtWWD03/7q7Sp+zaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564332; c=relaxed/simple;
	bh=FFhvi3eKrkE4G789Snz08i/HdQMFrqRe72TBATuHHLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3svfaSWL8NYsn1rY6prWiNECXhdQxffpuNoB1miRScsP9zrqiFC7sCGCq4+/gWRILNVy4rP2Iva8WLyxj9YJcHGe0ze1urt5Q2Qtve98yeYj6jSRSxDVGArHf3CYS5C4t/gr2QNba6YT2Lyrm1hbAtBE/bWCzEBNeVFJOJSu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHAQ84vB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHAQ84vB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8482074a000so1152665b3a.0
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564329; x=1784169129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZG0vOQBo+nL6M7xPLYpjT9WudAim/g/N78fOZlycf50=;
        b=cHAQ84vB7KJMZu0D24URt8kkZeymV6d7gsms35Aa+p+Bz9RyoRYHw+GwFpkaZLX8Kt
         0ckr9QBP12/taLPNJGvxHRwONUVlpzcuEReHQPlmr+eV7SdhJSZSWX2p7Z7aQoxcoCoA
         i8eFaU7t4HZ8GvtsvSDHhuKlWXnhUJ7oT+RNUOWOWMdRBKNg8HekO+gGhs7LytcBgVdU
         /NBAXEPjlnDbp+Eg7fG6BJv0ywSqbSpJHjxZhnY2FoUyOyStrZmMDG8WLcC719ly2IE8
         0XOf13oQvaH94c5oeOhFAnwCgTOyirO3IcYqwvmnqBsJdBx+SotXrHmNm0isGI37ETEj
         WiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564329; x=1784169129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZG0vOQBo+nL6M7xPLYpjT9WudAim/g/N78fOZlycf50=;
        b=Xkj3XNpakU74uAjbuKyQVcN3TUjOFmgouW9/82qZpDi8AI6zZj08hlmUSpVAPxAjtU
         EpqiDF3FFQtoGSMenplDf9wL3HRZxmSbpOAtjj7iZS5zOjQuHRra8G5E+vD3TfkTMMP5
         YlRvbiFo4MDhrp9E24Z33IJ9XEeA/JH8TGjVWQg/5++qS3fZgrn/cTvAMk6/Fjx5203w
         o4pY1TjGvidrxyUylCadB/7SUbRMUhO1mcuR+3KK9d/mTjOWQM+5MQ1vFLLFK7to4ee3
         kidulJ4gLoacciTWdMyUwKlvVTrRKcHswvk9nTUkP3s1XicG54mu7wDv9lC2s0J6pq/4
         VQIA==
X-Gm-Message-State: AOJu0YxYP6FddzNCiPSdWe6GAqNTUmU3cwJCcdKk1Jm2qZmUJWJ/IW+w
	Bdfqy/HDLOAhso7KJxPqJ/AZ5xgU1x3uM5YROcdbQNKKxHPz6obVqS1YHH0COg==
X-Gm-Gg: AfdE7cnkagfna1wfqcy8XEyAJE+qVzcjbyJlIK9ex265pHBAkckc/jfV7t4rlDwFUTS
	8SkO4HzIkThfzraVy6DFjwd3qU+viAe+HFjEVfow0eXA8sbHtzupbfTsF+P7wBun/SjzPDr248o
	NPCz0Yrin1o9VfVxt4O/iLt9ysQhwP69DgLoIkSnHAuwy4eQYxE0eQNPJeonmOnJUOphvXUMnyC
	ILQ6hG5UdMmOx+tTkt3FHsvFIKZQXdx9qdhHuwsQJPvjq0LvNmzQZNEOmnYL6K1ADfXOSZ2+urC
	3rRy5Z5k2O8ltIUiuTz81HbEp/5yN3PE8P0VVUjD7s2mIIRpFVmlS2rB+fwPIIH+pDg2eCmvE5v
	2PYlHJyBRiMFZXbl0+moIiSGglg6nGuP1hqzlZkjTmvkAiV7qn69lNn+rFb+xa25diLivQLbex7
	XiYpMBpk5NpCbWc+2ooI8Fy+unc6jt7WxjFiHp1nnyeA+xFgf26UXJMCk0wLi3C8va3zrP9Cg2N
	VNqi21g8nsRgfaDLDA0nAsdiuOnskamVoGZ3gGZs8PGfzLebZ/7RR6zPq8fbvnTvg==
X-Received: by 2002:a05:6a00:3996:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-8484302c747mr4865759b3a.23.1783564329021;
        Wed, 08 Jul 2026 19:32:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 3/5] ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
Date: Wed,  8 Jul 2026 19:32:00 -0700
Message-ID: <20260709023202.2132165-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709023202.2132165-1-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear_interrupt_bit() ignores the bit argument and performs a
read-write-back of the entire INTPR register.  If INTPR uses standard
Write-1-to-Clear semantics, this clears every pending interrupt bit,
not just the intended one.  Coalesced interrupts (e.g. DMAT + NEWFP)
would be cleared together, silently losing the second event.

Write only the specific bit to clear so that other pending interrupts
are preserved.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e206fbf6d2e9..097b060a9ee6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -394,8 +394,7 @@ static void clear_serror(struct ata_port *ap)
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
 {
-	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
-			sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr, bit);
 }
 
 static u32 qcmd_tag_to_mask(u8 tag)
-- 
2.55.0

