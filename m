Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15297EEF5
	for <linux-ide@vger.kernel.org>; Thu, 18 Jul 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296393; cv=none; b=dj1hgeWoI7jp93jwSQzSpu81Onoq00tuJToN6pdtad2naGSoAgnZzQHbFrIseCnReDdqa5UYAZaDppyjtAZw4DmZyGRo1+JloIIH8J8odPIaywEFcBWa+Izjau1+Jp4bnYZlXJu+h+SJrq3s7yw5FsblzHqINVbYaZRKECsLGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296393; c=relaxed/simple;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJtpCad+zR2jtxJR1BeQBOHb0Z2YzN7FKm23iHi3yQQ7CY5YeZ6J4lVXbsNKBzJ7iXZlcUBQEMGw1Ca83+iZBPArYYZ21KhVqr0HxOyLH4jQiWpwFGqQVd2kkGrOcnwXCih9qsd4qLdfuNCDFt74rjYGZBU0l9a+DYfx1mGxPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KojfXZYJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KojfXZYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086E9C4AF09;
	Thu, 18 Jul 2024 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721296392;
	bh=zqlhIfR9tgS+7BpN1qeueG8UiS0NA1KmqQg1GW0+wlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KojfXZYJDFI9F8hC8dcq6jXYvp8xS2wwXcnLZo9Je0A5/B3NZgOI0268AoJyp8d1B
	 AsrnLiHVZppxAMxD1ykgrnNOGjFXbfIyGEzCVoCvPa2RXLED58jvv8x/6KnZOnaci9
	 JSTB4aYNotLcAva0w89D0RsIFukn27bnjEjSG7ggTso30/TAG1P25Q4nQ1NO4pANUd
	 XQlqy4Ht02d1XHPziKrpavjt2UeaiDTcf/BgMFJLliG4cW7ZixkggQxA3ZM5tUL8Gb
	 pvvqWqmjRq/mFes41aMSMm8ncdCcADHfEV3bZevaRFO3Gz2OS8YXuVgWLYEM4zxVLI
	 eUTOeDjZgGIaQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/3] ata: libata: Rename ata_dma_blacklisted()
Date: Thu, 18 Jul 2024 18:53:08 +0900
Message-ID: <20240718095310.152254-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718095310.152254-1-dlemoal@kernel.org>
References: <20240718095310.152254-1-dlemoal@kernel.org>
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

