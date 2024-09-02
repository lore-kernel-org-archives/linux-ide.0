Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9B111AD
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235248; cv=none; b=VDZwf+z9imDguT3O8qN3YwheP09UHHsPKCHbcuUjqDGgiko5ChF1WPI+8J8bz18HsGOATfzJlenTZ2W/06DEAqeMqzGoIAGckaoaRqTqf6/AvNMk5EWgvBeJkwN6K5OVieokpRYxuEmMbmZ5IU0rJXuW2pkZ1JH9BLVdom72iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235248; c=relaxed/simple;
	bh=2pyVbTAa5dYX09aN5Tfw+GfsnbuxuU6S+CzwijMkOf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba1eCmZLNmx9Mz0SMHpN5e+zDSSR9wijwjPCM5n057nAeaFy+q5fL68mhgdt5kowgA8zaee7sOBe+75W+EgxSAyiN9vFwyk41iVs5ZUU2XHIsLqMCORqvxEaaIPKDO4rTJvG5te/+9G63hgG0GjJ0hZNKcuMWx1ydMbH9pzV0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS1Nqv9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS1Nqv9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A57C4CEC3;
	Mon,  2 Sep 2024 00:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725235247;
	bh=2pyVbTAa5dYX09aN5Tfw+GfsnbuxuU6S+CzwijMkOf8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QS1Nqv9OFtkorWxIyT5OSYK76GdYVBaHrrSp126kcn7DAXDdzHYzH94CCRdtmMGVo
	 viX24hrXFpPoXdqkNZOgeKp/Oc6n8rRfic4I21lFyHZ+UUGhPLkcxLxkkom/udVj9C
	 kz91zupc57GBEoUVmw1KO/owmkWjfhso7rdVa7TxousoTzzqYmloAqW1FRfdAQDobT
	 Oqh9mog/eIs1SgUGdeHvrZferZecES3ZZM45aHo9DjcfgtGQLimlx3q6YyFCFC2Y5z
	 zbqgW6xNWBhYf5wVP/GTy+iceWH9TgkF89bXg5vz3fBE9GeDHZZxoaQDHMIoowQh1v
	 hdrD2jryjm1dg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/7] ata: libata: Improve __ata_qc_complete()
Date: Mon,  2 Sep 2024 09:00:38 +0900
Message-ID: <20240902000043.155495-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902000043.155495-1-dlemoal@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
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

