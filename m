Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F162D23A4
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319717; cv=none; b=GC9oKCAdSuCJPs+4oxoFgL6DbS95AkQO2NBsM/iilGn/bs+VYjpuuHxYwFeNVnEl+IV95JduL6EbkASbCvZ+Z44COIs97sCIIeuH6p9fLKebJNPQbzhUGeunyPiVMlk5JnMUXDOaiXSLOf/Ip8yycIp1lvbGGZoez7VGrzJA3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319717; c=relaxed/simple;
	bh=i3M5JDt/M6kq2PdKoWXYNpl0hpaTmK6n4gRE+k+HDts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llxJ/5oGVUDkR9LxiGefGQO4Kim/ZUsc14j7aOm3Ri4Alxx1DSMKvO3/+kPuVlb1DXJ7gYmdLUQafjEAzTPrkXEwYH3mRQMmoo/RSyz5/E0X6un6JgJzT7L4ejwHO5Y5FPdCGjGp/8+3RsqoCzA6r9RlQ4GaQ3Y5SqjJuLioaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiCVogMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiCVogMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD2AC2BCB1;
	Fri, 28 Nov 2025 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319716;
	bh=i3M5JDt/M6kq2PdKoWXYNpl0hpaTmK6n4gRE+k+HDts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiCVogMwbhNhj3AmdBLkr5AsOpiMCoIIz1XXkUwUX/qA6ELEGAbIIX+QQ9HfTm6XY
	 WEnN/CxQnIv1EzGt3KTuBb6L5drapwQwxS9pn9lzsM1w4g8am7yjWPHBQiO4kzF/bZ
	 m3unXK59bN45O34We3SdjnSZqh4YH1DkneCfXhQopVx4OyH7FMIuPwYU+ORYHjQysx
	 mUw7j3t4pGz/emjjhk1kICou3haRvYQTrzmo+ri6XXwZJQkT5Es5d4jazCpaKONPRn
	 wX1ZiiNU9OXvBrqCAS6LjaKYGXHD90Pd0iV8umedt5Sc0mSoHh6S1DTZi5m3M+Ehyg
	 w6xXFXgOzS5tQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/8] ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
Date: Fri, 28 Nov 2025 09:48:17 +0100
Message-ID: <20251128084814.3798425-12-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5992; i=cassel@kernel.org; h=from:subject; bh=i3M5JDt/M6kq2PdKoWXYNpl0hpaTmK6n4gRE+k+HDts=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey8Zuaz7/6fshUXUjheGN6KXxtwyFVL/uvvJmx2n/ h0/0fjjSEcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAm0viS4X9Sw6I91/7LP6+9 6ecQVtQVKnAwO4vLfLlR1Nd7/Nd+79rPyDDpERfTnA2pm76a/euwcbA6nRISFb+RU6N9zVUhs2X bLZgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new quirk ATA_QUIRK_MAX_SEC, which has a separate table with device
specific values.

Convert all existing device quirks in __ata_dev_quirks to the new format.

Quirks ATA_QUIRK_MAX_SEC_128 and ATA_QUIRK_MAX_SEC_1024 cannot be removed
yet, since they are also used by libata.force, which functionally, is a
separate user of the quirks. The quirks will be removed once all users
have been converted to use the new format.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 62 ++++++++++++++++++++++++++++++++++++---
 include/linux/libata.h    |  2 ++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f48fb63d7e854..634d6b07a92dc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -77,6 +77,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned int ata_dev_quirks(const struct ata_device *dev);
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk);
 
 static DEFINE_IDA(ata_ida);
 
@@ -3146,6 +3147,11 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
 					 dev->max_sectors);
 
+	if (dev->quirks & ATA_QUIRK_MAX_SEC)
+		dev->max_sectors = min_t(unsigned int, dev->max_sectors,
+					 ata_dev_get_quirk_value(dev,
+							 ATA_QUIRK_MAX_SEC));
+
 	if (dev->quirks & ATA_QUIRK_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
@@ -3998,6 +4004,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
+	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
 	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
@@ -4042,6 +4049,20 @@ static void ata_dev_print_quirks(const struct ata_device *dev,
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
+	{ },
+};
+
 struct ata_dev_quirks_entry {
 	const char *model_num;
 	const char *model_rev;
@@ -4086,7 +4107,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "ASMT109x- Config",	NULL,		ATA_QUIRK_DISABLE },
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC_128 },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC },
 	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_QUIRK_ATAPI_MOD16_DMA },
 	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
 	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
@@ -4095,14 +4116,14 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
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
 
 	/* Devices we expect to fail diagnostics */
 
@@ -4348,6 +4369,39 @@ static unsigned int ata_dev_quirks(const struct ata_device *dev)
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 171268d651694..11b6a44572acd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -75,6 +75,7 @@ enum ata_quirks {
 	__ATA_QUIRK_NO_DMA_LOG,		/* Do not use DMA for log read */
 	__ATA_QUIRK_NOTRIM,		/* Do not use TRIM */
 	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
+	__ATA_QUIRK_MAX_SEC,		/* Limit max sectors */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
 	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
@@ -115,6 +116,7 @@ enum {
 	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
 	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
 	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
+	ATA_QUIRK_MAX_SEC		= (1U << __ATA_QUIRK_MAX_SEC),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
 	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
-- 
2.52.0

