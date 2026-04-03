Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230F1A23A6
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192663; cv=none; b=Q3VqfwjGYLm5QQvV16ZsOscpMuo+KdIKwLdOizTnXBllH1qV7IPalM/0krI1u52r/4qTATchMZn+85SH0Yz/FEgPTzv+IKCvSsBehHQZmzy8WiVujqa+RsfbynuFqF/ZzE62mbNVTB1ihAYyrQTnIlmiGrW4Ctit9Jc3W9HTGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192663; c=relaxed/simple;
	bh=/J8Dk+15CoPVwvQ5zpJCvKyzltAy68rBMdxiNp3NfdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kl2/dPkmeu3Ail3UEgHI9W1lh6UE3/zyfucjZL4fdgIGvYzfszXh9X2b1rrdHzZpGUcfezmGkKWOdS/BcIMP8+Bivfdci4BHdQqiVmnhwq2pxCSuJEUjOOXP5N8IkbXUiwrOA/nnV7AGW2ASGA0GRFONuCKCio9e+dI507Jzq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJtG3OfE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJtG3OfE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8fba3f769so6320985ad.2
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 22:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775192662; x=1775797462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKILOFg9YAfsEbzFmLOhd2asEpRl6q3Ra+XKpwUTfXU=;
        b=bJtG3OfEoD3QY3Ztk8eBma0XclODpwShjxXi+vn6uHqdw2kEzxf+LK+QAroCre3v2A
         CXX7FB7gkANJitvJuY+eQujbSUe2Bv20lzNn9Q7yDITnvwGhx5xJk/TAESadOsE4MpcA
         oY6oijeZo8RTWIvXxrDdRFHrkaCdd2J5VEhX/791lzC1ypwNM/oWXqG1nWUWDpxiiNTZ
         3bzgTmc7JLyz3ACpt6jRqNR42Fag7UdpJ+mDsnZneoGtl9K+Dz7aJj7KWdiOOQiUp4CH
         aDuyXnL5zBl5AthOA4Orn0/yBWoPv1mCs5coFfY95TBnh9ftPlvGdRh293LZnC/Vn+/o
         GZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775192662; x=1775797462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKILOFg9YAfsEbzFmLOhd2asEpRl6q3Ra+XKpwUTfXU=;
        b=DowjQkEYvTxh74rXQzdgkEnH37SWVcSJ9WsDSi9dWkDv1r7dKp/BhEWZZ/bvC6EnF6
         g2tbe/FVDXI6/7uhlRmu9ECeZDCEEoy52+BO5qgu9m8ZSqdPacj8Z1rWquvkMrWlhLUt
         uyOzNFPIAqTPOe2Nopq9LnXXGmH+6XOC1CV3k/HM9mcau6HbwdiWXjZw5j97ymu77fDO
         S0EdahCRa1f6g+8wFcD2yeqszNc9/W2Kv3e/tFUTgBeSfTflRfFgjL2lhA1QrLa0cT4C
         1jVXbsdx7oZyli1VaeOYnnCOoslBBPWr89EQq2dBaen2HJOSnPsfcAjD6cAhx8f+AEA+
         GHCA==
X-Gm-Message-State: AOJu0YxRyxqUq5V4hkpkyk5ieOFlHcN4iuCxNrj7HG2pouP9+IvZ5m4S
	IcHIxb4GK7k0BdGNnDwvz1T+hEwQVxl4lmnoArprG4PLR3ni0wmdcK+xHSFq0JeIWBE=
X-Gm-Gg: AeBDies1tEHQpNR7KENSljagDyYMQokOxCRXSGE7M/fZO2DdkgT0wBcj/9msDmAIvgZ
	ptdAxfl1vpPpKfxSAJssLaN/7cRtYaCIoP2L9QqgsQ2mKbEKejkumELSSXXczyIXGSjw+s+J0sF
	1Mo2Uza2h4D/pGv0cs3dFs/IRChn3pn68SrB9LJ3Idtm/HTvLqLhN3P6PFHyHCbeZ8FD/BhBka5
	2iY/43qVKabu0diT5aZpzJu927eGqsPwoOEp5UD89yA6J7tQIzACAoSEOFhgOahKH1GbVCVpz7j
	ap/c/xuPTdvFLxEXQ371AAZElZmOQY+cEbM8y7+p/PSDftOQrrF2hi6m01rtWXY3s7l9dxQneqg
	ToIZVz8kg+HzjMeMwBXgtvRGfhMsjcpKNGHhKUA4Z6+eJCL1FCHy5IuD2kzwu2VSnIG3eLDU5xL
	7UQ+lnh5CSCmNZvDXSRpb75wicdjhD6oXfwNy4LA==
X-Received: by 2002:a17:902:f548:b0:2b2:6b58:930c with SMTP id d9443c01a7336-2b28171632bmr21104505ad.9.1775192661686;
        Thu, 02 Apr 2026 22:04:21 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27473583dsm44498175ad.9.2026.04.02.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:04:21 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	artmoty@gmail.com
Subject: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Thu,  2 Apr 2026 22:04:18 -0700
Message-ID: <20260403050418.50398-1-artmoty@gmail.com>
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
