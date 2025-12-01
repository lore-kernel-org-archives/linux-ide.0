Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB82556E
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592523; cv=none; b=uStT4yWBIDFE8i8akbJZcwqOiJCv5HZpjq0ydnk3CFZu/HRHjzvwF6o4td8Wb6HjXfN61FuZ6hu9Rv6cnawzv+Aabmmyc26lITVyTAicsHC5/BO87dYpDdmoxXvW+G1upws/hkbG+6QoJ/BfcDjyO4mTJZZQJ7p53ll0NAa4ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592523; c=relaxed/simple;
	bh=mNIFdRwYGP4C1OKoQXRFlmnUo02TICF2a7zUvxmHIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBnFsFygT3DaMeXMrL0CJBr5N24h/lI6CRVfB/sXxsdzjrgWmdu3Jz2kR5sd2Mp/Tl/aFD1lwgdiFR8/00AX7Ll2WQFIMarj6TFsdqyKvxbTQyawnYdtOTdTx0Twq9Ek88nIZ8XXDZXQf0uLpUzwn7rTqyzlbtlqGsDupv3sNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glmOK5TL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glmOK5TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AF0C116D0;
	Mon,  1 Dec 2025 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592523;
	bh=mNIFdRwYGP4C1OKoQXRFlmnUo02TICF2a7zUvxmHIiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glmOK5TLMRumqacYblkCeYnlbEVFw8QMYyt79NlriEWVyASocmXp9njYzLNEZpTsX
	 gCFZHUuUkWyZtnGiuCCkNdfFo4/zSFv4+5LXJeMraOGS2zOSbRGRDSKZGLC9nZ+S/7
	 j22qDzZRNXUFByjo0+O73/26tCkYSwySKY3D1afxYBFW2EOlQk1QN3X6XwRrlxxiII
	 Gg7WqnNCpF2rQqypJhi5aHvOwf+/k6+8KJKJAS2vdMCeu7PSQtoq/eRv9EODvoHa/k
	 3hegFQJdcpgk8CEZvz7VXhwa6oszrCjCWGU2sKO29K1hPJtoaKOY6N6QWi3VxvukHz
	 u5tO22WJCywCw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 5/8] ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC quirk
Date: Mon,  1 Dec 2025 13:35:07 +0100
Message-ID: <20251201123501.246282-15-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6339; i=cassel@kernel.org; h=from:subject; bh=mNIFdRwYGP4C1OKoQXRFlmnUo02TICF2a7zUvxmHIiM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6u2pvYkv5pzb895M17+/jgbt1t30uq2zjRg0Fgim pN788vKjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkizbDX1nzeSsiu6/dn6C/ 0uEzY7Jb466sjVs/+NkdD03xZvN8bM3IMFk06VvJCo+zXFMDzScWV8YWtZmbMmv8v2N79dshzfs 9XAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Modify the existing libata.force parameters "max_sec_128" and
"max_sec_1024" to use the generic ATA_QUIRK_MAX_SEC quirk rather than
individual quirks.

This also allows us to remove the individual quirks ATA_QUIRK_MAX_SEC_128
and ATA_QUIRK_MAX_SEC_1024.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-core.c | 28 ++++++++++++++++------------
 include/linux/ata.h       |  2 --
 include/linux/libata.h    |  4 ----
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3657cd28e09a4..697188b990dd6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,6 +84,7 @@ static DEFINE_IDA(ata_ida);
 #ifdef CONFIG_ATA_FORCE
 struct ata_force_param {
 	const char	*name;
+	u64		value;
 	u8		cbl;
 	u8		spd_limit;
 	unsigned int	xfer_mask;
@@ -3152,14 +3153,6 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->quirks |= ATA_QUIRK_STUCK_ERR;
 	}
 
-	if (dev->quirks & ATA_QUIRK_MAX_SEC_128)
-		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
-					 dev->max_sectors);
-
-	if (dev->quirks & ATA_QUIRK_MAX_SEC_1024)
-		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
-					 dev->max_sectors);
-
 	if (dev->quirks & ATA_QUIRK_MAX_SEC)
 		dev->max_sectors = min_t(unsigned int, dev->max_sectors,
 					 ata_dev_get_quirk_value(dev,
@@ -3995,7 +3988,6 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_DIAGNOSTIC]	= "diagnostic",
 	[__ATA_QUIRK_NODMA]		= "nodma",
 	[__ATA_QUIRK_NONCQ]		= "noncq",
-	[__ATA_QUIRK_MAX_SEC_128]	= "maxsec128",
 	[__ATA_QUIRK_BROKEN_HPA]	= "brokenhpa",
 	[__ATA_QUIRK_DISABLE]		= "disable",
 	[__ATA_QUIRK_HPA_SIZE]		= "hpasize",
@@ -4016,7 +4008,6 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_ZERO_AFTER_TRIM]	= "zeroaftertrim",
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
-	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
 	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
@@ -4396,6 +4387,14 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
 	const struct ata_dev_quirk_value *ad = __ata_dev_max_sec_quirks;
 	u64 val = 0;
 
+#ifdef CONFIG_ATA_FORCE
+	const struct ata_force_ent *fe = ata_force_get_fe_for_dev(dev);
+	if (fe && (fe->param.quirk_on & ATA_QUIRK_MAX_SEC) && fe->param.value)
+		val = fe->param.value;
+#endif
+	if (val)
+		goto out;
+
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
@@ -4408,6 +4407,7 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
 		ad++;
 	}
 
+out:
 	ata_dev_warn(dev, "%s quirk is using value: %llu\n",
 		     ata_quirk_names[__ATA_QUIRK_MAX_SEC], val);
 
@@ -6453,6 +6453,10 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
+#define force_quirk_val(name, flag, val)		\
+	{ #name,	.quirk_on	= (flag),	\
+			.value		= (val) }
+
 #define force_quirk_onoff(name, flag)			\
 	{ "no" #name,	.quirk_on	= (flag) },	\
 	{ #name,	.quirk_off	= (flag) }
@@ -6527,8 +6531,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_quirk_onoff(iddevlog,	ATA_QUIRK_NO_ID_DEV_LOG),
 	force_quirk_onoff(logdir,	ATA_QUIRK_NO_LOG_DIR),
 
-	force_quirk_on(max_sec_128,	ATA_QUIRK_MAX_SEC_128),
-	force_quirk_on(max_sec_1024,	ATA_QUIRK_MAX_SEC_1024),
+	force_quirk_val(max_sec_128,	ATA_QUIRK_MAX_SEC,	128),
+	force_quirk_val(max_sec_1024,	ATA_QUIRK_MAX_SEC,	1024),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c9013e472aa3d..8fd48bcb2a46c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -26,9 +26,7 @@ enum {
 	ATA_MAX_DEVICES		= 2,	/* per bus/port */
 	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
 	ATA_SECT_SIZE		= 512,
-	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
-	ATA_MAX_SECTORS_1024    = 1024,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* avoid count to be 0000h */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 	ATA_MAX_TRIM_RNUM	= 64,	/* 512-byte payload / (6-byte LBA + 2-byte range per entry) */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 11b6a44572acd..7e5cd1647353f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -52,7 +52,6 @@ enum ata_quirks {
 	__ATA_QUIRK_DIAGNOSTIC,		/* Failed boot diag */
 	__ATA_QUIRK_NODMA,		/* DMA problems */
 	__ATA_QUIRK_NONCQ,		/* Don't use NCQ */
-	__ATA_QUIRK_MAX_SEC_128,	/* Limit max sects to 128 */
 	__ATA_QUIRK_BROKEN_HPA,		/* Broken HPA */
 	__ATA_QUIRK_DISABLE,		/* Disable it */
 	__ATA_QUIRK_HPA_SIZE,		/* Native size off by one */
@@ -74,7 +73,6 @@ enum ata_quirks {
 	__ATA_QUIRK_ZERO_AFTER_TRIM,	/* Guarantees zero after trim */
 	__ATA_QUIRK_NO_DMA_LOG,		/* Do not use DMA for log read */
 	__ATA_QUIRK_NOTRIM,		/* Do not use TRIM */
-	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
 	__ATA_QUIRK_MAX_SEC,		/* Limit max sectors */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
@@ -94,7 +92,6 @@ enum {
 	ATA_QUIRK_DIAGNOSTIC		= (1U << __ATA_QUIRK_DIAGNOSTIC),
 	ATA_QUIRK_NODMA			= (1U << __ATA_QUIRK_NODMA),
 	ATA_QUIRK_NONCQ			= (1U << __ATA_QUIRK_NONCQ),
-	ATA_QUIRK_MAX_SEC_128		= (1U << __ATA_QUIRK_MAX_SEC_128),
 	ATA_QUIRK_BROKEN_HPA		= (1U << __ATA_QUIRK_BROKEN_HPA),
 	ATA_QUIRK_DISABLE		= (1U << __ATA_QUIRK_DISABLE),
 	ATA_QUIRK_HPA_SIZE		= (1U << __ATA_QUIRK_HPA_SIZE),
@@ -115,7 +112,6 @@ enum {
 	ATA_QUIRK_ZERO_AFTER_TRIM	= (1U << __ATA_QUIRK_ZERO_AFTER_TRIM),
 	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
 	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
-	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
 	ATA_QUIRK_MAX_SEC		= (1U << __ATA_QUIRK_MAX_SEC),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
-- 
2.52.0

