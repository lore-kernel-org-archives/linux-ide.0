From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: prepare ata_sg_clean() for invocation from EH
Date: Tue, 14 Nov 2006 22:47:10 +0900
Message-ID: <11635120303659-git-send-email-htejun@gmail.com>
References: <1163512029469-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:3918 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965804AbWKNNrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:47:17 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1175636wxc
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:47:16 -0800 (PST)
In-Reply-To: <1163512029469-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_sg_clean() global and don't allow NCQ for internal commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 +++---
 drivers/ata/libata.h      |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1b33f05..9688bbf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -309,7 +309,8 @@ int ata_build_tf(struct ata_taskfile *tf
 	tf->flags |= tf_flags;
 
 	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
+			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ &&
+	    likely(tag != ATA_TAG_INTERNAL)) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
@@ -3517,8 +3518,7 @@ static unsigned int ata_dev_init_params(
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-static void ata_sg_clean(struct ata_queued_cmd *qc)
+void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->__sg;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index d4791e7..c0f27c3 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -66,6 +66,7 @@ extern int sata_down_spd_limit(struct at
 extern int sata_set_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
+extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.4.3.3


