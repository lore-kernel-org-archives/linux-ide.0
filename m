Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C022081
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964003; cv=none; b=o+T2arOju0OyP05X7kA+beIDX/kTd537o0AtsglpqF50RVOtPrtOpqFsNWOLMnBc3JL7VxG4GDM/Iz33V7DSpOASvkkgkmtbmNBK/PUA63fgWNKNt0d8Bew1DeYyHodfeElvFNy+kPf2+2TCTL0upypYJPSMuW04Gn3VUAhEX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964003; c=relaxed/simple;
	bh=XQFYXqelb/v2OkUsucKqSG/0RJoNrGzhKej7iOsWkF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtXh4ZmQi/cPQEHNN8fPFYlfNL6Bn84ttcPkiC0W/Mh0jXDxA+nbRVLTLnU3J5uFeOiDK6ANLqMtHS15JoK8FcLtyCsH66KbfW9ExUwvDBWdy3FbiUp7r+L+BNeau2WUdLTznavPTpiJ5XeKZqMx9v1McyOvfOEvt/xdH8YxoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwaT8j1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwaT8j1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC03C32786;
	Fri, 26 Jul 2024 03:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964003;
	bh=XQFYXqelb/v2OkUsucKqSG/0RJoNrGzhKej7iOsWkF0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OwaT8j1MhDD6Fk17AK7xSxGzuULY6WQPOVnUSrcrG1675uMDjmSCl1p3iLUE9J0fn
	 13mvBcoWLMyEDo0cK6gDM7+FlTYN1m4xw3hlYWIoyU4CcBAFIb+q/wyJKhihfONZZj
	 fi82Sn8HUmKgnJzONRxXoiGVQmsJfzwhTaQRnulP9arxK1nLPbyzTaiDvVm6IHYVoO
	 51BKkHGfbb2ditP4NHjnjkaVDW/wgdJuoERDjYR7S368A+OjmP2K9+24Lp/YbyDfJS
	 EU3fShHgt2gTqYa4XI5ZCK9kwps8ym9um8Pb5WfRKzdF/5ajIivbugyQZrRHQehlCN
	 RSSysPza1upug==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 11/11] ata: pata_hpt37x: Rename hpt_dma_blacklisted()
Date: Fri, 26 Jul 2024 12:19:54 +0900
Message-ID: <20240726031954.566882-12-dlemoal@kernel.org>
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
 drivers/ata/pata_hpt37x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index c0329cf01135..4af22b819416 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -218,8 +218,8 @@ static u32 hpt37x_find_mode(struct ata_port *ap, int speed)
 	return 0xffffffffU;	/* silence compiler warning */
 }
 
-static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
-			       const char * const list[])
+static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
+			  const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i;
@@ -281,9 +281,9 @@ static const char * const bad_ata100_5[] = {
 static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
-		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
+		if (hpt_dma_broken(adev, "UDMA", bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
-		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
+		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
 			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return mask;
@@ -300,7 +300,7 @@ static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
 static unsigned int hpt370a_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
-		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
+		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
 			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
 	return mask;
-- 
2.45.2

