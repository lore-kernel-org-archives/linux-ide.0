Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F42F3C0A
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482509; cv=none; b=lLLDEW96/eFYKDqR86mReyZPl0pMAMJ5r9CoCCVm1Wx8VyA0HqnkiKSoYaqhHldfpmtbXQlcsqDXmLZKgyWixmKCdiD5ZdPqbk0IYWX6Ga0CEsAH+CX45XbyWI7/v3OONPLhOKP5vXOJ9EkDBfn9clhkoBBIYoVHjhMff9aa9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482509; c=relaxed/simple;
	bh=RHNmtSOYEKIgjrmT8zS//+DLM1oTVW1fC9n5Q+tTpog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ/ccnBG6C+qOqeKdLmY/MW0s+FfFflizhtl1FUgIf2yfCcT0/5mrQWJnhjmWin/xqCaesEC4sVmkdDXbzAsAQvCsoXfGZWAzlEh3XTpuJmPmAP98qVfg8kNR7Q86FzFiryJ2CcjPdpKht+8UcpTse0SKCnXWXJ0fzXI91j5b0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+oKBC0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+oKBC0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91763C2BC86;
	Thu, 19 Feb 2026 06:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482508;
	bh=RHNmtSOYEKIgjrmT8zS//+DLM1oTVW1fC9n5Q+tTpog=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I+oKBC0G5yuw7fA5Wsj4yHyH8yMAvIGerPkXdpyu/D3pbgDSPEFCl3qI0ZjyMMNgv
	 t4kc6+3JKMiooc3XaNhD1TrH6X2g3k5wupgPlblIaOwR+LQXnwWUpD4w4q5nHN6Pi0
	 sWxehC40plEciiz1HiyN5+bd7PgyVS8p5bF0IFHsyKrzEq43Pln/Qum7fm9JJF/KyL
	 jYh9gPW7RrB7oYQrQq7y0A15RAQ+BL5qb2+X1SbFVncfFnksvZrVJ4lSw6wG1HRaEG
	 7pgC7+eKlWtITakFmwtbhW9TV4OCX6qewNnbh0svfwGX5jTxtP9+SAFmYen8kggKOd
	 iuQCazrDou8yA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/5] ata: libata-scsi: simplify ata_scsi_schedule_deferred_qc()
Date: Thu, 19 Feb 2026 15:23:10 +0900
Message-ID: <20260219062312.1030867-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ata_qc_done() instead of calling ata_qc_free() and scsi_done()
directly.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c0dd75a0287c..41918e21d0f8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1685,7 +1685,6 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ap->deferred_qc;
-	struct scsi_cmnd *scmd;
 
 	lockdep_assert_held(ap->lock);
 
@@ -1697,11 +1696,9 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	if (!qc)
 		return;
 
-	scmd = qc->scsicmd;
 	ap->deferred_qc = NULL;
-	ata_qc_free(qc);
-	scmd->result = (DID_SOFT_ERROR << 16);
-	scsi_done(scmd);
+	qc->scsicmd->result = (DID_SOFT_ERROR << 16);
+	ata_qc_done(qc);
 }
 
 static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
-- 
2.53.0

