From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/18] [PATCH] libata-link: introduce ata_link
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <1160952880428-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:3765 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422924AbWJOWyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:50 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626625nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:48 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Introduce ata_link.  It abstracts PHY and sits between ata_port and
ata_device.  This new level of abstraction is necessary to support
SATA Port Multiplier, which basically adds a bunch of links (PHYs) to
a ATA host port.  Fields related to command execution, spd_limit and
EH are per-link and thus moved to ata_link.

This patch only defines the host link.  Multiple link handling will be
added later.  Also, a lot of ap->link derefences are added but many of
them will be removed as each part is converted to deal directly with
ata_link instead of ata_port.

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   20 +++---
 drivers/ata/ata_generic.c   |    2 -
 drivers/ata/ata_piix.c      |    2 -
 drivers/ata/libata-core.c   |  147 +++++++++++++++++++++++--------------------
 drivers/ata/libata-eh.c     |  106 ++++++++++++++++---------------
 drivers/ata/libata-scsi.c   |   46 +++++++------
 drivers/ata/libata-sff.c    |    4 +
 drivers/ata/pata_it821x.c   |    4 +
 drivers/ata/pata_optidma.c  |    4 +
 drivers/ata/pata_pdc2027x.c |    2 -
 drivers/ata/pata_rz1000.c   |    2 -
 drivers/ata/pata_sis.c      |    2 -
 drivers/ata/pdc_adma.c      |    4 +
 drivers/ata/sata_mv.c       |    6 +-
 drivers/ata/sata_nv.c       |    4 +
 drivers/ata/sata_promise.c  |    4 +
 drivers/ata/sata_qstor.c    |    4 +
 drivers/ata/sata_sil.c      |    8 +-
 drivers/ata/sata_sil24.c    |   10 +--
 drivers/ata/sata_sx4.c      |    4 +
 drivers/ata/sata_via.c      |    2 -
 drivers/ata/sata_vsc.c      |    2 -
 include/linux/libata.h      |   38 +++++++----
 23 files changed, 225 insertions(+), 202 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 584b6c6..1494c04 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -776,7 +776,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(port_mmio);
 
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(ap->link.device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -853,7 +853,7 @@ static int ahci_hardreset(struct ata_por
 	ahci_stop_engine(port_mmio);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(ap->link.device, &tf);
 	tf.command = 0xff;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
@@ -880,7 +880,7 @@ static int ahci_vt8251_hardreset(struct 
 
 	ahci_stop_engine(port_mmio);
 
-	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context));
+	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->link.eh_context));
 
 	/* vt8251 needs SError cleared for the port to operate */
 	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
@@ -997,7 +997,7 @@ static void ahci_qc_prep(struct ata_queu
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned int err_mask = 0, action = 0;
 	struct ata_queued_cmd *qc;
 	u32 serror;
@@ -1044,7 +1044,7 @@ static void ahci_error_intr(struct ata_p
 	ehi->serror |= serror;
 	ehi->action |= action;
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc)
 		qc->err_mask |= err_mask;
 	else
@@ -1060,7 +1060,7 @@ static void ahci_host_intr(struct ata_po
 {
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u32 status, qc_active;
 	int rc;
 
@@ -1072,7 +1072,7 @@ static void ahci_host_intr(struct ata_po
 		return;
 	}
 
-	if (ap->sactive)
+	if (ap->link.sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
@@ -1090,17 +1090,17 @@ static void ahci_host_intr(struct ata_po
 	/* hmmm... a spurious interupt */
 
 	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+	if (ap->link.sactive && status & PORT_IRQ_D2H_REG_FIS)
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS))
+	if (ata_tag_valid(ap->link.active_tag) && (status & PORT_IRQ_PIOS_FIS))
 		return;
 
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
-				status, ap->active_tag, ap->sactive);
+				status, ap->link.active_tag, ap->link.sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 75e0bb5..eac2c16 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -81,7 +81,7 @@ static void generic_set_mode(struct ata_
 		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 99a4ce5..245a671 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -700,7 +700,7 @@ static int ich_pata_prereset(struct ata_
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
+		ap->link.eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 519e616..68333d8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -424,7 +424,7 @@ static const char *sata_spd_string(unsig
 
 void ata_dev_disable(struct ata_device *dev)
 {
-	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
+	if (ata_dev_enabled(dev) && ata_msg_drv(dev->link->ap)) {
 		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		dev->class++;
 	}
@@ -619,7 +619,7 @@ ata_dev_try_classify(struct ata_port *ap
 	/* see if device passed diags: if master then continue and warn later */
 	if (err == 0 && device == 0)
 		/* diagnostic fail : do nothing _YET_ */
-		ap->device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
+		ap->link.device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
 	else if (err == 1)
 		/* do nothing */ ;
 	else if ((device == 0) && (err == 0x81))
@@ -796,7 +796,7 @@ void ata_dev_select(struct ata_port *ap,
 	ap->ops->dev_select(ap, device);
 
 	if (wait) {
-		if (can_sleep && ap->device[device].class == ATA_DEV_ATAPI)
+		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
 			msleep(150);
 		ata_wait_idle(ap);
 	}
@@ -1023,7 +1023,8 @@ unsigned ata_exec_internal(struct ata_de
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
@@ -1063,11 +1064,11 @@ unsigned ata_exec_internal(struct ata_de
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
@@ -1135,8 +1136,8 @@ unsigned ata_exec_internal(struct ata_de
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	ap->active_tag = preempted_tag;
-	ap->sactive = preempted_sactive;
+	link->active_tag = preempted_tag;
+	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
@@ -1241,7 +1242,7 @@ unsigned int ata_pio_need_iordy(const st
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		    int post_reset, u16 *id)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
@@ -1332,13 +1333,14 @@ int ata_dev_read_id(struct ata_device *d
 
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
@@ -1365,7 +1367,7 @@ static void ata_set_port_max_cmd_len(str
 		unsigned int len = 0;
 
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			len = max(len, ap->device[i].cdb_len);
+			len = max(len, ap->link.device[i].cdb_len);
 
 		ap->scsi_host->max_cmd_len = len;
 	}
@@ -1387,7 +1389,7 @@ static void ata_set_port_max_cmd_len(str
  */
 int ata_dev_configure(struct ata_device *dev, int print_info)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
@@ -1602,7 +1604,7 @@ int ata_bus_probe(struct ata_port *ap)
 	ap->ops->phy_reset(ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
@@ -1619,11 +1621,11 @@ int ata_bus_probe(struct ata_port *ap)
 	   state is undefined. Record the mode */
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].pio_mode = XFER_PIO_0;
+		ap->link.device[i].pio_mode = XFER_PIO_0;
 
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (tries[i])
 			dev->class = classes[i];
@@ -1648,7 +1650,7 @@ int ata_bus_probe(struct ata_port *ap)
 	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			return 0;
 
 	/* no device present, disable port */
@@ -1809,8 +1811,8 @@ void sata_phy_reset(struct ata_port *ap)
 
 struct ata_device *ata_dev_pair(struct ata_device *adev)
 {
-	struct ata_port *ap = adev->ap;
-	struct ata_device *pair = &ap->device[1 - adev->devno];
+	struct ata_link *link = adev->link;
+	struct ata_device *pair = &link->device[1 - adev->devno];
 	if (!ata_dev_enabled(pair))
 		return NULL;
 	return pair;
@@ -1831,8 +1833,8 @@ struct ata_device *ata_dev_pair(struct a
 
 void ata_port_disable(struct ata_port *ap)
 {
-	ap->device[0].class = ATA_DEV_NONE;
-	ap->device[1].class = ATA_DEV_NONE;
+	ap->link.device[0].class = ATA_DEV_NONE;
+	ap->link.device[1].class = ATA_DEV_NONE;
 	ap->flags |= ATA_FLAG_DISABLED;
 }
 
@@ -1859,7 +1861,7 @@ int sata_down_spd_limit(struct ata_port 
 	if (rc)
 		return rc;
 
-	mask = ap->sata_spd_limit;
+	mask = ap->link.sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
 	highbit = fls(mask) - 1;
@@ -1873,7 +1875,7 @@ int sata_down_spd_limit(struct ata_port 
 	if (!mask)
 		return -EINVAL;
 
-	ap->sata_spd_limit = mask;
+	ap->link.sata_spd_limit = mask;
 
 	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
@@ -1885,10 +1887,10 @@ static int __sata_set_spd_needed(struct 
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
@@ -1901,7 +1903,7 @@ static int __sata_set_spd_needed(struct 
  *	@ap: Port in question
  *
  *	Test whether the spd limit in SControl matches
- *	@ap->sata_spd_limit.  This function is used to determine
+ *	@ap->link.sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
  *
@@ -2205,7 +2207,7 @@ int ata_set_mode(struct ata_port *ap, st
 		 * return error code and failing device on failure.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (ata_dev_ready(&ap->device[i])) {
+			if (ata_dev_ready(&ap->link.device[i])) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2217,7 +2219,7 @@ int ata_set_mode(struct ata_port *ap, st
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -2238,7 +2240,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 2: always set host PIO timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2256,7 +2258,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 3: set host DMA timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
@@ -2269,7 +2271,7 @@ int ata_set_mode(struct ata_port *ap, st
 
 	/* step 4: update devices' xfer mode */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		/* don't udpate suspended devices' xfer mode */
 		if (!ata_dev_ready(dev))
@@ -2480,6 +2482,7 @@ static unsigned int ata_bus_softreset(st
 
 void ata_bus_reset(struct ata_port *ap)
 {
+	struct ata_device *device = ap->link.device;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
@@ -2512,23 +2515,23 @@ void ata_bus_reset(struct ata_port *ap)
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
@@ -2644,7 +2647,7 @@ int sata_phy_resume(struct ata_port *ap,
 
 static void ata_wait_spinup(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned long end, secs;
 	int rc;
 
@@ -2685,7 +2688,7 @@ static void ata_wait_spinup(struct ata_p
  */
 int ata_std_prereset(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
@@ -2850,7 +2853,7 @@ int sata_port_hardreset(struct ata_port 
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&ap->eh_context);
+	const unsigned long *timing = sata_ehc_deb_timing(&ap->link.eh_context);
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -3084,7 +3087,7 @@ static int ata_dev_same_device(struct at
 int ata_dev_revalidate(struct ata_device *dev, int post_reset)
 {
 	unsigned int class = dev->class;
-	u16 *id = (void *)dev->ap->sector_buf;
+	u16 *id = (void *)dev->link->ap->sector_buf;
 	int rc;
 
 	if (!ata_dev_enabled(dev)) {
@@ -3171,7 +3174,7 @@ static int ata_dma_blacklisted(const str
 	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
 	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
 	 */
-	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
+	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
 	    (dev->flags & ATA_DFLAG_CDB_INTR))
 		return 1;
 
@@ -3207,7 +3210,8 @@ static int ata_dma_blacklisted(const str
  */
 static void ata_dev_xfermask(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
 
@@ -3733,7 +3737,7 @@ #endif /* __BIG_ENDIAN */
 void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
@@ -3779,7 +3783,7 @@ void ata_mmio_data_xfer(struct ata_devic
 void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf,
 		       unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	unsigned int words = buflen >> 1;
 
 	/* Transfer multiple of 2 bytes */
@@ -4481,7 +4485,7 @@ static struct ata_queued_cmd *ata_qc_new
 
 struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
 	qc = ata_qc_new(ap);
@@ -4524,6 +4528,7 @@ void ata_qc_free(struct ata_queued_cmd *
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
@@ -4533,9 +4538,9 @@ void __ata_qc_complete(struct ata_queued
 
 	/* command should be marked inactive atomically with qc completion */
 	if (qc->tf.protocol == ATA_PROT_NCQ)
-		ap->sactive &= ~(1 << qc->tag);
+		link->sactive &= ~(1 << qc->tag);
 	else
-		ap->active_tag = ATA_TAG_POISON;
+		link->active_tag = ATA_TAG_POISON;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
@@ -4696,19 +4701,20 @@ static inline int ata_should_dma_map(str
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
@@ -4998,7 +5004,7 @@ irqreturn_t ata_interrupt (int irq, void
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
@@ -5198,8 +5204,8 @@ static int ata_host_request_pm(struct at
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		ap->eh_info.action |= action;
-		ap->eh_info.flags |= ehi_flags;
+		ap->link.eh_info.action |= action;
+		ap->link.eh_info.flags |= ehi_flags;
 
 		ata_port_schedule_eh(ap);
 
@@ -5248,7 +5254,7 @@ int ata_host_suspend(struct ata_host *ho
 		struct ata_port *ap = host->ports[i];
 
 		for (j = 0; j < ATA_MAX_DEVICES; j++) {
-			struct ata_device *dev = &ap->device[j];
+			struct ata_device *dev = &ap->link.device[j];
 
 			if (ata_dev_ready(dev)) {
 				ata_port_printk(ap, KERN_WARNING,
@@ -5357,11 +5363,12 @@ void ata_host_stop (struct ata_host *hos
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
@@ -5415,8 +5422,8 @@ void ata_port_init(struct ata_port *ap, 
 		ap->flags |= ent->port_flags;
 		ap->ops = ent->port_ops;
 	}
-	ap->hw_sata_spd_limit = UINT_MAX;
-	ap->active_tag = ATA_TAG_POISON;
+	ap->link.hw_sata_spd_limit = UINT_MAX;
+	ap->link.active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
@@ -5439,9 +5446,11 @@ #endif
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
@@ -5668,9 +5677,9 @@ int ata_device_add(const struct ata_prob
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
-			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
 		}
-		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+		ap->link.sata_spd_limit = ap->link.hw_sata_spd_limit;
 
 		rc = scsi_add_host(ap->scsi_host, dev);
 		if (rc) {
@@ -5683,7 +5692,7 @@ int ata_device_add(const struct ata_prob
 		}
 
 		if (ap->ops->error_handler) {
-			struct ata_eh_info *ehi = &ap->eh_info;
+			struct ata_eh_info *ehi = &ap->link.eh_info;
 			unsigned long flags;
 
 			ata_port_probe(ap);
@@ -5779,7 +5788,7 @@ void ata_port_detach(struct ata_port *ap
 	spin_lock_irqsave(ap->lock, flags);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_disable(&ap->device[i]);
+		ata_dev_disable(&ap->link.device[i]);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2cbd19d..46fca04 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -104,7 +104,7 @@ static int ata_ering_map(struct ata_erin
 
 static unsigned int ata_eh_dev_action(struct ata_device *dev)
 {
-	struct ata_eh_context *ehc = &dev->ap->eh_context;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 
 	return ehc->i.action | ehc->i.dev_action[dev->devno];
 }
@@ -170,7 +170,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 
 	ret = EH_HANDLED;
 	spin_lock_irqsave(ap->lock, flags);
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc) {
 		WARN_ON(qc->scsicmd != cmd);
 		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
@@ -277,9 +277,9 @@ void ata_scsi_error(struct Scsi_Host *ho
 		/* fetch & clear EH info */
 		spin_lock_irqsave(ap->lock, flags);
 
-		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
-		ap->eh_context.i = ap->eh_info;
-		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+		memset(&ap->link.eh_context, 0, sizeof(ap->link.eh_context));
+		ap->link.eh_context.i = ap->link.eh_info;
+		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
 		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
@@ -314,7 +314,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
@@ -325,7 +325,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(ap->lock, flags);
 	} else {
-		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
 	}
 
@@ -480,7 +480,7 @@ void ata_eng_timeout(struct ata_port *ap
 {
 	DPRINTK("ENTER\n");
 
-	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
+	ata_qc_timeout(ata_qc_from_tag(ap, ap->link.active_tag));
 
 	DPRINTK("EXIT\n");
 }
@@ -741,7 +741,7 @@ void ata_eh_qc_retry(struct ata_queued_c
  */
 static void ata_eh_detach_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -756,8 +756,8 @@ static void ata_eh_detach_dev(struct ata
 	}
 
 	/* clear per-dev EH actions */
-	ata_eh_clear_action(dev, &ap->eh_info, ATA_EH_PERDEV_MASK);
-	ata_eh_clear_action(dev, &ap->eh_context.i, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &dev->link->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &dev->link->eh_context.i, ATA_EH_PERDEV_MASK);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
@@ -769,8 +769,8 @@ static void ata_eh_detach_dev(struct ata
  *	@action: action about to be performed
  *
  *	Called just before performing EH actions to clear related bits
- *	in @ap->eh_info such that eh actions are not unnecessarily
- *	repeated.
+ *	in @ap->link.eh_info such that eh actions are not
+ *	unnecessarily repeated.
  *
  *	LOCKING:
  *	None.
@@ -779,8 +779,8 @@ static void ata_eh_about_to_do(struct at
 			       unsigned int action)
 {
 	unsigned long flags;
-	struct ata_eh_info *ehi = &ap->eh_info;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -812,7 +812,7 @@ static void ata_eh_about_to_do(struct at
  *	@action: action just completed
  *
  *	Called right after performing EH actions to clear related bits
- *	in @ap->eh_context.
+ *	in @ap->link.eh_context.
  *
  *	LOCKING:
  *	None.
@@ -820,13 +820,15 @@ static void ata_eh_about_to_do(struct at
 static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
 			unsigned int action)
 {
+	struct ata_eh_context *ehc = &ap->link.eh_context;
+
 	/* if reset is complete, clear all reset actions & reset modifier */
 	if (action & ATA_EH_RESET_MASK) {
 		action |= ATA_EH_RESET_MASK;
-		ap->eh_context.i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(dev, &ap->eh_context.i, action);
+	ata_eh_clear_action(dev, &ehc->i, action);
 }
 
 /**
@@ -920,7 +922,7 @@ static unsigned int ata_read_log_page(st
 static int ata_eh_read_log_10h(struct ata_device *dev,
 			       int *tag, struct ata_taskfile *tf)
 {
-	u8 *buf = dev->ap->sector_buf;
+	u8 *buf = dev->link->ap->sector_buf;
 	unsigned int err_mask;
 	u8 csum;
 	int i;
@@ -973,7 +975,7 @@ static int ata_eh_read_log_10h(struct at
 static unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   unsigned char *sense_buf)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
@@ -1024,7 +1026,7 @@ static unsigned int atapi_eh_request_sen
  */
 static void ata_eh_analyze_serror(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
 
@@ -1066,8 +1068,8 @@ static void ata_eh_analyze_serror(struct
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
@@ -1077,7 +1079,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 
 	/* is it NCQ device error? */
-	if (!ap->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+	if (!ap->link.sactive || !(ehc->i.err_mask & AC_ERR_DEV))
 		return;
 
 	/* has LLDD analyzed already? */
@@ -1099,7 +1101,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 	}
 
-	if (!(ap->sactive & (1 << tag))) {
+	if (!(ap->link.sactive & (1 << tag))) {
 		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
 				"inactive tag %d\n", tag);
 		return;
@@ -1286,7 +1288,7 @@ static int ata_eh_speed_down(struct ata_
 		return 0;
 
 	/* speed down SATA link speed if possible */
-	if (sata_down_spd_limit(dev->ap) == 0)
+	if (sata_down_spd_limit(dev->link->ap) == 0)
 		return ATA_EH_HARDRESET;
 
 	/* lower transfer mode */
@@ -1311,7 +1313,7 @@ static int ata_eh_speed_down(struct ata_
  */
 static void ata_eh_autopsy(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1408,7 +1410,7 @@ static void ata_eh_autopsy(struct ata_po
  */
 static void ata_eh_report(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	const char *frozen, *desc;
 	int tag, nr_failed = 0;
 
@@ -1437,15 +1439,15 @@ static void ata_eh_report(struct ata_por
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
@@ -1508,7 +1510,7 @@ static int ata_eh_reset(struct ata_port 
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
@@ -1535,7 +1537,7 @@ static int ata_eh_reset(struct ata_port 
 		if (rc) {
 			if (rc == -ENOENT) {
 				ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
-				ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
+				ehc->i.action &= ~ATA_EH_RESET_MASK;
 			} else
 				ata_port_printk(ap, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
@@ -1628,7 +1630,7 @@ static int ata_eh_reset(struct ata_port 
 		 * controller state is undefined.  Record the mode.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ap->device[i].pio_mode = XFER_PIO_0;
+			ap->link.device[i].pio_mode = XFER_PIO_0;
 
 		if (postreset)
 			postreset(ap, classes);
@@ -1644,7 +1646,7 @@ static int ata_eh_reset(struct ata_port 
 static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 					struct ata_device **r_failed_dev)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	unsigned long flags;
 	int i, rc = 0;
@@ -1654,7 +1656,7 @@ static int ata_eh_revalidate_and_attach(
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int action;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
@@ -1727,7 +1729,7 @@ static int ata_eh_suspend(struct ata_por
 		unsigned long flags;
 		unsigned int action, err_mask;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_SUSPEND))
@@ -1790,7 +1792,7 @@ static void ata_eh_prep_resume(struct at
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int action;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
@@ -1828,7 +1830,7 @@ static int ata_eh_resume(struct ata_port
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int action, err_mask;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
@@ -1863,7 +1865,7 @@ static int ata_port_nr_enabled(struct at
 	int i, cnt = 0;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			cnt++;
 	return cnt;
 }
@@ -1873,19 +1875,19 @@ static int ata_port_nr_vacant(struct ata
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
 
 	/* skip if all possible devices are suspended */
 	for (i = 0; i < ata_port_max_devices(ap); i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
 			break;
@@ -1901,7 +1903,7 @@ static int ata_eh_skip_recovery(struct a
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
@@ -1914,8 +1916,8 @@ static int ata_eh_skip_recovery(struct a
 static void ata_eh_handle_dev_fail(struct ata_device *dev, int err,
 				   int down_xfermask)
 {
-	struct ata_port *ap = dev->ap;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_port *ap = dev->link->ap;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 
 	switch (err) {
 	case -ENODEV:
@@ -1985,7 +1987,7 @@ static int ata_eh_recover(struct ata_por
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	int down_xfermask, i, rc;
 
@@ -1993,7 +1995,7 @@ static int ata_eh_recover(struct ata_por
 
 	/* prep for recovery */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
@@ -2090,7 +2092,7 @@ static int ata_eh_recover(struct ata_por
 		ata_hp_poll_activate(ap);
 
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->device[i]);
+			ata_dev_disable(&ap->link.device[i]);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
@@ -2255,7 +2257,7 @@ static void ata_eh_handle_port_resume(st
 	timeout = jiffies + HZ; /* 1s max */
 	while (1) {
 		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			struct ata_device *dev = &ap->device[i];
+			struct ata_device *dev = &ap->link.device[i];
 			unsigned int action = ata_eh_dev_action(dev);
 
 			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
@@ -2363,7 +2365,7 @@ void ata_hp_poll_worker(void *data)
 		rc = ap->ops->hp_poll(ap);
 		if (rc) {
 			if (rc > 0) {
-				ata_ehi_hotplugged(&ap->eh_info);
+				ata_ehi_hotplugged(&ap->link.eh_info);
 				ata_port_freeze(ap);
 			}
 			ap->pflags &= ~ATA_PFLAG_HP_POLL;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..a8d988e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -472,8 +472,8 @@ int ata_scsi_device_suspend(struct scsi_
 	action = ATA_EH_SUSPEND;
 	if (mesg.event != PM_EVENT_SUSPEND)
 		action |= ATA_EH_PM_FREEZE;
-	ap->eh_info.dev_action[dev->devno] |= action;
-	ap->eh_info.flags |= ATA_EHI_QUIET;
+	dev->link->eh_info.dev_action[dev->devno] |= action;
+	dev->link->eh_info.flags |= ATA_EHI_QUIET;
 	ata_port_schedule_eh(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -517,7 +517,7 @@ int ata_scsi_device_resume(struct scsi_d
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi;
 	unsigned long flags;
 	unsigned int action;
 
@@ -532,6 +532,7 @@ int ata_scsi_device_resume(struct scsi_d
 		goto out_unlock;
 
 	/* request resume */
+	ehi = &dev->link->eh_info;
 	action = ATA_EH_RESUME;
 	if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)
 		__ata_ehi_hotplugged(ehi);
@@ -1462,7 +1463,7 @@ static void ata_scsi_qc_complete(struct 
 	if (!need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
 	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
 	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
-		qc->ap->eh_info.action |= ATA_EH_REVALIDATE;
+		qc->dev->link->eh_info.action |= ATA_EH_REVALIDATE;
 		ata_port_schedule_eh(qc->ap);
 	}
 
@@ -1516,16 +1517,16 @@ static void ata_scsi_qc_complete(struct 
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
@@ -2521,7 +2522,7 @@ static unsigned int atapi_xlat(struct at
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
 	if (likely(id < ATA_MAX_DEVICES))
-		return &ap->device[id];
+		return &ap->link.device[id];
 	return NULL;
 }
 
@@ -2553,7 +2554,7 @@ static int ata_scsi_dev_enabled(struct a
 	if (unlikely(!ata_dev_enabled(dev)))
 		return 0;
 
-	if (!atapi_enabled || (dev->ap->flags & ATA_FLAG_NO_ATAPI)) {
+	if (!atapi_enabled || (dev->link->ap->flags & ATA_FLAG_NO_ATAPI)) {
 		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
 			ata_dev_printk(dev, KERN_WARNING,
 				       "WARNING: ATAPI is %s, device ignored.\n",
@@ -2980,7 +2981,7 @@ void ata_scsi_scan_host(struct ata_port 
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		struct scsi_device *sdev;
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
@@ -3030,7 +3031,7 @@ int ata_scsi_offline_dev(struct ata_devi
  */
 static void ata_scsi_remove_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct scsi_device *sdev;
 	unsigned long flags;
 
@@ -3103,7 +3104,7 @@ void ata_scsi_hotplug(void *data)
 
 	/* unplug detached devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
@@ -3124,7 +3125,7 @@ void ata_scsi_hotplug(void *data)
 	 * unattached devices.
 	 */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev) && !dev->sdev) {
 			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
 			break;
@@ -3154,6 +3155,7 @@ static int ata_scsi_user_scan(struct Scs
 			      unsigned int id, unsigned int lun)
 {
 	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags;
 	int rc = 0;
 
@@ -3167,15 +3169,15 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(ap->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ap->eh_info.probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
-		ap->eh_info.action |= ATA_EH_SOFTRESET;
+		ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+		ehi->action |= ATA_EH_SOFTRESET;
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
 
 		if (dev) {
-			ap->eh_info.probe_mask |= 1 << dev->devno;
-			ap->eh_info.action |= ATA_EH_SOFTRESET;
-			ap->eh_info.flags |= ATA_EHI_RESUME_LINK;
+			ehi->probe_mask |= 1 << dev->devno;
+			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
 	}
@@ -3207,7 +3209,7 @@ void ata_scsi_dev_rescan(void *data)
 	unsigned int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (ata_dev_enabled(dev) && dev->sdev)
 			scsi_rescan_device(&(dev->sdev->sdev_gendev));
@@ -3333,7 +3335,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
 int ata_sas_slave_configure(struct scsi_device *sdev, struct ata_port *ap)
 {
 	ata_scsi_sdev_config(sdev);
-	ata_scsi_dev_config(sdev, ap->device);
+	ata_scsi_dev_config(sdev, ap->link.device);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_slave_configure);
@@ -3353,8 +3355,8 @@ int ata_sas_queuecmd(struct scsi_cmnd *c
 {
 	ata_scsi_dump_cdb(ap, cmd);
 
-	if (likely(ata_scsi_dev_enabled(ap->device)))
-		__ata_scsi_queuecmd(cmd, done, ap->device);
+	if (likely(ata_scsi_dev_enabled(ap->link.device)))
+		__ata_scsi_queuecmd(cmd, done, ap->link.device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 06daaa3..083234c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -714,12 +714,12 @@ void ata_bmdma_drive_eh(struct ata_port 
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int thaw = 0;
 
-	qc = __ata_qc_from_tag(ap, ap->active_tag);
+	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
 		qc = NULL;
 
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 18ff3e5..d883906 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -416,7 +416,7 @@ static void it821x_passthru_dev_select(s
 {
 	struct it821x_dev *itdev = ap->private_data;
 	if (itdev && device != itdev->last_device) {
-		struct ata_device *adev = &ap->device[device];
+		struct ata_device *adev = &ap->link.device[device];
 		it821x_program(ap, adev, itdev->pio[adev->devno]);
 		itdev->last_device = device;
 	}
@@ -494,7 +494,7 @@ static void it821x_smart_set_mode(struct
 		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index c6906b4..c58c135 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -338,8 +338,8 @@ static void optidma_post_set_mode(struct
 	pci_read_config_byte(pdev, 0x43, &r);
 
 	r &= (0x0F << nybble);
-	r |= (optidma_make_bits43(&ap->device[0]) +
-	     (optidma_make_bits43(&ap->device[0]) << 2)) << nybble;
+	r |= (optidma_make_bits43(&ap->link.device[0]) +
+	     (optidma_make_bits43(&ap->link.device[0]) << 2)) << nybble;
 
 	pci_write_config_byte(pdev, 0x43, r);
 }
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 56e0287..09c01ca 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -456,7 +456,7 @@ static void pdc2027x_post_set_mode(struc
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (ata_dev_enabled(dev)) {
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 4533b63..b59fafd 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -63,7 +63,7 @@ static void rz1000_set_mode(struct ata_p
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index b9ffafb..886e449 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -53,7 +53,7 @@ struct sis_chipset {
 
 static int sis_port_base(struct ata_device *adev)
 {
-	return  0x40 + (4 * adev->ap->port_no) +  (2 * adev->devno);
+	return  0x40 + (4 * adev->link->ap->port_no) +  (2 * adev->devno);
 }
 
 /**
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 9021e34..53f523e 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
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
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 1b8e0eb..9776a67 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1417,7 +1417,7 @@ static void mv_host_intr(struct ata_host
 		}
 
 		if (handled) {
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
@@ -1938,7 +1938,7 @@ static void __mv_phy_reset(struct ata_po
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct ata_taskfile tf;
-	struct ata_device *dev = &ap->device[0];
+	struct ata_device *dev = &ap->link.device[0];
 	unsigned long timeout;
 	int retry = 5;
 	u32 sstatus;
@@ -2045,7 +2045,7 @@ static void mv_eng_timeout(struct ata_po
 	mv_dump_all_regs(ap->host->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host->dev));
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
         printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
 	       ap->host->mmio_base, ap, qc, qc->scsicmd, &qc->scsicmd->cmnd);
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index fcdae1a..f5c22de 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -297,7 +297,7 @@ static irqreturn_t nv_generic_interrupt(
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += ata_host_intr(ap, qc);
 			else
@@ -315,7 +315,7 @@ static irqreturn_t nv_generic_interrupt(
 
 static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	int handled;
 
 	/* freeze if hotplugged */
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 72eda51..f9faf80 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -436,7 +436,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -543,7 +543,7 @@ static irqreturn_t pdc_interrupt (int ir
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc_host_intr(ap, qc);
 		}
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 710909d..bf1f3e2 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
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
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 1b2e36a..3d6e355 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -303,7 +303,7 @@ static void sil_post_set_mode (struct at
 	unsigned int i;
 
 	for (i = 0; i < 2; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			dev_mode[i] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
@@ -357,7 +357,7 @@ static void sil_scr_write (struct ata_po
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
@@ -376,8 +376,8 @@ static void sil_host_intr(struct ata_por
 		 * repeat probing needlessly.
 		 */
 		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-			ata_ehi_hotplugged(&ap->eh_info);
-			ap->eh_info.serror |= serror;
+			ata_ehi_hotplugged(&ap->link.eh_info);
+			ap->link.eh_info.serror |= serror;
 		}
 
 		goto freeze;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index c84efc3..ea1e3e5 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -764,7 +764,7 @@ static void sil24_thaw(struct ata_port *
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
 	u32 irq_stat;
 
@@ -816,7 +816,7 @@ static void sil24_error_intr(struct ata_
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_update_tf(ap);
 			qc->err_mask |= err_mask;
@@ -860,7 +860,7 @@ static inline void sil24_host_intr(struc
 	if (rc > 0)
 		return;
 	if (rc < 0) {
-		struct ata_eh_info *ehi = &ap->eh_info;
+		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
 		ata_port_freeze(ap);
@@ -870,7 +870,7 @@ static inline void sil24_host_intr(struc
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
-			slot_stat, ap->active_tag, ap->sactive);
+			slot_stat, ap->link.active_tag, ap->link.sactive);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
@@ -912,7 +912,7 @@ static irqreturn_t sil24_interrupt(int i
 
 static void sil24_error_handler(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	if (sil24_init_port(ap)) {
 		ata_eh_freeze_port(ap);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index ae7992d..6ad990d 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -837,7 +837,7 @@ static irqreturn_t pdc20621_interrupt (i
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
@@ -864,7 +864,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f4455a1..6978bc8 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -224,7 +224,7 @@ static void svia_scr_write (struct ata_p
  */
 static int vt6420_prereset(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 sstatus, scontrol;
 	int online;
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index c92fb0d..631b0cd 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -231,7 +231,7 @@ static irqreturn_t vsc_sata_interrupt (i
 			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				struct ata_queued_cmd *qc;
 
-				qc = ata_qc_from_tag(ap, ap->active_tag);
+				qc = ata_qc_from_tag(ap, ap->link.active_tag);
 				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 					handled += ata_host_intr(ap, qc);
 				else if (is_vsc_sata_int_err(i, int_status)) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 832c500..fb6d334 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -467,7 +467,7 @@ struct ata_ering {
 };
 
 struct ata_device {
-	struct ata_port		*ap;
+	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
@@ -527,6 +527,23 @@ struct ata_eh_context {
 	unsigned int		did_probe_mask;
 };
 
+struct ata_link {
+	struct ata_port		*ap;
+
+	unsigned int		active_tag;	/* active tag on this link */
+	u32			sactive;	/* active NCQ commands */
+
+	unsigned int		hw_sata_spd_limit;
+	unsigned int		sata_spd_limit;
+
+	/* record runtime error info, protected by host_set lock */
+	struct ata_eh_info	eh_info;
+	/* EH context */
+	struct ata_eh_context	eh_context;
+
+	struct ata_device	device[ATA_MAX_DEVICES];
+};
+
 struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
@@ -550,22 +567,12 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
-	unsigned int		hw_sata_spd_limit;
-	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
-
-	/* record runtime error info, protected by host lock */
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
 
 	struct ata_port_stats	stats;
 	struct ata_host		*host;
@@ -898,8 +905,11 @@ extern void ata_do_eh(struct ata_port *a
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
@@ -1137,7 +1147,7 @@ static inline void ata_tf_init(struct at
 {
 	memset(tf, 0, sizeof(*tf));
 
-	tf->ctl = dev->ap->ctl;
+	tf->ctl = dev->link->ap->ctl;
 	if (dev->devno == 0)
 		tf->device = ATA_DEVICE_OBS;
 	else
-- 
1.4.2.3


