From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: s/ap->id/ap->print_id/g
Date: Wed, 21 Feb 2007 01:06:51 +0900
Message-ID: <20070220160651.GS1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:18676 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965292AbXBTQHH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 11:07:07 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2057748wxd
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 08:07:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ata_port has two different id fields - id and port_no.  id is
system-wide 1-based unique id for the port while port_no is 0-based
host-wide port number.  The former is primarily used to identify the
ATA port to the user in printk messages while the latter is used in
various places in libata core and LLDs to index the port inside the
host.

The two fields feel quite similar and sometimes ap->id is used in
place of ap->port_no, which is very difficult to spot.  This patch
renames ap->id to ap->print_id to reduce the possibility of such bugs.

Some printk messages are adjusted such that id string (ata%u[.%u])
isn't printed twice and/or to use ata_*_printk() instead of hardcoded
id format.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2cf8251..e7041a8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -72,7 +72,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
-static unsigned int ata_unique_id = 1;
+static unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
 
 struct workqueue_struct *ata_aux_wq;
@@ -887,8 +887,8 @@ void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
 	if (ata_msg_probe(ap))
-		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
-				"device %u, wait %u\n", ap->id, device, wait);
+		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, "
+				"device %u, wait %u\n", device, wait);
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -1388,8 +1388,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	int rc;
 
 	if (ata_msg_ctl(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
-			       __FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
@@ -1426,7 +1425,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
 			DPRINTK("ata%u.%d: NODEV after polling detection\n",
-				ap->id, dev->devno);
+				ap->print_id, dev->devno);
 			return -ENOENT;
 		}
 
@@ -1554,15 +1553,13 @@ int ata_dev_configure(struct ata_device *dev)
 	int rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_printk(dev, KERN_INFO,
-			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			       __FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT -- nodev\n",
+			       __FUNCTION__);
 		return 0;
 	}
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
-			       __FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
@@ -1596,8 +1593,9 @@ int ata_dev_configure(struct ata_device *dev)
 	if (dev->class == ATA_DEV_ATA) {
 		if (ata_id_is_cfa(id)) {
 			if (id[162] & 1) /* CPRM may make this media unusable */
-				ata_dev_printk(dev, KERN_WARNING, "ata%u: device %u  supports DRM functions and may not be fully accessable.\n",
-					ap->id, dev->devno);
+				ata_dev_printk(dev, KERN_WARNING,
+					       "supports DRM functions and may "
+					       "not be fully accessable.\n");
 			snprintf(revbuf, 7, "CFA");
 		}
 		else
@@ -2595,7 +2593,7 @@ static unsigned int ata_bus_softreset(struct ata_port *ap,
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
 
 	/* software reset.  causes dev0 to be selected */
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
@@ -2655,7 +2653,7 @@ void ata_bus_reset(struct ata_port *ap)
 	u8 err;
 	unsigned int dev0, dev1 = 0, devmask = 0;
 
-	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
+	DPRINTK("ENTER, host %u, port %u\n", ap->print_id, ap->port_no);
 
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
@@ -3725,7 +3723,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	struct scatterlist *lsg = &sg[qc->n_elem - 1];
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
-	VPRINTK("ENTER, ata%u\n", ap->id);
+	VPRINTK("ENTER, ata%u\n", ap->print_id);
 	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
@@ -4126,7 +4124,7 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 	if (do_write != i_write)
 		goto err_out;
 
-	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
 	__atapi_pio_bytes(qc, bytes);
 
@@ -4243,7 +4241,7 @@ int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -4276,8 +4274,8 @@ fsm_start:
 		 * let the EH abort the command or reset the device.
 		 */
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
-			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
-			       ap->id, status);
+			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
+					"error, dev_stat 0x%X\n", status);
 			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
@@ -4334,8 +4332,9 @@ fsm_start:
 			 * let the EH abort the command or reset the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
-				       ap->id, status);
+				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with "
+						"device error, dev_stat 0x%X\n",
+						status);
 				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -4421,7 +4420,7 @@ fsm_start:
 
 		/* no more data to transfer */
 		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
-			ap->id, qc->dev->devno, status);
+			ap->print_id, qc->dev->devno, status);
 
 		WARN_ON(qc->err_mask);
 
@@ -4963,7 +4962,7 @@ inline unsigned int ata_host_intr (struct ata_port *ap,
 	u8 status, host_stat = 0;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
@@ -4984,7 +4983,8 @@ inline unsigned int ata_host_intr (struct ata_port *ap,
 		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
 			/* check status of DMA engine */
 			host_stat = ap->ops->bmdma_status(ap);
-			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+			VPRINTK("ata%u: host_stat 0x%X\n",
+				ap->print_id, host_stat);
 
 			/* if it's not our irq... */
 			if (!(host_stat & ATA_DMA_INTR))
@@ -5443,7 +5443,7 @@ void ata_port_init(struct ata_port *ap, struct ata_host *host,
 
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
-	ap->id = ata_unique_id++;
+	ap->print_id = ata_print_id++;
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host = host;
 	ap->dev = ent->dev;
@@ -5514,7 +5514,7 @@ static void ata_port_init_shost(struct ata_port *ap, struct Scsi_Host *shost)
 {
 	ap->scsi_host = shost;
 
-	shost->unique_id = ap->id;
+	shost->unique_id = ap->print_id;
 	shost->max_id = 16;
 	shost->max_lun = 1;
 	shost->max_channel = 1;
@@ -5778,9 +5778,9 @@ int ata_device_add(const struct ata_probe_ent *ent)
 			/* wait for EH to finish */
 			ata_port_wait_eh(ap);
 		} else {
-			DPRINTK("ata%u: bus probe begin\n", ap->id);
+			DPRINTK("ata%u: bus probe begin\n", ap->print_id);
 			rc = ata_bus_probe(ap);
-			DPRINTK("ata%u: bus probe end\n", ap->id);
+			DPRINTK("ata%u: bus probe end\n", ap->print_id);
 
 			if (rc) {
 				/* FIXME: do something useful here?
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 52c85af..54eba5e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -585,7 +585,7 @@ static void __ata_port_freeze(struct ata_port *ap)
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->id);
+	DPRINTK("ata%u port frozen\n", ap->print_id);
 }
 
 /**
@@ -658,7 +658,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->id);
+	DPRINTK("ata%u port thawed\n", ap->print_id);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0009818..9f325a5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -781,7 +781,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+		ata_to_sense_error(qc->ap->print_id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3], verbose);
 		sb[1] &= 0x0f;
 	}
@@ -854,7 +854,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+		ata_to_sense_error(qc->ap->print_id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3], verbose);
 		sb[1] &= 0x0f;
 	}
@@ -1469,7 +1469,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	}
 
 	if (need_sense && !ap->ops->error_handler)
-		ata_dump_status(ap->id, &qc->result_tf);
+		ata_dump_status(ap->print_id, &qc->result_tf);
 
 	qc->scsidone(cmd);
 
@@ -2774,7 +2774,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 	u8 *scsicmd = cmd->cmnd;
 
 	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		ap->id,
+		ap->print_id,
 		scsidev->channel, scsidev->id, scsidev->lun,
 		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
 		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 16bc3e3..7fea094 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -175,7 +175,7 @@ void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
  */
 void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_pause(ap);
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 560103d..591b0c1 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -151,7 +151,7 @@ static int sis_66_pre_reset(struct ata_port *ap)
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		return 0;
 	}
 	/* Older chips keep cable detect in bits 4/5 of reg 0x48 */
@@ -197,7 +197,7 @@ static int sis_old_pre_reset(struct ata_port *ap)
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		return 0;
 	}
 	ap->cbl = ATA_CBL_PATA40;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 857ac23..37bab32 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -498,7 +498,7 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-					ap->id, qc->tf.protocol, status);
+					ap->print_id, qc->tf.protocol, status);
 
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d689df5..462ffd0 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1276,7 +1276,7 @@ static void mv_err_intr(struct ata_port *ap, int reset_allowed)
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	}
 	DPRINTK(KERN_ERR "ata%u: port error; EDMA err cause: 0x%08x "
-		"SERR: 0x%08x\n", ap->id, edma_err_cause, serr);
+		"SERR: 0x%08x\n", ap->print_id, edma_err_cause, serr);
 
 	/* Clear EDMA now that SERR cleanup done */
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 6097d8f..1558571 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -446,7 +446,7 @@ static inline unsigned int qs_intr_mmio(struct ata_host *host)
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-					ap->id, qc->tf.protocol, status);
+					ap->print_id, qc->tf.protocol, status);
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 0ebd77b..4fb8bfc 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -421,7 +421,7 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	VPRINTK("ata%u: ENTER\n", ap->print_id);
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -478,7 +478,7 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	VPRINTK("ata%u: ENTER\n", ap->print_id);
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -605,7 +605,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	VPRINTK("ata%u: ENTER\n", ap->print_id);
 
 	wmb();			/* flush PRD, pkt writes */
 
@@ -672,7 +672,7 @@ static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
 
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
-			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
+			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->print_id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -683,7 +683,7 @@ static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
 		/* step one - exec ATA command */
 		else {
 			u8 seq = (u8) (port_no + 1 + 4);
-			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->id,
+			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->print_id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit hdma pkt */
@@ -698,7 +698,7 @@ static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
-			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->id,
+			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->print_id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit ata pkt */
@@ -711,7 +711,7 @@ static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
 
 		/* step two - execute ATA command */
 		else {
-			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
+			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->print_id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b870b20..7feb2ba 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -530,8 +530,8 @@ struct ata_port {
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
-	unsigned int		id;	/* unique id req'd by scsi midlyr */
-	unsigned int		port_no; /* unique port #; from zero */
+	unsigned int		print_id; /* user visible unique port ID */
+	unsigned int		port_no; /* 0 based port no. inside the host */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
@@ -885,10 +885,10 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
  * printk helpers
  */
 #define ata_port_printk(ap, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (ap)->id , ##args)
+	printk(lv"ata%u: "fmt, (ap)->print_id , ##args)
 
 #define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
+	printk(lv"ata%u.%02u: "fmt, (dev)->ap->print_id, (dev)->devno , ##args)
 
 /*
  * ata_eh_info helpers
