Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E32556E
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592519; cv=none; b=EUeRECLvWTbDZ1kYxAxPKxE31nRBvOCHzzgFtrEJ4HxCWs5Q2xF0qvVol7uivRGlN5HvlD03ou7rFF9Sa+amRZjekb3BTCvS3XBUGoumNpx/yn6XK1QfqYR06RJInLnQIawT5pD2Mx7I6IKNAK92o8fhdc/zZ93rNixgl9t7VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592519; c=relaxed/simple;
	bh=9xoUJP1mYyXnHPMvh158c41k9CVn7Cj5x8yQxiNgx/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5li5g9hHq9yH8VFcPz9S8RTRq8pQam+3+3fFExf8uUi7zVn1Q2s4GHufKNZZepABIz7/MiGWtMcWj3UhSasO30cNzrnRKTRdD4rNSb/wfTIBV9jemfZA4QX/Fpo6gIvyjiS9Czx2U82qRe5sw+66YKog8IDlRkE3PNz4KtYtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng6LQgBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng6LQgBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8ABC19421;
	Mon,  1 Dec 2025 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592518;
	bh=9xoUJP1mYyXnHPMvh158c41k9CVn7Cj5x8yQxiNgx/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ng6LQgBxh4CfQGetjgg1yLE3c12x2zs9LT8n3rT5qahfqpH1oc4vCifzLvRHmY5Pc
	 2NircI99DYGscGiqSvpeAomk6OaNE2jVvZyEJqnF4cF6HOpsv5zevRHNS6kVKmypMr
	 W0kv+hiQWhpMg0fW3ClP3edFT4vWrx1HzldgkpMX1jf9oFZUL4jizuAFvdaESHRtrD
	 agR4eZJkKOhCbt9y7fX55kp8jO4x/j3pdfzs13pHpa3V9mQDd7Mfg6ui1M9Sg2rapa
	 FRT2XxQo0oEem6rhRCozw6R0bRc8gzTsO4njZY4yN0zR6Im2SwZzbisYZaby8Bqd3J
	 TybERwL9BB4Pw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH v3 2/8] ata: libata-core: Quirk DELLBOSS VD max_sectors
Date: Mon,  1 Dec 2025 13:35:04 +0100
Message-ID: <20251201123501.246282-12-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=cassel@kernel.org; h=from:subject; bh=9xoUJP1mYyXnHPMvh158c41k9CVn7Cj5x8yQxiNgx/k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6vebw9qLrlwtVFXomzPhiW/evy13zpw31JlCD6Rv fBT19nAjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEbj8jQ+OLTReLJrKe+bR6 4zX5mbO3FqvNSU7PFYrodCm4cnSvmR3D//LZC5Zert5V+VFR+h1rm/451RN1yeITDjBsvhy5dKO DMBMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
the default max_sectors_kb from 1280 KiB to 4096 KiB.

DELLBOSS VD with FW rev MV.R00-0 times out when sending I/Os of size
4096 KiB.

Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
since any I/O with more sectors than that lead to I/O timeouts.

With this, the DELLBOSS VD SATA controller is usable again.

Cc: stable+noautosel@kernel.org # depends on Move quirk flags to their own enum
Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 11 +++++++++++
 include/linux/ata.h       |  1 +
 include/linux/libata.h    |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f48fb63d7e854..387a4f3bd3eac 100644
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
+	{ "DELLBOSS VD",	"MV.R00-0",	ATA_QUIRK_MAX_SEC_8191 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c9013e472aa3d..54b416e269959 100644
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
index 171268d651694..39534fafa36ae 100644
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

