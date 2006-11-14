From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: sync result_tf.flags w/ command tf.flags
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <11635114553644-git-send-email-htejun@gmail.com>
References: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:33407 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965716AbWKNNhq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:46 -0500
Received: by wr-out-0506.google.com with SMTP id i22so142367wra
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:46 -0800 (PST)
In-Reply-To: <11635114553453-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata didn't initialize result_tf.flags which indicates transfer type
(RW/FUA) and address type (CHS/LBA/LBA48).  ata_gen_fixed_sense()
assumed result_tf.flags equals command tf.flags and failed to report
the first failed block to SCSI layer because zero tf flags indicates
CHS and bad block reporting for CHS is not implemented.

Implement fill_result_tf() which sets result_tf.flags to command
tf.flags and use it to fill result_tf.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 994bc27..476df94 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4516,6 +4516,14 @@ void __ata_qc_complete(struct ata_queued
 	qc->complete_fn(qc);
 }
 
+static void fill_result_tf(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	ap->ops->tf_read(ap, &qc->result_tf);
+	qc->result_tf.flags = qc->tf.flags;
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -4553,7 +4561,7 @@ void ata_qc_complete(struct ata_queued_c
 		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
 			if (!ata_tag_internal(qc->tag)) {
 				/* always fill result TF for failed qc */
-				ap->ops->tf_read(ap, &qc->result_tf);
+				fill_result_tf(qc);
 				ata_qc_schedule_eh(qc);
 				return;
 			}
@@ -4561,7 +4569,7 @@ void ata_qc_complete(struct ata_queued_c
 
 		/* read result TF if requested */
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
-			ap->ops->tf_read(ap, &qc->result_tf);
+			fill_result_tf(qc);
 
 		__ata_qc_complete(qc);
 	} else {
@@ -4570,7 +4578,7 @@ void ata_qc_complete(struct ata_queued_c
 
 		/* read result TF if failed or requested */
 		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
-			ap->ops->tf_read(ap, &qc->result_tf);
+			fill_result_tf(qc);
 
 		__ata_qc_complete(qc);
 	}
-- 
1.4.3.3


