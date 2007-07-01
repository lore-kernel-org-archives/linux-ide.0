From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/16] libata-link: introduce ata_link
Date: Sun, 1 Jul 2007 19:05:59 +0900
Message-ID: <11832843593752-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51779 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbXGAKGH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879666wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:07 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
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
 drivers/ata/ahci.c           |   18 +++---
 drivers/ata/ata_generic.c    |    2 +-
 drivers/ata/libata-acpi.c    |   21 +++---
 drivers/ata/libata-core.c    |  157 ++++++++++++++++++++++--------------------
 drivers/ata/libata-eh.c      |  100 ++++++++++++++-------------
 drivers/ata/libata-scsi.c    |   41 ++++++-----
 drivers/ata/libata-sff.c     |    4 +-
 drivers/ata/pata_it821x.c    |    4 +-
 drivers/ata/pata_ixp4xx_cf.c |    4 +-
 drivers/ata/pata_legacy.c    |    4 +-
 drivers/ata/pata_optidma.c   |    4 +-
 drivers/ata/pata_pcmcia.c    |    4 +-
 drivers/ata/pata_pdc2027x.c  |    2 +-
 drivers/ata/pata_platform.c  |    2 +-
 drivers/ata/pata_qdi.c       |    2 +-
 drivers/ata/pata_rz1000.c    |    2 +-
 drivers/ata/pata_scc.c       |    2 +-
 drivers/ata/pata_sis.c       |    2 +-
 drivers/ata/pata_winbond.c   |    2 +-
 drivers/ata/pdc_adma.c       |    4 +-
 drivers/ata/sata_inic162x.c  |    7 +-
 drivers/ata/sata_mv.c        |    6 +-
 drivers/ata/sata_nv.c        |   26 ++++----
 drivers/ata/sata_promise.c   |    4 +-
 drivers/ata/sata_qstor.c     |    4 +-
 drivers/ata/sata_sil.c       |   14 ++--
 drivers/ata/sata_sil24.c     |   12 ++--
 drivers/ata/sata_sx4.c       |    4 +-
 drivers/ata/sata_via.c       |    2 +-
 drivers/ata/sata_vsc.c       |    2 +-
 include/linux/libata.h       |   40 +++++++----
 31 files changed, 263 insertions(+), 239 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2e4c9ad..ee87caa 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -981,7 +981,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(ap->link.device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -1055,7 +1055,7 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
 	ahci_stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(ap->link.device, &tf);
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
@@ -1082,7 +1082,7 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
 
 	ahci_stop_engine(ap);
 
-	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context),
+	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->link.eh_context),
 				 deadline);
 
 	/* vt8251 needs SError cleared for the port to operate */
@@ -1201,7 +1201,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned int err_mask = 0, action = 0;
 	struct ata_queued_cmd *qc;
 	u32 serror;
@@ -1255,7 +1255,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	ehi->serror |= serror;
 	ehi->action |= action;
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc)
 		qc->err_mask |= err_mask;
 	else
@@ -1270,7 +1270,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 static void ahci_port_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 status, qc_active;
 	int rc, known_irq = 0;
@@ -1283,7 +1283,7 @@ static void ahci_port_intr(struct ata_port *ap)
 		return;
 	}
 
-	if (ap->sactive)
+	if (ap->link.sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
@@ -1303,7 +1303,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	/* if !NCQ, ignore.  No modern ATA device has broken HSM
 	 * implementation for non-NCQ commands.
 	 */
-	if (!ap->sactive)
+	if (!ap->link.sactive)
 		return;
 
 	if (status & PORT_IRQ_D2H_REG_FIS) {
@@ -1356,7 +1356,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	if (!known_irq)
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
-				status, ap->active_tag, ap->sactive);
+				status, ap->link.active_tag, ap->link.sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 5758b10..3009824 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -53,7 +53,7 @@ static int generic_set_mode(struct ata_port *ap, struct ata_device **unused)
 		dma_enabled = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c059f78..0023ac4 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -44,7 +44,8 @@ static void ata_acpi_associate_sata_port(struct ata_port *ap)
 {
 	acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
 
-	ap->device->acpi_handle = acpi_get_child(ap->host->acpi_handle, adr);
+	ap->link.device->acpi_handle =
+		acpi_get_child(ap->host->acpi_handle, adr);
 }
 
 static void ata_acpi_associate_ide_port(struct ata_port *ap)
@@ -60,7 +61,7 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 		max_devices++;
 
 	for (i = 0; i < max_devices; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		dev->acpi_handle = acpi_get_child(ap->acpi_handle, i);
 	}
@@ -182,10 +183,10 @@ static int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
 	/* Buffers for id may need byteswapping ? */
 	in_params[1].type = ACPI_TYPE_BUFFER;
 	in_params[1].buffer.length = 512;
-	in_params[1].buffer.pointer = (u8 *)ap->device[0].id;
+	in_params[1].buffer.pointer = (u8 *)ap->link.device[0].id;
 	in_params[2].type = ACPI_TYPE_BUFFER;
 	in_params[2].buffer.length = 512;
-	in_params[2].buffer.pointer = (u8 *)ap->device[1].id;
+	in_params[2].buffer.pointer = (u8 *)ap->link.device[1].id;
 
 	input.count = 3;
 	input.pointer = in_params;
@@ -226,7 +227,7 @@ static int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
 static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 			   void **ptr_to_free)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	acpi_status status;
 	struct acpi_buffer output;
 	union acpi_object *out_obj;
@@ -320,7 +321,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 static int taskfile_load_raw(struct ata_device *dev,
 			      const struct ata_acpi_gtf *gtf)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf, rtf;
 	unsigned int err_mask;
 
@@ -424,7 +425,7 @@ static int ata_acpi_exec_tfs(struct ata_device *dev)
  */
 static int ata_acpi_push_id(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	int err;
 	acpi_status status;
 	struct acpi_object_list input;
@@ -519,7 +520,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
 
 	/* schedule _GTF */
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].flags |= ATA_DFLAG_ACPI_PENDING;
+		ap->link.device[i].flags |= ATA_DFLAG_ACPI_PENDING;
 }
 
 /**
@@ -538,8 +539,8 @@ void ata_acpi_on_resume(struct ata_port *ap)
  */
 int ata_acpi_on_devcfg(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_port *ap = dev->link->ap;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	int acpi_sata = ap->flags & ATA_FLAG_ACPI_SATA;
 	int rc;
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49c9ea5..ccd0570 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -232,7 +232,7 @@ static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device *dev)
 	if (dev->flags & ATA_DFLAG_PIO) {
 		tf->protocol = ATA_PROT_PIO;
 		index = dev->multi_count ? 0 : 8;
-	} else if (lba48 && (dev->ap->flags & ATA_FLAG_PIO_LBA48)) {
+	} else if (lba48 && (dev->link->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
 		index = dev->multi_count ? 0 : 8;
@@ -601,7 +601,7 @@ static const char *sata_spd_string(unsigned int spd)
 void ata_dev_disable(struct ata_device *dev)
 {
 	if (ata_dev_enabled(dev)) {
-		if (ata_msg_drv(dev->ap))
+		if (ata_msg_drv(dev->link->ap))
 			ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
 					     ATA_DNXFER_QUIET);
@@ -732,7 +732,7 @@ ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 	/* see if device passed diags: if master then continue and warn later */
 	if (err == 0 && device == 0)
 		/* diagnostic fail : do nothing _YET_ */
-		ap->device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
+		ap->link.device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
 	else if (err == 1)
 		/* do nothing */ ;
 	else if ((device == 0) && (err == 0x81))
@@ -1147,7 +1147,7 @@ void ata_dev_select(struct ata_port *ap, unsigned int device,
 	ap->ops->dev_select(ap, device);
 
 	if (wait) {
-		if (can_sleep && ap->device[device].class == ATA_DEV_ATAPI)
+		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
 			msleep(150);
 		ata_wait_idle(ap);
 	}
@@ -1373,7 +1373,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 			      int dma_dir, struct scatterlist *sg,
 			      unsigned int n_elem)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
@@ -1413,11 +1414,11 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
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
@@ -1494,8 +1495,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	ap->active_tag = preempted_tag;
-	ap->sactive = preempted_sactive;
+	link->active_tag = preempted_tag;
+	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
@@ -1593,7 +1594,7 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 {
 	/* Controller doesn't support  IORDY. Probably a pointless check
 	   as the caller should know this */
-	if (adev->ap->flags & ATA_FLAG_NO_IORDY)
+	if (adev->link->ap->flags & ATA_FLAG_NO_IORDY)
 		return 0;
 	/* PIO3 and higher it is mandatory */
 	if (adev->pio_mode > XFER_PIO_2)
@@ -1649,7 +1650,7 @@ static u32 ata_pio_mask_no_iordy(const struct ata_device *adev)
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		    unsigned int flags, u16 *id)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
@@ -1801,13 +1802,14 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 
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
@@ -1844,8 +1846,8 @@ static void ata_dev_config_ncq(struct ata_device *dev,
  */
 int ata_dev_configure(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_port *ap = dev->link->ap;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
@@ -2139,7 +2141,7 @@ int ata_bus_probe(struct ata_port *ap)
 	ap->ops->phy_reset(ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
@@ -2156,14 +2158,14 @@ int ata_bus_probe(struct ata_port *ap)
 	   state is undefined. Record the mode */
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].pio_mode = XFER_PIO_0;
+		ap->link.device[i].pio_mode = XFER_PIO_0;
 
 	/* read IDENTIFY page and configure devices. We have to do the identify
 	   specific sequence bass-ackwards so that PDIAG- is released by
 	   the slave device */
 
 	for (i = ATA_MAX_DEVICES - 1; i >=  0; i--) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (tries[i])
 			dev->class = classes[i];
@@ -2185,13 +2187,13 @@ int ata_bus_probe(struct ata_port *ap)
 	   this in the normal order so that the user doesn't get confused */
 
 	for(i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		ap->eh_context.i.flags |= ATA_EHI_PRINTINFO;
+		ap->link.eh_context.i.flags |= ATA_EHI_PRINTINFO;
 		rc = ata_dev_configure(dev);
-		ap->eh_context.i.flags &= ~ATA_EHI_PRINTINFO;
+		ap->link.eh_context.i.flags &= ~ATA_EHI_PRINTINFO;
 		if (rc)
 			goto fail;
 	}
@@ -2202,7 +2204,7 @@ int ata_bus_probe(struct ata_port *ap)
 		goto fail;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			return 0;
 
 	/* no device present, disable port */
@@ -2367,8 +2369,8 @@ void sata_phy_reset(struct ata_port *ap)
 
 struct ata_device *ata_dev_pair(struct ata_device *adev)
 {
-	struct ata_port *ap = adev->ap;
-	struct ata_device *pair = &ap->device[1 - adev->devno];
+	struct ata_link *link = adev->link;
+	struct ata_device *pair = &link->device[1 - adev->devno];
 	if (!ata_dev_enabled(pair))
 		return NULL;
 	return pair;
@@ -2389,8 +2391,8 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 
 void ata_port_disable(struct ata_port *ap)
 {
-	ap->device[0].class = ATA_DEV_NONE;
-	ap->device[1].class = ATA_DEV_NONE;
+	ap->link.device[0].class = ATA_DEV_NONE;
+	ap->link.device[1].class = ATA_DEV_NONE;
 	ap->flags |= ATA_FLAG_DISABLED;
 }
 
@@ -2423,9 +2425,9 @@ int sata_down_spd_limit(struct ata_port *ap)
 	if (rc == 0)
 		spd = (sstatus >> 4) & 0xf;
 	else
-		spd = ap->sata_spd;
+		spd = ap->link.sata_spd;
 
-	mask = ap->sata_spd_limit;
+	mask = ap->link.sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
 
@@ -2445,7 +2447,7 @@ int sata_down_spd_limit(struct ata_port *ap)
 	if (!mask)
 		return -EINVAL;
 
-	ap->sata_spd_limit = mask;
+	ap->link.sata_spd_limit = mask;
 
 	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
@@ -2457,10 +2459,10 @@ static int __sata_set_spd_needed(struct ata_port *ap, u32 *scontrol)
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
@@ -2473,7 +2475,7 @@ static int __sata_set_spd_needed(struct ata_port *ap, u32 *scontrol)
  *	@ap: Port in question
  *
  *	Test whether the spd limit in SControl matches
- *	@ap->sata_spd_limit.  This function is used to determine
+ *	@ap->link.sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
  *
@@ -2772,7 +2774,7 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 
 static int ata_dev_set_mode(struct ata_device *dev)
 {
-	struct ata_eh_context *ehc = &dev->ap->eh_context;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 	unsigned int err_mask;
 	int rc;
 
@@ -2832,7 +2834,7 @@ int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -2853,7 +2855,7 @@ int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 
 	/* step 2: always set host PIO timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2871,7 +2873,7 @@ int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 
 	/* step 3: set host DMA timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
@@ -2884,7 +2886,7 @@ int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 
 	/* step 4: update devices' xfer mode */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		/* don't update suspended devices' xfer mode */
 		if (!ata_dev_enabled(dev))
@@ -3165,6 +3167,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 
 void ata_bus_reset(struct ata_port *ap)
 {
+	struct ata_device *device = ap->link.device;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
@@ -3200,22 +3203,22 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	ap->device[0].class = ata_dev_try_classify(ap, 0, &err);
+	device[0].class = ata_dev_try_classify(ap, 0, &err);
 	if ((slave_possible) && (err != 0x81))
-		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
+		device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
 	ap->ops->irq_on(ap);
 
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
@@ -3357,7 +3360,7 @@ int sata_phy_resume(struct ata_port *ap, const unsigned long *params,
  */
 int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
@@ -3529,7 +3532,7 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
 		       unsigned long deadline)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&ap->eh_context);
+	const unsigned long *timing = sata_ehc_deb_timing(&ap->link.eh_context);
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -3682,7 +3685,7 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
-	u16 *id = (void *)dev->ap->sector_buf;
+	u16 *id = (void *)dev->link->ap->sector_buf;
 	int rc;
 
 	/* read ID data */
@@ -3845,7 +3848,7 @@ static int ata_dma_blacklisted(const struct ata_device *dev)
 	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
 	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
 	 */
-	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
+	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
 	    (dev->flags & ATA_DFLAG_CDB_INTR))
 		return 1;
 	return (ata_device_blacklisted(dev) & ATA_HORKAGE_NODMA) ? 1 : 0;
@@ -3865,7 +3868,8 @@ static int ata_dma_blacklisted(const struct ata_device *dev)
  */
 static void ata_dev_xfermask(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
 
@@ -4406,7 +4410,7 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
 		   unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	unsigned int words = buflen >> 1;
 
 	/* Transfer multiple of 2 bytes */
@@ -5114,7 +5118,7 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 
 struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
 	qc = ata_qc_new(ap);
@@ -5157,6 +5161,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
@@ -5166,9 +5171,9 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
 
 	/* command should be marked inactive atomically with qc completion */
 	if (qc->tf.protocol == ATA_PROT_NCQ)
-		ap->sactive &= ~(1 << qc->tag);
+		link->sactive &= ~(1 << qc->tag);
 	else
-		ap->active_tag = ATA_TAG_POISON;
+		link->active_tag = ATA_TAG_POISON;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
@@ -5337,19 +5342,20 @@ static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
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
@@ -5532,7 +5538,7 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 inline unsigned int ata_host_intr (struct ata_port *ap,
 				   struct ata_queued_cmd *qc)
 {
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 status, host_stat = 0;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
@@ -5647,7 +5653,7 @@ irqreturn_t ata_interrupt (int irq, void *dev_instance)
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
@@ -5847,8 +5853,8 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		ap->eh_info.action |= action;
-		ap->eh_info.flags |= ehi_flags;
+		ap->link.eh_info.action |= action;
+		ap->link.eh_info.flags |= ehi_flags;
 
 		ata_port_schedule_eh(ap);
 
@@ -5952,12 +5958,13 @@ int ata_port_start(struct ata_port *ap)
  */
 void ata_dev_init(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
 	/* SATA spd limit is bound to the first device */
-	ap->sata_spd_limit = ap->hw_sata_spd_limit;
-	ap->sata_spd = 0;
+	link->sata_spd_limit = link->hw_sata_spd_limit;
+	link->sata_spd = 0;
 
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
@@ -6005,8 +6012,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->host = host;
 	ap->dev = host->dev;
 
-	ap->hw_sata_spd_limit = UINT_MAX;
-	ap->active_tag = ATA_TAG_POISON;
+	ap->link.hw_sata_spd_limit = UINT_MAX;
+	ap->link.active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
@@ -6029,9 +6036,11 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 	ap->cbl = ATA_CBL_NONE;
 
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
@@ -6327,9 +6336,9 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
 			if (spd)
-				ap->hw_sata_spd_limit &= (1 << spd) - 1;
+				ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
 		}
-		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+		ap->link.sata_spd_limit = ap->link.hw_sata_spd_limit;
 
 		/* report the secondary IRQ for second channel legacy */
 		irq_line = host->irq;
@@ -6361,7 +6370,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 		/* probe */
 		if (ap->ops->error_handler) {
-			struct ata_eh_info *ehi = &ap->eh_info;
+			struct ata_eh_info *ehi = &ap->link.eh_info;
 			unsigned long flags;
 
 			ata_port_probe(ap);
@@ -6485,7 +6494,7 @@ void ata_port_detach(struct ata_port *ap)
 	spin_lock_irqsave(ap->lock, flags);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_disable(&ap->device[i]);
+		ata_dev_disable(&ap->link.device[i]);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5e82231..1562bde 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -130,7 +130,7 @@ static int ata_ering_map(struct ata_ering *ering,
 
 static unsigned int ata_eh_dev_action(struct ata_device *dev)
 {
-	struct ata_eh_context *ehc = &dev->ap->eh_context;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 
 	return ehc->i.action | ehc->i.dev_action[dev->devno];
 }
@@ -196,7 +196,7 @@ enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
 
 	ret = EH_HANDLED;
 	spin_lock_irqsave(ap->lock, flags);
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc) {
 		WARN_ON(qc->scsicmd != cmd);
 		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
@@ -306,9 +306,9 @@ void ata_scsi_error(struct Scsi_Host *host)
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
@@ -344,7 +344,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
@@ -355,7 +355,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 
 		spin_unlock_irqrestore(ap->lock, flags);
 	} else {
-		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
 	}
 
@@ -510,7 +510,7 @@ void ata_eng_timeout(struct ata_port *ap)
 {
 	DPRINTK("ENTER\n");
 
-	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
+	ata_qc_timeout(ata_qc_from_tag(ap, ap->link.active_tag));
 
 	DPRINTK("EXIT\n");
 }
@@ -857,7 +857,7 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
  */
 static void ata_eh_detach_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -872,8 +872,8 @@ static void ata_eh_detach_dev(struct ata_device *dev)
 	}
 
 	/* clear per-dev EH actions */
-	ata_eh_clear_action(dev, &ap->eh_info, ATA_EH_PERDEV_MASK);
-	ata_eh_clear_action(dev, &ap->eh_context.i, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &dev->link->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &dev->link->eh_context.i, ATA_EH_PERDEV_MASK);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
@@ -885,8 +885,8 @@ static void ata_eh_detach_dev(struct ata_device *dev)
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
@@ -895,8 +895,8 @@ static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
 			       unsigned int action)
 {
 	unsigned long flags;
-	struct ata_eh_info *ehi = &ap->eh_info;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -928,7 +928,7 @@ static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
  *	@action: action just completed
  *
  *	Called right after performing EH actions to clear related bits
- *	in @ap->eh_context.
+ *	in @ap->link.eh_context.
  *
  *	LOCKING:
  *	None.
@@ -936,13 +936,15 @@ static void ata_eh_about_to_do(struct ata_port *ap, struct ata_device *dev,
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
@@ -1036,7 +1038,7 @@ static unsigned int ata_read_log_page(struct ata_device *dev,
 static int ata_eh_read_log_10h(struct ata_device *dev,
 			       int *tag, struct ata_taskfile *tf)
 {
-	u8 *buf = dev->ap->sector_buf;
+	u8 *buf = dev->link->ap->sector_buf;
 	unsigned int err_mask;
 	u8 csum;
 	int i;
@@ -1090,7 +1092,7 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 {
 	struct ata_device *dev = qc->dev;
 	unsigned char *sense_buf = qc->scsicmd->sense_buffer;
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
@@ -1141,7 +1143,7 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
  */
 static void ata_eh_analyze_serror(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
 
@@ -1183,8 +1185,8 @@ static void ata_eh_analyze_serror(struct ata_port *ap)
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
@@ -1194,7 +1196,7 @@ static void ata_eh_analyze_ncq_error(struct ata_port *ap)
 		return;
 
 	/* is it NCQ device error? */
-	if (!ap->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+	if (!ap->link.sactive || !(ehc->i.err_mask & AC_ERR_DEV))
 		return;
 
 	/* has LLDD analyzed already? */
@@ -1216,7 +1218,7 @@ static void ata_eh_analyze_ncq_error(struct ata_port *ap)
 		return;
 	}
 
-	if (!(ap->sactive & (1 << tag))) {
+	if (!(ap->link.sactive & (1 << tag))) {
 		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
 				"inactive tag %d\n", tag);
 		return;
@@ -1432,7 +1434,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	/* speed down? */
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
-		if (sata_down_spd_limit(dev->ap) == 0) {
+		if (sata_down_spd_limit(dev->link->ap) == 0) {
 			action |= ATA_EH_HARDRESET;
 			goto done;
 		}
@@ -1463,7 +1465,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	 * SATA.  Consider it only for PATA.
 	 */
 	if ((verdict & ATA_EH_SPDN_FALLBACK_TO_PIO) && (dev->spdn_cnt >= 2) &&
-	    (dev->ap->cbl != ATA_CBL_SATA) &&
+	    (dev->link->ap->cbl != ATA_CBL_SATA) &&
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
@@ -1492,7 +1494,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
  */
 static void ata_eh_autopsy(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1591,7 +1593,7 @@ static void ata_eh_autopsy(struct ata_port *ap)
  */
 static void ata_eh_report(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	const char *frozen, *desc;
 	int tag, nr_failed = 0;
 
@@ -1620,15 +1622,15 @@ static void ata_eh_report(struct ata_port *ap)
 	if (ehc->i.dev) {
 		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
 			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
-			       ehc->i.err_mask, ap->sactive, ehc->i.serror,
-			       ehc->i.action, frozen);
+			       ehc->i.err_mask, ap->link.sactive,
+			       ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
 			ata_dev_printk(ehc->i.dev, KERN_ERR, "%s\n", desc);
 	} else {
 		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
 				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
-				ehc->i.err_mask, ap->sactive, ehc->i.serror,
-				ehc->i.action, frozen);
+				ehc->i.err_mask, ap->link.sactive,
+				ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
 			ata_port_printk(ap, KERN_ERR, "%s\n", desc);
 	}
@@ -1710,7 +1712,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned int *classes = ehc->classes;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	int try = 0;
@@ -1739,7 +1741,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			if (rc == -ENOENT) {
 				ata_port_printk(ap, KERN_DEBUG,
 						"port disabled. ignoring.\n");
-				ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
+				ehc->i.action &= ~ATA_EH_RESET_MASK;
 
 				for (i = 0; i < ATA_MAX_DEVICES; i++)
 					classes[i] = ATA_DEV_NONE;
@@ -1842,11 +1844,11 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		 * controller state is undefined.  Record the mode.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ap->device[i].pio_mode = XFER_PIO_0;
+			ap->link.device[i].pio_mode = XFER_PIO_0;
 
 		/* record current link speed */
 		if (sata_scr_read(ap, SCR_STATUS, &sstatus) == 0)
-			ap->sata_spd = (sstatus >> 4) & 0xf;
+			ap->link.sata_spd = (sstatus >> 4) & 0xf;
 
 		if (postreset)
 			postreset(ap, classes);
@@ -1864,7 +1866,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 					struct ata_device **r_failed_dev)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	unsigned int new_mask = 0;
 	unsigned long flags;
@@ -1879,7 +1881,7 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 	for (i = ATA_MAX_DEVICES - 1; i >= 0; i--) {
 		unsigned int action, readid_flags = 0;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		action = ata_eh_dev_action(dev);
 
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
@@ -1939,7 +1941,7 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 	 * device detection messages backwards.
 	 */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!(new_mask & (1 << i)))
 			continue;
@@ -1971,7 +1973,7 @@ static int ata_port_nr_enabled(struct ata_port *ap)
 	int i, cnt = 0;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
+		if (ata_dev_enabled(&ap->link.device[i]))
 			cnt++;
 	return cnt;
 }
@@ -1981,14 +1983,14 @@ static int ata_port_nr_vacant(struct ata_port *ap)
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
 
 	/* thaw frozen port, resume link and recover failed devices */
@@ -1998,7 +2000,7 @@ static int ata_eh_skip_recovery(struct ata_port *ap)
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
@@ -2010,8 +2012,8 @@ static int ata_eh_skip_recovery(struct ata_port *ap)
 
 static void ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 {
-	struct ata_port *ap = dev->ap;
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_port *ap = dev->link->ap;
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 
 	ehc->tries[dev->devno]--;
 
@@ -2084,7 +2086,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	int i, rc;
 
@@ -2092,7 +2094,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	/* prep for recovery */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
@@ -2175,7 +2177,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
  out:
 	if (rc) {
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->device[i]);
+			ata_dev_disable(&ap->link.device[i]);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9bf0292..43757b4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1368,14 +1368,14 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		case ATA_CMD_SET_FEATURES:
 			if ((qc->tf.feature == SETFEATURES_WC_ON) ||
 			    (qc->tf.feature == SETFEATURES_WC_OFF)) {
-				ap->eh_info.action |= ATA_EH_REVALIDATE;
+				ap->link.eh_info.action |= ATA_EH_REVALIDATE;
 				ata_port_schedule_eh(ap);
 			}
 			break;
 
 		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
 		case ATA_CMD_SET_MULTI: /* multi_count changed */
-			ap->eh_info.action |= ATA_EH_REVALIDATE;
+			ap->link.eh_info.action |= ATA_EH_REVALIDATE;
 			ata_port_schedule_eh(ap);
 			break;
 		}
@@ -1439,14 +1439,14 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
  */
 static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_link *link = dev->link;
 	int is_ncq = is_io && ata_ncq_enabled(dev);
 
 	if (is_ncq) {
-		if (!ata_tag_valid(ap->active_tag))
+		if (!ata_tag_valid(link->active_tag))
 			return 0;
 	} else {
-		if (!ata_tag_valid(ap->active_tag) && !ap->sactive)
+		if (!ata_tag_valid(link->active_tag) && !link->sactive)
 			return 0;
 	}
 	return 1;
@@ -2426,7 +2426,7 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
 	if (likely(id < ATA_MAX_DEVICES))
-		return &ap->device[id];
+		return &ap->link.device[id];
 	return NULL;
 }
 
@@ -2458,7 +2458,7 @@ static int ata_scsi_dev_enabled(struct ata_device *dev)
 	if (unlikely(!ata_dev_enabled(dev)))
 		return 0;
 
-	if (!atapi_enabled || (dev->ap->flags & ATA_FLAG_NO_ATAPI)) {
+	if (!atapi_enabled || (dev->link->ap->flags & ATA_FLAG_NO_ATAPI)) {
 		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
 			ata_dev_printk(dev, KERN_WARNING,
 				       "WARNING: ATAPI is %s, device ignored.\n",
@@ -2961,7 +2961,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct scsi_device *sdev;
 
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
 			continue;
@@ -2978,7 +2978,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 	 * whether all devices are attached.
 	 */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev) && !dev->sdev)
 			break;
 	}
@@ -3049,7 +3049,7 @@ int ata_scsi_offline_dev(struct ata_device *dev)
  */
 static void ata_scsi_remove_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
+	struct ata_port *ap = dev->link->ap;
 	struct scsi_device *sdev;
 	unsigned long flags;
 
@@ -3123,7 +3123,7 @@ void ata_scsi_hotplug(struct work_struct *work)
 
 	/* unplug detached devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
@@ -3162,6 +3162,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, unsigned int lun)
 {
 	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags;
 	int rc = 0;
 
@@ -3175,15 +3176,15 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
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
@@ -3220,7 +3221,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	spin_lock_irqsave(ap->lock, flags);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		struct scsi_device *sdev = dev->sdev;
 
 		if (!ata_dev_enabled(dev) || !sdev)
@@ -3359,7 +3360,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
 int ata_sas_slave_configure(struct scsi_device *sdev, struct ata_port *ap)
 {
 	ata_scsi_sdev_config(sdev);
-	ata_scsi_dev_config(sdev, ap->device);
+	ata_scsi_dev_config(sdev, ap->link.device);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_slave_configure);
@@ -3382,8 +3383,8 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
 
 	ata_scsi_dump_cdb(ap, cmd);
 
-	if (likely(ata_scsi_dev_enabled(ap->device)))
-		rc = __ata_scsi_queuecmd(cmd, done, ap->device);
+	if (likely(ata_scsi_dev_enabled(ap->link.device)))
+		rc = __ata_scsi_queuecmd(cmd, done, ap->link.device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ce84805..04c7644 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -440,7 +440,7 @@ void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 	unsigned long flags;
 	int thaw = 0;
 
-	qc = __ata_qc_from_tag(ap, ap->active_tag);
+	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
 		qc = NULL;
 
@@ -1123,7 +1123,7 @@ unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer
 	/* Filter out DMA modes if the device has been configured by
 	   the BIOS as PIO only */
 
-	if (adev->ap->ioaddr.bmdma_addr == 0)
+	if (adev->link->ap->ioaddr.bmdma_addr == 0)
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	return xfer_mask;
 }
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 4f26ef1..74aef88 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -391,7 +391,7 @@ static void it821x_passthru_dev_select(struct ata_port *ap,
 {
 	struct it821x_dev *itdev = ap->private_data;
 	if (itdev && device != itdev->last_device) {
-		struct ata_device *adev = &ap->device[device];
+		struct ata_device *adev = &ap->link.device[device];
 		it821x_program(ap, adev, itdev->pio[adev->devno]);
 		itdev->last_device = device;
 	}
@@ -464,7 +464,7 @@ static int it821x_smart_set_mode(struct ata_port *ap, struct ata_device **unused
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 4ca7fd6..7ccdd7f 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -31,7 +31,7 @@ static int ixp4xx_set_mode(struct ata_port *ap, struct ata_device **error)
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			ata_dev_printk(dev, KERN_INFO, "configured for PIO0\n");
 			dev->pio_mode = XFER_PIO_0;
@@ -49,7 +49,7 @@ static void ixp4xx_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
 	struct ixp4xx_pata_data *data = ap->host->dev->platform_data;
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index edffc25..4bcc0ae 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -112,7 +112,7 @@ static int legacy_set_mode(struct ata_port *ap, struct ata_device **unused)
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 			dev->pio_mode = XFER_PIO_0;
@@ -256,7 +256,7 @@ static void pdc20230_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 static void pdc_data_xfer_vlb(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 	unsigned long flags;
 
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f89bdfd..f8234d7 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -340,8 +340,8 @@ static int optidma_set_mode(struct ata_port *ap, struct ata_device **r_failed)
 		pci_read_config_byte(pdev, 0x43, &r);
 
 		r &= (0x0F << nybble);
-		r |= (optidma_make_bits43(&ap->device[0]) +
-		     (optidma_make_bits43(&ap->device[0]) << 2)) << nybble;
+		r |= (optidma_make_bits43(&ap->link.device[0]) +
+		     (optidma_make_bits43(&ap->link.device[0]) << 2)) << nybble;
 		pci_write_config_byte(pdev, 0x43, r);
 	}
 	return rc;
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 4d44c75..fab30ab 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -67,8 +67,8 @@ struct ata_pcmcia_info {
 
 static int pcmcia_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
-	struct ata_device *master = &ap->device[0];
-	struct ata_device *slave = &ap->device[1];
+	struct ata_device *master = &ap->link.device[0];
+	struct ata_device *slave = &ap->link.device[1];
 
 	if (!ata_dev_enabled(master) || !ata_dev_enabled(slave))
 		return ata_do_set_mode(ap, r_failed_dev);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 0d2cc49..db95323 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -486,7 +486,7 @@ static int pdc2027x_set_mode(struct ata_port *ap, struct ata_device **r_failed)
 		return i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (ata_dev_enabled(dev)) {
 
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index cbb7866..e0adc3f 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -35,7 +35,7 @@ static int pata_platform_set_mode(struct ata_port *ap, struct ata_device **unuse
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 1998c19..ec2206e 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -126,7 +126,7 @@ static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
 
 static void qdi_data_xfer(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 
 	if (ata_id_has_dword_io(adev->id)) {
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 7632fcb..57363c0 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -39,7 +39,7 @@ static int rz1000_set_mode(struct ata_port *ap, struct ata_device **unused)
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		struct ata_device *dev = &ap->link.device[i];
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 61502bc..8811e71 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -758,7 +758,7 @@ static u8 scc_bmdma_status (struct ata_port *ap)
 static void scc_data_xfer (struct ata_device *adev, unsigned char *buf,
 			   unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	unsigned int words = buflen >> 1;
 	unsigned int i;
 	u16 *buf16 = (u16 *) buf;
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 3286378..956c6cc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -82,7 +82,7 @@ static int sis_short_ata40(struct pci_dev *dev)
 
 static int sis_old_port_base(struct ata_device *adev)
 {
-	return  0x40 + (4 * adev->ap->port_no) +  (2 * adev->devno);
+	return  0x40 + (4 * adev->link->ap->port_no) +  (2 * adev->devno);
 }
 
 /**
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 83abfec..c375703 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -94,7 +94,7 @@ static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 static void winbond_data_xfer(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
 {
-	struct ata_port *ap = adev->ap;
+	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 
 	if (ata_id_has_dword_io(adev->id)) {
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 74c50c9..97ecfd5 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -464,7 +464,7 @@ static inline unsigned int adma_intr_pkt(struct ata_host *host)
 		pp = ap->private_data;
 		if (!pp || pp->state != adma_state_pkt)
 			continue;
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 			if ((status & (aPERR | aPSD | aUIRQ)))
 				qc->err_mask |= AC_ERR_OTHER;
@@ -489,7 +489,7 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
 			struct adma_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != adma_state_mmio)
 				continue;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 2ad5690..dcaf8e4 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -285,7 +285,7 @@ static void inic_irq_clear(struct ata_port *ap)
 static void inic_host_intr(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 irq_stat;
 
 	/* fetch and clear irq */
@@ -293,7 +293,8 @@ static void inic_host_intr(struct ata_port *ap)
 	writeb(irq_stat, port_base + PORT_IRQ_STAT);
 
 	if (likely(!(irq_stat & PIRQ_ERR))) {
-		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+		struct ata_queued_cmd *qc =
+			ata_qc_from_tag(ap, ap->link.active_tag);
 
 		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 			ata_chk_status(ap);	/* clear ATA interrupt */
@@ -421,7 +422,7 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class,
 {
 	void __iomem *port_base = inic_port_base(ap);
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
-	const unsigned long *timing = sata_ehc_deb_timing(&ap->eh_context);
+	const unsigned long *timing = sata_ehc_deb_timing(&ap->link.eh_context);
 	u16 val;
 	int rc;
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 0ced447..cdd5ad7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1443,7 +1443,7 @@ static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned int hc)
 		}
 
 		if (handled) {
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
@@ -1969,7 +1969,7 @@ static void __mv_phy_reset(struct ata_port *ap, int can_sleep)
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct ata_taskfile tf;
-	struct ata_device *dev = &ap->device[0];
+	struct ata_device *dev = &ap->link.device[0];
 	unsigned long timeout;
 	int retry = 5;
 	u32 sstatus;
@@ -2091,7 +2091,7 @@ static void mv_eng_timeout(struct ata_port *ap)
 	DPRINTK("All regs @ start of eng_timeout\n");
 	mv_dump_all_regs(mmio, ap->port_no, to_pci_dev(ap->host->dev));
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
         printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
 	       mmio, ap, qc, qc->scsicmd, &qc->scsicmd->cmnd);
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 9790f3c..3108720 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -593,7 +593,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 		/* Not a proper libata device, ignore */
 		return rc;
 
-	if (ap->device[sdev->id].class == ATA_DEV_ATAPI) {
+	if (ap->link.device[sdev->id].class == ATA_DEV_ATAPI) {
 		/*
 		 * NVIDIA reports that ADMA mode does not support ATAPI commands.
 		 * Therefore ATAPI commands are sent through the legacy interface.
@@ -710,7 +710,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 		     flags & (NV_CPB_RESP_ATA_ERR |
 			      NV_CPB_RESP_CMD_ERR |
 			      NV_CPB_RESP_CPB_ERR)))) {
-		struct ata_eh_info *ehi = &ap->eh_info;
+		struct ata_eh_info *ehi = &ap->link.eh_info;
 		int freeze = 0;
 
 		ata_ehi_clear_desc(ehi);
@@ -746,7 +746,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 			DPRINTK("Completing qc from tag %d\n",cpb_num);
 			ata_qc_complete(qc);
 		} else {
-			struct ata_eh_info *ehi = &ap->eh_info;
+			struct ata_eh_info *ehi = &ap->link.eh_info;
 			/* Notifier bits set without a command may indicate the drive
 			   is misbehaving. Raise host state machine violation on this
 			   condition. */
@@ -763,7 +763,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 
 static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	/* freeze if hotplugged */
 	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
@@ -816,7 +816,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 			if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
 				u8 irq_stat = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
 					>> (NV_INT_PORT_SHIFT * i);
-				if(ata_tag_valid(ap->active_tag))
+				if(ata_tag_valid(ap->link.active_tag))
 					/** NV_INT_DEV indication seems unreliable at times
 					    at least in ADMA mode. Force it on always when a
 					    command is active, to prevent losing interrupts. */
@@ -851,7 +851,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 					       NV_ADMA_STAT_HOTUNPLUG |
 					       NV_ADMA_STAT_TIMEOUT |
 					       NV_ADMA_STAT_SERROR))) {
-				struct ata_eh_info *ehi = &ap->eh_info;
+				struct ata_eh_info *ehi = &ap->link.eh_info;
 
 				ata_ehi_clear_desc(ehi);
 				ata_ehi_push_desc(ehi, "<ADMA status 0x%08x", status );
@@ -877,10 +877,10 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 				u32 check_commands;
 				int pos, error = 0;
 
-				if(ata_tag_valid(ap->active_tag))
-					check_commands = 1 << ap->active_tag;
+				if(ata_tag_valid(ap->link.active_tag))
+					check_commands = 1 << ap->link.active_tag;
 				else
-					check_commands = ap->sactive;
+					check_commands = ap->link.sactive;
 
 				/** Check CPBs for completed commands */
 				while ((pos = ffs(check_commands)) && !error) {
@@ -1331,7 +1331,7 @@ static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance)
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += ata_host_intr(ap, qc);
 			else
@@ -1483,7 +1483,7 @@ static void nv_adma_error_handler(struct ata_port *ap)
 		int i;
 		u16 tmp;
 
-		if(ata_tag_valid(ap->active_tag) || ap->sactive) {
+		if(ata_tag_valid(ap->link.active_tag) || ap->link.sactive) {
 			u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 			u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
 			u32 gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
@@ -1499,8 +1499,8 @@ static void nv_adma_error_handler(struct ata_port *ap)
 
 			for( i=0;i<NV_ADMA_MAX_CPBS;i++) {
 				struct nv_adma_cpb *cpb = &pp->cpb[i];
-				if( (ata_tag_valid(ap->active_tag) && i == ap->active_tag) ||
-				    ap->sactive & (1 << i) )
+				if( (ata_tag_valid(ap->link.active_tag) && i == ap->link.active_tag) ||
+				    ap->link.sactive & (1 << i) )
 					ata_port_printk(ap, KERN_ERR,
 						"CPB %d: ctl_flags 0x%x, resp_flags 0x%x\n",
 						i, cpb->ctl_flags, cpb->resp_flags);
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c710059..bf63539 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -631,7 +631,7 @@ static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
 static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc,
 			   u32 port_status, u32 err_mask)
 {
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned int ac_err_mask = 0;
 
 	ata_ehi_clear_desc(ehi);
@@ -750,7 +750,7 @@ static irqreturn_t pdc_interrupt (int irq, void *dev_instance)
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc_host_intr(ap, qc);
 		}
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 13348a6..dbef6f3 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -404,7 +404,7 @@ static inline unsigned int qs_intr_pkt(struct ata_host *host)
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
 					continue;
-				qc = ata_qc_from_tag(ap, ap->active_tag);
+				qc = ata_qc_from_tag(ap, ap->link.active_tag);
 				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 					switch (sHST) {
 					case 0: /* successful CPB */
@@ -437,7 +437,7 @@ static inline unsigned int qs_intr_mmio(struct ata_host *host)
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 94a528f..b14468c 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -312,7 +312,7 @@ static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed)
 		return rc;
 
 	for (i = 0; i < 2; i++) {
-		dev = &ap->device[i];
+		dev = &ap->link.device[i];
 		if (!ata_dev_enabled(dev))
 			dev_mode[i] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
@@ -374,8 +374,8 @@ static int sil_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
-	struct ata_eh_info *ehi = &ap->eh_info;
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
@@ -394,8 +394,8 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		 * repeat probing needlessly.
 		 */
 		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-			ata_ehi_hotplugged(&ap->eh_info);
-			ap->eh_info.serror |= serror;
+			ata_ehi_hotplugged(&ap->link.eh_info);
+			ap->link.eh_info.serror |= serror;
 		}
 
 		goto freeze;
@@ -562,8 +562,8 @@ static void sil_thaw(struct ata_port *ap)
  */
 static void sil_dev_config(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
-	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
+	struct ata_port *ap = dev->link->ap;
+	int print_info = ap->link.eh_context.i.flags & ATA_EHI_PRINTINFO;
 	unsigned int n, quirks = 0;
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 07489a0..7587d68 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -456,7 +456,7 @@ static int sil24_tag(int tag)
 
 static void sil24_dev_config(struct ata_device *dev)
 {
-	void __iomem *port = dev->ap->ioaddr.cmd_addr;
+	void __iomem *port = dev->link->ap->ioaddr.cmd_addr;
 
 	if (dev->cdb_len == 16)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
@@ -759,7 +759,7 @@ static void sil24_thaw(struct ata_port *ap)
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
 	u32 irq_stat;
 
@@ -811,7 +811,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_update_tf(ap);
 			qc->err_mask |= err_mask;
@@ -855,7 +855,7 @@ static inline void sil24_host_intr(struct ata_port *ap)
 	if (rc > 0)
 		return;
 	if (rc < 0) {
-		struct ata_eh_info *ehi = &ap->eh_info;
+		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
 		ata_port_freeze(ap);
@@ -865,7 +865,7 @@ static inline void sil24_host_intr(struct ata_port *ap)
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
-			slot_stat, ap->active_tag, ap->sactive);
+			slot_stat, ap->link.active_tag, ap->link.sactive);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
@@ -907,7 +907,7 @@ static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
 
 static void sil24_error_handler(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 
 	if (sil24_init_port(ap)) {
 		ata_eh_freeze_port(ap);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 3d83ee2..b5a3c80 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -854,7 +854,7 @@ static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance)
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
-			qc = ata_qc_from_tag(ap, ap->active_tag);
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
@@ -881,7 +881,7 @@ static void pdc_eng_timeout(struct ata_port *ap)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index d39d68d..9f5bc49 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -296,7 +296,7 @@ static void svia_noop_freeze(struct ata_port *ap)
  */
 static int vt6420_prereset(struct ata_port *ap, unsigned long deadline)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 sstatus, scontrol;
 	int online;
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 8b7a9c6..c2104ef 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -240,7 +240,7 @@ static void vsc_port_intr(u8 port_status, struct ata_port *ap)
 		return;
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
 		handled = ata_host_intr(ap, qc);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1424e80..ff482f8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -432,7 +432,7 @@ struct ata_ering {
 };
 
 struct ata_device {
-	struct ata_port		*ap;
+	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
@@ -506,6 +506,24 @@ struct ata_acpi_gtm {
 	u32 flags;
 } __packed;
 
+struct ata_link {
+	struct ata_port		*ap;
+
+	unsigned int		active_tag;	/* active tag on this link */
+	u32			sactive;	/* active NCQ commands */
+
+	unsigned int		hw_sata_spd_limit;
+	unsigned int		sata_spd_limit;
+	unsigned int		sata_spd;	/* current SATA PHY speed */
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
@@ -529,23 +547,12 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
-	unsigned int		hw_sata_spd_limit;
-	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
-	unsigned int		sata_spd;	/* current SATA PHY speed */
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
@@ -907,8 +914,11 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 #define ata_port_printk(ap, lv, fmt, args...) \
 	printk(lv"ata%u: "fmt, (ap)->print_id , ##args)
 
+#define ata_link_printk(link, lv, fmt, args...) \
+	printk(lv"ata%u: "fmt, (link)->ap->print_id , ##args)
+
 #define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->print_id, (dev)->devno , ##args)
+	printk(lv"ata%u.%02u: "fmt, (dev)->link->ap->print_id, (dev)->devno , ##args)
 
 /*
  * ata_eh_info helpers
@@ -1151,7 +1161,7 @@ static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 {
 	memset(tf, 0, sizeof(*tf));
 
-	tf->ctl = dev->ap->ctl;
+	tf->ctl = dev->link->ap->ctl;
 	if (dev->devno == 0)
 		tf->device = ATA_DEVICE_OBS;
 	else
-- 
1.5.0.3


