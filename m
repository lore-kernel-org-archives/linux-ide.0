Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA82FC89F
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319720; cv=none; b=hXwrtzsleDDA4sh3msKRiOdEkNnB3vtaDSUaeMOPArNYkIpR+F3Mn9ehDjNWZf5eHS0K2qxmS4NakKzLYx8QzjM802mD/uw7Gudjw5tsyb5hwjQSHv4jTFl1CXPwgm/sg/lmDNFPAsnz6oYb/I2icUMO1KcIo+OfP9XRugxbvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319720; c=relaxed/simple;
	bh=oO/50+7K2TEz0VXUROtAX/Ct5E2rf465Hu4xyfarhxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZFC+lCIamtFqsrMtg67to6YQKn6i+ut0o/pmRmUc2xjcD1RzwoDb9gKtjrNymw+3kmlJz4Hbf9taYIGKR1cWE318sCYZGrNVVD++z/0GCdJgJSuLEOCsMfGIxsD0iYYbdLehpdDI2Ct47O6HO2F6mAm/wucEL+5wUjPh0y5Jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsTUp6Fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsTUp6Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E031C2BCB1;
	Fri, 28 Nov 2025 08:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319719;
	bh=oO/50+7K2TEz0VXUROtAX/Ct5E2rf465Hu4xyfarhxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsTUp6FkM/8N9/jVOkNUpnZfs9MLd2OZcKriT645V/IkN82mVnj/PVoY95Weq5Ltz
	 bHsA6gyIy9Em0shESC6ejbsNXxj8jxNnGtg2dJey7hH2fX6R/RX+fSQrmK7FVLJOtv
	 JuIxwaRou/9IC2x9SIWq5UTUalcr0SFdck2Vs+1AfDlIkTB2+//tfF58oV1mvt6oRd
	 ksjYQrjXNUyfPcO9iRtLXAL7Li9vsjZJsMvq+3x1+OAMIjc96+RUyv+QFcRNHmXQi6
	 s5ilHeeqnnO2Bzvl1thySI+YJhkh44A4na3pMJsOsl1iv3Ci7J105CSvCg6rNlG5ad
	 Qd4YsKI9D5/Pg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 4/8] ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC quirk
Date: Fri, 28 Nov 2025 09:48:19 +0100
Message-ID: <20251128084814.3798425-14-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6277; i=cassel@kernel.org; h=from:subject; bh=oO/50+7K2TEz0VXUROtAX/Ct5E2rf465Hu4xyfarhxk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey99kjTMc/jgGqzSOUH97sG1D8rlD4sGchtzTLoSe HcnW7JcRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYSy8bwTz1SlMsreHunmUxz dIZP0kd/FbNPrVk6z9g5Hz6/ZjG/jpHheTrnOUO1vYmKzeY2BbLxDtsm73t5PaVJR23CJQHtVyJ 8AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Modify the existing libata.force parameters "max_sec_128" and
"max_sec_1024" to use the generic ATA_QUIRK_MAX_SEC quirk rather than
individual quirks.

This also allows us to remove the individual quirks ATA_QUIRK_MAX_SEC_128
and ATA_QUIRK_MAX_SEC_1024.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 28 ++++++++++++++++------------
 include/linux/ata.h       |  2 --
 include/linux/libata.h    |  4 ----
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b1ef45c1a376a..a3fdb73e48fb7 100644
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
@@ -4389,6 +4380,14 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
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
 
@@ -4401,6 +4400,7 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
 		ad++;
 	}
 
+out:
 	ata_dev_warn(dev, "%s quirk is using value: %llu\n",
 		     ata_quirk_names[__ATA_QUIRK_MAX_SEC], val);
 
@@ -6446,6 +6446,10 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
+#define force_quirk_val(name, flag, val)		\
+	{ #name,	.quirk_on	= (flag),	\
+			.value		= (val) }
+
 #define force_quirk_onoff(name, flag)			\
 	{ "no" #name,	.quirk_on	= (flag) },	\
 	{ #name,	.quirk_off	= (flag) }
@@ -6520,8 +6524,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
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

