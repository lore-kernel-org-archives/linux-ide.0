From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] libata: use ata_is_ncq() accessors
Date: Mon, 20 Jun 2016 13:39:11 +0200
Message-ID: <1466422756-126637-2-git-send-email-hare@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbcFTLyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:04 -0400
In-Reply-To: <1466422756-126637-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Use accessor functions instead of the raw value.

Signed-off-by: Hannes Reinecke <hare@suse.com>
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
index 6be7770..e798915 100644
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
index bfec66f..94bcd76 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3125,8 +3125,8 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->command = cdb[9];
 	}
 
-	/* For NCQ commands with FPDMA protocol, copy the tag value */
-	if (tf->protocol == ATA_PROT_NCQ)
+	/* For NCQ commands copy the tag value */
+	if (ata_is_ncq(tf->protocol))
 		tf->nsect = qc->tag << 3;
 
 	/* enforce correct master/slave bit */
-- 
1.8.5.6

