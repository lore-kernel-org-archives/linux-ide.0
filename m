Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22D311C13
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678110; cv=none; b=cdRg8inNXW5viEV7heEIVLgkmxoZxb6ZHaDs1y8zDEwJw0bU9RYnA4z+sp5WKS8l00SILs/bNC9UuxTATAzYkE3LVmt8JhmFyXHTx1iK9dL57Zw9Ek3W9dJsGPDw06WftKQji2cwu4wj8RN0egQIlwcfJB3jYwcAk7W46kN+ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678110; c=relaxed/simple;
	bh=Wc92ZfisGFM8YGCMm7ooZJUv/WpLXM9yCxwyWQoHstg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWRGy28IqVcNV7NjtoxOJv208pw8r33IwFgVn+qpxTgLm0v6ywkT0JkSRJ9IZxcd5yfsccaH8hFv62+g1P/UgHTgq1UoJ6s2NiKbzvj7Nm7quJ4EST4vR++8bf0sXUCsKMnfHMhGgENBE+5sk5/3CWeBMQoPaNJfE6zfA2HaZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQw68LgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQw68LgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE44C116D0;
	Tue,  2 Dec 2025 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678110;
	bh=Wc92ZfisGFM8YGCMm7ooZJUv/WpLXM9yCxwyWQoHstg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQw68LgXBGu9rPJMNefrCa6RDkU2wKA5cpkY3aTP1SoiBwIO7hGixrxeVAzZiuS+0
	 sIiCrOfF88qlSl3wccrh8ZFRL7/OYhj4swp01TBoStw6OlwXrptgSLrVPqVPPWyxs5
	 qKiikxjGHc16K33kcpTkKEvzfs769cPcPNr9R6cbeZciXQnWBcboOJwJIGqDID/KNe
	 iRZKyu5vAa6ATboFYlyO7eVFUB9S1OLSZ3/yfuPWW+C7eu5yRryu4njDkdVe5N7XMR
	 mBWFI/3CIvlzb7V5zaKCaEd7UBq4AczljRJgy3JWNUtxpbSNjOyOoUqm/YsFtcYYMQ
	 IROrpaYGbRtUg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 3/6] ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC quirk
Date: Tue,  2 Dec 2025 13:21:33 +0100
Message-ID: <20251202122129.421783-11-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
References: <20251202122129.421783-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6389; i=cassel@kernel.org; h=from:subject; bh=Wc92ZfisGFM8YGCMm7ooZJUv/WpLXM9yCxwyWQoHstg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp6Tf36kSF9Tlln3ppEd49yHQh6avxTDfu/de8Pqn YVTXcnfjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEyEyYvhr9DuLe5FVr0JJh7v cmWcjZu/Chl1XbxyY9rM9BP6shat6Qx/OIqPm31jnd7/4djGssqeP77/5DReTDd8lTn3/868K9J HuAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Modify the existing libata.force parameters "max_sec_128" and
"max_sec_1024" to use the generic ATA_QUIRK_MAX_SEC quirk rather than
individual quirks.

This also allows us to remove the individual quirks ATA_QUIRK_MAX_SEC_128
and ATA_QUIRK_MAX_SEC_1024.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 28 ++++++++++++++++------------
 include/linux/ata.h       |  2 --
 include/linux/libata.h    |  4 ----
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4dad69b603713..f7f5b530bc2a7 100644
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
@@ -3144,14 +3145,6 @@ int ata_dev_configure(struct ata_device *dev)
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
@@ -3987,7 +3980,6 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_DIAGNOSTIC]	= "diagnostic",
 	[__ATA_QUIRK_NODMA]		= "nodma",
 	[__ATA_QUIRK_NONCQ]		= "noncq",
-	[__ATA_QUIRK_MAX_SEC_128]	= "maxsec128",
 	[__ATA_QUIRK_BROKEN_HPA]	= "brokenhpa",
 	[__ATA_QUIRK_DISABLE]		= "disable",
 	[__ATA_QUIRK_HPA_SIZE]		= "hpasize",
@@ -4008,7 +4000,6 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_ZERO_AFTER_TRIM]	= "zeroaftertrim",
 	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
 	[__ATA_QUIRK_NOTRIM]		= "notrim",
-	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
 	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
@@ -4392,6 +4383,14 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
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
 
@@ -4404,6 +4403,7 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
 		ad++;
 	}
 
+out:
 	ata_dev_warn(dev, "%s quirk is using value: %llu\n",
 		     ata_quirk_names[__ATA_QUIRK_MAX_SEC], val);
 
@@ -6449,6 +6449,10 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
+#define force_quirk_val(name, flag, val)		\
+	{ #name,	.quirk_on	= (flag),	\
+			.value		= (val) }
+
 #define force_quirk_onoff(name, flag)			\
 	{ "no" #name,	.quirk_on	= (flag) },	\
 	{ #name,	.quirk_off	= (flag) }
@@ -6523,8 +6527,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_quirk_onoff(iddevlog,	ATA_QUIRK_NO_ID_DEV_LOG),
 	force_quirk_onoff(logdir,	ATA_QUIRK_NO_LOG_DIR),
 
-	force_quirk_on(max_sec_128,	ATA_QUIRK_MAX_SEC_128),
-	force_quirk_on(max_sec_1024,	ATA_QUIRK_MAX_SEC_1024),
+	force_quirk_val(max_sec_128,	ATA_QUIRK_MAX_SEC,	128),
+	force_quirk_val(max_sec_1024,	ATA_QUIRK_MAX_SEC,	1024),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 792e10a09787f..8abd6ef19da92 100644
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
index 0b37cdfae869e..718b4428bda33 100644
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

