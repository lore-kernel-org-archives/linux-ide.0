Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A963610C
	for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612054; cv=none; b=JOuK9paAunU3s0ovkpu8/3yTIXL/gCXX5eo5lI0LZyESd4tBOo3+WDb9s16FhZe23LaqKKWbDhN6QmbSta+52k90mrd2cBcuf1+z/Cg9cYMsfa7gH4DBYhOSxL8v7WpjlX5EK8bd45n4rMIddg0TPVK0/30d6KC6Bh+nj6fnFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612054; c=relaxed/simple;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pM3HF+fIUpqZ+Zcv2c93ZMQS2/X56Dhrpo8ow+y+CUqwJMfL2ebrfP45wFQvSbC1CCzm1Rz5aYBWP8B8P9GdLu+AmBYrpuSYgy1iejhOQ7Hx7bZxwspXlc18Nct3/UwM8W3AmNXBf5bgPsFOYqfH32ixsJDH7Iu2xJarba73tYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjaOBxPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjaOBxPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AA1C4AF0E;
	Mon, 22 Jul 2024 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721612054;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cjaOBxPahX1e1B0ZVn5uf+Yzxm6wcZ/ivzVoFsjtrd2/ionwvf7tV0ST3IyFg3j5O
	 1+7Idc+KlVEvrVWUnxJctIIxh76KdHqPcqyzqEyGpbA+kDcOrmkm6pbOx3ufzQZr7L
	 dabxsYQlFJO+freqN5xEQJb26jhDiVlwZiRH5F542tvbtayH9olzdhxp3kgNvgBQfM
	 yynllHRU6PRzPv0LlLxiP4x1e4xqb/zO9SER8BufvclxfotT+HHtT9wsMvBpNfKBhV
	 CkwpY6mQe3w3BfMlsxVCrozaOM1/XCXIWGJd8pE7ICtquCpQnEfjouv8HsQlaf4bwi
	 6Qpv25lO4eIgQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/3] ata: libata: Rename ata_dma_blacklisted()
Date: Mon, 22 Jul 2024 10:34:10 +0900
Message-ID: <20240722013412.274267-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722013412.274267-1-dlemoal@kernel.org>
References: <20240722013412.274267-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function ata_dma_blacklisted() to ata_dev_nodma() as this new
name is more neutral. The function signature is also changed to return a
boolean instead of an int.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7752dc80028..286e1bc02540 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4287,16 +4287,17 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	return 0;
 }
 
-static int ata_dma_blacklisted(const struct ata_device *dev)
+static bool ata_dev_nodma(const struct ata_device *dev)
 {
-	/* We don't support polling DMA.
-	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
-	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
+	/*
+	 * We do not support polling DMA. Deny DMA for those ATAPI devices
+	 * with CDB-intr (and use PIO) if the LLDD handles only interrupts in
+	 * the HSM_ST_LAST state.
 	 */
 	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
 	    (dev->flags & ATA_DFLAG_CDB_INTR))
-		return 1;
-	return (dev->horkage & ATA_HORKAGE_NODMA) ? 1 : 0;
+		return true;
+	return !!(dev->horkage & ATA_HORKAGE_NODMA);
 }
 
 /**
@@ -4404,7 +4405,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
 		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
 	}
 
-	if (ata_dma_blacklisted(dev)) {
+	if (ata_dev_nodma(dev)) {
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_warn(dev,
 			     "device is on DMA blacklist, disabling DMA\n");
-- 
2.45.2

