Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89391EA80
	for <linux-ide@vger.kernel.org>; Thu, 18 Jul 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298840; cv=none; b=I0T9ZoyBTU5L29yq3JPelJC23HENhKp5C4N8PNDAG16Uppqb9mITgPbrOv1n3LQrqj9a0WIr+iiFNhiSjbYlQYBHuTywBmTvB0xy4lY3Yytj7Q9VsnywcyqLKvav0g18ursUYuElIfp8s1UbUikvWwwvBKwNwAGKYebRtrrcdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298840; c=relaxed/simple;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPQmDCBQsG3y7W+HHBe3eVOXY1Gqs3eu6KO05X5h3WdhnCVfGmFyJwihMYHKjRsZJYAWCAWMX1Bx0qB6rtefqzRn3hHzV7DcDV2u+D344/ZamroR3Ijs1ILQr2698snxIdWLhN0wDmDYvbexsRoGq/kMxKAQGK5wivgaQuMpHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ha4KYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ha4KYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF75C4AF09;
	Thu, 18 Jul 2024 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298840;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E2ha4KYmes5F8+91l/M1mVZ/0qs0q3GoVZdGwi5jSZ/4cifvgwfxaoK4oH+QiAinC
	 H8t4+ytblSqdOJet7pv9+RHgGZkZQ43oBztw4ns7DM4zTLsoDiJIHkxA+Fwm50E7td
	 zdXz+y9TzqjkWQjpPelSBOWRtedDfyFSFrmg67CyPqDW64waVFyGC5+BiyG1yj6uv1
	 UnoTTJL6wjonAzK808xlA8huU0cF3pyOu5WzkfcAdCH9oma9wJNzGecYcV01TY2Qgs
	 9GEW4PpOJthqJdkrydkTgVjgMozFJqf9RqfvCZ+0tOQR71TdluHCQyyhYP1umUE97G
	 4kyR25yQS9O2g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/3] ata: libata: Rename ata_dma_blacklisted()
Date: Thu, 18 Jul 2024 19:33:56 +0900
Message-ID: <20240718103358.176260-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718103358.176260-1-dlemoal@kernel.org>
References: <20240718103358.176260-1-dlemoal@kernel.org>
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

