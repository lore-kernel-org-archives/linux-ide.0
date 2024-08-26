Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A036F2F6
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657470; cv=none; b=DPUM9x2PSoA8Ua0V11c6hiV3UTe5iaS9Ojgt2bh8dylxlc5yzwZFlI+chcORRmUChdtioFWVQ1Uoa6ojsJQuHwMgC466WKAXwj7Qrg3Z1kSNLSLXQtLiB8JDOcmRu1KQ70uJ1QA6STk07fTyj3xk7dGHSbxuyU10F+2LmyooJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657470; c=relaxed/simple;
	bh=ADFZOZJN+o/waq/964U0BBdgXy/hajbQBjs+rgTvbqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlEmo8M864VdvwMhiz1wIZrIyBDLfaRBvTal0h8U4L3L1vSgbfB8gJIYocxcqcG3YD1eyG4RIToVmST8fFXt+2PtCDHKB6CZRGZGJbhDOhlQSn+PaTR0wyeI3JfyKcqbCzsw3yEWv7p7JihTUvwya+uizbwgs1nWq2eisGH69Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImziCe2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImziCe2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C542CC8CDC5;
	Mon, 26 Aug 2024 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657469;
	bh=ADFZOZJN+o/waq/964U0BBdgXy/hajbQBjs+rgTvbqY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ImziCe2dyiUrHIpJTdTj8paAOaRDuJ/339AvNFDVwC6eisc2piT3Kk5ZZ483Ob2WD
	 if0xish7BjnyDjzu2ua7h1cj/0N7Cd2tbawF3TEOWny/OKVpWTV04lXBtGbLhhl0ox
	 q86vw1DoRIfzz8wDhc8d0IUksUagJbY42u3trwZkYiBDIYJXUC6Biq5nXtNK+1Q4Ua
	 WqPlTxHfwffNJOqiz3qbnMI+0pYyigAdJKUQgCnVdRD2ZHGUvUVNE6e0zZyF7Wh1SO
	 PXw73keV7k6vUa6/tb33UM/+oH5uXyfvcGKH22hxoD/I7QOJwE7Z1zHc5kWoHpl6X6
	 vqrW49t9JDmKA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/7] ata: libata: Improve __ata_qc_complete()
Date: Mon, 26 Aug 2024 16:31:01 +0900
Message-ID: <20240826073106.56918-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>
References: <20240826073106.56918-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function __ata_qc_complete() is always called with a qc that already
has been dereferenced and so is guaranteed to be non-NULL (as otherwise
the kernel would have crashed). So remove the warning for a NULL qc as
it is useless.

Furthermore, the qc passed to __ata_qc_complete() must always be marked
as active with the ATA_QCFLAG_ACTIVE flag. If that is not the case, in
addition to the existing warning, return early so that we do not attempt
to complete an invalid qc.

Finally, fix the comment related to clearing the qc active flag as that
operation applies to all devices, not just ATAPI ones.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4023fc288ac..5acc37397f4b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4829,8 +4829,9 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
 	struct ata_port *ap;
 	struct ata_link *link;
 
-	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
-	WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_ACTIVE));
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_ACTIVE)))
+		return;
+
 	ap = qc->ap;
 	link = qc->dev->link;
 
@@ -4852,9 +4853,10 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
 		     ap->excl_link == link))
 		ap->excl_link = NULL;
 
-	/* atapi: mark qc as inactive to prevent the interrupt handler
-	 * from completing the command twice later, before the error handler
-	 * is called. (when rc != 0 and atapi request sense is needed)
+	/*
+	 * Mark qc as inactive to prevent the port interrupt handler from
+	 * completing the command twice later, before the error handler is
+	 * called.
 	 */
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 	ap->qc_active &= ~(1ULL << qc->tag);
-- 
2.46.0

