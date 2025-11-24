Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306B306D5E
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991863; cv=none; b=m4iN7nBx7s24M6lRzudUMyz3dL+CzgAUGPyDnhrpTr8Ru3fZ1I3rs4m1Bqer7ask7AHH35IntQ3HoxM43g1bEqrlukf1pXYH1BRdAOo98TegLK+3UFrDvTdTib84Z/+LQBRcxYanC89q9Xi9GJGv4ARLue3629B8PV7V4aK8Hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991863; c=relaxed/simple;
	bh=TXdKZzMZjXN1pVZTH7LM1VwUuRduOruU4xar5v4TnmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpsulaYRiFoJRAe6qK1gwBMePIZrLSTAvXw2G2rvutEvalPgL1jP2gyMGQIPNGkheYUN/pcaH3L9hNsftuiXi6PSYAllmrUtXD0sv+zohf0d3fj45oqeafPpWm44FfZVKe5y62l3DIG2k5ape8i5F5XBqCbVuQz8805etooyUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW5JQRk8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW5JQRk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACF0C4CEF1;
	Mon, 24 Nov 2025 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763991863;
	bh=TXdKZzMZjXN1pVZTH7LM1VwUuRduOruU4xar5v4TnmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TW5JQRk8XqF13qsjaLEZsRVxTLDVMLoO1DyMWgok9IWZtkIX4ntjaKuNRf42N2KP0
	 6uGPcJTSdIJUSGMwEw5pF6KSZqIpnAUHH9yCIjIKfugfAZJonDGlxcoVyDChmdBk2o
	 GBl2xZysQi8iUHVOi59aHvBZVCZg8YB5R/hiMVqyQM32jcvscLd41idHhRfSJ5Jh8N
	 Ge9vICp8BN8RBdWCI4pI1/nRp56Hq8QYgbGu7QqSGzzKm7vDWKJkLYcGHAwTFbCrAD
	 MpKgziNx9A/H1c+lTModFR/M3TgA1teYQM8N4bWi/b8w2LNnFInzYn7dBs5vehufbg
	 aer5DVUERibyQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/3] ata: libata-core: Quirk DELLBOSS VD MV.R00-0 max_sectors
Date: Mon, 24 Nov 2025 14:44:17 +0100
Message-ID: <20251124134414.3057512-7-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251124134414.3057512-5-cassel@kernel.org>
References: <20251124134414.3057512-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=cassel@kernel.org; h=from:subject; bh=TXdKZzMZjXN1pVZTH7LM1VwUuRduOruU4xar5v4TnmM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJVEvW6VVcrPuF7LXzzkiXLP808uWPCkYyTjy+v3dh8V Lv5R2VxRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaitprhf8aX9SWWSe8TDQ+1 5R3LatlQdGV/wAvp10xnDoSsd97uV8DIME3t2tqMWWVdqjOMVQ4E/F837W7e1QNpOw9YnktM2fL MmBkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

DELLBOSS VD MV.R00-0 with FW rev MV.R00-0 times out when sending
I/Os of size 4096 KiB.

Add a quirk so that the SATA controller is usable again.

Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 12 ++++++++++++
 include/linux/ata.h       |  1 +
 include/linux/libata.h    |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f48fb63d7e85..be320c3e0fef 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3146,6 +3146,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
 					 dev->max_sectors);
 
+	if (dev->quirks & ATA_QUIRK_MAX_SEC_8191)
+		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_8191,
+					 dev->max_sectors);
+
 	if (dev->quirks & ATA_QUIRK_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
@@ -3998,6 +4002,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
+	[__ATA_QUIRK_MAX_SEC_8191]	= "maxsec8191",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
 	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
@@ -4104,6 +4109,12 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
 	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
 
+	/*
+	 * These devices time out with higher max sects.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=220693
+	 */
+	{ "DELLBOSS VD MV.R00-0", "MV.R00-0",	ATA_QUIRK_MAX_SEC_8191 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
@@ -6455,6 +6466,7 @@ static const struct ata_force_param force_tbl[] __initconst = {
 
 	force_quirk_on(max_sec_128,	ATA_QUIRK_MAX_SEC_128),
 	force_quirk_on(max_sec_1024,	ATA_QUIRK_MAX_SEC_1024),
+	force_quirk_on(max_sec_8191,	ATA_QUIRK_MAX_SEC_8191),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c9013e472aa3..54b416e26995 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -29,6 +29,7 @@ enum {
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_1024    = 1024,
+	ATA_MAX_SECTORS_8191    = 8191,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* avoid count to be 0000h */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 	ATA_MAX_TRIM_RNUM	= 64,	/* 512-byte payload / (6-byte LBA + 2-byte range per entry) */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 171268d65169..39534fafa36a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -75,6 +75,7 @@ enum ata_quirks {
 	__ATA_QUIRK_NO_DMA_LOG,		/* Do not use DMA for log read */
 	__ATA_QUIRK_NOTRIM,		/* Do not use TRIM */
 	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
+	__ATA_QUIRK_MAX_SEC_8191,	/* Limit max sects to 8191 */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
 	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
@@ -115,6 +116,7 @@ enum {
 	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
 	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
 	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
+	ATA_QUIRK_MAX_SEC_8191		= (1U << __ATA_QUIRK_MAX_SEC_8191),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
 	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
-- 
2.52.0

