Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39C22F1C
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964002; cv=none; b=Y9sI9zsnZmcZFoiWTe+GWYdkZMCPfa21+Zh9k8Ku1HGwI+t2pXN9XCAqvzKgoQ0BzM88I0rYWjaMyOmntEpKGB5DyYJIPWVz/v4zba7M5bmA6AjIbX7MXmq6KRQ/H61aCDshi+4JhqNjn+g/2VP0FnhfWM3kTGP9BOj0VE+A/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964002; c=relaxed/simple;
	bh=taFx8JsyXWTEkRwPoArEtcd86z446JfZEpM7KSlUKO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X28PCSIF3tKzAUUo2isgI8x5AsPvvuF9brUNIiXrTBeMegdUpDGFLFgmD/XLwSImBnYLkgjtLsul4noKHACNhpUVBB7qpGDyFx5U1cVA6twp5XnKOFClFlJ1aiH933Kn6Mr+5kWyecOSbnumhVjGw9lOuajHcFaHQi4zoglkhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwqELbY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwqELbY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B32C32786;
	Fri, 26 Jul 2024 03:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964002;
	bh=taFx8JsyXWTEkRwPoArEtcd86z446JfZEpM7KSlUKO4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hwqELbY31CEXldNgAKfS18o9yP2IhJMAAxYVL+7yOKf9kWgjFaJNjpjBkk8Pnet99
	 iGovyfEEUf7DT9kfAj0jcOLRmi4xDrtCmZx9I9PjIRUbj+OGWv6i1A47W1GAWbjFZS
	 d5Kaa5BsLll6OrUU3JVNJREZ+CMtHntlilW7a/DV1C6+NrvYY5QjM6fOCdNNt+P+qK
	 LHTzRUkawKfzxpUwqEoKHsIPTqx1iatN3qmfGgXn3Cl9ttbLR4iclWkIX/yH2thvGR
	 q+KwIeBGYHdzH78R0u6V5KD786cpdj+AOyLTVabibEl2HXuV3GW8mTsGOqUvWaPjaO
	 nHuos1JSxXGYQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 10/11] ata: pata_hpt366: Rename hpt_dma_blacklisted()
Date: Fri, 26 Jul 2024 12:19:53 +0900
Message-ID: <20240726031954.566882-11-dlemoal@kernel.org>
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

Rename the function hpt_dma_blacklisted() to the more neutral
hpt_dma_broken().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_hpt366.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index bdccd1ba1524..5280e9960025 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -170,8 +170,8 @@ static const char * const bad_ata66_3[] = {
 	NULL
 };
 
-static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
-			       const char * const list[])
+static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
+			  const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i;
@@ -197,11 +197,11 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 static unsigned int hpt366_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
-		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
+		if (hpt_dma_broken(adev, "UDMA",  bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
-		if (hpt_dma_blacklisted(adev, "UDMA3", bad_ata66_3))
+		if (hpt_dma_broken(adev, "UDMA3", bad_ata66_3))
 			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
+		if (hpt_dma_broken(adev, "UDMA4", bad_ata66_4))
 			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
 	} else if (adev->class == ATA_DEV_ATAPI)
 		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-- 
2.45.2

