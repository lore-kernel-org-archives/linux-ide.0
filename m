Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE541EA80
	for <linux-ide@vger.kernel.org>; Thu, 18 Jul 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298842; cv=none; b=GhQaSg9dygsnKLKSoWx0tD5nmgasyLnaL6S9WOXhutgw+V5o4sn3tOgAsVm9mfVSZdX46c+eVfP8WuaeEZoOdRj5Ce85VgZ1pZAHpU3iNxL29tcOLfsXwTqR36XNT7+2McBxXiJxZfGuiJeoEd9YVdQvCBGfrpx6Yfz6ihaLVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298842; c=relaxed/simple;
	bh=81MZkniIJxrYGdAylxmGbytZv+hqkujWdHLaCdtpVPQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHyBMss+mQhF3LO3Y5PYurJlTUtREHKZ2zbrh9rbx89RpiAEh1TgEudUmFE7/NKwN4+TWvX2DdWsri+Et4tDu2fkqQPqjp8McTc1+E1YpSqny86zNh1quc0VPTk0wejLuoFfnZcsR+4MsGCIxALbwFuSQokUMa3AZ+dosVHc/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTMUPqlt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTMUPqlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D6C4AF0D;
	Thu, 18 Jul 2024 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298841;
	bh=81MZkniIJxrYGdAylxmGbytZv+hqkujWdHLaCdtpVPQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PTMUPqltwpH/lLXKd8X3mFQZ6L+xmWorPO4bdx9y3AjKVORve/1pp6L82ES//gT7q
	 Zb3ulBVrIzd//E99Ss1IVV6JVsigYVjpwlRbhHIE6Joq51EAD02X8b85e8q1I7mISN
	 g9T2d6sGxt1TOQQnTrs3bkmrPXsJOMUsjgSO3bryqKEVLgvJYh/C9PDnE0we3Eq1G/
	 lYJG6k7CpPmFMi5YJ6Ypo50gQmBgTXUhaX+Yfr83ttvHlr+mZTb/eq62bm5djuqNoT
	 I9l1wKq/2necZizpvXLavEfeOGf3KJDeggghsWZIEitVbTgcZG95USyRt4ofG0fEJQ
	 9Tzt7SKOW03hw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/3] ata: libata: Print horkages applied to devices
Date: Thu, 18 Jul 2024 19:33:58 +0900
Message-ID: <20240718103358.176260-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718103358.176260-1-dlemoal@kernel.org>
References: <20240718103358.176260-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function ata_dev_print_horkage() to print the horkage
flags that will be used for a device. This new function is called from
ata_dev_horkage() when a match on a device model or device model and
revision is found for a device in the ata_dev_horkages array.

To implement this function, the ATA_HORKAGE_ flags are redefined using
the new enum ata_horkage which defines the bit shift for each horkage
flag. The array of strings ata_horkage_names is used to define the name
of each flag, which are printed by ata_dev_print_horkage().

Example output for a device listed in the ata_dev_horkages array and
which has the ATA_HORKAGE_DISABLE flag applied:

[10193.461270] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[10193.469190] ata1.00: Model ASMT109x- Config, applying horkages: disable
[10193.469195] ata1.00: unsupported device, disabling
[10193.481564] ata1.00: disable device

And while at it, make sure to use the unsigned int type for horkage
flags as struct ata_device->horkage is an unsugned int.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c |  79 ++++++++++++++++++++++++++--
 include/linux/libata.h    | 108 +++++++++++++++++++++++++-------------
 2 files changed, 145 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ee958d2893e6..398f0aa10b1b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static unsigned long ata_dev_horkage(const struct ata_device *dev);
+static unsigned int ata_dev_horkage(const struct ata_device *dev);
 
 static DEFINE_IDA(ata_ida);
 
@@ -3987,10 +3987,73 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	return rc;
 }
 
+static const char *ata_horkage_names[] = {
+	[__ATA_HORKAGE_DIAGNOSTIC]	= "diagnostic",
+	[__ATA_HORKAGE_NODMA]		= "nodma",
+	[__ATA_HORKAGE_NONCQ]		= "noncq",
+	[__ATA_HORKAGE_MAX_SEC_128]	= "maxsec128",
+	[__ATA_HORKAGE_BROKEN_HPA]	= "brokenhpa",
+	[__ATA_HORKAGE_DISABLE]		= "disable",
+	[__ATA_HORKAGE_HPA_SIZE]	= "hpasize",
+	[__ATA_HORKAGE_IVB]		= "ivb",
+	[__ATA_HORKAGE_STUCK_ERR]	= "stuckerr",
+	[__ATA_HORKAGE_BRIDGE_OK]	= "bridgeok",
+	[__ATA_HORKAGE_ATAPI_MOD16_DMA]	= "atapimod16dma",
+	[__ATA_HORKAGE_FIRMWARE_WARN]	= "firmwarewarn",
+	[__ATA_HORKAGE_1_5_GBPS]	= "1.5gbps",
+	[__ATA_HORKAGE_NOSETXFER]	= "nosetxfer",
+	[__ATA_HORKAGE_BROKEN_FPDMA_AA]	= "brokenfpdmaaa",
+	[__ATA_HORKAGE_DUMP_ID]		= "dumpid",
+	[__ATA_HORKAGE_MAX_SEC_LBA48]	= "maxseclba48",
+	[__ATA_HORKAGE_ATAPI_DMADIR]	= "atapidmadir",
+	[__ATA_HORKAGE_NO_NCQ_TRIM]	= "noncqtrim",
+	[__ATA_HORKAGE_NOLPM]		= "nolpm",
+	[__ATA_HORKAGE_WD_BROKEN_LPM]	= "wdbrokenlpm",
+	[__ATA_HORKAGE_ZERO_AFTER_TRIM]	= "zeroaftertrim",
+	[__ATA_HORKAGE_NO_DMA_LOG]	= "nodmalog",
+	[__ATA_HORKAGE_NOTRIM]		= "notrim",
+	[__ATA_HORKAGE_MAX_SEC_1024]	= "maxsec1024",
+	[__ATA_HORKAGE_MAX_TRIM_128M]	= "maxtrim128m",
+	[__ATA_HORKAGE_NO_NCQ_ON_ATI]	= "noncqonati",
+	[__ATA_HORKAGE_NO_ID_DEV_LOG]	= "noiddevlog",
+	[__ATA_HORKAGE_NO_LOG_DIR]	= "nologdir",
+	[__ATA_HORKAGE_NO_FUA]		= "nofua",
+};
+
+static void ata_dev_print_horkage(const struct ata_device *dev,
+				  const char *model, const char *rev,
+				  unsigned int horkage)
+{
+	int n = 0, i;
+	size_t sz;
+	char *str;
+
+	if (!horkage)
+		return;
+
+	sz = 64 + ARRAY_SIZE(ata_horkage_names) * 16;
+	str = kmalloc(sz, GFP_KERNEL);
+	if (!str)
+		return;
+
+	n = snprintf(str, sz, "Model %s%s%s, applying horkages:",
+		     model, rev ? ", rev" : "", rev ? rev : "");
+
+	for (i = 0; i < ARRAY_SIZE(ata_horkage_names); i++) {
+		if (horkage & (1U << i))
+			n += snprintf(str + n, sz - n,
+				      " %s", ata_horkage_names[i]);
+	}
+
+	ata_dev_warn(dev, "%s", str);
+
+	kfree(str);
+}
+
 struct ata_dev_horkage_entry {
 	const char *model_num;
 	const char *model_rev;
-	unsigned long horkage;
+	unsigned int horkage;
 };
 
 static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
@@ -4266,7 +4329,7 @@ static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
 	{ }
 };
 
-static unsigned long ata_dev_horkage(const struct ata_device *dev)
+static unsigned int ata_dev_horkage(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
@@ -4277,10 +4340,16 @@ static unsigned long ata_dev_horkage(const struct ata_device *dev)
 
 	while (ad->model_num) {
 		if (glob_match(ad->model_num, model_num)) {
-			if (ad->model_rev == NULL)
+			if (ad->model_rev == NULL) {
+				ata_dev_print_horkage(dev, model_num,
+						      NULL, ad->horkage);
 				return ad->horkage;
-			if (glob_match(ad->model_rev, model_rev))
+			}
+			if (glob_match(ad->model_rev, model_rev)) {
+				ata_dev_print_horkage(dev, model_num,
+						      model_rev, ad->horkage);
 				return ad->horkage;
+			}
 		}
 		ad++;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 17394098bee9..5378d364c0f2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -55,6 +55,44 @@
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
+/*
+ * Horkage types. May be set by libata or controller on drives.
+ * Some horkage may be drive/controller pair dependent.
+ */
+enum ata_horkage {
+	__ATA_HORKAGE_DIAGNOSTIC,	/* Failed boot diag */
+	__ATA_HORKAGE_NODMA,		/* DMA problems */
+	__ATA_HORKAGE_NONCQ,		/* Don't use NCQ */
+	__ATA_HORKAGE_MAX_SEC_128,	/* Limit max sects to 128 */
+	__ATA_HORKAGE_BROKEN_HPA,	/* Broken HPA */
+	__ATA_HORKAGE_DISABLE,		/* Disable it */
+	__ATA_HORKAGE_HPA_SIZE,		/* native size off by one */
+	__ATA_HORKAGE_IVB,		/* cbl det validity bit bugs */
+	__ATA_HORKAGE_STUCK_ERR,	/* stuck ERR on next PACKET */
+	__ATA_HORKAGE_BRIDGE_OK,	/* no bridge limits */
+	__ATA_HORKAGE_ATAPI_MOD16_DMA,	/* use ATAPI DMA for commands
+					    not multiple of 16 bytes */
+	__ATA_HORKAGE_FIRMWARE_WARN,	/* firmware update warning */
+	__ATA_HORKAGE_1_5_GBPS,		/* force 1.5 Gbps */
+	__ATA_HORKAGE_NOSETXFER,		/* skip SETXFER, SATA only */
+	__ATA_HORKAGE_BROKEN_FPDMA_AA,	/* skip AA */
+	__ATA_HORKAGE_DUMP_ID,		/* dump IDENTIFY data */
+	__ATA_HORKAGE_MAX_SEC_LBA48,	/* Set max sects to 65535 */
+	__ATA_HORKAGE_ATAPI_DMADIR,	/* device requires dmadir */
+	__ATA_HORKAGE_NO_NCQ_TRIM,	/* don't use queued TRIM */
+	__ATA_HORKAGE_NOLPM,		/* don't use LPM */
+	__ATA_HORKAGE_WD_BROKEN_LPM,	/* some WDs have broken LPM */
+	__ATA_HORKAGE_ZERO_AFTER_TRIM,	/* guarantees zero after trim */
+	__ATA_HORKAGE_NO_DMA_LOG,	/* don't use DMA for log read */
+	__ATA_HORKAGE_NOTRIM,		/* don't use TRIM */
+	__ATA_HORKAGE_MAX_SEC_1024,	/* Limit max sects to 1024 */
+	__ATA_HORKAGE_MAX_TRIM_128M,	/* Limit max trim size to 128M */
+	__ATA_HORKAGE_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
+	__ATA_HORKAGE_NO_ID_DEV_LOG,	/* Identify device log missing */
+	__ATA_HORKAGE_NO_LOG_DIR,	/* Do not read log directory */
+	__ATA_HORKAGE_NO_FUA,		/* Do not use FUA */
+};
+
 enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
@@ -362,43 +400,39 @@ enum {
 	 */
 	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
 
-	/* Horkage types. May be set by libata or controller on drives
-	   (some horkage may be drive/controller pair dependent */
-
-	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
-	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
-	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
-	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
-	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
-	ATA_HORKAGE_DISABLE	= (1 << 5),	/* Disable it */
-	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
-	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
-	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
-	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
-	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
-						    not multiple of 16 bytes */
-	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
-	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
-	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
-	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
-	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
-	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
-	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
-	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
-	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
-	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
-	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
-	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
-	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
-	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
-	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
-	ATA_HORKAGE_NO_NCQ_ON_ATI = (1 << 27),	/* Disable NCQ on ATI chipset */
-	ATA_HORKAGE_NO_ID_DEV_LOG = (1 << 28),	/* Identify device log missing */
-	ATA_HORKAGE_NO_LOG_DIR	= (1 << 29),	/* Do not read log directory */
-	ATA_HORKAGE_NO_FUA	= (1 << 30),	/* Do not use FUA */
-
-	 /* DMA mask for user DMA control: User visible values; DO NOT
-	    renumber */
+	/* Horkage flags */
+	ATA_HORKAGE_DIAGNOSTIC      = (1U << __ATA_HORKAGE_DIAGNOSTIC),
+	ATA_HORKAGE_NODMA           = (1U << __ATA_HORKAGE_NODMA),
+	ATA_HORKAGE_NONCQ           = (1U << __ATA_HORKAGE_NONCQ),
+	ATA_HORKAGE_MAX_SEC_128     = (1U << __ATA_HORKAGE_MAX_SEC_128),
+	ATA_HORKAGE_BROKEN_HPA      = (1U << __ATA_HORKAGE_BROKEN_HPA),
+	ATA_HORKAGE_DISABLE         = (1U << __ATA_HORKAGE_DISABLE),
+	ATA_HORKAGE_HPA_SIZE        = (1U << __ATA_HORKAGE_HPA_SIZE),
+	ATA_HORKAGE_IVB             = (1U << __ATA_HORKAGE_IVB),
+	ATA_HORKAGE_STUCK_ERR       = (1U << __ATA_HORKAGE_STUCK_ERR),
+	ATA_HORKAGE_BRIDGE_OK       = (1U << __ATA_HORKAGE_BRIDGE_OK),
+	ATA_HORKAGE_ATAPI_MOD16_DMA = (1U << __ATA_HORKAGE_ATAPI_MOD16_DMA),
+	ATA_HORKAGE_FIRMWARE_WARN   = (1U << __ATA_HORKAGE_FIRMWARE_WARN),
+	ATA_HORKAGE_1_5_GBPS        = (1U << __ATA_HORKAGE_1_5_GBPS),
+	ATA_HORKAGE_NOSETXFER       = (1U << __ATA_HORKAGE_NOSETXFER),
+	ATA_HORKAGE_BROKEN_FPDMA_AA = (1U << __ATA_HORKAGE_BROKEN_FPDMA_AA),
+	ATA_HORKAGE_DUMP_ID         = (1U << __ATA_HORKAGE_DUMP_ID),
+	ATA_HORKAGE_MAX_SEC_LBA48   = (1U << __ATA_HORKAGE_MAX_SEC_LBA48),
+	ATA_HORKAGE_ATAPI_DMADIR    = (1U << __ATA_HORKAGE_ATAPI_DMADIR),
+	ATA_HORKAGE_NO_NCQ_TRIM     = (1U << __ATA_HORKAGE_NO_NCQ_TRIM),
+	ATA_HORKAGE_NOLPM           = (1U << __ATA_HORKAGE_NOLPM),
+	ATA_HORKAGE_WD_BROKEN_LPM   = (1U << __ATA_HORKAGE_WD_BROKEN_LPM),
+	ATA_HORKAGE_ZERO_AFTER_TRIM = (1U << __ATA_HORKAGE_ZERO_AFTER_TRIM),
+	ATA_HORKAGE_NO_DMA_LOG      = (1U << __ATA_HORKAGE_NO_DMA_LOG),
+	ATA_HORKAGE_NOTRIM          = (1U << __ATA_HORKAGE_NOTRIM),
+	ATA_HORKAGE_MAX_SEC_1024    = (1U << __ATA_HORKAGE_MAX_SEC_1024),
+	ATA_HORKAGE_MAX_TRIM_128M   = (1U << __ATA_HORKAGE_MAX_TRIM_128M),
+	ATA_HORKAGE_NO_NCQ_ON_ATI   = (1U << __ATA_HORKAGE_NO_NCQ_ON_ATI),
+	ATA_HORKAGE_NO_ID_DEV_LOG   = (1U << __ATA_HORKAGE_NO_ID_DEV_LOG),
+	ATA_HORKAGE_NO_LOG_DIR      = (1U << __ATA_HORKAGE_NO_LOG_DIR),
+	ATA_HORKAGE_NO_FUA          = (1U << __ATA_HORKAGE_NO_FUA),
+
+	/* User visible DMA mask for DMA control. DO NOT renumber. */
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
 	ATA_DMA_MASK_ATAPI	= (1 << 1),	/* DMA on ATAPI */
 	ATA_DMA_MASK_CFA	= (1 << 2),	/* DMA on CF Card */
-- 
2.45.2

