From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v4] libata: support the ata host which implements a queue depth less than 32
Date: Sat, 12 Jul 2014 12:08:24 +0800
Message-ID: <1405138104-25769-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60669 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaGLEJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jul 2014 00:09:13 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so140510pdi.25
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 21:09:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
("libata/ahci: accommodate tag ordered controllers"). The reason is
that the ata controller on this SoC only implement a queue depth of
16. When issuing the commands in tag order, all the commands in tag
16 ~ 31 are mapped to tag 0 unconditionally and then causes the sata
malfunction. It makes no senses to use a 32 queue in software while
the hardware has less queue depth. So consider the queue depth
implemented by the hardware when requesting a command tag.

Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4:
  - Change WARN_ON_ONCE() to WARN_ON() and move it to ata_host_register()
  - Add comment for function ata_qc_new()

v3: Use ap->scsi_host->can_queue for the queue depth implemented by hardware.
    Patch 2 in v2 is also dropped due to this change.

v2: Remove the changes for the ata tag helper functions

 drivers/ata/libata-core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8f3043165048..259d87937ce7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4721,6 +4721,10 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: target port
  *
+ *	Some ATA host controllers may implement a queue depth which is less
+ *	than ATA_MAX_QUEUE. So we shouldn't allocate a tag which is beyond
+ *	the hardware limitation.
+ *
  *	LOCKING:
  *	None.
  */
@@ -4728,14 +4732,16 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
-	unsigned int i, tag;
+	unsigned int i, tag, max_queue;
+
+	max_queue = ap->scsi_host->can_queue;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
-		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
+	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
+		tag = tag < max_queue ? tag : 0;
 
 		/* the last tag is reserved for internal command. */
 		if (tag == ATA_TAG_INTERNAL)
@@ -6103,6 +6109,16 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 {
 	int i, rc;
 
+	/*
+	 * The max queue supported by hardware must not be greater than
+	 * ATA_MAX_QUEUE.
+	 */
+	if (sht->can_queue > ATA_MAX_QUEUE) {
+		dev_err(host->dev, "BUG: the hardware max queue is too large\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	/* host must have been started */
 	if (!(host->flags & ATA_HOST_STARTED)) {
 		dev_err(host->dev, "BUG: trying to register unstarted host\n");
-- 
1.9.3

