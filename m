From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/2] libata: micro-optimize tag allocation
Date: Fri, 16 Jan 2015 15:13:08 -0800
Message-ID: <20150116231307.18771.52330.stgit@viggo.jf.intel.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22160 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbbAPXND (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2015 18:13:03 -0500
In-Reply-To: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>

Jens notes, "libata tag allocator sucks. Like seriously sucks, it's
almost a worst case implementation."  Previously I thought SATA mmio
latency dominated performance profiles, but as Tejun notes:

  "Hmmm... one problem with the existing tag allocator in ata is that
   it's not very efficient which actually shows up in profile when libata
   is used with a very zippy SSD.  Given that ata needs a different
   allocation policies anyway maybe the right thing to do is making the
   existing allocator suck less."

So replace it with a naive enhancement that also supports the existing
quirks.  Hopefully, soon to be replaced by Shaohua's patches [1], but
those do not yet support the quirk needed by sil24 (ATA_FLAG_LOWTAG)
[2].

[1]: http://marc.info/?l=linux-ide&m=142137195324687&w=2
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=87101

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libahci.c     |    2 +-
 drivers/ata/libata-core.c |   59 ++++++++++++++++++++++++---------------------
 drivers/ata/libata-sff.c  |    2 +-
 include/linux/libata.h    |    3 +-
 4 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 97683e45ab04..5b8983738172 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2423,7 +2423,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 {
 	int i, rc;
 
-	rc = ata_host_start(host);
+	rc = ata_host_start(host, sht->can_queue);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e2085d4b5b93..71415819b072 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1585,7 +1585,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	else
 		tag = 0;
 
-	if (test_and_set_bit(tag, &ap->qc_allocated))
+	if (__test_and_set_bit(tag, &ap->qc_allocated))
 		BUG();
 	qc = __ata_qc_from_tag(ap, tag);
 
@@ -4740,29 +4740,32 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
+	int i;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
-		if (ap->flags & ATA_FLAG_LOWTAG)
-			tag = i;
-		else
-			tag = tag < max_queue ? tag : 0;
-
-		/* the last tag is reserved for internal command. */
-		if (tag == ATA_TAG_INTERNAL)
+	/*
+	 * Find first zero bit in qc_allocated starting from ->last_tag,
+	 * unless ATA_FLAG_LOWTAG is set.  In the ATA_FLAG_LOWTAG case
+	 * start searching from zero.
+	 */
+	for (i = !(ap->flags & ATA_FLAG_LOWTAG); i >= 0; i--) {
+		unsigned long qc_allocated = ap->qc_allocated, tag;
+		int last_tag = ap->last_tag * i;
+
+		/* note, ap->qc_allocated protected by ap->lock */
+		qc_allocated |= ~((~0UL >> last_tag) << last_tag);
+		qc_allocated |= (1 << ATA_TAG_INTERNAL);
+		if (qc_allocated == ~0UL)
 			continue;
-
-		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
-			qc = __ata_qc_from_tag(ap, tag);
-			qc->tag = tag;
-			ap->last_tag = tag;
-			break;
-		}
+		tag = ffz(qc_allocated);
+		__set_bit(tag, &ap->qc_allocated);
+		qc = __ata_qc_from_tag(ap, tag);
+		qc->tag = tag;
+		ap->last_tag = tag;
+		break;
 	}
 
 	return qc;
@@ -4815,7 +4818,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qc_allocated);
+		__clear_bit(tag, &ap->qc_allocated);
 	}
 }
 
@@ -5962,20 +5965,25 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
  *	RETURNS:
  *	0 if all ports are started successfully, -errno otherwise.
  */
-int ata_host_start(struct ata_host *host)
+int ata_host_start(struct ata_host *host, int can_queue)
 {
-	int have_stop = 0;
+	int i, rc, n_tags, have_stop = 0;
+	unsigned long qc_allocated;
 	void *start_dr = NULL;
-	int i, rc;
 
 	if (host->flags & ATA_HOST_STARTED)
 		return 0;
 
 	ata_finalize_port_ops(host->ops);
 
+	n_tags = clamp(can_queue, 1, ATA_MAX_QUEUE - 1);
+	qc_allocated = (~0UL >> n_tags) << n_tags;
+	clear_bit(ATA_TAG_INTERNAL, &qc_allocated);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		ap->qc_allocated = qc_allocated;
 		ata_finalize_port_ops(ap->ops);
 
 		if (!host->ops && !ata_port_is_dummy(ap))
@@ -6038,7 +6046,6 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 {
 	spin_lock_init(&host->lock);
 	mutex_init(&host->eh_mutex);
-	host->n_tags = ATA_MAX_QUEUE - 1;
 	host->dev = dev;
 	host->ops = ops;
 }
@@ -6120,8 +6127,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 {
 	int i, rc;
 
-	host->n_tags = clamp(sht->can_queue, 1, ATA_MAX_QUEUE - 1);
-
 	/* host must have been started */
 	if (!(host->flags & ATA_HOST_STARTED)) {
 		dev_err(host->dev, "BUG: trying to register unstarted host\n");
@@ -6136,7 +6141,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	for (i = host->n_ports; host->ports[i]; i++)
 		kfree(host->ports[i]);
 
-	/* give ports names and add SCSI hosts */
+	/* give ports names and add init tag allocation */
 	for (i = 0; i < host->n_ports; i++) {
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
 		host->ports[i]->local_port_no = i + 1;
@@ -6227,7 +6232,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 {
 	int i, rc;
 
-	rc = ata_host_start(host);
+	rc = ata_host_start(host, sht->can_queue);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index db90aa35cb71..575ea268ef2a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2419,7 +2419,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 	const char *drv_name = dev_driver_string(host->dev);
 	int legacy_mode = 0, rc;
 
-	rc = ata_host_start(host);
+	rc = ata_host_start(host, sht->can_queue);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index aba87a3f60bc..32f4ba80be67 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -595,7 +595,6 @@ struct ata_host {
 	struct device 		*dev;
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
-	unsigned int		n_tags;			/* nr of NCQ tags */
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
@@ -1111,7 +1110,7 @@ extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
 extern int ata_slave_link_init(struct ata_port *ap);
-extern int ata_host_start(struct ata_host *host);
+extern int ata_host_start(struct ata_host *host, int can_queue);
 extern int ata_host_register(struct ata_host *host,
 			     struct scsi_host_template *sht);
 extern int ata_host_activate(struct ata_host *host, int irq,

