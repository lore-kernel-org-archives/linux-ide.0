From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata-link: introduce ata_link
Date: Fri, 12 May 2006 01:30:22 +0900
Message-ID: <11473650221419-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:23435 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751856AbWEKQaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:30 -0400
Received: by wr-out-0506.google.com with SMTP id 55so367439wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:29 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Introduce ata_link.  It abstracts PHY and sits between ata_port and
ata_device.  This new level of abstraction is necessary to support
SATA Port Multiplier, which basically adds a bunch of links (PHYs) to
a ATA host port.  Fields related to command execution, spd_limit and
EH are per-link and thus moved to ata_link.

Except for the host link, each link can be connected to at most one
device and thus contains one struct ata_device.  Slave device (PATA or
emulated SATA) is a special case for the host link and is handled by
struct ata_device storage __dev1 put right after the host link in
struct ata_port.

This patch only defines the host link.  Multiple link handling will be
added later.  Also, a lot of ap->link derefences are added but many of
them will be removed as each part is converted to deal directly with
ata_link instead of ata_port.

This patch introduces no behavior change.

---

 drivers/scsi/ahci.c         |   20 +++---
 drivers/scsi/libata-bmdma.c |    4 +
 drivers/scsi/libata-core.c  |  134 +++++++++++++++++++++++--------------------
 drivers/scsi/libata-eh.c    |   68 +++++++++++-----------
 drivers/scsi/libata-scsi.c  |   20 +++---
 drivers/scsi/pdc_adma.c     |    4 +
 drivers/scsi/sata_mv.c      |    6 +-
 drivers/scsi/sata_nv.c      |    2 -
 drivers/scsi/sata_promise.c |    4 +
 drivers/scsi/sata_qstor.c   |    4 +
 drivers/scsi/sata_sil.c     |    4 +
 drivers/scsi/sata_sil24.c   |   10 ++-
 drivers/scsi/sata_sx4.c     |    4 +
 drivers/scsi/sata_vsc.c     |    2 -
 include/linux/libata.h      |   40 ++++++++-----
 15 files changed, 174 insertions(+), 152 deletions(-)

14834a330b2a065a120bc776be561f3be32831c1
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index ce8b00a..e3b4fd5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -617,7 +617,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(ap->link.device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -709,7 +709,7 @@ static void ahci_postreset(struct ata_po
 
 	/* clear stored SError */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->eh_info.serror = 0;
+	ap->link.eh_info.serror = 0;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	/* Make sure port's ATAPI bit is set appropriately */
@@ -807,7 +807,7 @@ static void ahci_qc_prep(struct ata_queu
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned int err_mask = 0, action = 0;
 	struct ata_queued_cmd *qc;
 	u32 serror;
@@ -855,7 +855,7 @@ static void ahci_error_intr(struct ata_p
 	ehi->serror |= serror;
 	ehi->action |= action;
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc)
 		qc->err_mask |= err_mask;
 	else
@@ -871,7 +871,7 @@ static void ahci_host_intr(struct ata_po
 {
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u32 status, serror, qc_active;
 	int rc;
 
@@ -897,7 +897,7 @@ static void ahci_host_intr(struct ata_po
 		return;
 	}
 
-	if (ap->sactive)
+	if (ap->link.sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
@@ -915,13 +915,13 @@ static void ahci_host_intr(struct ata_po
 	/* hmmm... a spurious interupt */
 
 	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+	if (ap->link.sactive && status & PORT_IRQ_D2H_REG_FIS)
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag)) {
+	if (ata_tag_valid(ap->link.active_tag)) {
 		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->active_tag);
+			ata_qc_from_tag(ap, ap->link.active_tag);
 
 		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
 		    (status & PORT_IRQ_PIOS_FIS))
@@ -931,7 +931,7 @@ static void ahci_host_intr(struct ata_po
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
-				status, ap->active_tag, ap->sactive);
+				status, ap->link.active_tag, ap->link.sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index db5a975..b3a4642 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -716,12 +716,12 @@ void ata_bmdma_drive_eh(struct ata_port 
 			ata_postreset_fn_t postreset)
 {
 	struct ata_host_set *host_set = ap->host_set;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int thaw = 0;
 
-	qc = __ata_qc_from_tag(ap, ap->active_tag);
+	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
 		qc = NULL;
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index defc6c9..e132e47 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -799,7 +799,7 @@ void ata_dev_select(struct ata_port *ap,
 	ap->ops->dev_select(ap, device);
 
 	if (wait) {
-		if (can_sleep && ap->device[device].class == ATA_DEV_ATAPI)
+		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
 			msleep(150);
 		ata_wait_idle(ap);
 	}
@@ -997,7 +997,8 @@ unsigned ata_exec_internal(struct ata_de
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
@@ -1037,11 +1038,11 @@ unsigned ata_exec_internal(struct ata_de
 	qc->dev = dev;
 	ata_qc_reinit(qc);
 
-	preempted_tag = ap->active_tag;
-	preempted_sactive = ap->sactive;
+	preempted_tag = link->active_tag;
+	preempted_sactive = link->sactive;
 	preempted_qc_active = ap->qc_active;
-	ap->active_tag = ATA_TAG_POISON;
-	ap->sactive = 0;
+	link->active_tag = ATA_TAG_POISON;
+	link->sactive = 0;
 	ap->qc_active = 0;
 
 	/* prepare & issue qc */
@@ -1106,8 +1107,8 @@ unsigned ata_exec_internal(struct ata_de
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	ap->active_tag = preempted_tag;
-	ap->sactive = preempted_sactive;
+	link->active_tag = preempted_tag;
+	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
@@ -1185,7 +1186,7 @@ unsigned int ata_pio_need_iordy(const st
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		    int post_reset, u16 *id)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
@@ -1268,13 +1269,14 @@ int ata_dev_read_id(struct ata_device *d
 
 static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
-	return ((dev->ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
+	struct ata_port *ap = dev->link->ap;
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
 static void ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
 
 	if (!ata_id_has_ncq(dev->id)) {
@@ -1309,7 +1311,7 @@ static void ata_dev_config_ncq(struct at
  */
 int ata_dev_configure(struct ata_device *dev, int print_info)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	int i, rc;
@@ -1436,7 +1438,7 @@ int ata_dev_configure(struct ata_device 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->host->max_cmd_len = max_t(unsigned int,
 					      ap->host->max_cmd_len,
-					      ap->device[i].cdb_len);
+					      ap->link.device[i].cdb_len);
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
@@ -1492,7 +1494,7 @@ static int ata_bus_probe(struct ata_port
 	ap->ops->phy_reset(ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
@@ -1507,7 +1509,7 @@ static int ata_bus_probe(struct ata_port
 
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (tries[i])
 			dev->class = classes[i];
@@ -1532,7 +1534,7 @@ static int ata_bus_probe(struct ata_port
 	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			return 0;
 
 	/* no device present, disable port */
@@ -1693,8 +1695,8 @@ void sata_phy_reset(struct ata_port *ap)
 
 struct ata_device *ata_dev_pair(struct ata_device *adev)
 {
-	struct ata_port *ap = adev->ap;
-	struct ata_device *pair = &ap->device[1 - adev->devno];
+	struct ata_link *link = adev->link;
+	struct ata_device *pair = &link->device[1 - adev->devno];
 	if (!ata_dev_enabled(pair))
 		return NULL;
 	return pair;
@@ -1715,8 +1717,8 @@ struct ata_device *ata_dev_pair(struct a
 
 void ata_port_disable(struct ata_port *ap)
 {
-	ap->device[0].class = ATA_DEV_NONE;
-	ap->device[1].class = ATA_DEV_NONE;
+	ap->link.device[0].class = ATA_DEV_NONE;
+	ap->link.device[1].class = ATA_DEV_NONE;
 	ap->flags |= ATA_FLAG_DISABLED;
 }
 
@@ -1743,7 +1745,7 @@ int ata_down_sata_spd_limit(struct ata_p
 	if (rc)
 		return rc;
 
-	mask = ap->sata_spd_limit;
+	mask = ap->link.sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
 	highbit = fls(mask) - 1;
@@ -1757,7 +1759,7 @@ int ata_down_sata_spd_limit(struct ata_p
 	if (!mask)
 		return -EINVAL;
 
-	ap->sata_spd_limit = mask;
+	ap->link.sata_spd_limit = mask;
 
 	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
@@ -1769,10 +1771,10 @@ static int __ata_set_sata_spd_needed(str
 {
 	u32 spd, limit;
 
-	if (ap->sata_spd_limit == UINT_MAX)
+	if (ap->link.sata_spd_limit == UINT_MAX)
 		limit = 0;
 	else
-		limit = fls(ap->sata_spd_limit);
+		limit = fls(ap->link.sata_spd_limit);
 
 	spd = (*scontrol >> 4) & 0xf;
 	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
@@ -1785,7 +1787,7 @@ static int __ata_set_sata_spd_needed(str
  *	@ap: Port in question
  *
  *	Test whether the spd limit in SControl matches
- *	@ap->sata_spd_limit.  This function is used to determine
+ *	@ap->link.sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
  *
@@ -2084,7 +2086,7 @@ int ata_set_mode(struct ata_port *ap, st
 		 * return error code and failing device on failure.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (ata_dev_enabled(&ap->device[i])) {
+			if (ata_dev_enabled(&ap->link.device[i])) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2096,7 +2098,7 @@ int ata_set_mode(struct ata_port *ap, st
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -2117,7 +2119,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 2: always set host PIO timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2135,7 +2137,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 3: set host DMA timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
@@ -2148,7 +2150,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 4: update devices' xfer mode */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -2356,6 +2358,7 @@ static unsigned int ata_bus_softreset(st
 
 void ata_bus_reset(struct ata_port *ap)
 {
+	struct ata_device *device = ap->link.device;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
@@ -2388,23 +2391,23 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	ap->device[0].class = ata_dev_try_classify(ap, 0, &err);
+	device[0].class = ata_dev_try_classify(ap, 0, &err);
 	if ((slave_possible) && (err != 0x81))
-		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
+		device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
 		ata_irq_on(ap);
 
 	/* is double-select really necessary? */
-	if (ap->device[1].class != ATA_DEV_NONE)
+	if (device[1].class != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 1);
-	if (ap->device[0].class != ATA_DEV_NONE)
+	if (device[0].class != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 0);
 
 	/* if no devices were detected, disable this port */
-	if ((ap->device[0].class == ATA_DEV_NONE) &&
-	    (ap->device[1].class == ATA_DEV_NONE))
+	if ((device[0].class == ATA_DEV_NONE) &&
+	    (device[1].class == ATA_DEV_NONE))
 		goto err_out;
 
 	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
@@ -2540,7 +2543,7 @@ int ata_std_prereset(struct ata_port *ap
 	int rc;
 
 	/* if we're about to do hardreset, don't bother */
-	if (ap->eh_context.i.action & ATA_EH_HARDRESET)
+	if (ap->link.eh_context.i.action & ATA_EH_HARDRESET)
 		return 0;
 
 	/* resume port */
@@ -2822,7 +2825,7 @@ static int ata_dev_same_device(struct at
 int ata_dev_revalidate(struct ata_device *dev, int post_reset)
 {
 	unsigned int class = dev->class;
-	u16 *id = (void *)dev->ap->sector_buf;
+	u16 *id = (void *)dev->link->ap->sector_buf;
 	int rc;
 
 	if (!ata_dev_enabled(dev)) {
@@ -2941,7 +2944,8 @@ static int ata_dma_blacklisted(const str
  */
 static void ata_dev_xfermask(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
 	int i;
@@ -2957,7 +2961,7 @@ static void ata_dev_xfermask(struct ata_
 
 	/* FIXME: Use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *d = &ap->device[i];
+		struct ata_device *d = &link->device[i];
 
 		if (ata_dev_absent(d))
 			continue;
@@ -4199,7 +4203,7 @@ static struct ata_queued_cmd *ata_qc_new
 
 struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
 	qc = ata_qc_new(ap);
@@ -4242,6 +4246,7 @@ void ata_qc_free(struct ata_queued_cmd *
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
@@ -4251,9 +4256,9 @@ void __ata_qc_complete(struct ata_queued
 
 	/* command should be marked inactive atomically with qc completion */
 	if (qc->tf.protocol == ATA_PROT_NCQ)
-		ap->sactive &= ~(1 << qc->tag);
+		link->sactive &= ~(1 << qc->tag);
 	else
-		ap->active_tag = ATA_TAG_POISON;
+		link->active_tag = ATA_TAG_POISON;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
@@ -4416,19 +4421,20 @@ static inline int ata_should_dma_map(str
 void ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	/* Make sure only one non-NCQ command is outstanding.  The
 	 * check is skipped for old EH because it reuses active qc to
 	 * request ATAPI sense.
 	 */
-	WARN_ON(ap->ops->error_handler && ata_tag_valid(ap->active_tag));
+	WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
 
 	if (qc->tf.protocol == ATA_PROT_NCQ) {
-		WARN_ON(ap->sactive & (1 << qc->tag));
-		ap->sactive |= 1 << qc->tag;
+		WARN_ON(link->sactive & (1 << qc->tag));
+		link->sactive |= 1 << qc->tag;
 	} else {
-		WARN_ON(ap->sactive);
-		ap->active_tag = qc->tag;
+		WARN_ON(link->sactive);
+		link->active_tag = qc->tag;
 	}
 
 	qc->flags |= ATA_QCFLAG_ACTIVE;
@@ -4719,7 +4725,7 @@ irqreturn_t ata_interrupt (int irq, void
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
@@ -4928,7 +4934,7 @@ static int ata_start_drive(struct ata_de
  */
 int ata_device_resume(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		struct ata_device *failed_dev;
@@ -4953,7 +4959,7 @@ int ata_device_resume(struct ata_device 
  */
 int ata_device_suspend(struct ata_device *dev, pm_message_t state)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 
 	if (!ata_dev_enabled(dev))
 		return 0;
@@ -5059,11 +5065,12 @@ static void ata_host_remove(struct ata_p
  */
 void ata_dev_init(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
 	/* SATA spd limit is bound to the first device */
-	ap->sata_spd_limit = ap->hw_sata_spd_limit;
+	link->sata_spd_limit = link->hw_sata_spd_limit;
 
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
@@ -5121,8 +5128,8 @@ static void ata_host_init(struct ata_por
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->hw_sata_spd_limit = UINT_MAX;
-	ap->active_tag = ATA_TAG_POISON;
+	ap->link.hw_sata_spd_limit = UINT_MAX;
+	ap->link.active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
@@ -5134,9 +5141,11 @@ static void ata_host_init(struct ata_por
 	if (ap->flags & ATA_FLAG_SATA)
 		ap->cbl = ATA_CBL_SATA;
 
+	ap->link.ap = ap;
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-		dev->ap = ap;
+		struct ata_device *dev = &ap->link.device[i];
+		dev->link = &ap->link;
 		dev->devno = i;
 		ata_dev_init(dev);
 	}
@@ -5298,9 +5307,9 @@ int ata_device_add(const struct ata_prob
 		/* init sata_spd_limit to the current value */
 		if (ata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
-			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
 		}
-		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+		ap->link.sata_spd_limit = ap->link.hw_sata_spd_limit;
 
 		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
@@ -5320,8 +5329,9 @@ int ata_device_add(const struct ata_prob
 
 			spin_lock_irqsave(&ap->host_set->lock, flags);
 
-			ap->eh_info.probe_mask = (1 << ATA_MAX_DEVICES) - 1;
-			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ap->link.eh_info.probe_mask =
+				(1 << ATA_MAX_DEVICES) - 1;
+			ap->link.eh_info.action |= ATA_EH_SOFTRESET;
 
 			set_bit(bit, &ap->flags);
 			ata_port_schedule_eh(ap);
@@ -5396,7 +5406,7 @@ void ata_port_detach(struct ata_port *ap
 
 	ap->flags |= ATA_FLAG_UNLOADING;
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].flags |= ATA_DFLAG_DETACH;
+		ap->link.device[i].flags |= ATA_DFLAG_DETACH;
 
 	ata_port_schedule_eh(ap);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 88f8bc7..cde769f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -133,7 +133,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 
 	ret = EH_HANDLED;
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc) {
 		WARN_ON(qc->scsicmd != cmd);
 		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
@@ -238,10 +238,10 @@ void ata_scsi_error(struct Scsi_Host *ho
 		/* fetch & clear EH info */
 		spin_lock_irqsave(hs_lock, flags);
 
-		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
+		memset(&ap->link.eh_context, 0, sizeof(ap->link.eh_context));
 		if (!(ap->flags & ATA_FLAG_UNLOADING))
-			ap->eh_context.i = ap->eh_info;
-		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+			ap->link.eh_context.i = ap->link.eh_info;
+		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
 
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
 
@@ -269,7 +269,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
 
 		/* Clear host_eh_scheduled while holding hs_lock such
 		 * that if exception occurs after this point but
@@ -280,7 +280,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(hs_lock, flags);
 	} else {
-		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
 	}
 
@@ -401,7 +401,7 @@ void ata_eng_timeout(struct ata_port *ap
 {
 	DPRINTK("ENTER\n");
 
-	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
+	ata_qc_timeout(ata_qc_from_tag(ap, ap->link.active_tag));
 
 	DPRINTK("EXIT\n");
 }
@@ -654,7 +654,7 @@ void ata_eh_qc_retry(struct ata_queued_c
  */
 static void ata_eh_detach_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -688,7 +688,7 @@ static void ata_eh_about_to_do(struct at
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->eh_info.action &= ~action;
+	ap->link.eh_info.action &= ~action;
 	ap->flags |= ATA_FLAG_RECOVERED;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
@@ -784,7 +784,7 @@ static unsigned int ata_read_log_page(st
 static int ata_eh_read_log_10h(struct ata_device *dev,
 			       int *tag, struct ata_taskfile *tf)
 {
-	u8 *buf = dev->ap->sector_buf;
+	u8 *buf = dev->link->ap->sector_buf;
 	unsigned int err_mask;
 	u8 csum;
 	int i;
@@ -837,7 +837,7 @@ static int ata_eh_read_log_10h(struct at
 static unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   unsigned char *sense_buf)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
@@ -889,7 +889,7 @@ static unsigned int atapi_eh_request_sen
  */
 static void ata_eh_analyze_serror(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
 
@@ -934,8 +934,8 @@ static void ata_eh_analyze_serror(struct
  */
 static void ata_eh_analyze_ncq_error(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
-	struct ata_device *dev = ap->device;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_device *dev = ap->link.device;
 	struct ata_queued_cmd *qc;
 	struct ata_taskfile tf;
 	int tag, rc;
@@ -945,7 +945,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 
 	/* is it NCQ device error? */
-	if (!ap->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+	if (!ap->link.sactive || !(ehc->i.err_mask & AC_ERR_DEV))
 		return;
 
 	/* has LLDD analyzed already? */
@@ -967,7 +967,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 	}
 
-	if (!(ap->sactive & (1 << tag))) {
+	if (!(ap->link.sactive & (1 << tag))) {
 		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
 				"inactive tag %d\n", tag);
 		return;
@@ -1154,7 +1154,7 @@ static int ata_eh_speed_down(struct ata_
 		return 0;
 
 	/* speed down SATA link speed if possible */
-	if (ata_down_sata_spd_limit(dev->ap) == 0)
+	if (ata_down_sata_spd_limit(dev->link->ap) == 0)
 		return ATA_EH_HARDRESET;
 
 	/* lower transfer mode */
@@ -1179,7 +1179,7 @@ static int ata_eh_speed_down(struct ata_
  */
 static void ata_eh_autopsy(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int action = ehc->i.action;
 	struct ata_device *failed_dev = NULL;
 	unsigned int all_err_mask = 0;
@@ -1267,7 +1267,7 @@ static void ata_eh_autopsy(struct ata_po
  */
 static void ata_eh_report(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	const char *frozen, *desc;
 	int tag, nr_failed = 0;
 
@@ -1296,15 +1296,15 @@ static void ata_eh_report(struct ata_por
 	if (ehc->i.dev) {
 		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
 			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
-			       ehc->i.err_mask, ap->sactive, ehc->i.serror,
-			       ehc->i.action, frozen);
+			       ehc->i.err_mask, ap->link.sactive,
+			       ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
 			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
 	} else {
 		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
 				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
-				ehc->i.err_mask, ap->sactive, ehc->i.serror,
-				ehc->i.action, frozen);
+				ehc->i.err_mask, ap->link.sactive,
+				ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
 			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
 	}
@@ -1367,7 +1367,7 @@ static int ata_eh_reset(struct ata_port 
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ap->flags & ATA_FLAG_LOADING);
@@ -1484,7 +1484,7 @@ static int ata_eh_reset(struct ata_port 
 static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 					struct ata_device **r_failed_dev)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	unsigned long flags;
 	int i, rc = 0;
@@ -1492,7 +1492,7 @@ static int ata_eh_revalidate_and_attach(
 	DPRINTK("ENTER\n");
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (ehc->i.action & ATA_EH_REVALIDATE && ata_dev_enabled(dev) &&
 		    (!ehc->i.dev || ehc->i.dev == dev)) {
@@ -1540,7 +1540,7 @@ static int ata_port_nr_enabled(struct at
 	int i, cnt = 0;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			cnt++;
 	return cnt;
 }
@@ -1550,14 +1550,14 @@ static int ata_port_nr_vacant(struct ata
 	int i, cnt = 0;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ap->device[i].class == ATA_DEV_UNKNOWN)
+		if (ap->link.device[i].class == ATA_DEV_UNKNOWN)
 			cnt++;
 	return cnt;
 }
 
 static int ata_eh_skip_recovery(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	int i;
 
 	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
@@ -1565,7 +1565,7 @@ static int ata_eh_skip_recovery(struct a
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
@@ -1600,7 +1600,7 @@ static int ata_eh_recover(struct ata_por
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	int down_xfermask, i, rc;
 
@@ -1608,7 +1608,7 @@ static int ata_eh_recover(struct ata_por
 
 	/* prep for recovery */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
@@ -1725,7 +1725,7 @@ static int ata_eh_recover(struct ata_por
  out:
 	if (rc) {
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->device[i]);
+			ata_dev_disable(&ap->link.device[i]);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
@@ -1812,7 +1812,7 @@ void ata_eh_scsi_hotplug(void *data)
 
 	/* unplug detached devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index f5ded5b..6d9384a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1356,16 +1356,16 @@ static void ata_scsi_qc_complete(struct 
  */
 static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
 
 	if (!(dev->flags & ATA_DFLAG_NCQ))
 		return 0;
 
 	if (is_io) {
-		if (!ata_tag_valid(ap->active_tag))
+		if (!ata_tag_valid(link->active_tag))
 			return 0;
 	} else {
-		if (!ata_tag_valid(ap->active_tag) && !ap->sactive)
+		if (!ata_tag_valid(link->active_tag) && !link->sactive)
 			return 0;
 	}
 	return 1;
@@ -2348,7 +2348,7 @@ static unsigned int atapi_xlat(struct at
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
 	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
-		return &ap->device[id];
+		return &ap->link.device[id];
 	return NULL;
 }
 
@@ -2781,7 +2781,7 @@ void ata_scsi_scan_host(struct ata_port 
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		struct scsi_device *sdev;
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
@@ -2831,7 +2831,7 @@ int ata_scsi_offline_dev(struct ata_devi
  */
 void ata_scsi_remove_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct scsi_device *sdev;
 	unsigned long flags;
 
@@ -2911,14 +2911,14 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ap->eh_info.probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
-		ap->eh_info.action |= ATA_EH_SOFTRESET;
+		ap->link.eh_info.probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+		ap->link.eh_info.action |= ATA_EH_SOFTRESET;
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
 
 		if (dev) {
-			ap->eh_info.probe_mask |= 1 << dev->devno;
-			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ap->link.eh_info.probe_mask |= 1 << dev->devno;
+			ap->link.eh_info.action |= ATA_EH_SOFTRESET;
 		} else
 			rc = -EINVAL;
 	}
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index eb910e4..f771359 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -461,7 +461,7 @@ static inline unsigned int adma_intr_pkt
 		pp = ap->private_data;
 		if (!pp || pp->state != adma_state_pkt)
 			continue;
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 			if ((status & (aPERR | aPSD | aUIRQ)))
 				qc->err_mask |= AC_ERR_OTHER;
@@ -486,7 +486,7 @@ static inline unsigned int adma_intr_mmi
 			struct adma_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != adma_state_mmio)
 				continue;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 4e6388f..af4b1f8 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1413,7 +1413,7 @@ static void mv_host_intr(struct ata_host
 		}
 
 		if (handled) {
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
@@ -1922,7 +1922,7 @@ static void __mv_phy_reset(struct ata_po
 	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct ata_taskfile tf;
-	struct ata_device *dev = &ap->device[0];
+	struct ata_device *dev = &ap->link.device[0];
 	unsigned long timeout;
 	int retry = 5;
 	u32 sstatus;
@@ -2029,7 +2029,7 @@ static void mv_eng_timeout(struct ata_po
 	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host_set->dev));
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
         printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 2a840f5..58e5658 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -283,7 +283,7 @@ static irqreturn_t nv_interrupt (int irq
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += ata_host_intr(ap, qc);
 			else
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 9c70018..6f598ea 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -432,7 +432,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -539,7 +539,7 @@ static irqreturn_t pdc_interrupt (int ir
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc_host_intr(ap, qc);
 		}
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 3fc1003..fe2a6cf 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -400,7 +400,7 @@ static inline unsigned int qs_intr_pkt(s
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
 					continue;
-				qc = ata_qc_from_tag(ap, ap->active_tag);
+				qc = ata_qc_from_tag(ap, ap->link.active_tag);
 				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 					switch (sHST) {
 					case 0: /* successful CPB */
@@ -433,7 +433,7 @@ static inline unsigned int qs_intr_mmio(
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 59c49d3..84756af 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -285,7 +285,7 @@ static void sil_post_set_mode (struct at
 	unsigned int i;
 
 	for (i = 0; i < 2; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			dev_mode[i] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
@@ -339,7 +339,7 @@ static void sil_scr_write (struct ata_po
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ || !qc || qc->tf.ctl & ATA_NIEN))
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 8bbcf69..6e0b74b 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -735,7 +735,7 @@ static void sil24_thaw(struct ata_port *
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
 	u32 irq_stat;
 
@@ -794,7 +794,7 @@ static void sil24_error_intr(struct ata_
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_read_tf(ap, sil24_tag(qc->tag), &qc->result_tf);
 			qc->err_mask |= err_mask;
@@ -838,7 +838,7 @@ static inline void sil24_host_intr(struc
 	if (rc > 0)
 		return;
 	if (rc < 0) {
-		struct ata_eh_info *ehi = &ap->eh_info;
+		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
 		ata_port_freeze(ap);
@@ -848,7 +848,7 @@ static inline void sil24_host_intr(struc
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
-			slot_stat, ap->active_tag, ap->sactive);
+			slot_stat, ap->link.active_tag, ap->link.sactive);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -890,7 +890,7 @@ static irqreturn_t sil24_interrupt(int i
 
 static void sil24_error_handler(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	if (sil24_init_port(ap)) {
 		ata_eh_freeze_port(ap);
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index fb69fc2..6432cf0 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -837,7 +837,7 @@ static irqreturn_t pdc20621_interrupt (i
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
@@ -864,7 +864,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index d51c8d6..96700ec 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -232,7 +232,7 @@ static irqreturn_t vsc_sata_interrupt (i
 			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				struct ata_queued_cmd *qc;
 
-				qc = ata_qc_from_tag(ap, ap->active_tag);
+				qc = ata_qc_from_tag(ap, ap->link.active_tag);
 				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 					handled += ata_host_intr(ap, qc);
 				else if (is_vsc_sata_int_err(i, int_status)) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index db9e84c..fbb3f4c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -417,7 +417,7 @@ struct ata_ering {
 	struct ata_ering_entry	name_entries[size];
 
 struct ata_device {
-	struct ata_port		*ap;
+	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
@@ -468,6 +468,24 @@ struct ata_eh_context {
 	unsigned int		did_probe_mask;
 };
 
+struct ata_link {
+	struct ata_port		*ap;
+
+	unsigned int		active_tag;	/* active tag on this link */
+	u32			sactive;	/* active NCQ commands */
+
+	unsigned int		flags;		/* ATA_LFLAG_* */
+	unsigned int		hw_sata_spd_limit;
+	unsigned int		sata_spd_limit;
+
+	/* record runtime error info, protected by host_set lock */
+	struct ata_eh_info	eh_info;
+	/* EH context */
+	struct ata_eh_context	eh_context;
+
+	struct ata_device	device[1];
+};
+
 struct ata_port {
 	struct Scsi_Host	*host;	/* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
@@ -490,22 +508,13 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
-	unsigned int		hw_sata_spd_limit;
-	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
-
-	/* record runtime error info, protected by host_set lock */
-	struct ata_eh_info	eh_info;
-	/* EH context owned by EH */
-	struct ata_eh_context	eh_context;
-
-	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qc_allocated;
 	unsigned int		qc_active;
 
-	unsigned int		active_tag;
-	u32			sactive;
+	struct ata_link		link;	/* host default link */
+	struct ata_device	__dev1;	/* storage for link.device[1] */
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -782,8 +791,11 @@ extern void ata_do_eh(struct ata_port *a
 #define ata_port_printk(ap, lv, fmt, args...) \
 	printk(lv"ata%u: "fmt, (ap)->id , ##args)
 
+#define ata_link_printk(link, lv, fmt, args...) \
+	printk(lv"ata%u: "fmt, (link)->ap->id , ##args)
+
 #define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
+	printk(lv"ata%u.%02u: "fmt, (dev)->link->ap->id, (dev)->devno , ##args)
 
 /*
  * ata_eh_info helpers
@@ -984,7 +996,7 @@ static inline void ata_tf_init(struct at
 {
 	memset(tf, 0, sizeof(*tf));
 
-	tf->ctl = dev->ap->ctl;
+	tf->ctl = dev->link->ap->ctl;
 	if (dev->devno == 0)
 		tf->device = ATA_DEVICE_OBS;
 	else
-- 
1.2.4


