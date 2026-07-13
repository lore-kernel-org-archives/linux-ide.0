Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE63403EA
	for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919395; cv=none; b=VwMC10hMP/URwB+oZg/MiQfkF2kZquPfZwv2u3ORDCcgp3Q3VKqY+1UewZvxGE/1TGmAA03GjVB/z6yYqI5RizG5fVnxKHzi9h3pre3e3v+FReI0APsgVDX6RPPBqrn5Q1WByktDuiplbUJTr1uPzztNgbAHULR1JuxApMwfQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919395; c=relaxed/simple;
	bh=8s8mgQ4m/G6WKonY722y/ELbPuDT0IdpdmQLAK7Xilk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LUGV+TXNLBCNB/jgq4AQwCcOqTdgzX9baRs1i/vcz/lR9iBGFn4qah7OFzkCkoRvVAQ248Gy5L9VRN+aaNkp8QK3H4Sn4dstgiY5KDM9Ql126ndb7jdeQbkvDqF+qxsVVsv7peyeXQBcKBsavSVe3IXCdIi9PZp5hz1NaJYJVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCu7qHsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCu7qHsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50BC1F000E9;
	Mon, 13 Jul 2026 05:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783919394;
	bh=QkBHBGcMZQ/pzX+m/oiGNwT5bu1/jkfUbc8u1e8Wes0=;
	h=From:To:Subject:Date;
	b=mCu7qHsIzC+VLPqgBrG8I1Ij5doPKNef11YMueM/YBNvY9aYSbqGOHa71/WYQ7RC4
	 i1glmAQSPBP1d7Lo8J8D75Tfgz7N7b/p4rCQHxcScuJpnlVI+p7nbosIJ/+oq5h/ee
	 R5gTUkSTHhXm0T9e7JbiAeI5B5/PNEHpUzqIBdp5bAGO6o1/QaxNKGo5PBFmLyiKzX
	 Lpp5PS9bvy+Jo2wtLtgz5jcI1gqWDsOW69mp2zU/rG39q+wO2Fh5MJKHAN8Txxz4Ud
	 3WMV8sZ9C5AlzH6sgW+71BbHwSkf7rFHoTQIAmmgh+Uz1WnFfB+68Rev1yUSSjArIi
	 TE/p0kjIr+a+Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-eh: make ata_eh_qc_complete() and ata_eh_qc_retry() static
Date: Mon, 13 Jul 2026 14:09:42 +0900
Message-ID: <20260713050942.576415-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions ata_eh_qc_complete() and ata_eh_qc_retry() are used only in
libata-eh.c. So remove the declaration of these functions from
include/linux/libata.h and define them as static. While at it, add a
missing blank line between variable declaration and code in these two
functions.

No functional changes intended.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 6 ++++--
 include/linux/libata.h  | 3 ---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ff6d9f94ebed..11e8a28a7210 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1264,9 +1264,10 @@ static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
  *	Indicate to the mid and upper layers that an ATA command has
  *	completed.  To be used from EH.
  */
-void ata_eh_qc_complete(struct ata_queued_cmd *qc)
+static void ata_eh_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
+
 	scmd->retries = scmd->allowed;
 	__ata_eh_qc_complete(qc);
 }
@@ -1282,9 +1283,10 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
  *	scmd->allowed is incremented for commands which get retried
  *	due to unrelated failures (qc->err_mask is zero).
  */
-void ata_eh_qc_retry(struct ata_queued_cmd *qc)
+static void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
+
 	if (!qc->err_mask)
 		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2ea7bfbdd867..224bbfd7c0d6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1421,9 +1421,6 @@ extern int ata_port_freeze(struct ata_port *ap);
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
 
-extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
-extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-
 extern void ata_std_error_handler(struct ata_port *ap)
 	__must_hold(&ap->host->eh_mutex);
 extern void ata_std_sched_eh(struct ata_port *ap);
-- 
2.55.0

