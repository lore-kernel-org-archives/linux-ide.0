Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B75695
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799942; cv=none; b=OtV9Wil05HbikKMNOuS0rWeVFZVMIxCYycLKMLIFLgRCXdbpX7agR6Ebi0pX1r0eOez4p4i/66ew/6WU4kBidy3pjSWRNALGylR4iR2EYpYWDFhAPobTNWprnKWG8EYnBKBnuhuTO9HIxZSbm8lJ8+tyZcY4zUArMRgVYEvvt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799942; c=relaxed/simple;
	bh=Ni/7m6ZN+sYMnOonIpgkMgG0NtgBM9pRE6mJdzZgU7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvQVNO9WYiUt6iNdkfX1fCOk7jRBm6SwIDHqpBiEuoOvOFhN6582yo9kXX0X+OgN173BtjTg5SYCjDSpslnTc37lv9Vq+e7/PDvlJgpSGVmPloN0AYJDMHkvdx+9CQ1Ano6w2ZEE0Eng7z9+b294oVfVp2qwxAwf36xy149Q5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc/77/su; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc/77/su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486FBC4AF09;
	Wed, 24 Jul 2024 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721799941;
	bh=Ni/7m6ZN+sYMnOonIpgkMgG0NtgBM9pRE6mJdzZgU7I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wc/77/su7g2yhAOaBp0EBAiM4H/Gs+fRXrpOmtzBztEtYpOF1B0216YDpKmEEMHgI
	 I25YAiRGFYuKsI00e0Vty6QGuChj58R0u5aRrZ+KU4Qj0WeeH/IglbmoyUzch3/rq7
	 ujjASZAU72JvoqVXahG3a0C4l1Z/Vtqsgnj4YbAYLUwYi1ucRTp8g+1Zo9kiKImHNm
	 g1LJd6xKtyF3jDKawr0IdjOOTbTR9dcfm2KMYAVDXGTsrLznUxf94Z8yAXcBhIB9Wb
	 Qb4lItMR59FfZr+l5JT69JDic2oMMMRjXxK3VBx7dS4dR4wO+Ir5wxz4Q+ogWVuDur
	 8po621sfVrv4g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 1/4] ata: libata: Rename ata_dma_blacklisted()
Date: Wed, 24 Jul 2024 14:45:36 +0900
Message-ID: <20240724054539.182655-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724054539.182655-1-dlemoal@kernel.org>
References: <20240724054539.182655-1-dlemoal@kernel.org>
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
---
 drivers/ata/libata-core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7752dc80028..a35bce4236d3 100644
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

