From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix internal command failure handling
Date: Fri, 16 Oct 2009 13:00:51 +0900
Message-ID: <4AD7EFF3.1000902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59795 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZJPEB4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2009 00:01:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Ethan <ethanhsiao@jmicron.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

When an internal command fails, it should be failed directly without
invoking EH.  In the original implemetation, this was accomplished by
letting internal command bypass failure handling in ata_qc_complete().
However, later changes added post-successful-completion handling to
that code path and the success path is no longer adequate as internal
command failure path.  One of the visible problems is that internal
command failure due to timeout or other freeze conditions would
spuriously trigger WARN_ON_ONCE() in the success path.

This patch updates failure path such that internal command failure
handling is contained there.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@kernel.org
---
 drivers/ata/libata-core.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b525a09..d7f0f1b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5028,12 +5028,14 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			qc->flags |= ATA_QCFLAG_FAILED;

 		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
-			if (!ata_tag_internal(qc->tag)) {
-				/* always fill result TF for failed qc */
-				fill_result_tf(qc);
+			/* always fill result TF for failed qc */
+			fill_result_tf(qc);
+
+			if (!ata_tag_internal(qc->tag))
 				ata_qc_schedule_eh(qc);
-				return;
-			}
+			else
+				__ata_qc_complete(qc);
+			return;
 		}

 		WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN);
