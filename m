Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029721D3E2
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192551; cv=none; b=o1a/mFoG6QtiAJs2e+4GGcivfI8GwuuuCfOC4cogYA9VHVyl4Em9U5PjM3ZBiykyfeuOyxzlwjgv9fs2Kn00G3tJlEn0OnWMX2IqUcljtS0+1LmnRcFS6oQG7njNnrdrbsKorh547LmIX9RpKEkSyCI3EDUb3FPqVdU/mS+VgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192551; c=relaxed/simple;
	bh=/J8Dk+15CoPVwvQ5zpJCvKyzltAy68rBMdxiNp3NfdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXiaHNndhct/Fy6kfrhIwVLVdhQEjaC+L/TL7zbAVsJB3kPst+Uz+y85IClHWzQWf6/LQU0LJQygAU2wOVpZC903bIpaXMtCbXDo9rlSk6kKA/zwWqyhWoyyJtE3tm46cLU+mJ7QM68/FxeyoJlaVBo+9lAHcLNtY+qEUXQpgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsIMsmsH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsIMsmsH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82735a41920so529229b3a.2
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775192549; x=1775797349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKILOFg9YAfsEbzFmLOhd2asEpRl6q3Ra+XKpwUTfXU=;
        b=MsIMsmsHoF6WgGhB00bCwV1cLwhgkb14X0eI4Wm8ddWj8tDJSqTJNgHu+MYwtoReXC
         BLE2/rQPP3IaGPGKvCqoHYlgHLi7OCM4QVLN9nC5C7UXnzPCo24aY9R9DFs/v6NlSFtQ
         O8m5oceduwBYi/ga3MX7o5Fq1yESmOA6HPujJTcc3MIpB5m1iYdeTCPqvOYpi/knOU2u
         9Eudi62T3u05fNTzpGSU5oixNv309flkYcPSdGw6+/l0uQGMJ80AbYk/kE8HtUcwu/WH
         yMBFfU0UEUHN6WdrnuEUGIx3Jd3W+R8clF6z4yWIig2Db5A+Gpt0NeX0r9FVZxU41RVF
         tFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775192549; x=1775797349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKILOFg9YAfsEbzFmLOhd2asEpRl6q3Ra+XKpwUTfXU=;
        b=UWCoMDRfTFIKuDZls53FdmUT0044kkIhqRnWLJlIW/a7ucaENWL1S/vpqBqd4rWyyN
         PmjKQ2gZsKuLoVgO1d2PIPs23pvycf5x2D9NKNRFUCtQ3BXU30YiLFTtoXw9URwS8/ng
         AfW1l9qdzGc/3DTX9qTjgImXQhWg2sxi6kGRQdDrm6reBnzBUgi6q2I0ZV7yHNe4yDh/
         N58QnSHOLbIWaavaGZm+UP9dvr6YQ1KHrFDeLRfvEHpEXnrd0iBzoo/NFNByzE6fL05Z
         2u1nbPri9iYrzy896iq1AXfTfZlxxh31PT1xnR/M+17Ja0I7Wc3IdxsAmj42W+DbWUYJ
         DOyg==
X-Gm-Message-State: AOJu0Yzw8drJqAuWFL3cNTreg0Ggo3sBHJejKlh/qCqQFYzFHxOdQgxY
	UW9fKejut070tRK79ZcA9xgpJM/twLI14KEvC6UJqvWJX00cuWLTxVXm+Tx5jjVT
X-Gm-Gg: ATEYQzyPpHfF0RcEWMnjOOIkG7pt5QWt3ygZffREtReDR3FWmhpd0UOs6BD9SG5tzFS
	8925jwryNy77OTytzQpRT69+XvRi0k7WErznXD+pNS4iuNOtFWI1Z3ndn6YVytN9qUMcNRtxtr6
	9O7twnPTHl2uFWgJRAtnkizO0FqCPG1KcRjdY0jUmJZpwKbjLPAwzphlLEOe4Godr5SYGJXoTxB
	a8NC36VrFiI1MTHtIdVT497bFc7evSBgIKz2w3GR/EMUDMEokjENmanAl/TJcFyMNvVkIbes3Cp
	p95nWm08wc8RFg1Q1YYq4PcmR3+UsMzOhqMXm6Ybfbya6QdJqdyWra1jww63trrkN04LCNVrayV
	tCNpTpqHgaSu1PZkYyP+HhtF5NxVYi7Saep6Omt4jjG+h9vl0R6UvAwm/jOW7KtU8pqPC5XEtBY
	3LPQjeCTHUbEY7FKyt24X08MxhBYcnYJSHfmyRIg==
X-Received: by 2002:a05:6a00:1bce:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-82d0da99535mr1663583b3a.15.1775192548965;
        Thu, 02 Apr 2026 22:02:28 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbf6sm5101176b3a.52.2026.04.02.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:02:28 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: artmoty@gmail.com
Subject: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Thu,  2 Apr 2026 22:02:22 -0700
Message-ID: <20260403050225.50186-1-artmoty@gmail.com>
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
addresses above 4GB silently corrupt data — writes land at incorrect
memory addresses with no errors logged.

This has been confirmed on multiple platforms (Minisforum N5 Pro,
Raspberry Pi, Unraid, Proxmox, TrueNAS) and is consistent with the
controller truncating or mishandling upper address bits during 64-bit
DMA transactions.

The failure pattern is identical to the ASMedia ASM1062 (commit
edb96a15dc18), which also falsely advertised 64-bit DMA and was fixed
with AHCI_HFLAG_32BIT_ONLY.

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

Investigation and patch development assisted by Claude (Anthropic AI).

Signed-off-by: Arthur Husband <artmoty@gmail.com>
---
 drivers/ata/ahci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {
 	board_ahci,
 	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
+	board_ahci_jmb585,
 	board_ahci_no_debounce_delay,
 	board_ahci_no_msi,
 	/*
@@ -115,6 +116,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
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
 	[board_ahci_no_debounce_delay] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
@@ -XXX,7 +XXX,12 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	...

-	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
+	/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
+	{ PCI_VDEVICE(JMICRON, 0x0582), board_ahci_jmb585 },
+	{ PCI_VDEVICE(JMICRON, 0x0585), board_ahci_jmb585 },
+
+	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },

--
