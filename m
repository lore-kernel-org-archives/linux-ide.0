Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773535959
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243894; cv=none; b=IDrMabe4y/CQPDf467iNWosKdRiAlsYTyqCZ+6DwUs9WqdxOGGZ+KS5CKHUlH/rizsG1PAPP6BJsLv2bK6Jq8a1b0oSMN24iB1m2Yua1wyXR71sWuqWtMuqLZN0tCUFDIRv4vkSTfrxTSUZ4MCgcpjKGlZrHtpsWY3Z7LJPMgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243894; c=relaxed/simple;
	bh=5sd9w7DTFLwnnM8zr9LPq3i9lqiC1rsiJtfUfVeUPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3mHQAFm4Md6bAYy40jC+gpqWOjPldNltRsG0QxwWjuMfyiPvab5ySOXWP7a4Xx2e35aMn2yYVwMZ1z4/R7QMBo/7vHPpAERclu9FowOMNupunm7uVzHZyQP5JAAwJRhlK8Z3h4Wlx/pNeIaZ5az8lh60XwwmOJ3mGsYGIaEKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpR/XBh5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpR/XBh5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c1a131946so1936472a91.0
        for <linux-ide@vger.kernel.org>; Fri, 03 Apr 2026 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775243892; x=1775848692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3Py0yQ8XkKI1xOrPOMiuCndItMurIJRFpDl731cy6E=;
        b=WpR/XBh5HUr/0+66xcUgYud0zXSNWSO7ipSSwC3RzpY+C/YFapp8Yt/ZZCU9H7s49z
         caySmA+aJbWfEWon4Ntv8Eofjpm7kFKvT/p/IjejdUoyEFhLqLb81uJVBSJ0MhxszO9Y
         Fzqf9qVX1Q5mRG4K/9tdxGQvdc0iwt2nirxWSdcWfKzqTMuC0gpYLOXsovqoLojLwG4z
         jANx4+OyFQVpCKTyiyVRhPEaF0SYjPK3vlgMvh3Rys5qfmy90iPX4JRN1h1obLd3/xUQ
         0lXFTwz81aIsyp7yhC6qLzKgSNm4mT8fsOKlb5Ut1r51pK/fa+hTe2hN74XCA+k5hLJ+
         thQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775243892; x=1775848692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3Py0yQ8XkKI1xOrPOMiuCndItMurIJRFpDl731cy6E=;
        b=gRFd9cHAnKkHksf08H5bC+eBSPkFSAN/ASUFTT8RZ97xRZa+znKTMwoRic/Isi3b9+
         gjjIFWQgzGUacecAKcBNPEhoh+SvOD9R9z7ilm4kQ+qzSxCm+v9Oe1uZRG02oSKUwi1M
         +fz70cz/BJn0awCIfCfAeXN3rmm1CxtCYA4rJNpb/DpcBRJWw+eUXCKyUUNbB8wP1ZId
         VIh62YoiKNhi/u3uiUkRJCTK3PIipuSYdsPsvVX3tSIdsGJtUnMRbXeZPXy7du6I7AC4
         qCASDlGWutjJSOiZ/Y0GUygcsUpDY9fgnLitTNUl0mUrrtQfs3jUQ8uNUjVEgIkx33Cc
         HfEg==
X-Gm-Message-State: AOJu0YxqLydPAwfCMLVx1tx6w5tqkPt+xzyY1rh6rto6FSR2GCc6iMF5
	WbPo1Bo7HDD909NdVpbKi5KIHx1l/ONpGa11Yi7ZCjKd4QiIcgu91zJa77mt9Q/HyiM=
X-Gm-Gg: AeBDieteTNAyYU44hrnRH6lb87kC0LARXm/Cwec7ziDFP12bQkkyY1nXuyAHQCeTjbL
	q1i8l74ILcVcqTaBAEcYZShW1bWsd9Yuzkb40zu2ClhEq78iBPBy5NHfqW5R6VbldusBI6vXX1x
	avxtMUor5H9ZxqiCBzdTmGs2VW5P4u51IPX5CvzYpEk2UsuPMx0V+gQIPjFFHEvqtL6Ys7ihwTI
	B03zdKgIgxjGYaImufToCnGwEDuLqv1SMYqGHv/YUjqYPVBli8EmvxMzVRZfPdtwR1KB4ykMMfB
	qUHNF9/oxfV4FLsqSZCS9fX/ydkXRVeWUXJEXiWaS1nmglwAEed5qAA+K1jReO++PaymxqI4oDV
	p1QmACXpC6Ka+jHev/LRedmsOdE23hp2u4ZJZnr+Aro8TXtA4Z3WoWYKZeCiGoOfH40Ss8b1FCB
	DTe1Wq3DbQu46KJQ02w8COccgI8uX9QE3My85c
X-Received: by 2002:a17:902:f709:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2b277e36491mr67612025ad.14.1775243892036;
        Fri, 03 Apr 2026 12:18:12 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c0f3sm66964105ad.41.2026.04.03.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:18:11 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	artmoty@gmail.com
Subject: [PATCH v2] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Fri,  3 Apr 2026 12:17:52 -0700
Message-ID: <20260403191801.79888-1-artmoty@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403050418.50398-1-artmoty@gmail.com>
References: <20260403050418.50398-1-artmoty@gmail.com>
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
 drivers/ata/ahci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {

 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
 	board_ahci_avn,
+	board_ahci_jmb585,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
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
