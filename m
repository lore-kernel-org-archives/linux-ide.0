From: Shaohua Li <shli@fb.com>
Subject: [PATCH v3 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 17:32:27 -0800
Message-ID: <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51823 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbbAPBcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 20:32:33 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id t0G1WVlC022099
	for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 17:32:32 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0b-00082601.pphosted.com with ESMTP id 1rxr1hg5uh-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 17:32:32 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.212.232.63) with ESMTP	id
 886980229d1f11e48cd90002c992ebde-d0ed6390 for <linux-ide@vger.kernel.org>;
	Thu, 15 Jan 2015 17:32:28 -0800
In-Reply-To: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, dan.j.williams@intel.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

libata uses its own tag management which is duplication and the
implementation is poor. And if we switch to blk-mq, tag is build-in.
It's time to switch to generic taging.

The SAS driver has its own tag management, and looks we can't directly
map the host controler tag to SATA tag. So I just bypassed the SAS case.

I changed the code/variable name for the tag management of libata to
make it self contained. Only sas will use it. Later if libsas implements
its tag management, the tag management code in libata can be deleted
easily.

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/ata/libata-core.c | 54 +++++++++++++++++++++++++++++++++++------------
 drivers/ata/libata-scsi.c |  4 +++-
 drivers/ata/libata.h      |  2 +-
 include/linux/libata.h    |  5 +++--
 4 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5..695d33d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1525,6 +1525,15 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 	complete(waiting);
 }
 
+static bool ata_valid_internal_tag(struct ata_port *ap, struct ata_device *dev,
+				   unsigned int tag)
+{
+	if (!ap->scsi_host)
+		return !test_and_set_bit(tag, &ap->sas_tag_allocated);
+	return !dev->sdev ||
+	       !blk_queue_find_tag(dev->sdev->request_queue, tag);
+}
+
 /**
  *	ata_exec_internal_sg - execute libata internal command
  *	@dev: Device to which the command is sent
@@ -1585,8 +1594,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	else
 		tag = 0;
 
-	if (test_and_set_bit(tag, &ap->qc_allocated))
-		BUG();
+	BUG_ON(!ata_valid_internal_tag(ap, dev, tag));
 	qc = __ata_qc_from_tag(ap, tag);
 
 	qc->tag = tag;
@@ -4737,27 +4745,23 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *	None.
  */
 
-static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
+static struct ata_queued_cmd *sas_ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int max_queue = ap->host->n_tags;
 	unsigned int i, tag;
 
-	/* no command while frozen */
-	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
-		return NULL;
-
-	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
+	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
 		tag = tag < max_queue ? tag : 0;
 
 		/* the last tag is reserved for internal command. */
 		if (tag == ATA_TAG_INTERNAL)
 			continue;
 
-		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
+		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
 			qc = __ata_qc_from_tag(ap, tag);
 			qc->tag = tag;
-			ap->last_tag = tag;
+			ap->sas_last_tag = tag;
 			break;
 		}
 	}
@@ -4765,6 +4769,24 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 	return qc;
 }
 
+static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap, int blktag)
+{
+	struct ata_queued_cmd *qc;
+
+	/* no command while frozen */
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
+		return NULL;
+
+	/* SATA will directly use block tag. libsas need its own tag management */
+	if (ap->scsi_host) {
+		qc = __ata_qc_from_tag(ap, blktag);
+		qc->tag = blktag;
+		return qc;
+	}
+
+	return sas_ata_qc_new(ap);
+}
+
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
@@ -4773,12 +4795,12 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
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
@@ -4800,6 +4822,12 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
+static void sas_ata_qc_free(unsigned int tag, struct ata_port *ap)
+{
+	if (!ap->scsi_host)
+		clear_bit(tag, &ap->sas_tag_allocated);
+}
+
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap;
@@ -4812,7 +4840,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qc_allocated);
+		sas_ata_qc_free(tag, ap);
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
index 2d18241..f234547 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -821,10 +821,10 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
-	unsigned long		qc_allocated;
+	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
 	unsigned int		qc_active;
 	int			nr_active_links; /* #links with active qcs */
-	unsigned int		last_tag;	/* track next tag hw expects */
+	unsigned int		sas_last_tag;	/* track next tag hw expects */
 
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
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

