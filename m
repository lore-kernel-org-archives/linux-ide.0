Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C339EF2D
	for <linux-ide@vger.kernel.org>; Mon,  6 Apr 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514220; cv=none; b=jwCWoE7Pv0/4b61mgP4znRNYzA1kMTuBDBNp9jH2d0ORZKUiMQWGy5hsy8Lr5/8Bk++Mzv4C8yHSc7VMDmX50HvOdjrc7vflGbI/G4w2a0RqZwuR+MXv9P/aG4DlJ5mVl7Oxe0oZfvltlryz/kyb0WUzmI8pNQCirHbmc9ltizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514220; c=relaxed/simple;
	bh=Db+cRtJvu7wEHGVwhAS2GtqlATXvMbLCXIjYTeQMGbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vi4pLqn4XiE9xzho0EerQE3bSGnzht2lIE8FEGqu4bDOcXdZTdBw+tl9MGcvLfaYcLYYh4PAOXV77M9MAsQk99oIRx/0oc+y0WwSzEXXdHNlGcSfbP/bPs3flbe2Ztxy0K0c0faPsMj0qtFF37cBmd0uctjmovnfUmF4kMUxHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/TZj9fq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/TZj9fq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9a9be502so28468315ad.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2026 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514217; x=1776119017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9vtXYEIisJI64nWmZWeIB3JWuYBghhKEQTGq27IxR0=;
        b=T/TZj9fqCKvIWV9r6tZgGkezG0PFlxFu2h6tYzPXqN/fF3hYohgLmBzxWjwxIL/ilI
         dq9vAMocitKnCeaVSm0CeLGc34DmM2iG/Up8X84iZffcPdYyrIXlGe708egWLl5kcFno
         AOQLXyBgtIr+TO9vrA2Sk8q7f75gUe+zXy867zIsFqAqOcSgmSbERvYyVeO5pmPDT72r
         VmqCUTR/XjHY4ynaPnaldnhdYri7RqfJxXxTCbPO8X0wLl2pfoVYZW2vZJ0d90OSPHjN
         Q1E+e/1gg/yt3qVk58p3F0m6ldTe/otZRpNeAfW3EnWW5Q2S92O2qFGRnvp7KJDHf4LJ
         bLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514217; x=1776119017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vtXYEIisJI64nWmZWeIB3JWuYBghhKEQTGq27IxR0=;
        b=obpDsVtCJyL65XZJU7VccxSy3299Mtci1EWnbYhWUQzAsQLBThAAKY9rJrr7BfP8Vt
         AEib+P1IT3z/uBICBqZghP43iVeXitjmfehacw1I6nSM31CZ9Gm3zNA3Bnx84wZPaM0O
         ZYjgJZkmL1/D+WLCBE63/d7tsP8Hisqogmm0PGOvxVd2SaiBqvOx7rFZQyGdpdR2S0N/
         OxwZij+dV8Fx8eQuQRnQ3tQoEx6WRyjOwlqI1fXkSFwm9mBFqPBh/cSZvSs8W9H6jolj
         8bErMMp0LOlb1ACDRFYs+UKFO3UE1D4aFkojFkaSqlfBHnCHrF6ASosK/DUiz++l7hYP
         lO/w==
X-Gm-Message-State: AOJu0YzPJx5dxcHxmcQG4ct592SCh6zP/s1k8R4MRXba8PukA/Kuv/Y3
	Aw/KsntEBfbbX2+e9wdjGaoL8jaioIYlWMqG084pu4u6lpLhZiJksniaSeqKzZgTBBJJDg==
X-Gm-Gg: AeBDietDYuqCAd+93mpsmG8rCwgHnPCUL0YQQ+xo1NqL3QhiiEVLFzxPShAHPSLYcmo
	57xdU4eWBOl+6hRJ/M6DNZkAVZaaa/uPNFfsajiCRCD5fvrD11oSdySNNBlADzK+1yERPHBJUhR
	JXcXJrDtR6EOR37KXmVABcEIdnT4Yidl5CsGYyyiNakC9b33LuGILYI9NBlXXwd1+5KnViyr6ZN
	FEFz1n6Az2Ktj/gSLteAsZzJKB9UxkKusc4Sg/6+GAY7CK2ddNGBpNhehVWrcPSylOUxtfXk27s
	lLdIP2+7U2vTu5oL61ZO83CVj6SuRPfjZ7GU2iOtR1W1Hlmdhj+Fj8Nj3Te76/tGEFt/BSoTDOz
	kG8LrrFdbDLQcXBwhpTYlf453+gguqM0kxchv5xyV4DZlkxk0gMyiYZXs+eTpIQKw2H+qSyO+RP
	iMp4d+QT+apT/hUTWR5ySIHZNL+qyxaMLbQ2agOQ==
X-Received: by 2002:a17:902:f541:b0:2b0:ac1e:973a with SMTP id d9443c01a7336-2b281889a3dmr138022795ad.39.1775514216875;
        Mon, 06 Apr 2026 15:23:36 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm193260945ad.27.2026.04.06.15.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:36 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	Arthur Husband <artmoty@gmail.com>
Subject: [PATCH v4] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Mon,  6 Apr 2026 15:23:35 -0700
Message-ID: <20260406222335.379935-1-artmoty@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
implementation is defective. Under sustained I/O, DMA transfers targeting
addresses above 4GB silently corrupt data -- writes land at incorrect
memory addresses with no errors logged.

The failure pattern is similar to the ASMedia ASM1061
(commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
ASM1061 controllers")), which also falsely advertised full 64-bit DMA
support. However, the JMB585 requires a stricter 32-bit DMA mask rather
than 43-bit, as corruption occurs with any address above 4GB.

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
Changes since v3:
- Fixed commit reference hash (was transposed: 2073d vs 20730)
- Reflowed paragraph so commit reference passes checkpatch

No code changes from v3. Please disregard v3 in favour of this
version — the typo in the commit hash slipped through my review.

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

