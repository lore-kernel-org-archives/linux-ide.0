Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370E17F394
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278044; cv=none; b=gyiN2J2dwnbPB3k9hbZPavvLPX+G/SPVFC00mPq1alp4vzMv+eI8rtOTxNiL6QPejIvxqPHruH4X92ovHDSH1A7p6CTTMqDlRvp4MdNqpOZSrNO5W7spofYOx2Pv0rXCCr/z2NfQSSBpfBOCKlXCoLnFv9sv7lMBlhE5lATyyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278044; c=relaxed/simple;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSkYx8p/oyzBfCIHSJ++c0BMMwr9FYr1qbmuGaV6cMOc48B0jrhzIK0xSwoDy5j1Ww0jTPlCS+lWhea2MKPwxVOrZAZYGXGncKuVRU7duGkJfAKp/lg/A3lgKHX+DKumTOnMvfkE1n9cfyQ4aLasIK+xoqrAUxpaeC1gQMm55CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv3wZe+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv3wZe+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3778C4CEC2;
	Mon,  2 Sep 2024 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725278044;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qv3wZe+6C/CM1Dfnsr/cSGdk1ioCvucynvtyIs34xWqcm4ZWL4stsppicb1FRN3Ig
	 y+9jYzZXPUmlbladpUqxNN85w3yCRneSKwwPadRU2PYSNRUI1IEYfjxMLHXzTSZDkG
	 5bmuV8VeDJaokZsfw/jsqg30gNSoTad98d22B1wcIWG8QmvIbj5FD9JLPEvyxLK0gf
	 tJL1aPviBEuD5JdZ9sSggBSpD3ed2v+MhI5CMEaZwqQIS9jj3SpHJdG4tX8D7NIUNA
	 wbqZIiv1hYRKOR9ydtZu/9ZTilMD3NJ+JZ0eLEzl6NNaiW4hrbGR3NnBF7dDOoLqO4
	 fH1vWd9yA9SBQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/7] ata: libata: Improve __ata_qc_complete()
Date: Mon,  2 Sep 2024 20:53:55 +0900
Message-ID: <20240902115400.166881-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902115400.166881-1-dlemoal@kernel.org>
References: <20240902115400.166881-1-dlemoal@kernel.org>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

