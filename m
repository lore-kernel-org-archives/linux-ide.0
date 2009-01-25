From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH 1/2] [libata] add fields to store TaskFile before error handling kicks.
Date: Sun, 25 Jan 2009 14:26:54 -0800
Message-ID: <1232922415-23836-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:3335 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZAYW1F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 17:27:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: liml@rtr.ca, linux-ide@vger.kernel.org
Cc: Gwendal Grignou <gwendal@google.com>

Sometimes, it is useful to store ATA Task File in qc->result_tf
while still on the data path, instead of the error handler triggering
it.


Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-core.c |    7 +++++--
 drivers/ata/libata-eh.c   |    1 +
 include/linux/libata.h    |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88c2428..9559d25 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4829,8 +4829,11 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	qc->result_tf.flags = qc->tf.flags;
-	ap->ops->qc_fill_rtf(qc);
+	if ((qc->flags & ATA_QCFLAG_RTF_VALID) == 0) {
+		qc->result_tf.flags = qc->tf.flags;
+		qc->flags |= ATA_QCFLAG_RTF_VALID;
+		ap->ops->qc_fill_rtf(qc);
+	}
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8147a83..5490608 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1585,6 +1585,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
+	qc->flags |= ATA_QCFLAG_RTF_VALID;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2c6bd66..c9defdf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -235,6 +235,7 @@ enum {
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
+	ATA_QCFLAG_RTF_VALID	= (1 << 19), /* set when result_tf is valid */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
-- 
1.5.4.5

