Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C6306D5E
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991864; cv=none; b=NkTp1zft1A10q6CjpMJzTqIXL88ld46mYIbfFZgli1jNeJT/JpVfULOSRoQVqOfaDAOdbGy51pOVUm8rk7jP2QdAi2Td+Kd7aaskhsUSWNm27pmUdc0/ht0mZ8IBja5JtJGX69Rj9rtSp7edmc2vN7KdHS8eHLc9hvsP/nft2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991864; c=relaxed/simple;
	bh=wzqguoARn9DogY8ZBo0n85ELMJ2/TNA9RHNAKd6HKHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF2/aW8xxgDMn2Ma10oWicnKpfdhHWo+KAIo5pBDC2h92xxPIC3LuFR457o6zpHAOd4hP7iFYR5yYphtS3EViRi+ldArfCiygyfVIcd7P0V2tPFTBtTxlqClJg6gs3jRfuBEINHR6NPz932McrHpU0hMqDUGi3f9XHOwOGWOSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN8/ARTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN8/ARTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF2BC19421;
	Mon, 24 Nov 2025 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763991864;
	bh=wzqguoARn9DogY8ZBo0n85ELMJ2/TNA9RHNAKd6HKHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN8/ARTVanXZ2iSUoY+hyqOI/ibh/tIx0NqR1GXNmgKCvH55Dkaeyd8UxTPmX3on7
	 9tJfRnJ5A+0wswGw1WUQPARFnuXPG9wAymPC62UBWjkP2/sIkp/typuQe1T35HgykQ
	 j7SRXJPWX6NK748VnUcM9bDJJFqRZjOKWCd884cMX9uSXPm955hFDxq2glR7A8DFKM
	 9uzZJjIBSg3hiRsB4cvSdIYApv5KqwqK4F/YownYL19XzUuTkFY4bftIHQMBbwSKNz
	 tTRtNxTvKRQm95xQOWIgbjOMLWc9FYew88k0pkSKO0/1OnbSGi0Y3LEuV8+c1ZqRN7
	 fJizuI5ONbHaA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/3] ata: libata: Allow more quirks
Date: Mon, 24 Nov 2025 14:44:18 +0100
Message-ID: <20251124134414.3057512-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251124134414.3057512-5-cassel@kernel.org>
References: <20251124134414.3057512-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=cassel@kernel.org; h=from:subject; bh=wzqguoARn9DogY8ZBo0n85ELMJ2/TNA9RHNAKd6HKHA=; b=kA0DAAoWyWQxo5nGTXIByyZiAGkkYS6jpWHjdse96+DGZj9M/EvB+0NRDnZriolRW6eLlYTQv oh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmkkYS4ACgkQyWQxo5nGTXKCpgEA/e7B /Ui2Ltk1cHLMTEmrvKHTAcf8QFBrudoUT08MNRwBAPvamZPQR6FipqXpCde/V3W26puF54HPGd+ 7r4C3OeoN
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

We have currently used up all 32-bits in the struct ata_device struct
member quirks. Thus, it is currently not possible to add another quirk.

Change the struct ata_device struct member quirks from an unsigned int to
an unsigned long long.

Doing this core level change now, will make it easier for whoever needs to
add another quirk, as they will not need to also do core level changes.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 4 ++--
 include/linux/libata.h    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index be320c3e0fef..d8ab5bc56fc6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4341,8 +4341,8 @@ static unsigned int ata_dev_quirks(const struct ata_device *dev)
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
 	const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
 
-	/* dev->quirks is an unsigned int. */
-	BUILD_BUG_ON(__ATA_QUIRK_MAX > 32);
+	/* dev->quirks is an unsigned long long. */
+	BUILD_BUG_ON(__ATA_QUIRK_MAX > 64);
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 39534fafa36a..4ed7bca91691 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -46,7 +46,8 @@
 
 /*
  * Quirk flags bits.
- * ata_device->quirks is an unsigned int, so __ATA_QUIRK_MAX must not exceed 32.
+ * ata_device->quirks is an unsigned long long, so __ATA_QUIRK_MAX must not
+ * exceed 64.
  */
 enum ata_quirks {
 	__ATA_QUIRK_DIAGNOSTIC,		/* Failed boot diag */
@@ -723,7 +724,7 @@ struct ata_cdl {
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-	unsigned int		quirks;		/* List of broken features */
+	unsigned long long	quirks;		/* List of broken features */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 	void			*private_data;
-- 
2.52.0

