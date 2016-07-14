From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/10] libata: use ata_is_ncq() accessors
Date: Thu, 14 Jul 2016 09:05:43 +0900
Message-ID: <1468454751-12466-3-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55689 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:04 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

Use accessor functions instead of the raw value.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libahci.c     | 2 +-
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-scsi.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 71b0719..3e69c20 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1975,7 +1975,7 @@ unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	pp->active_link = qc->dev->link;
 
-	if (qc->tf.protocol == ATA_PROT_NCQ)
+	if (ata_is_ncq(qc->tf.protocol))
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
 
 	if (pp->fbs_enabled && pp->fbs_last_dev != qc->dev->link->pmp) {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 077daf0..f5eb07e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4842,7 +4842,7 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
 
-	if (qc->tf.protocol == ATA_PROT_NCQ) {
+	if (ata_is_ncq(qc->tf.protocol)) {
 		if (!ata_tag_valid(link->active_tag))
 			return 0;
 	} else {
@@ -5007,7 +5007,7 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
 		ata_sg_clean(qc);
 
 	/* command should be marked inactive atomically with qc completion */
-	if (qc->tf.protocol == ATA_PROT_NCQ) {
+	if (ata_is_ncq(qc->tf.protocol)) {
 		link->sactive &= ~(1 << qc->tag);
 		if (!link->sactive)
 			ap->nr_active_links--;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3dca0d1..0447a39 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3130,8 +3130,8 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->command = cdb[9];
 	}
 
-	/* For NCQ commands with FPDMA protocol, copy the tag value */
-	if (tf->protocol == ATA_PROT_NCQ)
+	/* For NCQ commands copy the tag value */
+	if (ata_is_ncq(tf->protocol))
 		tf->nsect = qc->tag << 3;
 
 	/* enforce correct master/slave bit */
-- 
2.1.4

