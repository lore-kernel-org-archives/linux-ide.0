Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7702DEA7A
	for <linux-ide@vger.kernel.org>; Thu,  4 Dec 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854299; cv=none; b=pBnlOvv9YNuyIZK4xaq/qwS8dNmXPyvhX45+wDv0DSQ6Q+rviEL1AaZ0B3kMvFYu5aWAsxCW9W5BFffjoPQeoPgrQ2L7W1mAYusijIy0uJFvoHCM+0VYROfc7XfwF98kw2K6usQtFyyKxLDMBy54eboswZkIDEsoqYtyl1Dwz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854299; c=relaxed/simple;
	bh=YGJ8RzoMC019FxEMdDk9EQWhGqxo9VMvVMq0Mdjwkb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao3MCPE6TFu0sVUHhJwJVwDrPtmFAacACGSanGxb2RCur3//wHHw9kY77jfGAHNsY5gy7mZUyP9F7fgZYFonSOcZSDgEmp0Ey2FYplbbppenmZE9nc5pP69bMI9Wpv1bruvfgJ7oeQHj6K2238rycO3Tdl5/CUBxIqL6qEq8EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL8oqQCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL8oqQCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053E1C4CEFB;
	Thu,  4 Dec 2025 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854299;
	bh=YGJ8RzoMC019FxEMdDk9EQWhGqxo9VMvVMq0Mdjwkb8=;
	h=From:To:Cc:Subject:Date:From;
	b=kL8oqQCizcuf+C6ssMyuM6saVxzac9cWCosh5oEH8iguEm6aB+XSJdasewzV+Kzfq
	 ySGdojZrV/UhVG37fYfR8HU5EvNK/sVyg4K1MS+Mxy+U+IFr2cNk4nNVUwzE6WUunF
	 l6wT4JJa6nTQLsWPtC8dhZypgF7J2tgWwK7/1+KY3DgDZPyLEf2W/fo1R0phvl54no
	 D0uE3y0u3arg/m2gLL5UgxUSjqdNBAmZFDJ4+BN5aHjXICH9VkvUXPaewpt//cG7z7
	 IW5R9lWmLRkkhmKoSJXYulWE24WuagLmsml4fciE57X8MW/w5SEPKC0aIO/5ob4hJM
	 yNtZ2AhRVJlyg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: Remove superfluous local_irq_save()
Date: Thu,  4 Dec 2025 14:18:04 +0100
Message-ID: <20251204131804.946417-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=cassel@kernel.org; h=from:subject; bh=YGJ8RzoMC019FxEMdDk9EQWhGqxo9VMvVMq0Mdjwkb8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDINu3h6F9SL24fqLjEsvv7TicuhN9j1SthutnMlL4qW6 HwtuPG6o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPRPsnwT+HoIj7JTd4SrlNL Ddo/XTbulZ1qd3x5NV+AhHOIuHzuBkaGN2L6Ib49mskWOnPyXgjnyuetX3zAtfxUa4ZFz4GE34G sAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 28a3fc2295a7 ("libata: implement ZBC IN translation") added
ata_scsi_report_zones_complete(). Since the beginning, this function
has disabled IRQs on the local CPU using local_irq_save().

qc->complete_fn is always called with ap->lock held, and the ap->lock
is always taking using spin_lock_irq*().

Thus, this local_irq_save() is superfluous and can be removed.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 434774e71fe61..86d283d340e32 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3572,13 +3572,13 @@ static void ata_scsi_report_zones_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct sg_mapping_iter miter;
-	unsigned long flags;
 	unsigned int bytes = 0;
 
+	lockdep_assert_held(qc->ap->lock);
+
 	sg_miter_start(&miter, scsi_sglist(scmd), scsi_sg_count(scmd),
 		       SG_MITER_TO_SG | SG_MITER_ATOMIC);
 
-	local_irq_save(flags);
 	while (sg_miter_next(&miter)) {
 		unsigned int offset = 0;
 
@@ -3626,7 +3626,6 @@ static void ata_scsi_report_zones_complete(struct ata_queued_cmd *qc)
 		}
 	}
 	sg_miter_stop(&miter);
-	local_irq_restore(flags);
 
 	ata_scsi_qc_complete(qc);
 }
-- 
2.52.0

