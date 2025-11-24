Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA7306D5E
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991862; cv=none; b=pckiS551Ydlp6TwzgW8O2n8ivZujQEYv4gvQrM13qIOaf7QSfZN+9np6k6uWTTE+uLNxX7W3dgd91hC/b+wM1Qg/zOscf2fQzES4owLHTuLBv7rvSSwqKHdh8Y7ExKT6Ah2WIKLJwTAUCAQ8ABPi5/c9AlPgUkxSUREJr53P09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991862; c=relaxed/simple;
	bh=OePhxhIFCitfPwhph5ci0/DYKGWPpGgoOMh8zz3DzRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHYiD4L3DLowUI3o/ghF6UI0dGD17qyg6LU+q29Dz4v10flDRIJlpkklyZcgjs6DpnhoI7m5wpfleIUyckPcMbDkaWF+1mDLHqXLKLwkKk3Ejf1ziSckyBrNWMLJT1HEjE8ZZ4UMB5UGLNNe2JOiC3LJlpBI8t4LHDfnQZtN0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COIFtR6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COIFtR6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9EC116C6;
	Mon, 24 Nov 2025 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763991861;
	bh=OePhxhIFCitfPwhph5ci0/DYKGWPpGgoOMh8zz3DzRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COIFtR6f5higVYHYX6uSPSqSvNsOJoMVdVAdZj8q4nONQ5Oe9L2tEK+uQW8sBR7Or
	 PmtyTfCo3wmOhDnSFSesLgaA3iPaKOXDyP4WXXGHgVesUMYVuT9S66AjxZPlxVITag
	 uAPSo9+4ZiZaHx3V7eA1pVxcHhg3dtB2iXcVq+jfUi5ZSgw3aHWODnfT23fC0/Evx/
	 JdhpvZqvyDsajby+gYoW8XNH2LD9uZvfZzr8ZO7tssT+8RLwOXmjCGPhN3boC6YKja
	 lIoq3y8tUM9I0ArIfUzApTVXQw1UNBTlRgfiQvOnzXg3HmksTOusbCvMTZB8IKGVjP
	 sCBeQJuagjQRg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/3] ata: libata: Move quirk flags to their own enum
Date: Mon, 24 Nov 2025 14:44:16 +0100
Message-ID: <20251124134414.3057512-6-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251124134414.3057512-5-cassel@kernel.org>
References: <20251124134414.3057512-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5855; i=cassel@kernel.org; h=from:subject; bh=OePhxhIFCitfPwhph5ci0/DYKGWPpGgoOMh8zz3DzRg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJVEvVuXJ12wmXW3sinVp+mr4oQ8HnS6eZT6Wu19o9v4 Tm9v9u8O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR910M/92q/DdV9i9++Fn+ 7w2Z6bd03hw8e1TpmfX8X/NPuKyc4ubFyHCo10s4TrbdyX/2Ssbbjlw31Qp9MqfO4L31s2/FxyU F2YwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The anonymous enum in include/linux/libata.h that is used to store various
global constants can currently be backed by type int.
(It contains both negative and positive constants.)

__ATA_QUIRK_MAX is currently 31.
The quirk flags in the various global constants enum are defined as
"1U << quirk_flag_bit".

Thus if we simply add an additional quirk, the quirk flag will be 1 << 31,
which is a value that is too large to be represented by a signed int.
The various global constants enum will thus therefore be backed by type
long.

This will lead to error prints like e.g.:
ata_port_err(ap, "EH pending after %d tries, giving up\n",
	     ATA_EH_MAX_TRIES);

now failing to build, with build error:
error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Werror=format=]

This is because all other constants in the various global constants enum
now has to be printed as a long.

Move the quirk flags to a separate enum, so that we don't need to change
the printf specifier for all other constants in the "various global
constants" enum when adding an additional quirk.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/libata.h | 74 ++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7a98de1cc995..171268d65169 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -85,6 +85,44 @@ enum ata_quirks {
 	__ATA_QUIRK_MAX,
 };
 
+/*
+ * Quirk flags: may be set by libata or controller drivers on drives.
+ * Some quirks may be drive/controller pair dependent.
+ */
+enum {
+	ATA_QUIRK_DIAGNOSTIC		= (1U << __ATA_QUIRK_DIAGNOSTIC),
+	ATA_QUIRK_NODMA			= (1U << __ATA_QUIRK_NODMA),
+	ATA_QUIRK_NONCQ			= (1U << __ATA_QUIRK_NONCQ),
+	ATA_QUIRK_MAX_SEC_128		= (1U << __ATA_QUIRK_MAX_SEC_128),
+	ATA_QUIRK_BROKEN_HPA		= (1U << __ATA_QUIRK_BROKEN_HPA),
+	ATA_QUIRK_DISABLE		= (1U << __ATA_QUIRK_DISABLE),
+	ATA_QUIRK_HPA_SIZE		= (1U << __ATA_QUIRK_HPA_SIZE),
+	ATA_QUIRK_IVB			= (1U << __ATA_QUIRK_IVB),
+	ATA_QUIRK_STUCK_ERR		= (1U << __ATA_QUIRK_STUCK_ERR),
+	ATA_QUIRK_BRIDGE_OK		= (1U << __ATA_QUIRK_BRIDGE_OK),
+	ATA_QUIRK_ATAPI_MOD16_DMA	= (1U << __ATA_QUIRK_ATAPI_MOD16_DMA),
+	ATA_QUIRK_FIRMWARE_WARN		= (1U << __ATA_QUIRK_FIRMWARE_WARN),
+	ATA_QUIRK_1_5_GBPS		= (1U << __ATA_QUIRK_1_5_GBPS),
+	ATA_QUIRK_NOSETXFER		= (1U << __ATA_QUIRK_NOSETXFER),
+	ATA_QUIRK_BROKEN_FPDMA_AA	= (1U << __ATA_QUIRK_BROKEN_FPDMA_AA),
+	ATA_QUIRK_DUMP_ID		= (1U << __ATA_QUIRK_DUMP_ID),
+	ATA_QUIRK_MAX_SEC_LBA48		= (1U << __ATA_QUIRK_MAX_SEC_LBA48),
+	ATA_QUIRK_ATAPI_DMADIR		= (1U << __ATA_QUIRK_ATAPI_DMADIR),
+	ATA_QUIRK_NO_NCQ_TRIM		= (1U << __ATA_QUIRK_NO_NCQ_TRIM),
+	ATA_QUIRK_NOLPM			= (1U << __ATA_QUIRK_NOLPM),
+	ATA_QUIRK_WD_BROKEN_LPM		= (1U << __ATA_QUIRK_WD_BROKEN_LPM),
+	ATA_QUIRK_ZERO_AFTER_TRIM	= (1U << __ATA_QUIRK_ZERO_AFTER_TRIM),
+	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
+	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
+	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
+	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
+	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
+	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
+	ATA_QUIRK_NO_ID_DEV_LOG		= (1U << __ATA_QUIRK_NO_ID_DEV_LOG),
+	ATA_QUIRK_NO_LOG_DIR		= (1U << __ATA_QUIRK_NO_LOG_DIR),
+	ATA_QUIRK_NO_FUA		= (1U << __ATA_QUIRK_NO_FUA),
+};
+
 enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
@@ -390,42 +428,6 @@ enum {
 	 */
 	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
 
-	/*
-	 * Quirk flags: may be set by libata or controller drivers on drives.
-	 * Some quirks may be drive/controller pair dependent.
-	 */
-	ATA_QUIRK_DIAGNOSTIC		= (1U << __ATA_QUIRK_DIAGNOSTIC),
-	ATA_QUIRK_NODMA			= (1U << __ATA_QUIRK_NODMA),
-	ATA_QUIRK_NONCQ			= (1U << __ATA_QUIRK_NONCQ),
-	ATA_QUIRK_MAX_SEC_128		= (1U << __ATA_QUIRK_MAX_SEC_128),
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
-	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
-	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
-	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
-	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
-	ATA_QUIRK_NO_ID_DEV_LOG		= (1U << __ATA_QUIRK_NO_ID_DEV_LOG),
-	ATA_QUIRK_NO_LOG_DIR		= (1U << __ATA_QUIRK_NO_LOG_DIR),
-	ATA_QUIRK_NO_FUA		= (1U << __ATA_QUIRK_NO_FUA),
-
 	/* User visible DMA mask for DMA control. DO NOT renumber. */
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
 	ATA_DMA_MASK_ATAPI	= (1 << 1),	/* DMA on ATAPI */
-- 
2.52.0

