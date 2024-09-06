Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB01BDE6
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587931; cv=none; b=Zjkpc8f2I3OnIuvdS4b5kxaLAXINVsSTV6MZ6TA2+FJwHts8uqHlXdq611rCZ2q4Cyu6aYka/D6DuahMORVOg5+hKXsO+PugPdporijSPLz+WZ2Vkc13mrHhYvadYCbMsF5WLQn3DYB6BmOwGfSGpMnoPYvvmGnWCat0rCwAkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587931; c=relaxed/simple;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnyENvMRY4ZYECIQdCTaQMrI53hSQGFlTIAMwtdOko1DdvLMwai4rNUm+u0T0C6ga4HH4DoS/BqRe0sJG3MjoH1KdMNFi4wnNblv2aavxNNcQ1a20kU7cHeDEZ611S/f/Zzur5GK7+/dALimC1XbcFymNIaO8fCZ6X+RRKHkH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAsDAJnq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAsDAJnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4FFC4CEC5;
	Fri,  6 Sep 2024 01:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587931;
	bh=nn3TT6WfKr9FCa7rZPJnbYBdFmjqJOi7Vk+m1vin2L8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gAsDAJnqIfvWJUO6zGkyAIC5tetVfbMeferNvMS9AoUu8PZQkMK70c3WY9pj9cpCe
	 Cl5uc3GL3VO87FBdDUNPybQcCgG7lowG9YjHM9w6YAwc453x0WuC0RHS4IWfef3Mpa
	 aF1yIsYMa4O3cg4essfpmyYSfwO+ZsdUwpWqGanxtBpAt6K40i+lDUlIPe/jgkeNMZ
	 hOZB6Ae2ZRDtioPZqPCfWgd3zZt8MpzqESL8ew8aQ5QUfyOCUy4VMjeO17tAT30tkM
	 0MaRNekP3fTekI3iKavyF8N+vtNjlAsrpxxjDzhBwBIFsW3Jldinq8IBm2ZCYAPKsU
	 QDhJvAQIIl9SA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 3/9] ata: libata: Improve __ata_qc_complete()
Date: Fri,  6 Sep 2024 10:58:41 +0900
Message-ID: <20240906015847.229539-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906015847.229539-1-dlemoal@kernel.org>
References: <20240906015847.229539-1-dlemoal@kernel.org>
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

