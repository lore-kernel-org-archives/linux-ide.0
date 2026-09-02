Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A328337BAB
	for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314923; cv=none; b=HP2uAbIdd2EHP6v8O2P4iURNww1ND8iHQasEKhP/Vy2/aw2QCA28HbemHZtNKPQvvSiKqAZF3rsyjnKBFiiGt613Eai3Fq93kdkXxMm1QB1BPXbW5bw0m6h/T+HGbXWxBpkVniR/AKhQNlyPo1SSQHzZHg9T0thvf4aNuNVlOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314923; c=relaxed/simple;
	bh=p3drjMizIZ0C2wqffnkNXIloGDH5/n4dhACkpTOSVqE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kl/mmrxPIcGG+o9ajMdd23ljKGfaqDwC/RNlFhVW9JzTX+Z9TDJtOcnrpxHGhzv7ZRfZqZSfjv6+rVUJ2vsh3iXC7fQpYUpHthYAkScHmk88jEtJYZC+JhsO8wGOykZJblpWCIE8UaTWNJuaoN/i3fBNZuHkAs70r1EH16RUD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhwo6P6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhwo6P6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AE21F000E9;
	Wed,  2 Sep 2026 02:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788314920;
	bh=sxv0dqWhQqNrOdsIugk111/o2ToxIc+Y4VfLPAtm/0g=;
	h=From:To:Subject:Date;
	b=Hhwo6P6MXora6UInFHljNoNgo9ZrTVjWCLPo5XtfG02cIcQfazuMHbZvqLSOhHEC6
	 CLnJhydXdOybbmxwTjEohQZ8ape40h+ohN8rd8dcAlFVzigzvpWK2q4Q9DBHnM3EOY
	 3HHNsKjOlb7VbZoGgVtwflERbd4ovzllnrXM6RwGD8tLPfFAc8OSUUIDYM4QN1OxPN
	 k7o7LIC1z7QlzJTtv046+tlcsyLDSfVuCLqcEwOQjdCQfQI8dxxoCgJUeUKA0TsuHd
	 AjzEeURlz50pIMhnVZn/eJZDXfB8SgXfIMlolFwtZc7EE3zl1605CESC8Cng4Mjrf/
	 GqBZ7oxVy7u2Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-scsi: do not raise UA for storage element depopulation and restoration
Date: Wed,  2 Sep 2026 11:08:28 +0900
Message-ID: <20260902020828.1436048-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the translation of the trnalated ATA commands REMOVE ELEMENT
AND TRUNCATE and RESTORE ELEMENTS AND REBUILD are completed using the
function ata_scsi_depop_ua_cap_changed_complete(). This completion
function raises a UNIT ATTENTION with the additional sense code CAPACITY
DATA CHANGED. But doing so, the scsi layer seeing the UNIT ATTENTION sense
key ends up failing the command, even if the command result is in fact OK.

The SAT specifications do provide more details about the capacity change
should be notified, and that relies on the ACCESSIBLE CAPACITY field of
the IDENTIFY DATA retrieved before or after the command is issued, and
then raising a UNIT ATTENTION if the capacity has really changed. However,
we do not have any simple mean to raise a unit attention from libata-scsi.
So rather than seeing the REMOVE ELEMENT AND TRUNCATE and RESTORE ELEMENTS
AND REBUILD commands failing, remove the function
ata_scsi_depop_ua_cap_changed_complete() and rely on the regular
completion callback. Since for now these commands can only be issued as
passthrough commands, the user is responsible for revalidating the device
capacity after executing these commands.

Fixes: db496721cb0d ("ata: libata-scsi: add support for the REMOVE ELEMENT AND TRUNCATE command")
Fixes: 1e307ca61a9c ("ata: libata-scsi: add support for the RESTORE ELEMENTS AND REBUILD command")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a7d667cfcfec..b3666519b648 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4823,28 +4823,6 @@ ata_scsi_get_phys_element_status_xlat(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static void ata_scsi_depop_ua_cap_changed_complete(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *scmd = qc->scsicmd;
-	u8 *cdb = scmd->cmnd;
-	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
-	bool is_success = qc->err_mask == 0;
-
-	/*
-	 * For successful non-passthrough commands, raise a UNIT ATTENTION with
-	 * the additional sense code set to CAPACITY DATA HAS CHANGED to be
-	 * raised. Note that this should be done only if the capacity has
-	 * actually changed, which may not be the case if the element that was
-	 * specified for depopulation was already depopulated, or we did not
-	 * restore any removed element. But a capacity change unit attention is
-	 * harmless, so always raise the unit attention.
-	 */
-	if (is_success && !is_ata_passthru)
-		ata_scsi_set_sense(qc->dev, scmd, UNIT_ATTENTION,
-				   UA_CHANGED_ASC, CAPACITY_CHANGED_ASCQ);
-	ata_scsi_qc_complete(qc);
-}
-
 static unsigned int
 ata_scsi_remove_element_and_truncate_xlat(struct ata_queued_cmd *qc)
 {
@@ -4884,7 +4862,6 @@ ata_scsi_remove_element_and_truncate_xlat(struct ata_queued_cmd *qc)
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
 
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
-	qc->complete_fn = ata_scsi_depop_ua_cap_changed_complete;
 
 	return 0;
 }
@@ -4937,7 +4914,6 @@ ata_scsi_restore_elements_and_rebuild_xlat(struct ata_queued_cmd *qc)
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
 
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
-	qc->complete_fn = ata_scsi_depop_ua_cap_changed_complete;
 
 	return 0;
 }
-- 
2.55.0

