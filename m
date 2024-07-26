Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77C20B35
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963997; cv=none; b=BvNsczyuRLhLX67vpGOh9wA7IT9D2crZd65xpkeaSz0lbAt7f6waLvy1h7rjJyiCCRMQPevWL1agYJi1ygtoQXseT6CnKBUvWHo2m4HgAMW6k6JyxCQqH+VxNGir/Oqn34ED5FsOFkkP8XpomFtreR4jPLJ2iOpG//E+ttp0dFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963997; c=relaxed/simple;
	bh=3DQKxiEcCqr1wrwjuJ2DChYp4WvzmZKWguyNkwIs/1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw+O8j7y68zpEX+boktRnWl4FlrovFsuWghlyw7vzEqw+6hrvaD34bW2AJS/IXHIx50Bej9487b/0X1InjE+zmsz30RvtvORUGT2xO7sEaQl24D/kFCoCrW4loFsdde1Lg0gMDgt1pstxwPZvxkdDDrkR5+vfzEippcduGEpO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4PwVTKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4PwVTKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15811C4AF0B;
	Fri, 26 Jul 2024 03:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721963997;
	bh=3DQKxiEcCqr1wrwjuJ2DChYp4WvzmZKWguyNkwIs/1c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d4PwVTKVpoJRZv/vHaWEZOV8YeLjd/3uGD9Y7oRfo1gKfbXJ5e6d3Ji3TjvTY+NjM
	 tDVJ0eS/IdP/WgkATmEuO44AzXaGk8ZLIhDI5erHIOPmLP73Dtmj2qNwDTe5xURLtp
	 tZ1ZwR60z0/bGv+vG8HX0++QbDsGj12TtfM9AgoYw5Z2lt+6NR1E6PISGwUahHPdue
	 cfS/47dpYYLpDFYl8kPqfcK6icYKgm1A746BKJg+lP7xVQQ293olh7qEYj2w2aQG7D
	 BrhxAW2kqjLwtNO6zgW27llu8dBjR+C0c02EqZ0AJRXeV1wRNd1g9+kORl7z12B4be
	 HhKPmCfC4vCaQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 02/11] ata: libata: Rename ata_dma_blacklisted()
Date: Fri, 26 Jul 2024 12:19:45 +0900
Message-ID: <20240726031954.566882-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
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
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c49334e13c0b..f1e5055e33fe 100644
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
+	return dev->horkage & ATA_HORKAGE_NODMA;
 }
 
 /**
@@ -4404,10 +4405,10 @@ static void ata_dev_xfermask(struct ata_device *dev)
 		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
 	}
 
-	if (ata_dma_blacklisted(dev)) {
+	if (ata_dev_nodma(dev)) {
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_warn(dev,
-			     "device is on DMA blacklist, disabling DMA\n");
+			     "device does not support DMA, disabling DMA\n");
 	}
 
 	if ((host->flags & ATA_HOST_SIMPLEX) &&
-- 
2.45.2

