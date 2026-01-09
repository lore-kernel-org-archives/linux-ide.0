Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474535E52F
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969598; cv=none; b=clvd5h/KXFiYNBNarkzO2XrJpKzWAPLjlQ0z249oUQbEb9klvEHBG6AFdnvr4rdsPAPW+v/vmTHuBLJebNJ9Ur5MNYCgx4qmszb+KOTq4FoiJ5wpUcbzGQPnPWoYMNVFXqO9mxyl1eJcecYiyBVPl7nn96+83jE8sGA4+CQiBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969598; c=relaxed/simple;
	bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQMpmEHYsOmz0NhnfCSmaDwMng8ctWi774dAa98+0XIbCl2//afd6K+2Oz6yIoHrc4bmKXA6yO+XNMoXabRZbJllbUUmiO9hThpRKfnv9m6gIjyk4x7AChPhJkT3Zthc0DqRRpCGJxqYxryBy8+SUk6gujCIbyULG+9aDkO7evQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebDeo1sb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebDeo1sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D27C19422;
	Fri,  9 Jan 2026 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969598;
	bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebDeo1sbLKMOHjmyWOmkU/hMwKB33eVAGbRaty54EmHvZgVspuqjncnyRZRy+yRtz
	 xI/3SklCKvnedseEwVZzUkKaI2K0cCilbmU59XIz6Zoiy1FZuS5dCJ+cS0D/IqFXL+
	 BV+MetABrOLNnPDSTtcL4F3rgXptoLk4xe18VCUxS+BStG6Di2w+v7oBQq2PPD3Q2j
	 7np0JxF/cSvDcAX5hfyTXYQV0KszLzsikZZwQmNGPHn6P5EWHsJ4qlbrcH/dUgPCcu
	 xcUf4y8ieVWagRkGAGYwVPxRjs3hDL3m6KJjfxNuX3I0rsCMIFXTeQY/zZHtBMaapP
	 YfdwwR08JmEYw==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/5] ata: libata: Call ata_dev_config_lpm() for ATAPI devices
Date: Fri,  9 Jan 2026 15:39:51 +0100
Message-ID: <20260109143949.331105-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109143949.331105-7-cassel@kernel.org>
References: <20260109143949.331105-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=cassel@kernel.org; h=from:subject; bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThU2FZFszznOdu/XVj7nN7tmXfokEnvC59g/nzb5n1 OZerBXSUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIkoqDL8lVvzm4WhS9H71Zq+ c9dLromGbV9rtSL6xR+mxKuJjXMr9zAyXPaOvDzhsuIB1brjee+t7t8LmbC59//NnWfWHl1zOm/ tXx4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
introduced ata_dev_config_lpm(). However, it only called this function for
ATA_DEV_ATA and ATA_DEV_ZAC devices, not for ATA_DEV_ATAPI devices.

Additionally, commit d99a9142e782 ("ata: libata-core: Move device LPM quirk
settings to ata_dev_config_lpm()") moved the LPM quirk application from
ata_dev_configure() to ata_dev_config_lpm(), causing LPM quirks for ATAPI
devices to no longer be applied.

Call ata_dev_config_lpm() also for ATAPI devices, such that LPM quirks are
applied for ATAPI devices with an entry in __ata_dev_quirks once again.

Fixes: d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
Fixes: d99a9142e782 ("ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b96105481784..1e8e35c10b35 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3148,6 +3148,8 @@ int ata_dev_configure(struct ata_device *dev)
 				     ata_mode_string(xfer_mask),
 				     cdb_intr_string, atapi_an_string,
 				     dma_dir_string);
+
+		ata_dev_config_lpm(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.52.0

