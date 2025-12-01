Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7342556E
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592517; cv=none; b=opjiPnlkvcRcKFBkaVt1ovAfRvdCx5T8n7ptxj4XkG7U04buuIr5hqAGDRXTd7SYrf3CVcNVGD0DW/pi3RQC1hmQT1FBw1wvqR1FJqqbe6nf2ZuqCQyZ6RH5rGKORzt/p8cf+Rl+aUIMFAkDAq2YjHG+i1dXz/PThrRhTWspTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592517; c=relaxed/simple;
	bh=RuPiFi1YFiMG0Hj6sW8IVEwGBdbYtrhlaTwJwAb2mhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnIMLbPyH60yTSNYaOcR/GqeWMrtnk7vaxV2SUf3nFkxCJOekkm2nEIWOdCCYZ/OxCKH8juDxYqd6VW6waE2UUmQyb5s6DaTPfLRbgef/dGpwYZBmVFzWhAxdJ/usuqc0zag7NwreQEw9KGU3LOcE94GNK7J8ZzrTPNZHp370AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja4iLlRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja4iLlRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9F6C116D0;
	Mon,  1 Dec 2025 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592516;
	bh=RuPiFi1YFiMG0Hj6sW8IVEwGBdbYtrhlaTwJwAb2mhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ja4iLlRiVsemWG/ix88GZc17PkjYK2Mn0RqoZOnQQUrP1n1hQBLvCQCBD2OH7hfGo
	 CobF1xbZhkcKbKzm7pviTANca+6JOscGu7gzFThmPqTFTYAtAWCtaNSChD//Yhs9pl
	 Sn3z5iJeZEp+TDH9CJhNl45+vAY7RDMqJpavpZBA82rkyXJ/3AhzlHeBfiWKsqNOCA
	 7gBdoyRq/Q3LbyLHPwVukFpaHaRHGbflIZQAVN+MlR8P3kl4IB29qZ/Y6DB4W4EHfC
	 mNNeW5Z8iQd6wTUsqMiz0xov45xdGfLlNji1KhdMUSg+4E5MqiJ02nCVamnuJ2vC2S
	 B7ijZj1QP9UZA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/8] ata: libata: Move quirk flags to their own enum
Date: Mon,  1 Dec 2025 13:35:03 +0100
Message-ID: <20251201123501.246282-11-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6154; i=cassel@kernel.org; h=from:subject; bh=RuPiFi1YFiMG0Hj6sW8IVEwGBdbYtrhlaTwJwAb2mhA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6vCjq98Vf/l+ZRL30/8Z+h10nKefEKyOm1FeRtXy sSHXRmdHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI7yZGhjne7spTGnYk7rvU XMPYf3G/2q5lZ2ernNirv9jH5px4yBNGhsP/tQKLV3P9e2UySdVM6olk7B21Kv45jVfC2mdekbt 3nA0A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The anonymous enum in include/linux/libata.h that is used to store
various global constants can currently be backed by type int.
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

This is because all constants in the various global constants enum now
has to be printed as a long, as that is now the backing type of the enum.

Since the compiler will use the smallest possible backing type for an
enum, it is good practice to not mix unrelated things in a single enum.

Move the quirk flags to a separate enum, so that we don't need to change
the printf specifier for all other constants in the "various global
constants" enum when adding an additional quirk.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/libata.h | 74 ++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7a98de1cc995c..171268d651694 100644
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

