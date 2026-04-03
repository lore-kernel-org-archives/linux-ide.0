Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B273624A7
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256802; cv=none; b=D0Qi73Tftlj20/kZ5kaXMaNM3yJUc+0kZWoP65AN0mO3uvuksJuPhiDcb5SKtTpDtnT8lcqyFu0r6In+WcWI4Spyj3/DPUBx5uqfqRdrAR6ILZb+AW8uXEchchtbITwt0XkeRNVhymQFU53G0V1UPu8qrpTwfAcY2M2/quZ28o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256802; c=relaxed/simple;
	bh=eprISpmCG1iTcAbl9gyLBENb03Bt3s33TR+VmRDN2O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfOiccAfhHAzMgQbd+w3vt+/yf/uHK3F8U1/2yoPW97qqQZsnXyNqdRWInqU7bIh/9RaIYewykzTwDOarA5L+EHcXCcPxIN92IqYgLWT7nBsLtR44GK2EdBpqVzEKAKExL08CWVvvSh7i6dTQ054k2brG/dJa98f/Nvzvuil5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlVFUOTz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlVFUOTz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso15112295ad.1
        for <linux-ide@vger.kernel.org>; Fri, 03 Apr 2026 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775256800; x=1775861600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP3I7x1aHfaau206ls0y7NJ32arb32yUHOQgHg/w8ZY=;
        b=OlVFUOTzWbMgCDctERojBw3WkNDdcxmDJWjbU2tLInfHg2FCBUzl9YsfuvYVazbkd2
         8MVHVFQ+oBp2PwfLU6qsbziERFNe5gsZXcb/xqQxJM0SUNcY0rCllOpuSPc31byScIfC
         hF9zNLMKuuL2ViV2yTL7Rbo7SNzbhjZEeJK6fPHWoMDXLXsbdAF8SLpsTRs32zL6mEdt
         Xb2vTPbUdxhTO72xmB6lJ7Gdt5qafaA4EvOlqF4pZ73wp8mvB1Le4Z9V3L8V3SdGvEYo
         9rQ0zjjvtvk9EboXlkXw1dIT2XvuISntC8yG+R6QeRxfvS4Og0qtz6MuhM3vJMxSMpDk
         SZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256800; x=1775861600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vP3I7x1aHfaau206ls0y7NJ32arb32yUHOQgHg/w8ZY=;
        b=K/eoLWKN+YtVb42mRQUbHVXYzR1UB5aTdmZYmTcbWyAlRY/4I7T+B5FLheNnh09/dF
         iQCN6H4tPxH5G3arEKXtJ1QSKw1z6SLag7bAOhRUs9HTBpAokxKJEJ701Lai2aUosN6w
         yXIfC2DrHyg8VM6oUzPKUk9n1fZT5nQN0lBX5FVmZqIxp95EiK6st2C43EWcwxHs5uAx
         XsbwvCmAFiQinN7EX2A2k5AJSx1SRWP7c1iyQd/cWwTeWDVF88gezrn8fgNLLCjjiDkC
         inalYHz94c8O4gxiZeuT+RUF0BW0/PNN+cMiZeGbAocFtQQQdRTSpbadgLEZoC931mY5
         da2A==
X-Gm-Message-State: AOJu0Yx4QuitD8fWRdZhHkzs3T2ussesNyM72QEHtRLkqsqQxeeY1C1A
	qimjP+eVZAzbrj6j0SA0VyOYhoJcUaMU9fjggdES5ttbV4+Z/vYZ6nTC/0xAK3Nhj2s=
X-Gm-Gg: AeBDieu6g5rWQDDF+Apt5wXgNsjmuGeIyQS0tVb2QjoABPDHMqzncBBhNaevDkbeTHG
	V81Lz2JIHqL0BRlPqVVlYQ0STmMnwh34I2p4ddGXLiJ29Dn46yCKrU8/F/6k3l9Z0ricm2eTFZb
	hfTmhSesMzp0wrjcxt40VP5sYUyGOmcSJ5bfw0OmMpEENxAOJ+xuD1yhNQhV1nkeThNLV3XqmkT
	nFbmDWPTSL89XdV7c2U6NByKW7HpKm3jwzt3RkwaSO29KiNCiGdAE3qE0fsVR8FRLMlfHAE2Dt2
	W2hhs3Dx4lyinYtM10TrdEYQXXg5vAs05sco6yT9BaW14XOJPunafTDet7nWff61E2hQ6mqIRqr
	RvNdvGyL0iqK/Tl7Cf50CJm2T5b4yNgL/v+ANOEXZH6pfnlGqi4k4sqaTowspOYjpaoHvmP9tco
	nbmfx21pJIPmJPjR9Rs2oqWycpQQX2YCMrM94N
X-Received: by 2002:a17:903:b0e:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b28186117fmr43241355ad.36.1775256799953;
        Fri, 03 Apr 2026 15:53:19 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749c38adsm84776375ad.69.2026.04.03.15.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:19 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	artmoty@gmail.com
Subject: [PATCH v2] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Fri,  3 Apr 2026 15:53:14 -0700
Message-ID: <20260403225314.96459-1-artmoty@gmail.com>
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
