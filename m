Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF43054F2
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592528; cv=none; b=HDJodxfswZahjBErpcegqRxsIdsqTLXRS6IMNPRldTjI2dlDh1QuSDIdZC+ncYZKxsOQ7v57HnzGm1X/CluqnmDTz8rNdc9TdveR94Ex4z5+27lVuhRxA/NZiRNQSaqbSVpwgoO40f4H8fc9hOno7CiUJ/nsmZgQ/4KqiW8fXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592528; c=relaxed/simple;
	bh=NUDI7k0Oy/JUzMc9TOrD/msLDFTwMZWovb549aektvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw96kJcGIkTGmD+I+F1JDGRI7UNRC9ekKDn7KhU9gRbR7EUC28NWyT6J5bii17oJa2d1heatvVb2fjuuq4efz5mnNdIIu2J6TkJzwsAPvx7XQWkhXc3/mSeZj/1U5U+u7b/1j1CA2kTUBu7PHIpOF4aEzBQhGRJZEJe7EZ1EkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJEJknDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJEJknDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B4AC116D0;
	Mon,  1 Dec 2025 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592528;
	bh=NUDI7k0Oy/JUzMc9TOrD/msLDFTwMZWovb549aektvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJEJknDHKJIQiQRVgZdAUtnjuP4nMw339PWNr+E6fuQYVC2kAf66LE1HVTK7/WTJy
	 Uo25TvoeLa0glRsNAQFIw8ay8biyMR9C0+9IRAaBA2ZJ6LPt/wkYL/iUXQ2E8LxDu5
	 Toj2BcanTu2Dj2bzHfXodAba3Cf577AHeeANBlRe/6gh6VYV1bU5evIK8mvIeprhxi
	 6BYE5snI+zid0S5LjfuDyo3zGG8fCU+FOtK4OTXHDhSyV+XWUblZvLea53P5UZQu0Y
	 NSxMRLWBH1VkUd3HyJoaRYT27FcOYnsosUoZ3p/HS6o0lw8wzdkfrVmJCBYr6dlUqN
	 daZ8QwDLhLGiA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 8/8] ata: libata: Allow more quirks
Date: Mon,  1 Dec 2025 13:35:10 +0100
Message-ID: <20251201123501.246282-18-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7511; i=cassel@kernel.org; h=from:subject; bh=NUDI7k0Oy/JUzMc9TOrD/msLDFTwMZWovb549aektvc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6tn+PDMS0xc9NrCWV/mhaL3p/+lDW/WLG94smZ9N ce8pfsndpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiDEsZGaac2jOTUe2vwLaV xkcZHQ0llLf0Nh+dqs74oubGxy2b/2gy/FNbsOtOd8PlhQEfXBpTc2uWscVK/+E+9cKyJ6wumj/ 5KyMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

We have currently used up 30 out of the 32-bits in the struct ata_device
struct member quirks. Thus, it is only possible to add two more quirks.

Change the struct ata_device struct member quirks from an unsigned int to
an u64.

Doing this core level change now, will make it easier for us now, as we
will not need to also do core level changes once the final two bits are
used as well.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-core.c | 18 +++++------
 include/linux/libata.h    | 64 +++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c122a8aa27688..a15ddd8855b53 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -76,8 +76,8 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static unsigned int ata_dev_quirks(const struct ata_device *dev);
-static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk);
+static u64 ata_dev_quirks(const struct ata_device *dev);
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, u64 quirk);
 
 static DEFINE_IDA(ata_ida);
 
@@ -88,8 +88,8 @@ struct ata_force_param {
 	u8		cbl;
 	u8		spd_limit;
 	unsigned int	xfer_mask;
-	unsigned int	quirk_on;
-	unsigned int	quirk_off;
+	u64		quirk_on;
+	u64		quirk_off;
 	unsigned int	pflags_on;
 	u16		lflags_on;
 	u16		lflags_off;
@@ -4071,7 +4071,7 @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
 struct ata_dev_quirks_entry {
 	const char *model_num;
 	const char *model_rev;
-	unsigned int quirks;
+	u64 quirks;
 };
 
 static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
@@ -4356,14 +4356,14 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ }
 };
 
-static unsigned int ata_dev_quirks(const struct ata_device *dev)
+static u64 ata_dev_quirks(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
 	const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
 
-	/* dev->quirks is an unsigned int. */
-	BUILD_BUG_ON(__ATA_QUIRK_MAX > 32);
+	/* dev->quirks is an u64. */
+	BUILD_BUG_ON(__ATA_QUIRK_MAX > 64);
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
@@ -4414,7 +4414,7 @@ static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
 	return val;
 }
 
-static u64 ata_dev_get_quirk_value(struct ata_device *dev, unsigned int quirk)
+static u64 ata_dev_get_quirk_value(struct ata_device *dev, u64 quirk)
 {
 	if (quirk == ATA_QUIRK_MAX_SEC)
 		return ata_dev_get_max_sec_quirk_value(dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7e5cd1647353f..aa88244f3d838 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -46,7 +46,7 @@
 
 /*
  * Quirk flags bits.
- * ata_device->quirks is an unsigned int, so __ATA_QUIRK_MAX must not exceed 32.
+ * ata_device->quirks is an u64, so __ATA_QUIRK_MAX must not exceed 64.
  */
 enum ata_quirks {
 	__ATA_QUIRK_DIAGNOSTIC,		/* Failed boot diag */
@@ -89,36 +89,36 @@ enum ata_quirks {
  * Some quirks may be drive/controller pair dependent.
  */
 enum {
-	ATA_QUIRK_DIAGNOSTIC		= (1U << __ATA_QUIRK_DIAGNOSTIC),
-	ATA_QUIRK_NODMA			= (1U << __ATA_QUIRK_NODMA),
-	ATA_QUIRK_NONCQ			= (1U << __ATA_QUIRK_NONCQ),
-	ATA_QUIRK_BROKEN_HPA		= (1U << __ATA_QUIRK_BROKEN_HPA),
-	ATA_QUIRK_DISABLE		= (1U << __ATA_QUIRK_DISABLE),
-	ATA_QUIRK_HPA_SIZE		= (1U << __ATA_QUIRK_HPA_SIZE),
-	ATA_QUIRK_IVB			= (1U << __ATA_QUIRK_IVB),
-	ATA_QUIRK_STUCK_ERR		= (1U << __ATA_QUIRK_STUCK_ERR),
-	ATA_QUIRK_BRIDGE_OK		= (1U << __ATA_QUIRK_BRIDGE_OK),
-	ATA_QUIRK_ATAPI_MOD16_DMA	= (1U << __ATA_QUIRK_ATAPI_MOD16_DMA),
-	ATA_QUIRK_FIRMWARE_WARN		= (1U << __ATA_QUIRK_FIRMWARE_WARN),
-	ATA_QUIRK_1_5_GBPS		= (1U << __ATA_QUIRK_1_5_GBPS),
-	ATA_QUIRK_NOSETXFER		= (1U << __ATA_QUIRK_NOSETXFER),
-	ATA_QUIRK_BROKEN_FPDMA_AA	= (1U << __ATA_QUIRK_BROKEN_FPDMA_AA),
-	ATA_QUIRK_DUMP_ID		= (1U << __ATA_QUIRK_DUMP_ID),
-	ATA_QUIRK_MAX_SEC_LBA48		= (1U << __ATA_QUIRK_MAX_SEC_LBA48),
-	ATA_QUIRK_ATAPI_DMADIR		= (1U << __ATA_QUIRK_ATAPI_DMADIR),
-	ATA_QUIRK_NO_NCQ_TRIM		= (1U << __ATA_QUIRK_NO_NCQ_TRIM),
-	ATA_QUIRK_NOLPM			= (1U << __ATA_QUIRK_NOLPM),
-	ATA_QUIRK_WD_BROKEN_LPM		= (1U << __ATA_QUIRK_WD_BROKEN_LPM),
-	ATA_QUIRK_ZERO_AFTER_TRIM	= (1U << __ATA_QUIRK_ZERO_AFTER_TRIM),
-	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
-	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
-	ATA_QUIRK_MAX_SEC		= (1U << __ATA_QUIRK_MAX_SEC),
-	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
-	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
-	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
-	ATA_QUIRK_NO_ID_DEV_LOG		= (1U << __ATA_QUIRK_NO_ID_DEV_LOG),
-	ATA_QUIRK_NO_LOG_DIR		= (1U << __ATA_QUIRK_NO_LOG_DIR),
-	ATA_QUIRK_NO_FUA		= (1U << __ATA_QUIRK_NO_FUA),
+	ATA_QUIRK_DIAGNOSTIC		= BIT_ULL(__ATA_QUIRK_DIAGNOSTIC),
+	ATA_QUIRK_NODMA			= BIT_ULL(__ATA_QUIRK_NODMA),
+	ATA_QUIRK_NONCQ			= BIT_ULL(__ATA_QUIRK_NONCQ),
+	ATA_QUIRK_BROKEN_HPA		= BIT_ULL(__ATA_QUIRK_BROKEN_HPA),
+	ATA_QUIRK_DISABLE		= BIT_ULL(__ATA_QUIRK_DISABLE),
+	ATA_QUIRK_HPA_SIZE		= BIT_ULL(__ATA_QUIRK_HPA_SIZE),
+	ATA_QUIRK_IVB			= BIT_ULL(__ATA_QUIRK_IVB),
+	ATA_QUIRK_STUCK_ERR		= BIT_ULL(__ATA_QUIRK_STUCK_ERR),
+	ATA_QUIRK_BRIDGE_OK		= BIT_ULL(__ATA_QUIRK_BRIDGE_OK),
+	ATA_QUIRK_ATAPI_MOD16_DMA	= BIT_ULL(__ATA_QUIRK_ATAPI_MOD16_DMA),
+	ATA_QUIRK_FIRMWARE_WARN		= BIT_ULL(__ATA_QUIRK_FIRMWARE_WARN),
+	ATA_QUIRK_1_5_GBPS		= BIT_ULL(__ATA_QUIRK_1_5_GBPS),
+	ATA_QUIRK_NOSETXFER		= BIT_ULL(__ATA_QUIRK_NOSETXFER),
+	ATA_QUIRK_BROKEN_FPDMA_AA	= BIT_ULL(__ATA_QUIRK_BROKEN_FPDMA_AA),
+	ATA_QUIRK_DUMP_ID		= BIT_ULL(__ATA_QUIRK_DUMP_ID),
+	ATA_QUIRK_MAX_SEC_LBA48		= BIT_ULL(__ATA_QUIRK_MAX_SEC_LBA48),
+	ATA_QUIRK_ATAPI_DMADIR		= BIT_ULL(__ATA_QUIRK_ATAPI_DMADIR),
+	ATA_QUIRK_NO_NCQ_TRIM		= BIT_ULL(__ATA_QUIRK_NO_NCQ_TRIM),
+	ATA_QUIRK_NOLPM			= BIT_ULL(__ATA_QUIRK_NOLPM),
+	ATA_QUIRK_WD_BROKEN_LPM		= BIT_ULL(__ATA_QUIRK_WD_BROKEN_LPM),
+	ATA_QUIRK_ZERO_AFTER_TRIM	= BIT_ULL(__ATA_QUIRK_ZERO_AFTER_TRIM),
+	ATA_QUIRK_NO_DMA_LOG		= BIT_ULL(__ATA_QUIRK_NO_DMA_LOG),
+	ATA_QUIRK_NOTRIM		= BIT_ULL(__ATA_QUIRK_NOTRIM),
+	ATA_QUIRK_MAX_SEC		= BIT_ULL(__ATA_QUIRK_MAX_SEC),
+	ATA_QUIRK_MAX_TRIM_128M		= BIT_ULL(__ATA_QUIRK_MAX_TRIM_128M),
+	ATA_QUIRK_NO_NCQ_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_NCQ_ON_ATI),
+	ATA_QUIRK_NO_LPM_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_LPM_ON_ATI),
+	ATA_QUIRK_NO_ID_DEV_LOG		= BIT_ULL(__ATA_QUIRK_NO_ID_DEV_LOG),
+	ATA_QUIRK_NO_LOG_DIR		= BIT_ULL(__ATA_QUIRK_NO_LOG_DIR),
+	ATA_QUIRK_NO_FUA		= BIT_ULL(__ATA_QUIRK_NO_FUA),
 };
 
 enum {
@@ -719,7 +719,7 @@ struct ata_cdl {
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-	unsigned int		quirks;		/* List of broken features */
+	u64			quirks;		/* List of broken features */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 	void			*private_data;
-- 
2.52.0

