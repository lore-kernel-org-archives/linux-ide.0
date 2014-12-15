From: Shaohua Li <shli@fb.com>
Subject: [PATCH 2/2] libata: use generic taging
Date: Sun, 14 Dec 2014 19:21:50 -0800
Message-ID: <fe6c323e2127bb4a89c4a4f85e5d131bba355a05.1418613253.git.shli@fb.com>
References: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25809 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbaLODVz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Dec 2014 22:21:55 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id sBF3JV7A028970
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2014 19:21:54 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1r96r49gqr-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2014 19:21:54 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.223.100.99) with ESMTP	id
 82a4eaca840911e486fd24be05956610-91fde390 for <linux-ide@vger.kernel.org>;
	Sun, 14 Dec 2014 19:21:51 -0800
In-Reply-To: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

libata uses its own tag management which is duplication and the
implementation is poor. And if we switch to blk-mq, tag is build-in.
It's time to switch to generic taging.

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/ata/libata-core.c | 71 +++++++++--------------------------------------
 drivers/ata/libata-scsi.c |  4 ++-
 drivers/ata/libata.h      |  2 +-
 include/linux/libata.h    |  4 +--
 4 files changed, 19 insertions(+), 62 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5..ba4986d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1585,7 +1585,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	else
 		tag = 0;
 
-	if (test_and_set_bit(tag, &ap->qc_allocated))
+	if (dev->sdev && blk_queue_find_tag(dev->sdev->request_queue, tag))
 		BUG();
 	qc = __ata_qc_from_tag(ap, tag);
 
@@ -4726,46 +4726,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 }
 
 /**
- *	ata_qc_new - Request an available ATA command, for queueing
- *	@ap: target port
- *
- *	Some ATA host controllers may implement a queue depth which is less
- *	than ATA_MAX_QUEUE. So we shouldn't allocate a tag which is beyond
- *	the hardware limitation.
- *
- *	LOCKING:
- *	None.
- */
-
-static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc = NULL;
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
-
-	/* no command while frozen */
-	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
-		return NULL;
-
-	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
-		tag = tag < max_queue ? tag : 0;
-
-		/* the last tag is reserved for internal command. */
-		if (tag == ATA_TAG_INTERNAL)
-			continue;
-
-		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
-			qc = __ata_qc_from_tag(ap, tag);
-			qc->tag = tag;
-			ap->last_tag = tag;
-			break;
-		}
-	}
-
-	return qc;
-}
-
-/**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
  *
@@ -4773,19 +4733,22 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
  *	None.
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
+struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new(ap);
-	if (qc) {
-		qc->scsicmd = NULL;
-		qc->ap = ap;
-		qc->dev = dev;
+	/* no command while frozen */
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
+		return NULL;
 
-		ata_qc_reinit(qc);
-	}
+	qc = __ata_qc_from_tag(ap, tag);
+	qc->tag = tag;
+	qc->scsicmd = NULL;
+	qc->ap = ap;
+	qc->dev = dev;
+
+	ata_qc_reinit(qc);
 
 	return qc;
 }
@@ -4802,18 +4765,10 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap;
-	unsigned int tag;
-
 	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
-	ap = qc->ap;
 
 	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qc_allocated);
-	}
+	qc->tag = ATA_TAG_POISON;
 }
 
 void __ata_qc_complete(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e364e86..12e867c 100644
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
@@ -3711,6 +3711,8 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 						 NULL);
 			if (!IS_ERR(sdev)) {
 				dev->sdev = sdev;
+				blk_queue_resize_tags(sdev->request_queue,
+					ap->host->n_tags);
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
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
index 2d18241..300204c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -821,10 +821,8 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
-	unsigned long		qc_allocated;
 	unsigned int		qc_active;
 	int			nr_active_links; /* #links with active qcs */
-	unsigned int		last_tag;	/* track next tag hw expects */
 
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
@@ -1344,6 +1342,8 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.ioctl			= ata_scsi_ioctl,		\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.can_queue		= ATA_DEF_QUEUE,		\
+	.use_blk_tags		= 1,				\
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
 	.emulated		= ATA_SHT_EMULATED,		\
-- 
1.8.1

