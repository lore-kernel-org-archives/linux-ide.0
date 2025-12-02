Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895F311979
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678107; cv=none; b=L1K7OQpcZ0j+QgUYsjS3+7Ef4dMjYRNxk3xIqvK5otsC8FagTfOZH2XJx1sv2MIzoRABWqnkL15GsS/wruhM5t2tFhHzGEz9HElER9IG35PId+JK+wGQvvN/957RSyIfatuUPgndnc6puDjestwnXZzQpVF9GBl8PVUlPDvNu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678107; c=relaxed/simple;
	bh=L0ozqRGReB9PVm+Qzchxsa6WCNT+bSUt029QIxtTEEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUHmUgvqYHoyiQXYnt/+P+/mijSRR7ZEm8qv2ZalkrV8oQa+PyWSYQB2++UEjg05nUqfqt/llHpGn9U8d7QrPn8nVwykTgYM7IfMjWSru5BSmDo6EK5IclOvFMNYJLQnT14vl0taTUsy2e5wUERMS9loqRCci6QVJ874S8jh1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYRUj8R+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYRUj8R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420F7C16AAE;
	Tue,  2 Dec 2025 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678107;
	bh=L0ozqRGReB9PVm+Qzchxsa6WCNT+bSUt029QIxtTEEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYRUj8R+mOl74BP6/aN1iNGqmXJgy4OxGS2n6nFs/w21+nN40YvUgbr/LWNI20/39
	 vJpyn5cqK9aTEvUt3bXqndXI/mWtqmsokefRQNFCU0Ze73BrNdFb90ruaSQTP0d7so
	 QxDMi5OlLFMJ4+FBw9kgPk4G5jDkYucYlH9eVgAbcFRhwkj8ZMumvhfU48GnXVUCzu
	 UF9o4xPdfQP2bJ5lvAvBZdfkk1R5akpaAXWUEkKU4rvXr+tKZ8DmdfjnVLN9ub3sak
	 YAerqadskuccwRAIlcZVhfsaGRj0Js6ZD/vPZO9ZVqdY9Tiwrr73AAjN9jOoejSTl+
	 VtWM15TFGnMXw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 1/6] ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
Date: Tue,  2 Dec 2025 13:21:31 +0100
Message-ID: <20251202122129.421783-9-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
References: <20251202122129.421783-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7277; i=cassel@kernel.org; h=from:subject; bh=L0ozqRGReB9PVm+Qzchxsa6WCNT+bSUt029QIxtTEEk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp7L1b9+/8WFCX/XG3/n8GLXORSSfG2bgJAOz3n+e 7wnTeZd7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEDJ8wMjx8J9IWHnFDMVBN 5sT8vX/+3lVeusH66HO5bNkDH3e5rrvDyLDuaZ+WNVfoNsOam2cCQmx2nuXbup7dNmp6aW/EXHd 9RSYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new quirk ATA_QUIRK_MAX_SEC, which has a separate table with device
specific values.

Convert all existing ATA_QUIRK_MAX_SEC_XXX device quirks in
__ata_dev_quirks to the new format.

Quirks ATA_QUIRK_MAX_SEC_128 and ATA_QUIRK_MAX_SEC_1024 cannot be removed
yet, since they are also used by libata.force, which functionally, is a
separate user of the quirks. The quirks will be removed once all users
have been converted to use the new format.

The quirk ATA_QUIRK_MAX_SEC_8191 can be removed since it has no equivalent
libata.force parameter.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 68 +++++++++++++++++++++++++++++++++------
 include/linux/ata.h       |  1 -
 include/linux/libata.h    |  4 +--
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 08cc43b6bf465..e33008803e04e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -77,6 +77,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned int ata_dev_quirks(const struct ata_device *dev);
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk);
 
 static DEFINE_IDA(ata_ida);
 
@@ -3139,9 +3140,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
 					 dev->max_sectors);
 
-	if (dev->quirks & ATA_QUIRK_MAX_SEC_8191)
-		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_8191,
-					 dev->max_sectors);
+	if (dev->quirks & ATA_QUIRK_MAX_SEC)
+		dev->max_sectors = min_t(unsigned int, dev->max_sectors,
+					 ata_dev_get_quirk_value(dev,
+							 ATA_QUIRK_MAX_SEC));
 
 	if (dev->quirks & ATA_QUIRK_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
@@ -3995,7 +3997,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
-	[__ATA_QUIRK_MAX_SEC_8191]	= "maxsec8191",
+	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
 	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
@@ -4040,6 +4042,21 @@ static void ata_dev_print_quirks(const struct ata_device *dev,
 	kfree(str);
 }
 
+struct ata_dev_quirk_value {
+	const char	*model_num;
+	const char	*model_rev;
+	u64		val;
+};
+
+static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
+	{ "TORiSAN DVD-ROM DRD-N216",	NULL,		128 },
+	{ "ST380013AS",			"3.20",		1024 },
+	{ "LITEON CX1-JB*-HP",		NULL,		1024 },
+	{ "LITEON EP1-*",		NULL,		1024 },
+	{ "DELLBOSS VD",		"MV.R00-0",	8191 },
+	{ },
+};
+
 struct ata_dev_quirks_entry {
 	const char *model_num;
 	const char *model_rev;
@@ -4084,7 +4101,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "ASMT109x- Config",	NULL,		ATA_QUIRK_DISABLE },
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC_128 },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC },
 	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_QUIRK_ATAPI_MOD16_DMA },
 	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
 	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
@@ -4093,20 +4110,20 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	 * Causes silent data corruption with higher max sects.
 	 * http://lkml.kernel.org/g/x49wpy40ysk.fsf@segfault.boston.devel.redhat.com
 	 */
-	{ "ST380013AS",		"3.20",		ATA_QUIRK_MAX_SEC_1024 },
+	{ "ST380013AS",		"3.20",		ATA_QUIRK_MAX_SEC },
 
 	/*
 	 * These devices time out with higher max sects.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
 	 */
-	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
-	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
+	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC },
+	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC },
 
 	/*
 	 * These devices time out with higher max sects.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=220693
 	 */
-	{ "DELLBOSS VD",	"MV.R00-0",	ATA_QUIRK_MAX_SEC_8191 },
+	{ "DELLBOSS VD",	"MV.R00-0",	ATA_QUIRK_MAX_SEC },
 
 	/* Devices we expect to fail diagnostics */
 
@@ -4356,6 +4373,39 @@ static unsigned int ata_dev_quirks(const struct ata_device *dev)
 	return 0;
 }
 
+static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
+{
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
+	const struct ata_dev_quirk_value *ad = __ata_dev_max_sec_quirks;
+	u64 val = 0;
+
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
+
+	while (ad->model_num) {
+		if (glob_match(ad->model_num, model_num) &&
+		    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
+			val = ad->val;
+			break;
+		}
+		ad++;
+	}
+
+	ata_dev_warn(dev, "%s quirk is using value: %llu\n",
+		     ata_quirk_names[__ATA_QUIRK_MAX_SEC], val);
+
+	return val;
+}
+
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk)
+{
+	if (quirk == ATA_QUIRK_MAX_SEC)
+		return ata_dev_get_max_sec_quirk_value(dev);
+
+	return 0;
+}
+
 static bool ata_dev_nodma(const struct ata_device *dev)
 {
 	/*
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1786e7b1165f7..792e10a09787f 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -29,7 +29,6 @@ enum {
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_1024    = 1024,
-	ATA_MAX_SECTORS_8191    = 8191,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* avoid count to be 0000h */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 	ATA_MAX_TRIM_RNUM	= 64,	/* 512-byte payload / (6-byte LBA + 2-byte range per entry) */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abdc7b6f176c4..0b37cdfae869e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -75,7 +75,7 @@ enum ata_quirks {
 	__ATA_QUIRK_NO_DMA_LOG,		/* Do not use DMA for log read */
 	__ATA_QUIRK_NOTRIM,		/* Do not use TRIM */
 	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
-	__ATA_QUIRK_MAX_SEC_8191,	/* Limit max sects to 8191 */
+	__ATA_QUIRK_MAX_SEC,		/* Limit max sectors */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
 	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
@@ -116,7 +116,7 @@ enum {
 	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
 	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
 	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
-	ATA_QUIRK_MAX_SEC_8191		= (1U << __ATA_QUIRK_MAX_SEC_8191),
+	ATA_QUIRK_MAX_SEC		= (1U << __ATA_QUIRK_MAX_SEC),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
 	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
-- 
2.52.0

