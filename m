Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F21428E8
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318439; cv=none; b=J3NvYayCGG/B1i+b7/rdanRwZIdV8XPMY3hpVyEirhOffpU9aKdoOphVcTfJrgkOjisQ3AWaZrYQw3pqy8eT/j8x1wwD6xfG2lkajDkrXCl+gUM6BN9rQQ/SZ/iXgXwW/My/ZbfKq9nbvMueyWLtCmM11yBrv1DLk5DQTeyXZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318439; c=relaxed/simple;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiyazO+6HRV6ghcAx/mA2RXUbz1foFL8eho6LWytBNLibFuJfcy83erCVngJ6aEJOflwFlar6dDbYt7o2gSfI2N/Fmmg/+JO+zomUngCsTDU+ITk83AH3KbxDD2Orn08NXjyUIZsVoysfQ3DN+8R/P4gesevuTeHMakEUAXvRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfLmAO93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfLmAO93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315D6C4CEC6;
	Mon,  2 Sep 2024 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318438;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tfLmAO93lXkaUuq7O3Ad1Jr4b8xRJMuz6+L6jHwYU5MD/lKQrHCAbxpl2TZHzQsn5
	 6NhlsTZr9md4+ipmwN+/Ew+Y5b/UVy7fEjl4KMABQUG2Ke7PpmOOO4/DqUsOPDxqVU
	 W8oiliw0yvBf63QZG5HAQ1rhwjl36aM7ryckqIbMLwUmVoq4N7NZU+Yl49vtivCNnh
	 2KG/3LHKZQLmpdSmjvFTAxK9NM3oOgUaxIGydiVD5UxnyXd66JvfAQNj0Yqo9Npyh/
	 d5M0Zkpro+IwDp0oJUahxollqKg/+SOqA0Bd5aPooHMo1fjMa1JPCTEX34kBXNB/1f
	 8HRNUE8iGz67Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 2/7] ata: libata: Improve __ata_qc_complete()
Date: Tue,  3 Sep 2024 08:07:10 +0900
Message-ID: <20240902230715.176522-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902230715.176522-1-dlemoal@kernel.org>
References: <20240902230715.176522-1-dlemoal@kernel.org>
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

