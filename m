Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACA309F13
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592520; cv=none; b=S86EaY2IqEvMGiaMkEWfcwUaqiZj+BMDbmcbs6fLpOWImQcdmwsZfwDk704OCJEtsfxTxxrAHC9go//YmVJ9mkd90HV7y5DpMrXiIGlAm3sU3M57VTdeAwnLHVOgbtcNLptrdPYiQ/4sV8CO62eMHs+aGqKckEzZciG1vlK/S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592520; c=relaxed/simple;
	bh=SjeVfQAK7RALFDk4FlBKxju75SMFsYKCQhhDBPiiMkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktId38w6AI5uDRrmXmu/OioBrd++jqPvcL5ch8bhWQ1JPFWjJWrCHuEwiu00smeBQwFE0cdLibaixUH6sHkGTVqeMHhWiBorkjYYG+A5NmWV8pLOw3x/QlfoZ6cHzfIe4ifpQFWbA22uSns+Lf5gQm1E9lX/atkYiKL5vCPleXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9id5Kao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9id5Kao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EEFC4CEF1;
	Mon,  1 Dec 2025 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592519;
	bh=SjeVfQAK7RALFDk4FlBKxju75SMFsYKCQhhDBPiiMkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9id5KaoWqknffbFM/7qj3PS9VepyccYy2bNVHzIQYXm5XRu3sx/hIDmnPbpQqEcB
	 tYiN9bBVFoOaoxMJ6gRew24hcgT/6Vil7wZlMc+iT3AWH/i8x9RBg14zOtnxhrG6hU
	 njoVvGpYilA5GvuN9RawUMSET4AYfc2vnx0jjX269PchZeROQGjf30aY+JJVrGuCuA
	 iYJUj1RPTU94T5WcOd2YSX4y7o6cWf2TEH1YHpYkpAh/XYe8lTgZ7zz7BRHZmSI/lO
	 RRf9tl3sVJEjhSAG6hOMf8ZdrE6ZJltoVBZyLgSykEYJqd737x+TNJp3r1ZMVnReey
	 NS/V3+JL0+I8g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 3/8] ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
Date: Mon,  1 Dec 2025 13:35:05 +0100
Message-ID: <20251201123501.246282-13-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7203; i=cassel@kernel.org; h=from:subject; bh=SjeVfQAK7RALFDk4FlBKxju75SMFsYKCQhhDBPiiMkE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6scUyY+TczTlivtOT1bPft2zLeCNe1ci1n0mYXVX 7hPyPnaUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImI6TEyrGbXD33xYL/3en1H Y8sfR5x+Kct6LLj3+lLd/AjdR8u/uTEyfPSJ2nkkZ+rmjhCBuCq1/AmXbddcn7W3zbogU/164bm LLAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new quirk ATA_QUIRK_MAX_SEC, which has a separate table with device
specific values.

Convert all existing device quirks in __ata_dev_quirks to the new format.

Quirks ATA_QUIRK_MAX_SEC_128 and ATA_QUIRK_MAX_SEC_1024 cannot be removed
yet, since they are also used by libata.force, which functionally, is a
separate user of the quirks. The quirks will be removed once all users
have been converted to use the new format.

The quirk ATA_QUIRK_MAX_SEC_8191 can be removed since it has no equivalent
libata.force parameter.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 68 +++++++++++++++++++++++++++++++++------
 include/linux/ata.h       |  1 -
 include/linux/libata.h    |  4 +--
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 387a4f3bd3eac..90b7a1bf93474 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -77,6 +77,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned int ata_dev_quirks(const struct ata_device *dev);
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk);
 
 static DEFINE_IDA(ata_ida);
 
@@ -3146,9 +3147,10 @@ int ata_dev_configure(struct ata_device *dev)
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
@@ -4002,7 +4004,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
-	[__ATA_QUIRK_MAX_SEC_8191]	= "maxsec8191",
+	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
 	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
@@ -4047,6 +4049,21 @@ static void ata_dev_print_quirks(const struct ata_device *dev,
 	kfree(str);
 }
 
+struct ata_dev_quirk_value {
+	const char *model_num;
+	const char *model_rev;
+	u64 val;
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
@@ -4091,7 +4108,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "ASMT109x- Config",	NULL,		ATA_QUIRK_DISABLE },
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC_128 },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC },
 	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_QUIRK_ATAPI_MOD16_DMA },
 	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
 	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
@@ -4100,20 +4117,20 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
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
 
@@ -4359,6 +4376,39 @@ static unsigned int ata_dev_quirks(const struct ata_device *dev)
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
index 54b416e269959..c9013e472aa3d 100644
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
index 39534fafa36ae..11b6a44572acd 100644
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

