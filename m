From: Shaohua Li <shli@fb.com>
Subject: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 18 Dec 2014 10:46:22 -0800
Message-ID: <546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38865 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbaLRSq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2014 13:46:27 -0500
Received: from pps.filterd (m0044008 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id sBIIjfT7008012
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:27 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1rc40182ur-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:27 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.223.100.99) with ESMTP	id
 29c4bc3486e611e4828924be05956610-90fdc390 for <linux-ide@vger.kernel.org>;
	Thu, 18 Dec 2014 10:46:23 -0800
In-Reply-To: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

libata uses its own tag management which is duplication and the
implementation is poor. And if we switch to blk-mq, tag is build-in.
It's time to switch to generic taging.

The SAS driver has its own tag management, and looks we can't directly
map the host controler tag to SATA tag. So I just bypassed the SAS case.

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/ata/libata-core.c | 20 ++++++++++++++------
 drivers/ata/libata-scsi.c |  4 +++-
 drivers/ata/libata.h      |  2 +-
 include/linux/libata.h    |  1 +
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5..a27d00f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1585,8 +1585,9 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	else
 		tag = 0;
 
-	if (test_and_set_bit(tag, &ap->qc_allocated))
-		BUG();
+	BUG_ON((!ap->scsi_host && test_and_set_bit(tag, &ap->qc_allocated)) ||
+		(ap->scsi_host && dev->sdev &&
+			blk_queue_find_tag(dev->sdev->request_queue, tag)));
 	qc = __ata_qc_from_tag(ap, tag);
 
 	qc->tag = tag;
@@ -4737,7 +4738,7 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *	None.
  */
 
-static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
+static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap, int blktag)
 {
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int max_queue = ap->host->n_tags;
@@ -4747,6 +4748,12 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
+	if (ap->scsi_host) {
+		qc = __ata_qc_from_tag(ap, blktag);
+		qc->tag = blktag;
+		return qc;
+	}
+
 	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
 		tag = tag < max_queue ? tag : 0;
 
@@ -4773,12 +4780,12 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
  *	None.
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
+struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int blktag)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new(ap);
+	qc = ata_qc_new(ap, blktag);
 	if (qc) {
 		qc->scsicmd = NULL;
 		qc->ap = ap;
@@ -4812,7 +4819,8 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qc_allocated);
+		if (!ap->scsi_host)
+			clear_bit(tag, &ap->qc_allocated);
 	}
 }
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e364e86..94339c2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -756,7 +756,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 {
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new_init(dev);
+	qc = ata_qc_new_init(dev, cmd->request->tag);
 	if (qc) {
 		qc->scsicmd = cmd;
 		qc->scsidone = cmd->scsi_done;
@@ -3666,6 +3666,8 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		 */
 		shost->max_host_blocked = 1;
 
+		scsi_init_shared_tag_map(shost, host->n_tags);
+
 		rc = scsi_add_host_with_dma(ap->scsi_host,
 						&ap->tdev, ap->host->dev);
 		if (rc)
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5f4e0cc..4040513 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -63,7 +63,7 @@ extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
 extern void ata_force_cbl(struct ata_port *ap);
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
+extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2d18241..5f1c5606 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1344,6 +1344,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.ioctl			= ata_scsi_ioctl,		\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.can_queue		= ATA_DEF_QUEUE,		\
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
 	.emulated		= ATA_SHT_EMULATED,		\
-- 
1.8.1

