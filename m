From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: [PATCH 1/2] libata: Fix scsi_host can_queue issue in ata_qc_new()
Date: Tue, 22 Jul 2014 10:50:19 -0400
Message-ID: <1406040619-1722-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:46817 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbaGVOua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 10:50:30 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Tue, 22 Jul 2014 20:20:27 +0530
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: tj@kernel.org, haokexin@gmail.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>

The can_queue in scsi_host can be more than ATA_MAX_QUEUE (32),
for example, in ipr, it can be 100 or more.

Also, some drivers, like ipr driver, haven't filled the field
scsi_host in ata_port, and will lead a call trace, so add
check for that.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 drivers/ata/libata-core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 259d879..a5b9c70 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4734,7 +4734,10 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i, tag, max_queue;
 
-	max_queue = ap->scsi_host->can_queue;
+	if (ap->scsi_host && ap->scsi_host->can_queue <= ATA_MAX_QUEUE)
+		max_queue = ap->scsi_host->can_queue;
+	else
+		max_queue = ATA_MAX_QUEUE;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
@@ -6109,16 +6112,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 {
 	int i, rc;
 
-	/*
-	 * The max queue supported by hardware must not be greater than
-	 * ATA_MAX_QUEUE.
-	 */
-	if (sht->can_queue > ATA_MAX_QUEUE) {
-		dev_err(host->dev, "BUG: the hardware max queue is too large\n");
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	/* host must have been started */
 	if (!(host->flags & ATA_HOST_STARTED)) {
 		dev_err(host->dev, "BUG: trying to register unstarted host\n");
-- 
1.8.1.4

