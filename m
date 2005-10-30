From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] more qc_complete work
Date: Sat, 29 Oct 2005 23:17:48 -0400
Message-ID: <43643B5C.3090306@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070202010301040802030000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:29831 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932134AbVJ3DR4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 23:17:56 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EW3hi-0006Bp-J7
	for linux-ide@vger.kernel.org; Sun, 30 Oct 2005 03:17:56 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070202010301040802030000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's the latest work, updating ata_qc_complete() API to supply better 
error handling information, and eliminating the sometimes-emulated 
drv_stat argument.

--------------070202010301040802030000
Content-Type: text/plain;
 name="patch.qc-complete-mask"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.qc-complete-mask"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 03829ae..8ccb11d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -593,6 +593,10 @@ static void ahci_eng_timeout(struct ata_
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 	} else {
+		/*
+		 * should never occur
+		 */
+
 		/* hack alert!  We cannot use the supplied completion
 	 	 * function from inside the ->eh_strategy_handler() thread.
 	 	 * libata is the only user of ->eh_strategy_handler() in
@@ -600,7 +604,7 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc, AC_ERR_OTHER);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -629,7 +633,7 @@ static inline int ahci_host_intr(struct 
 	if (status & PORT_IRQ_FATAL) {
 		ahci_intr_error(ap, status);
 		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
+			ata_qc_complete(qc, AC_ERR_OTHER);
 	}
 
 	return 1;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d2f71a2..7123fa8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2669,7 +2669,7 @@ static int ata_sg_setup(struct ata_queue
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2677,7 +2677,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, drv_stat);
+	ata_qc_complete(qc, err_mask);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2774,7 +2774,7 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, 0);
 
 	/* another command may start at this point */
 
@@ -3142,18 +3142,15 @@ static void ata_pio_block(struct ata_por
 static void ata_pio_error(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	u8 drv_stat;
+
+	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
 }
 
 static void ata_pio_task(void *_data)
@@ -3276,7 +3273,7 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
@@ -3381,7 +3378,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	return 0;
 }
@@ -3440,7 +3437,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	int rc;
 
@@ -3457,7 +3454,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
+	rc = qc->complete_fn(qc, err_mask);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3895,7 +3892,7 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, status);
+		ata_qc_complete(qc, ac_err_mask(status));
 		break;
 
 	default:
@@ -3990,7 +3987,7 @@ static void atapi_packet_task(void *_dat
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out;
+		goto err_out_status;
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
@@ -4027,8 +4024,10 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
+err_out_status:
+	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, ATA_ERR);
+	ata_poll_qc_complete(qc, __ac_err_mask(status));
 }
 
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 89a04b1..d6532e2 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -560,7 +560,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
@@ -635,7 +635,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[2], &sb[12], &sb[13]);
 		sb[2] &= 0x0f;
@@ -644,7 +644,11 @@ void ata_gen_fixed_sense(struct ata_queu
 	sb[0] = 0x70;
 	sb[7] = 0x0a;
 
-	if (tf->flags & ATA_TFLAG_LBA && !(tf->flags & ATA_TFLAG_LBA48)) {
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		/* TODO: find solution for LBA48 descriptors */
+	}
+
+	else if (tf->flags & ATA_TFLAG_LBA) {
 		/* A small (28b) LBA will fit in the 32b info field */
 		sb[0] |= 0x80;		/* set valid bit */
 		sb[3] = tf->device & 0x0f;
@@ -652,6 +656,10 @@ void ata_gen_fixed_sense(struct ata_queu
 		sb[5] = tf->lbam;
 		sb[6] = tf->lbal;
 	}
+
+	else {
+		/* TODO: C/H/S */
+	}
 }
 
 /**
@@ -1199,10 +1207,12 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc,
+				unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
- 	int need_sense = drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ);
+	u8 *cdb = cmd->cmnd;
+ 	int need_sense = (err_mask != 0);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1211,8 +1221,8 @@ static int ata_scsi_qc_complete(struct a
 	 * whether the command completed successfully or not. If there
 	 * was no error, SK, ASC and ASCQ will all be zero.
 	 */
-	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
- 	    ((cmd->cmnd[2] & 0x20) || need_sense)) {
+	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
+ 	    ((cdb[2] & 0x20) || need_sense)) {
  		ata_gen_ata_desc_sense(qc);
 	} else {
 		if (!need_sense) {
@@ -1995,21 +2005,13 @@ void atapi_request_sense(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	VPRINTK("ENTER, drv_stat == 0x%x\n", drv_stat);
-
-	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
-		/* FIXME: not quite right; we don't want the
-		 * translation of taskfile registers into
-		 * a sense descriptors, since that's only
-		 * correct for ATA, not ATAPI
-		 */
-		ata_gen_ata_desc_sense(qc);
+	VPRINTK("ENTER\n");
 
-	else if (unlikely(drv_stat & ATA_ERR)) {
+	if (unlikely(err_mask & AC_ERR_DEV)) {
 		DPRINTK("request check condition\n");
 
 		/* FIXME: command completion with check condition
@@ -2026,6 +2028,14 @@ static int atapi_qc_complete(struct ata_
 		return 1;
 	}
 
+	else if (unlikely(err_mask))
+		/* FIXME: not quite right; we don't want the
+		 * translation of taskfile registers into
+		 * a sense descriptors, since that's only
+		 * correct for ATA, not ATAPI
+		 */
+		ata_gen_ata_desc_sense(qc);
+
 	else {
 		u8 *scsicmd = cmd->cmnd;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 65c264b..10ecd9e 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,7 +39,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
+extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index af99feb..74b3b2c 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -451,7 +451,7 @@ static inline unsigned int adma_intr_pkt
 		struct adma_port_priv *pp;
 		struct ata_queued_cmd *qc;
 		void __iomem *chan = ADMA_REGS(mmio_base, port_no);
-		u8 drv_stat = 0, status = readb(chan + ADMA_STATUS);
+		u8 status = readb(chan + ADMA_STATUS);
 
 		if (status == 0)
 			continue;
@@ -464,11 +464,14 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			unsigned int err_mask = 0;
+
 			if ((status & (aPERR | aPSD | aUIRQ)))
-				drv_stat = ATA_ERR;
+				err_mask = AC_ERR_OTHER;
 			else if (pp->pkt[0] != cDONE)
-				drv_stat = ATA_ERR;
-			ata_qc_complete(qc, drv_stat);
+				err_mask = AC_ERR_OTHER;
+
+			ata_qc_complete(qc, err_mask);
 		}
 	}
 	return handled;
@@ -498,7 +501,7 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, status);
+				ata_qc_complete(qc, ac_err_mask(status));
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index dcef5fe..936d1ce 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1065,6 +1065,7 @@ static void mv_host_intr(struct ata_host
 	struct ata_queued_cmd *qc;
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
+	unsigned int err_mask;
 	u8 ata_status = 0;
 
 	if (hc == 0) {
@@ -1100,15 +1101,15 @@ static void mv_host_intr(struct ata_host
 			handled++;
 		}
 
+		err_mask = ac_err_mask(ata_status);
+
 		shift = port << 1;		/* (port * 2) */
 		if (port >= MV_PORTS_PER_HC) {
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
 			mv_err_intr(ap);
-			/* OR in ATA_ERR to ensure libata knows we took one */
-			ata_status = readb((void __iomem *)
-					   ap->ioaddr.status_addr) | ATA_ERR;
+			err_mask |= AC_ERR_OTHER;
 			handled++;
 		}
 		
@@ -1118,7 +1119,7 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				ata_qc_complete(qc, ata_status);
+				ata_qc_complete(qc, err_mask);
 			}
 		}
 	}
@@ -1294,7 +1295,7 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc, AC_ERR_OTHER);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 63911f1..854d000 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -399,7 +399,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		drv_stat = ata_wait_idle(ap);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 
 	default:
@@ -408,7 +409,7 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
@@ -420,24 +421,21 @@ out:
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
-	u8 status;
-	unsigned int handled = 0, have_err = 0;
+	unsigned int handled = 0, err_mask = 0;
 	u32 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
-		have_err = 1;
+		err_mask = AC_ERR_DEV;
 		pdc_reset_port(ap);
 	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		status = ata_wait_idle(ap);
-		if (have_err)
-			status |= ATA_ERR;
-		ata_qc_complete(qc, status);
+		err_mask |= ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc, err_mask);
 		handled = 1;
 		break;
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 1aaf330..d95a02f 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -400,11 +400,12 @@ static inline unsigned int qs_intr_pkt(s
 				qc = ata_qc_from_tag(ap, ap->active_tag);
 				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					switch (sHST) {
-					case 0: /* sucessful CPB */
+					case 0: /* successful CPB */
 					case 3: /* device error */
 						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
-						ata_qc_complete(qc, sDST);
+						ata_qc_complete(qc,
+							ac_err_mask(sDST));
 						break;
 					default:
 						break;
@@ -441,7 +442,7 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, status);
+				ata_qc_complete(qc, ac_err_mask(status));
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e18a1e2..4afe2b1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -498,7 +498,7 @@ static void sil24_eng_timeout(struct ata
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: tiemout without command\n",
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 		return;
 	}
@@ -512,7 +512,7 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, ATA_ERR);
+	ata_qc_complete(qc, AC_ERR_OTHER);
 
 	sil24_reset_controller(ap);
 }
@@ -523,6 +523,7 @@ static void sil24_error_intr(struct ata_
 	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
+	unsigned int err_mask;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
 	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
@@ -550,17 +551,18 @@ static void sil24_error_intr(struct ata_
 		 * Device is reporting error, tf registers are valid.
 		 */
 		sil24_update_tf(ap);
+		err_mask = ac_err_mask(pp->tf.command);
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
 		 * mechanism to report these errors.  Just turn on
 		 * ATA_ERR.
 		 */
-		pp->tf.command = ATA_ERR;
+		err_mask = AC_ERR_OTHER;
 	}
 
 	if (qc)
-		ata_qc_complete(qc, pp->tf.command);
+		ata_qc_complete(qc, err_mask);
 
 	sil24_reset_controller(ap);
 }
@@ -585,7 +587,7 @@ static inline void sil24_host_intr(struc
 		sil24_update_tf(ap);
 
 		if (qc)
-			ata_qc_complete(qc, pp->tf.command);
+			ata_qc_complete(qc, ac_err_mask(pp->tf.command));
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index af08f4f..d9a8baf 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -718,7 +718,7 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -756,7 +756,7 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -766,7 +766,7 @@ static inline unsigned int pdc20621_host
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		ata_qc_complete(qc, ac_err_mask(status));
 		handled = 1;
 
 	} else {
@@ -881,7 +881,7 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		ata_qc_complete(qc, __ac_err_mask(ata_wait_idle(ap)));
 		break;
 
 	default:
@@ -890,7 +890,7 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a4cce99..0ba3af7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,13 @@ enum hsm_task_states {
 	HSM_ST_ERR,
 };
 
+enum ata_completion_errors {
+	AC_ERR_OTHER		= (1 << 0),
+	AC_ERR_DEV		= (1 << 1),
+	AC_ERR_ATA_BUS		= (1 << 2),
+	AC_ERR_HOST_BUS		= (1 << 3),
+};
+
 /* forward declarations */
 struct scsi_device;
 struct ata_port_operations;
@@ -179,7 +186,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -453,7 +460,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
+extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -716,4 +723,21 @@ static inline int ata_try_flush_cache(co
 	       ata_id_has_flush_ext(dev->id);
 }
 
+static inline unsigned int ac_err_mask(u8 status)
+{
+	if (status & ATA_BUSY)
+		return AC_ERR_ATA_BUS;
+	if (status & (ATA_ERR | ATA_DF))
+		return AC_ERR_DEV;
+	return 0;
+}
+
+static inline unsigned int __ac_err_mask(u8 status)
+{
+	unsigned int mask = ac_err_mask(status);
+	if (mask == 0)
+		return AC_ERR_OTHER;
+	return mask;
+}
+
 #endif /* __LINUX_LIBATA_H__ */

--------------070202010301040802030000--
