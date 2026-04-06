Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7A23507C
	for <linux-ide@vger.kernel.org>; Mon,  6 Apr 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514185; cv=none; b=ZBFiJNnozrVDDffW/crwYyV6HZ+vwjxiZd5HqhDqvOSeMjInQih1607P/YYlsrrU59DXnQb3jwTKaCSjM4qKRHScqKrF0d/ACIFpgvbvboKb9CHK+StvO7Xxw7uz9AtOdpvHGqcozmrvCijzw6qPNypE412eankrl+438DtSPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514185; c=relaxed/simple;
	bh=FBGeKsEKgmK468WF/uQFjeu2VcbpjwMhz5a1w8dG/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Je303NZbjv8VKzrQRYjVS2kH8jWNHWq21WfQGViQageXrl/WobWJPuNA/WZzye5IOC93GaDSibLojh1c1D1IqbrEKO7o7Z4vG8+teIMGIfdY4VxVY9CgtO0aFc2eTopyoBpDHIG1aAlfJXCpDkf0MhkWMjq2ykIWomN7ZWRNRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uan6ySMx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uan6ySMx"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so1841183b3a.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2026 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514184; x=1776118984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tvG7zaMP8EBK8sBcZa5o7Nyoh4bOnh2CmWTEXPpn0Q=;
        b=Uan6ySMxzaLC+RaBvHcJdszQRiYMFFykSA0SH/yodqugz5r5DRbc15nQoD5wg/8feW
         hmM24ZJUwwjPgLA6KhmlnwTaJao5YWIsSi5pRaw3WcyhkZIjKpp8AJJjow6S0xKkSpbL
         gpz/zFG+LGz0iIfC87Nz0cGjUfsDNEMfZgkXdfTVY3iQLfv3/DSpW2Ac8X6cTx0vRiRv
         mym0VBLQwOjJg4fUuw6J3pghA0/fqJMbBnJ7Hs4zxAvBZde3WU/e51G3bxgqX843BCqS
         J3cHlwKB7ZgSRPIVRy6qHeesJakYYOtzDyLF+bl4jtB2bBFe9JSfHrPS2ecGftwy14Bx
         v7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514184; x=1776118984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tvG7zaMP8EBK8sBcZa5o7Nyoh4bOnh2CmWTEXPpn0Q=;
        b=eqTgwza1VroPiuki1VbPYuTkpVnB6Hp4u/OZ05WPMPFLlI1MoUhavalZ4ulPzMNsie
         CQ3MYq2vB3Gt3pfc7DxJuZDWXTpO8mXhKBTZASDhr8JeEsdb+mit4cuolj5HvSDLzAPC
         w/md4maq7lu+VgMOOe2So0K28OoknULQ0xSusCNGJtHQEDj5A201u+5RsSLHxtfQuMT4
         Tqq+LOeErVh4NkEqDnPXzmab0zX95AVUp0xSS5EcjoDHcCq8pY173+KXpnLUhnmmlyK4
         xlSF34pSgGTsCggcGCOrs3XcP6HiPdqz2PPrhb6J6M7hVtRmRfqj95IrUdFDqH9ynhU7
         suhA==
X-Gm-Message-State: AOJu0Yy5rwcxIkLAzx4y/5AaW6gCbVeoei+ivle9/MfqrDFBew2nCfYg
	xc0+xlJTparEazcLDFckqkrONX9Xkaxy12vUQF7AMh92YzWhQCFWT3DUkQjFBK+qw8+WGw==
X-Gm-Gg: AeBDieu7ywwTWjJVijrJAnxQTd4lBS1gfgrsWdUyDXQoxgzA0/DGVlDUMD+gr+IdZ3+
	65VeSvW24vKKhZ9R81szTN7wwjphtTH4ofTLgtFJ0UdVXl7QYwgdZ/Aq1JKYbIrtUtxuE3L3hqY
	sLyD/SiFFN7i8tZuD0+6uleDAEE78w1CG3LguKw/mT3pBSI+T+FNS1h1lGsos3TsFi3AoBSrQyE
	fZkzeAoEy7579bsW4kqUrXEoOI7msKSmv6pSAvbFWBv9/SRKKIqp4/T1MeKt7y9t9ExbIW3H2eU
	0juW++o1Kpc0EienJ0Ch938bvNYp/0yOHFsJpCPCt35lQFqr3WS5ZlwUaff074VTFPSQX9KQIb5
	3cnn/EwvKT3tffzeWta6YwG9b/lauqO6BIvVsIwtQFverXyCC8BQhq2ey9eGOMODQsZRF9YDVV5
	wZiaJzBMkNQ4iwPQjUnunL1EA1pgTYuqhJ+BpSqg==
X-Received: by 2002:a05:6a00:22c4:b0:82a:6b97:34a7 with SMTP id d2e1a72fcca58-82d0dbb3246mr16519777b3a.39.1775514183860;
        Mon, 06 Apr 2026 15:23:03 -0700 (PDT)
Received: from fedora.mshome.net ([162.247.45.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca14b3sm17408986b3a.54.2026.04.06.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:03 -0700 (PDT)
From: Arthur Husband <artmoty@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	Arthur Husband <artmoty@gmail.com>
Subject: [PATCH v4] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Mon,  6 Apr 2026 15:22:57 -0700
Message-ID: <20260406222257.379703-1-artmoty@gmail.com>
X-Mailer: git-send-email 2.53.0
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

