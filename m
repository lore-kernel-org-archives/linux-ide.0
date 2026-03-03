Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0A39020B
	for <linux-ide@vger.kernel.org>; Tue,  3 Mar 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532231; cv=none; b=c1GwjAjL1Sxz0r0ONXxZRSZt+XGeFKypkqpP/6ZZ+DZLDW875kluXP1h43RoF4ObbpEC6i15fMHJyZrZESPD5Sd/U58uGKDmuRl/jXk0tihaJrIihrp0zduZOI7tkN9CTuPv7pE1WjB9H3Bx1sfBzCC1mEEVihjw0xu9hjy1WjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532231; c=relaxed/simple;
	bh=Ym9T8mCrEFmfypYa+USsCMLEUOKcpapSXJJfxilEsVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv7ol4brMDlwoDVKQ054x0n4jqN1NaN+QF+GXB58IJ5KZ9nDz+aewa1rW9vQIqo2q/yIV09NnxKytbyg8ERTyYWrI1+VfHtKvqK/5/QJ25YhPHJMOGgWRJS3JuXrNl63yQG1O5kgsseCJvm+/VpTrwb0PY8YyulFEX8T6S0BnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlvsOuwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlvsOuwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A466EC2BC87;
	Tue,  3 Mar 2026 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532231;
	bh=Ym9T8mCrEFmfypYa+USsCMLEUOKcpapSXJJfxilEsVs=;
	h=From:To:Cc:Subject:Date:From;
	b=HlvsOuwU1ehKSZ19i6bpxKGhr6vU39N2mfpUQRtQcCn9Nc4Ru7HA987GXG3uD2wcn
	 CaeOPi09vd7LoWSTN1I15pxVsEKKqecp6ACbfFRTXmpRsVbdbhP/qB4geylpjBeKsd
	 oLiYQeBJtIGzbvuwhoo6znaTZFq+oJKlHtpQKCsiS8BcSw8IiBXEJe6O4+kiLDQOGV
	 6PoNszuk/4f/whfU+Y21hn6cQeNktEfnVpIkNHlg7HQynM4s8rnS7zFlRfcrVXSNBQ
	 8lfdzDAas6A4UHGX4O92b1NFeXGcPrOJMvSkSoVXc1sMbLTqu0TQJlpXBUJIUbsUNp
	 i7etWPFJJS0sA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Igor Pylypiv <ipylypiv@google.com>
Cc: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: cancel pending work after clearing deferred_qc
Date: Tue,  3 Mar 2026 11:03:42 +0100
Message-ID: <20260303100341.362978-2-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=cassel@kernel.org; h=from:subject; bh=Ym9T8mCrEFmfypYa+USsCMLEUOKcpapSXJJfxilEsVs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXbfzrfjty29a+L1zurP2JN3LiclassahvjV+YyD65u H3LAinjjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwkO5Xhf6zB7rqaeyGnHJKm Wu99GpO/+PO+UyF8ViuyFSy+ykpHTmZkuNS8cNnFHXLK5f1dsi/m/avK+r9SuuCxS6ju46o/TgF y7AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Syzbot reported a WARN_ON() in ata_scsi_deferred_qc_work(), caused by
ap->ops->qc_defer() returning non-zero before issuing the deferred qc.

ata_scsi_schedule_deferred_qc() is called during each command completion.
This function will check if there is a deferred QC, and if
ap->ops->qc_defer() returns zero, meaning that it is possible to queue the
deferred qc at this time (without being deferred), then it will queue the
work which will issue the deferred qc.

Once the work get to run, which can potentially be a very long time after
the work was scheduled, there is a WARN_ON() if ap->ops->qc_defer() returns
non-zero.

While we hold the ap->lock both when assigning and clearing deferred_qc,
and the work itself holds the ap->lock, the code currently does not cancel
the work after clearing the deferred qc.

This means that the following scenario can happen:
1) One or several NCQ commands are queued.
2) A non-NCQ command is queued, gets stored in ap->deferred_qc.
3) Last NCQ command gets completed, work is queued to issue the deferred
   qc.
4) Timeout or error happens, ap->deferred_qc is cleared. The queued work is
   currently NOT canceled.
5) Port is reset.
6) One or several NCQ commands are queued.
7) A non-NCQ command is queued, gets stored in ap->deferred_qc.
8) Work is finally run. Yet at this time, there is still NCQ commands in
   flight.

The work in 8) really belongs to the non-NCQ command in 2), not to the
non-NCQ command in 7). The reason why the work is executed when it is not
supposed to, is because it was never canceled when ap->deferred_qc was
cleared in 4). Thus, ensure that we always cancel the work after clearing
ap->deferred_qc.

Another potential fix would have been to let ata_scsi_deferred_qc_work() do
nothing if ap->ops->qc_defer() returns non-zero. However, canceling the
work when clearing ap->deferred_qc seems slightly more logical, as we hold
the ap->lock when clearing ap->deferred_qc, so we know that the work cannot
be holding the lock. (The function could be waiting for the lock, but that
is okay since it will do nothing if ap->deferred_qc is not set.)

Reported-by: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c   | 1 +
 drivers/ata/libata-scsi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b373cceb95d2..563432400f72 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -659,6 +659,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 			 */
 			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
 			ap->deferred_qc = NULL;
+			cancel_work(&ap->deferred_qc_work);
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
 		} else if (i < ATA_MAX_QUEUE) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c0dd75a0287c..ad798e5246b4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1699,6 +1699,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 
 	scmd = qc->scsicmd;
 	ap->deferred_qc = NULL;
+	cancel_work(&ap->deferred_qc_work);
 	ata_qc_free(qc);
 	scmd->result = (DID_SOFT_ERROR << 16);
 	scsi_done(scmd);
-- 
2.53.0

