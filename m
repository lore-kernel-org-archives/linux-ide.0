From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 4/5] libata: support the ata host which implements a queue depth less than 32
Date: Thu,  3 Jul 2014 20:09:41 +0800
Message-ID: <1404389382-27298-5-git-send-email-haokexin@gmail.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37882 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaGCMKp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:45 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so124910pdj.5
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:44 -0700 (PDT)
In-Reply-To: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
("libata/ahci: accommodate tag ordered controllers"). The reason is
that the ata controller on this SoC only implement a queue depth of
16. When issuing the commands in tag order, all the commands in tag
16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
malfunction. It makes no senses to use a 32 queue in software while
the hardware has less queue depth. This patch provides the function
for libata to adjust the queue depth for a host controller.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++----
 drivers/ata/libata-eh.c   | 28 ++++++++++++++++++----------
 drivers/ata/libata-scsi.c |  5 +++--
 include/linux/libata.h    | 10 ++++++----
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f1cde0d289fa..08131fe45d42 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2115,7 +2115,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		return 0;
 	}
 	if (ap->flags & ATA_FLAG_NCQ) {
-		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);
+		hdepth = min((unsigned int)ap->scsi_host->can_queue,
+				 ap->host->queue_depth - 1);
 		dev->flags |= ATA_DFLAG_NCQ;
 	}
 
@@ -4729,14 +4730,14 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
-	unsigned int i, tag;
+	unsigned int i, tag, max_queue = ap->host->queue_depth;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
-		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
+	for (i = 0; i < max_queue; i++) {
+		tag = (i + ap->last_tag + 1) % max_queue;
 
 		/* the last tag is reserved for internal command. */
 		if (ata_tag_internal(ap, tag))
@@ -5689,6 +5690,27 @@ static void ata_host_release(struct device *gendev, void *res)
 }
 
 /**
+ *	ata_host_set_queue_depth - set the ATA host controller's queue depth
+ *	@host: ATA host to be set for
+ *	@queue_depth: the queue depth implemented on this host controller
+ *
+ *	We would assume that the ATA host controller has 32 queue depth and
+ *	then set the host->queue_depth to 32 by default. If this is not true
+ *	for one specific ATA host controller, you need to invoke this function
+ *	to set the correct value.
+ */
+int ata_host_set_queue_depth(struct ata_host *host, unsigned int queue_depth)
+{
+	if (!queue_depth || queue_depth > ATA_MAX_QUEUE) {
+		dev_err(host->dev, "Invalid queue depth\n");
+		return -EINVAL;
+	}
+
+	host->queue_depth = queue_depth;
+	return 0;
+}
+
+/**
  *	ata_host_alloc - allocate and init basic ATA host resources
  *	@dev: generic device this host is associated with
  *	@max_ports: maximum number of ATA ports associated with this host
@@ -5733,6 +5755,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	mutex_init(&host->eh_mutex);
 	host->dev = dev;
 	host->n_ports = max_ports;
+	host->queue_depth = ATA_MAX_QUEUE;
 
 	/* allocate ports bound to this host */
 	for (i = 0; i < max_ports; i++) {
@@ -6857,6 +6880,7 @@ EXPORT_SYMBOL_GPL(ata_dev_next);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
 EXPORT_SYMBOL_GPL(ata_host_init);
+EXPORT_SYMBOL_GPL(ata_host_set_queue_depth);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 EXPORT_SYMBOL_GPL(ata_slave_link_init);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a25af5258217..e277022fc552 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -625,6 +625,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 {
 	int i;
 	unsigned long flags;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	/* make sure sff pio task is not running */
 	ata_sff_flush_pio_task(ap);
@@ -664,14 +665,14 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
 			struct ata_queued_cmd *qc;
 
-			for (i = 0; i < ATA_MAX_QUEUE; i++) {
+			for (i = 0; i < max_queue; i++) {
 				qc = __ata_qc_from_tag(ap, i);
 				if (qc->flags & ATA_QCFLAG_ACTIVE &&
 				    qc->scsicmd == scmd)
 					break;
 			}
 
-			if (i < ATA_MAX_QUEUE) {
+			if (i < max_queue) {
 				/* the scmd has an associated qc */
 				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
 					/* which hasn't failed yet, timeout */
@@ -870,9 +871,10 @@ static int ata_eh_nr_in_flight(struct ata_port *ap)
 {
 	unsigned int tag;
 	int nr = 0;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	/* count only non-internal commands */
-	for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++)
+	for (tag = 0; tag < max_queue - 1; tag++)
 		if (ata_qc_from_tag(ap, tag))
 			nr++;
 
@@ -884,6 +886,7 @@ void ata_eh_fastdrain_timerfn(unsigned long arg)
 	struct ata_port *ap = (void *)arg;
 	unsigned long flags;
 	int cnt;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -899,7 +902,7 @@ void ata_eh_fastdrain_timerfn(unsigned long arg)
 		/* No progress during the last interval, tag all
 		 * in-flight qcs as timed out and freeze the port.
 		 */
-		for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++) {
+		for (tag = 0; tag < max_queue - 1; tag++) {
 			struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 			if (qc)
 				qc->err_mask |= AC_ERR_TIMEOUT;
@@ -1047,13 +1050,14 @@ void ata_port_schedule_eh(struct ata_port *ap)
 static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 {
 	int tag, nr_aborted = 0;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	WARN_ON(!ap->ops->error_handler);
 
 	/* we're gonna abort all commands, no need for fast drain */
 	ata_eh_set_pending(ap, 0);
 
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 
 		if (qc && (!link || qc->dev->link == link)) {
@@ -1733,6 +1737,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	struct ata_queued_cmd *qc;
 	struct ata_taskfile tf;
 	int tag, rc;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	/* if frozen, we can't do much */
 	if (ap->pflags & ATA_PFLAG_FROZEN)
@@ -1743,7 +1748,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		return;
 
 	/* has LLDD analyzed already? */
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		qc = __ata_qc_from_tag(ap, tag);
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED))
@@ -2124,6 +2129,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	int tag;
 	u32 serror;
 	int rc;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	DPRINTK("ENTER\n");
 
@@ -2151,7 +2157,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 
 	all_err_mask |= ehc->i.err_mask;
 
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
@@ -2405,6 +2411,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	const char *frozen, *desc;
 	char tries_buf[6] = "";
 	int tag, nr_failed = 0;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
 		return;
@@ -2413,7 +2420,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	if (ehc->i.desc[0] != '\0')
 		desc = ehc->i.desc;
 
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
@@ -2477,7 +2484,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		  ehc->i.serror & SERR_DEV_XCHG ? "DevExch " : "");
 #endif
 
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
 		const u8 *cdb = qc->cdb;
@@ -3930,9 +3937,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 void ata_eh_finish(struct ata_port *ap)
 {
 	int tag;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	/* retry or finish qcs */
-	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+	for (tag = 0; tag < max_queue; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED))
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0586f66d70fa..76a65b652389 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1161,9 +1161,10 @@ static int ata_scsi_dev_config(struct scsi_device *sdev,
 
 	if (dev->flags & ATA_DFLAG_NCQ) {
 		int depth;
+		struct ata_port *ap = dev->link->ap;
 
 		depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
-		depth = min(ATA_MAX_QUEUE - 1, depth);
+		depth = min((int)ap->host->queue_depth - 1, depth);
 		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
 	}
 
@@ -1277,7 +1278,7 @@ int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 	/* limit and apply queue depth */
 	queue_depth = min(queue_depth, sdev->host->can_queue);
 	queue_depth = min(queue_depth, ata_id_queue_depth(dev->id));
-	queue_depth = min(queue_depth, ATA_MAX_QUEUE - 1);
+	queue_depth = min(queue_depth, (int)ap->host->queue_depth - 1);
 
 	if (sdev->queue_depth == queue_depth)
 		return -EINVAL;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 74976a08c9bc..31e2090b7c9a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -126,7 +126,6 @@ enum {
 	ATA_DEF_QUEUE		= 1,
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
 	ATA_MAX_QUEUE		= 32,
-	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
 	ATA_SHORT_PAUSE		= 16,
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
@@ -593,6 +592,7 @@ struct ata_host {
 	struct device 		*dev;
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
+	unsigned int		queue_depth;
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
@@ -1104,6 +1104,8 @@ extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 
+extern int ata_host_set_queue_depth(struct ata_host *host,
+					unsigned int queue_depth);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
@@ -1476,18 +1478,18 @@ extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 
 static inline unsigned int ata_tag_valid(struct ata_port *ap, unsigned int tag)
 {
-	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
+	return (tag < ap->host->queue_depth) ? 1 : 0;
 }
 
 static inline unsigned int ata_get_internal_tag(struct ata_port *ap)
 {
-	return ATA_TAG_INTERNAL;
+	return ap->host->queue_depth - 1;
 }
 
 static inline unsigned int ata_tag_internal(struct ata_port *ap,
 						unsigned int tag)
 {
-	return tag == ATA_TAG_INTERNAL;
+	return tag == (ap->host->queue_depth - 1);
 }
 
 /*
-- 
1.9.3

