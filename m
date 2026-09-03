Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556234F27F
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465843; cv=none; b=sO8cU+tqiPiO+Z1ikMi/bCjGTpeFbGEViTYVIyKDoz8hIaaTI8KZljWI2eIIvGuL0iFSl/t/KheJ9/U5rPfI+UYxPcGOq9i+2T9v0YyJG3RKbPaiJTOSU5w2cHalM452+gIzq0Mg+NBKKgWDc2TqlVwK5ZthsWYu8LG9+P17DRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465843; c=relaxed/simple;
	bh=UgkM5lpGshtq4VtTQLh6Kwi7KXhMXI5wrhCP0csoa40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6oBshl76EZh3iFJOR6U7QiqvWTNNiuZjk8AkLgcatNdRj3hudWIKAyTnzySnefNdA6OEoHBULzBrkMlWiWGbT7xri122yvkNdg8hUzajTAl69ggAcUUhNgssRSmFJf9415p0faV77gbR7UPcz1Z4kQn4oUwvGsOgCK7hG+TETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHc3DPJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHc3DPJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4042E1F000E9;
	Thu,  3 Sep 2026 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465835;
	bh=6i0o0MMVctdmn8q9Uc6BstuPd5XzBtpuIfK55cg53Mg=;
	h=From:To:Cc:Subject:Date;
	b=UHc3DPJQKEUaUheOviH9dWWG9nj99diWlKk2zCm6bRzcPKPsXouECTI3VOy0Eyw+t
	 3S3aVe758XE3RcvzBisEx27Ylgznj0nJLUP0yCj/mDLrGjLkRXNbe0hehEYZeqRDMA
	 xUaqhyUY4CMdQaJM8Y/hwurS5DiumnGrEQJSnUH0Ue/g2Xwuz1mBnH5fqG3ulM4gHQ
	 zxuWcUL5mLDmUUZ8sq3zhhQGSYE6/ANcSD/TsiQ0qQOebKQhBM78BnIBbJJ1uOeFxU
	 hCXfoOkCs16z5IkSK9THyIgQFDU7Wdw4b2hAz4zijhJmguWnC93pEO8gStQsdmmuip
	 o4m9j2scelY9A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
	linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY
Date: Thu,  3 Sep 2026 22:03:50 +0200
Message-ID: <20260903200349.1316460-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; i=cassel@kernel.org; h=from:subject; bh=UgkM5lpGshtq4VtTQLh6Kwi7KXhMXI5wrhCP0csoa40=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJmXlra80c02SZ/EwP7d56Jrw79tI0u+yKTdGlG4d9Xh 451Tbvf0VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ8M1h+F8gtTfaW8ZCIPms y8F4Cf3lfFa29cx918+cVtTV2qu5TpGR4dPWeU6120JWxS2TO3FUrKOLWdZhjqZrsc1BvdanM7d 48QMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.

The failure is seen as soon as the ahci driver is probed, and booting with
iommu=off does not solve the problem.

Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
for HBAs that do not support 64-bit addressing.

For HBAs that support 64-bit addressing, the registers are read write,
with a reset value that is Implementation Specific.

When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
addressing, but we are simply setting a 32-bit DMA mask. Thus, in this
case, we need to explicitly clear the registers to 0.

Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6d72eb017b49..3a40ea926588 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -748,11 +748,25 @@ void ahci_start_fis_rx(struct ata_port *ap)
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->cmd_slot_dma >> 16) >> 16,
 		       port_mmio + PORT_LST_ADDR_HI);
+	/*
+	 * On HBAs that do not support 64-bit addressing PxCLBU is read only,
+	 * however, when forcing a HBA that has CAP.S64A in 32-bit only mode,
+	 * the register is RW, and the reset value is Implementation Specific.
+	 */
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_LST_ADDR_HI);
 	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
 
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->rx_fis_dma >> 16) >> 16,
 		       port_mmio + PORT_FIS_ADDR_HI);
+	/*
+	 * On HBAs that do not support 64-bit addressing PxFBU is read only,
+	 * however, when forcing a HBA that has CAP.S64A in 32-bit only mode,
+	 * the register is RW, and the reset value is Implementation Specific.
+	 */
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_FIS_ADDR_HI);
 	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
 
 	/* enable FIS reception */
-- 
2.55.0

