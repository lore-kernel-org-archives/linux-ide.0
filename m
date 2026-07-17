Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A737DE8D;
	Fri, 17 Jul 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279600; cv=none; b=HS3jXQuKWkogke6CUuco55fbD/CRJY9YNgufzCdzFLTMETWTOsscOsN+AT+FbOtZ7N6fPaGsuGmfajKaOQ0buT5cPiFL3wgi7EtG9GowuaoZCYcu9cYgyLxr1zue2dBA52XKAY3OD5GXJuz/t8YM33t5XdfzsMDHkDIDC7NQyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279600; c=relaxed/simple;
	bh=9Ys0Bb8I8vT8ULc8xeny8V61gybdtGMmjg+cd8vYMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQk7y3bwflS963CStyzHvzks+3D15Rvkv5LC66gfkws38gMtRE8T+wxsgZmxghE8B+XHfQrS8KqNGnIkL+CHk4qIET2Qoox+XDmC+qOTvTncEf2I9mmwwKB6/CsLsrQFRNy2PsG5Yl0HkCcx2EEJAtkqnfyfb8ku5Ox+XFjPgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B18B92698E6;
	Fri, 17 Jul 2026 11:04:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jYTY-eBFuK7E; Fri, 17 Jul 2026 11:04:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 500732698DA;
	Fri, 17 Jul 2026 11:04:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w2gkZ1sYjZoJ; Fri, 17 Jul 2026 11:04:18 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (93-82-119-196.adsl.highway.telekom.at [93.82.119.196])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id F30C22B4F67;
	Fri, 17 Jul 2026 11:04:17 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	upstream+linux@sigma-star.at,
	cassel@kernel.org,
	dlemoal@kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] libata: Don't busy-wait for PIO data-in command completion
Date: Fri, 17 Jul 2026 11:04:04 +0200
Message-ID: <20260717090404.857078-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

libata: Don't busy-wait for PIO data-in command completion

Unlike PIO data-out, the PIO data-in protocol raises no completion
interrupt, the last interrupt announces the final data block, and once
the host has drained it from the data register the ending status must
be obtained synchronously.  ata_sff_hsm_move() does this by spinning
in ata_wait_idle() for up to 10ms.

Usually this is not a big deal unless the device is slow.  In my case
it's a CF card which keeps BSY asserted for multiple milliseconds(!)
after the final data block.  Since the waiting happens in the
interrupt handler, under the port lock with interrupts disabled, the
CPU is hogged for milliseconds on every read command.

To improve the situation, bound the inline wait to ~100us.  If the
device is still busy after that, mark the command ATA_TFLAG_POLLING,
so the interrupt handler won't race for it, and obtain the ending
status via ata_sff_pio_task(), which sleeps between status checks
instead of spinning with the lock held.

Since ata_sff_pio_task() may now finish a data-in command, it must
wait for both BSY and DRQ to clear at HSM_ST_LAST, matching what
ata_wait_idle() enforced.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/ata/libata-sff.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 1e2a2c33cdc80..416e1239ed56d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1114,8 +1114,14 @@ int ata_sff_hsm_move(struct ata_port *ap, struct a=
ta_queued_cmd *qc,
=20
 			if (ap->hsm_task_state =3D=3D HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
-				/* all data read */
-				status =3D ata_wait_idle(ap);
+				status =3D ata_sff_busy_wait(ap,
+						ATA_BUSY | ATA_DRQ, 10);
+				if (status !=3D 0xff &&
+				    (status & (ATA_BUSY | ATA_DRQ))) {
+					qc->tf.flags |=3D ATA_TFLAG_POLLING;
+					ata_sff_queue_pio_task(link, 0);
+					return 0;
+				}
 				goto fsm_start;
 			}
 		}
@@ -1213,7 +1219,7 @@ static void ata_sff_pio_task(struct work_struct *wo=
rk)
 		container_of(work, struct ata_port, sff_pio_task.work);
 	struct ata_link *link =3D ap->sff_pio_task_link;
 	struct ata_queued_cmd *qc;
-	u8 status;
+	u8 status, wait_mask;
 	int poll_next;
=20
 	spin_lock_irq(ap->lock);
@@ -1229,6 +1235,10 @@ static void ata_sff_pio_task(struct work_struct *w=
ork)
 fsm_start:
 	WARN_ON_ONCE(ap->hsm_task_state =3D=3D HSM_ST_IDLE);
=20
+	wait_mask =3D ATA_BUSY;
+	if (ap->hsm_task_state =3D=3D HSM_ST_LAST)
+		wait_mask |=3D ATA_DRQ;
+
 	/*
 	 * This is purely heuristic.  This is a fast path.
 	 * Sometimes when we enter, BSY will be cleared in
@@ -1236,14 +1246,14 @@ static void ata_sff_pio_task(struct work_struct *=
work)
 	 * or something.  Snooze for a couple msecs, then
 	 * chk-status again.  If still busy, queue delayed work.
 	 */
-	status =3D ata_sff_busy_wait(ap, ATA_BUSY, 5);
-	if (status & ATA_BUSY) {
+	status =3D ata_sff_busy_wait(ap, wait_mask, 5);
+	if (status & wait_mask) {
 		spin_unlock_irq(ap->lock);
 		ata_msleep(ap, 2);
 		spin_lock_irq(ap->lock);
=20
-		status =3D ata_sff_busy_wait(ap, ATA_BUSY, 10);
-		if (status & ATA_BUSY) {
+		status =3D ata_sff_busy_wait(ap, wait_mask, 10);
+		if (status & wait_mask) {
 			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
 			goto out_unlock;
 		}
--=20
2.51.0

