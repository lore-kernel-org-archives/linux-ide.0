Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91C23BD0C;
	Wed, 12 Mar 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786834; cv=none; b=f/TmkPKUxUgZEPrKQFYOY92C/vuqNZsHAC97tXfl6JZsgrf0MRGFhr47tioVLwjPPycJOsm2iB4wa2XLHZGTZTKdDhyjCQa9WrsOV/6GWwVypwHIq+3wOLKMHtmpw+KHODAYO5QWGXcvfUOXMhwEzChRPGf1BMlSr9Wc4HMYMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786834; c=relaxed/simple;
	bh=W9blWCMEcJI08rILXLVoX7L2jF6I2R0jU4jGcUu0IwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbrMC/VUkgh7+VPMYcddY8NM+oFxrYoUV0vBuW/tnaqCBz6Dz9aKfcATI883x12FXJTpbXJp3jGoSl4SppeXNLAnxFkml1Z/tkXywpvtazBbVcloug/HLXE1LyGX3mkPIgSEyA/29MjeXDDDR7D8eQbz/85ulvkcjos8PVOMqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46496C4CEEC;
	Wed, 12 Mar 2025 13:40:28 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Daniel Kral <d.kral@proxmox.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] ata: libata: Return -EOPNOTSUPP instead of 1 in atapi_check_dma()
Date: Wed, 12 Mar 2025 21:39:54 +0800
Message-ID: <20250312133954.6666-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-EOPNOTSUPP means not supported, so return -EOPNOTSUPP instead of 1 is
more suitable if ATAPI DMA is not supported in atapi_check_dma().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7..2f5af295e8fc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4544,7 +4544,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	 */
 	if (!(qc->dev->quirks & ATA_QUIRK_ATAPI_MOD16_DMA) &&
 	    unlikely(qc->nbytes & 15))
-		return 1;
+		return -EOPNOTSUPP;
 
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
-- 
2.47.1

