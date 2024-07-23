Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103B14D2A0
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730849; cv=none; b=AEVVN5Y3bpufNa65oAJn6T1cpIUPq76Vgsj4xpmonU/QjjY32ihV1nXYPcVB0/fd9e+Sd4bxfrEGiAPz4B2tDYuI7d+9815Wlvlhgz4464H/wIIqJiJccs/hLqkirRylUQ0Q5v0+zkv0/OBd9UGLvSPWYo0tlumq10GuuV0WK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730849; c=relaxed/simple;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCnU0wPUztJ8SnLQBwh7Xkr/s8mjzrvfLpC1gRKaf+m/iR2+OEa5ODBy5RLj+jjaqQJYFuP+LEi1Q0krX1nv+dz0W3x2cbaYKZEr8GuROaKxalYbq55ST684yXE4oiFDH0adJ0DpQT1npk2Gj/PuyphA0Q+OAEa8pe6i6btjf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNsDP/cS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNsDP/cS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D19C4AF0B;
	Tue, 23 Jul 2024 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721730848;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sNsDP/cSUeJ+ceUIW3QHXLlgs4eTBvTw5hErcKjuQpp6mX06M9Ken+dBnjvpws6AO
	 R2aqknZjh/ns+Ltykc4UTBlbkKo9+hi8X14QPZlNmlrSvlsuW5D2n1zyKknDYfAq6h
	 DjDCCNBwxLKLjw9UPVXKSqVh9MJ4UjEe6+s4WvM51nnQVImseGkGCsdGuBHm6yCi2c
	 /GJIqmsQ5JXo3l9YQdinyFm+V0cdnKuf1MmurVz38Zqh/K6mYweQl+E0X1H6qNk0aW
	 DRW1Va0sCa8A3zdKoRJYWlItGiPi6Hrduo7oZOlOjMDGg4MYsIVVz+qYRMKbUECrA+
	 G1DkPW8OWS19g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 1/3] ata: libata: Rename ata_dma_blacklisted()
Date: Tue, 23 Jul 2024 19:34:04 +0900
Message-ID: <20240723103406.294462-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723103406.294462-1-dlemoal@kernel.org>
References: <20240723103406.294462-1-dlemoal@kernel.org>
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

