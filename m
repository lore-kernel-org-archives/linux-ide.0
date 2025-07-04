Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710623BCEF
	for <linux-ide@vger.kernel.org>; Fri,  4 Jul 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626083; cv=none; b=QcQwvjuszkdqBbL9shJdAXj69mzezfZpQA+FnF8Hn1XUO2Q/ZYmu5AaKgJgLhYyQGNYT6dF4+hwthDE5nTKGe0vRtvTiwq07CeIJmD2FEmP2tdsPzEAnWJDIZSgMCItv1KZSmlEJGLMaLm8oFK1Bbv5iNd9tW9f1V9cswjlBtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626083; c=relaxed/simple;
	bh=Acfm6RiMFSpYNVvmi7ONxT6lha1nQrowgq9s2YIbSc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j0OHUeaSVt4waBvU2I3Nq7belY9Cfa0iAjPqGEoir/twx1Eb/J3oMwMxrPZdVMfxOTCN6ARySHioZU0oyhlE996ZzQv0z16efkmMJkEifWESPsf1UwCyqQYDn4tWv/IJlb2wJbl3cEe7MNzaVof7nFNAZYdjP5pd6ysX2fchtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9k2mavW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9k2mavW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A6EC4CEE3;
	Fri,  4 Jul 2025 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751626083;
	bh=Acfm6RiMFSpYNVvmi7ONxT6lha1nQrowgq9s2YIbSc0=;
	h=From:To:Subject:Date:From;
	b=r9k2mavWG99DB2YeWau5dGidC4kScKl2CFwjLqxSOy5hdLcUsuhdkt/Rgy2HyM3/W
	 24QaRvUAMDwZgATjZ9qPt769vs+c0Xej288sV3UDjenLXMAPbVEu0Qx55QAqx4oZDf
	 apKzAtoNLov44pGrJsxhK4kZ1Qv9EJckEcEW2AIgREwkZYC2SePaix6TKVB4SB++4a
	 YcoSzOyWEyop7vbV6HOvd7KZBzIAvy9ko4CzR/7XgLXV2/hEKFioR4qyhDnMUJwM3g
	 aejyCLCmzqT0t2s3VRCwd7UuVwzlazSRqi6QNsK1aK2AE4RapPgEyvz22mQuPKx/f7
	 BJ9fX8QN/en+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-eh: use bool for fastdrain in ata_eh_set_pending()
Date: Fri,  4 Jul 2025 19:45:52 +0900
Message-ID: <20250704104552.310630-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the bool type for the fastdrain argmuent of ata_eh_set_pending(), as
it should be.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e5fa61fb8a59..1f8a6b930f5d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -907,7 +907,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
+static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
 {
 	unsigned int cnt;
 
@@ -947,7 +947,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 
 	qc->flags |= ATA_QCFLAG_EH;
-	ata_eh_set_pending(ap, 1);
+	ata_eh_set_pending(ap, true);
 
 	/* The following will fail if timeout has already expired.
 	 * ata_scsi_error() takes care of such scmds on EH entry.
@@ -969,7 +969,7 @@ void ata_std_sched_eh(struct ata_port *ap)
 	if (ap->pflags & ATA_PFLAG_INITIALIZING)
 		return;
 
-	ata_eh_set_pending(ap, 1);
+	ata_eh_set_pending(ap, true);
 	scsi_schedule_eh(ap->scsi_host);
 
 	trace_ata_std_sched_eh(ap);
@@ -1020,7 +1020,7 @@ static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 	int tag, nr_aborted = 0;
 
 	/* we're gonna abort all commands, no need for fast drain */
-	ata_eh_set_pending(ap, 0);
+	ata_eh_set_pending(ap, false);
 
 	/* include internal tag in iteration */
 	ata_qc_for_each_with_internal(ap, qc, tag) {
-- 
2.50.0

