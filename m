Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B11396D2A
	for <linux-ide@vger.kernel.org>; Mon,  6 Apr 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506313; cv=none; b=M+fg33BqUQAdtkHDbMIadE5vchHw9S2+5bU8dWM7BeGlwVJ+eNVHXcjEML/zynWC6CekwOKCwsfNxOsd8C5U1Th4Qja1sYg7Vl6srYXIGqnGgfT1PHkqxbRqTO7Cz+bOCProZ9cKV1dkzWKL3yktg8te9GazQoYueUgc4r88EcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506313; c=relaxed/simple;
	bh=SLwPYlMdavEHVHA19lhqHNieZYP7Jq/xPNceZx47loA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDFMzNwnUMEnId3v3nDI/xfZfmnlGv+Ub4KmZ6V2g+lvSN5cX4hUmBV7Y1I5NxX0F3Ak57okswbLXWWLPRcWEQR0nQVSGqWQuHqAMNWZEjRMn5ixxwoPdiXBmdslKVC2Sn+HMTSZZdbub7ZVZ6vQcVohOFn51iTSPwxqmOpZ4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7KwQoDA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7KwQoDA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad4d639db3so18888515ad.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2026 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506311; x=1776111111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GSrkoxT2ZIE3a+5zUsOYWwrgzQCE/3/UMzaGKBr0iU=;
        b=T7KwQoDA8WwOv3wCKgkseRjbhDuxOTyX/lGkHmn9FNkubhfvzWPxey8C8VQgNOMBTJ
         JRhkXe/FQ8mbj6KgwAmSusoilGbHX5O0rNJU4XU2FkL7hQUV4bVwIL1NfIOimf5G8A1i
         qfVH8VOSUQdgSGulBI03nPqAjatjKNFTOwYDwcaZMVqq2OqHMlswMu2FHedBEp7ExDIl
         +iL6509wEezQztlIfUbguJQc1hWbdsGj43FihWIapNcKtrqaK+EemyP3sIm8sQfOHBSr
         jquyKMgcxFh7Yps9NquCa4F1brCY8+jSjf9SHwSza+faE3U4HE4XkKnMHB1qTyWsUpK+
         HrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506311; x=1776111111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GSrkoxT2ZIE3a+5zUsOYWwrgzQCE/3/UMzaGKBr0iU=;
        b=LUKfYY4IvLInSksubzAxL6516uJ0evzlGAsRpmBMmB/bhFXdUFmha1ChZY4H0/dfWh
         EEFm1XtH61GigrE6/7yqSAfovHEwsBj9oPZb7SBTQV7bSsPrtw31MvZh4uLoMHMUn+Le
         V0CC6JGAE2iyDehjjFKz6RM53hXc2GdtqULAqaUjcA3g3ji26rvPZJmHbPSGPSGf02Ug
         Zw/gNrgX9gshqSXlP3JsZRgpEsAT3WzY33ciSTGjD4bvuJ88tzdXckDTxtgu8wn8uYzm
         jzL7TddC4hE+pOUDCxHQBucYOsme77Cg/q6pdkIbJVadQOZiTIFsBUslhkUWne1Rt13K
         f78Q==
X-Gm-Message-State: AOJu0Yzu+L3K1ysGqkZKRbp3ePQ7CX1sZQ+PfgMBNzAYwXD3F0lIyThi
	/UeOU2ttll40HrIDqb6emlr05aFkFPcQS6cyQrRaqnBuXt3Oi/w3S9YUqeLO1ulwSxh1/A==
X-Gm-Gg: AeBDievWpoVAYNqsebD1PeqgmQBSXosrQ3hI+NKkuSFZYEZyfn9M+10ybpTstJO/6W7
	9vl8wPSfj3RoY4XrOiPtB3Lpo6qv3PD4NldCz/QbExTF1YtmFgsvVJSHwajWwmjV51/bPE6TkuK
	vUkp7m10wdeSFo/rGWPMLt5o2deqReeukubx9f5b7odx4TgrxIKdtT9QA+CIPP9URPqfLs51ol9
	K4OADQkARJVjfSVfh5vJHMPvZl3E5NYt0wHohBacroUOZet94Mq993NJA5z0k3WZzgJys47ySLy
	H7MDJh1me3I7Ym4Ps8Bw3455dpdrqcpRtuDJN0Q+9Agc+WZ6zK5RM6tFprvGzXWpGahV9YwMLPY
	60ECngz789AcOzj3U/0k0q/EZ7cup+riwCnhxmxAJAhTicTImxRG0OZyIMb7acrzdHyuPluV3gq
	m50hBklVWwSzeM+TpD3sunjJm4+fF8TEt2UmARkQ==
X-Received: by 2002:a17:903:1ae5:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b281927e08mr135381585ad.43.1775506311395;
        Mon, 06 Apr 2026 13:11:51 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a28edsm189173315ad.58.2026.04.06.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:11:51 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	artmoty@gmail.com
Subject: [PATCH v3] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Mon,  6 Apr 2026 13:11:17 -0700
Message-ID: <20260406201117.363296-1-artmoty@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403050418.50398-1-artmoty@gmail.com>
References: <20260403050418.50398-1-artmoty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
implementation is defective. Under sustained I/O, DMA transfers targeting
addresses above 4GB silently corrupt data -- writes land at incorrect
memory addresses with no errors logged.

The failure pattern is similar to the ASMedia ASM1061 (commit
2073d0e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061
controllers")), which also falsely advertised full 64-bit DMA support.
However, the JMB585 requires a stricter 32-bit DMA mask rather than
43-bit, as corruption occurs with any address above 4GB.

On the Minisforum N5 Pro specifically, the combination of the JMB585's
broken 64-bit DMA with the AMD Family 1Ah (Strix Point) IOMMU causes
silent data corruption that is only detectable via checksumming
filesystems (BTRFS/ZFS scrub). The corruption occurs when 32-bit IOVA
space is exhausted and the kernel transparently switches to 64-bit DMA
addresses.

Add device-specific PCI ID entries for the JMB582 (0x0582) and JMB585
(0x0585) before the generic JMicron class match, using a new board type
that combines AHCI_HFLAG_IGN_IRQ_IF_ERR (preserving existing behavior)
with AHCI_HFLAG_32BIT_ONLY to force 32-bit DMA masks.

Signed-off-by: Arthur Husband <artmoty@gmail.com>
---
 drivers/ata/ahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 931d008..1d73a53 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -68,6 +68,7 @@ enum board_ids {
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
 	board_ahci_avn,
+	board_ahci_jmb585,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
@@ -212,6 +213,15 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_avn_ops,
 	},
+	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
+	[board_ahci_jmb585] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
+				 AHCI_HFLAG_32BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
@@ -439,6 +449,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
 	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
 
+	/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
+	{ PCI_VDEVICE(JMICRON, 0x0582), board_ahci_jmb585 },
+	{ PCI_VDEVICE(JMICRON, 0x0585), board_ahci_jmb585 },
+
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
-- 
2.53.0

