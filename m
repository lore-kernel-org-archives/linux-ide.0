From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] improve libata error handling
Date: Sat, 29 Oct 2005 03:25:28 -0400
Message-ID: <20051029072528.GA30228@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:18412 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751375AbVJ2HZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 03:25:31 -0400
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id C77E21C095B8
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 03:25:28 -0400 (EDT)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id j9T7PSsQ030247
	for linux-ide@vger.kernel.org; Sat, 29 Oct 2005 03:25:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This patch experiments with making the second arg to ata_qc_complete()
a mask of error classes.  Not committing this (at least not verbatim).


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index fe8187d..70aa04f 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -609,7 +609,8 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		qc->tf.command = ATA_BUSY;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -630,6 +631,7 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
+			qc->tf.command = ahci_check_status(ap);
 			ata_qc_complete(qc, 0);
 			qc = NULL;
 		}
@@ -637,8 +639,10 @@ static inline int ahci_host_intr(struct 
 
 	if (status & PORT_IRQ_FATAL) {
 		ahci_intr_error(ap, status);
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
+		if (qc) {
+			qc->tf.command = ahci_check_status(ap);
+			ata_qc_complete(qc, AC_ERR_UNKNOWN);
+		}
 	}
 
 	return 1;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f53d7b8..867fef1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1135,7 +1135,6 @@ static void ata_dev_identify(struct ata_
 	unsigned int major_version;
 	u16 tmp;
 	unsigned long xfer_modes;
-	u8 status;
 	unsigned int using_edd;
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
@@ -1189,8 +1188,7 @@ retry:
 	else
 		wait_for_completion(&wait);
 
-	status = ata_chk_status(ap);
-	if (status & ATA_ERR) {
+	if (qc->tf.command & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1340,7 +1338,7 @@ retry:
 		       ata_mode_string(xfer_modes));
 	}
 
-	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
+	DPRINTK("EXIT, drv_stat = 0x%x\n", qc->tf.command);
 	return;
 
 err_out_nosup:
@@ -2687,7 +2685,7 @@ static int ata_sg_setup(struct ata_queue
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2695,7 +2693,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, drv_stat);
+	ata_qc_complete(qc, err_mask);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2781,18 +2779,20 @@ static int ata_pio_complete (struct ata_
 		}
 	}
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	drv_stat = ata_wait_idle(ap);
+	qc->tf.command = drv_stat;
+
 	if (!ata_ok(drv_stat)) {
 		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, 0);
 
 	/* another command may start at this point */
 
@@ -3101,6 +3101,7 @@ err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
 	ap->hsm_task_state = HSM_ST_ERR;
+	qc->tf.command = ata_chk_status(ap);
 }
 
 /**
@@ -3150,6 +3151,7 @@ static void ata_pio_block(struct ata_por
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
 			ap->hsm_task_state = HSM_ST_ERR;
+			qc->tf.command = status;
 			return;
 		}
 
@@ -3160,18 +3162,16 @@ static void ata_pio_block(struct ata_por
 static void ata_pio_error(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	u8 drv_stat;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	drv_stat = ata_chk_status(ap);
 	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
+	       ap->id, qc->tf.command);
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, AC_ERR_UNKNOWN);
 }
 
 static void ata_pio_task(void *_data)
@@ -3294,7 +3294,8 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, drv_stat);
+		qc->tf.command = drv_stat;
+		ata_qc_complete(qc, ata_stat_err_mask(drv_stat) | AC_ERR_UNKNOWN);
 		break;
 	}
 
@@ -3399,7 +3400,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	return 0;
 }
@@ -3458,7 +3459,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	int rc;
 
@@ -3475,7 +3476,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
+	rc = qc->complete_fn(qc, err_mask);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3913,7 +3914,8 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, status);
+		qc->tf.command = status;
+		ata_qc_complete(qc, ata_stat_err_mask(status));
 		break;
 
 	default:
@@ -4008,7 +4010,7 @@ static void atapi_packet_task(void *_dat
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out;
+		goto err_out_status;
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
@@ -4045,8 +4047,11 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
+err_out_status:
+	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, ATA_ERR);
+	qc->tf.command = status;
+	ata_poll_qc_complete(qc, ata_stat_err_mask(status) | AC_ERR_ATA_BUS);
 }
 
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 89a04b1..65fe835 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1199,10 +1199,10 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
- 	int need_sense = drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ);
+ 	int need_sense = (err_mask & AC_ERR_ALL);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1995,21 +1995,13 @@ void atapi_request_sense(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	VPRINTK("ENTER, drv_stat == 0x%x\n", drv_stat);
 
-	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
-		/* FIXME: not quite right; we don't want the
-		 * translation of taskfile registers into
-		 * a sense descriptors, since that's only
-		 * correct for ATA, not ATAPI
-		 */
-		ata_gen_ata_desc_sense(qc);
-
-	else if (unlikely(drv_stat & ATA_ERR)) {
+	if (unlikely(err_mask & AC_ERR_DEV)) {
 		DPRINTK("request check condition\n");
 
 		/* FIXME: command completion with check condition
@@ -2026,6 +2018,14 @@ static int atapi_qc_complete(struct ata_
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
index 7999817..f1642d7 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -464,11 +464,16 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			unsigned int err_mask = 0;
+
 			if ((status & (aPERR | aPSD | aUIRQ)))
-				drv_stat = ATA_ERR;
+				err_mask |= AC_ERR_DEV;
 			else if (pp->pkt[0] != cDONE)
-				drv_stat = ATA_ERR;
-			ata_qc_complete(qc, drv_stat);
+				err_mask |= AC_ERR_UNKNOWN;
+
+			qc->tf.command = drv_stat;
+			err_mask |= ata_stat_err_mask(drv_stat);
+			ata_qc_complete(qc, err_mask);
 		}
 	}
 	return handled;
@@ -498,7 +503,8 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, status);
+				qc->tf.command = status;
+				ata_qc_complete(qc, ata_stat_err_mask(status));
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 422e0b6..ad09c53 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1068,6 +1068,7 @@ static void mv_host_intr(struct ata_host
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
 	u8 ata_status = 0;
+	unsigned int err_mask;
 
 	if (hc == 0) {
 		port0 = 0;
@@ -1088,6 +1089,7 @@ static void mv_host_intr(struct ata_host
 		ap = host_set->ports[port];
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
+		err_mask = 0;
 
 		if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
 			/* new CRPB on the queue; just one at a time until NCQ
@@ -1108,9 +1110,7 @@ static void mv_host_intr(struct ata_host
 		}
 		if ((PORT0_ERR << shift) & relevant) {
 			mv_err_intr(ap);
-			/* OR in ATA_ERR to ensure libata knows we took one */
-			ata_status = readb((void __iomem *)
-					   ap->ioaddr.status_addr) | ATA_ERR;
+			err_mask |= AC_ERR_UNKNOWN;
 			handled++;
 		}
 		
@@ -1120,7 +1120,11 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				ata_qc_complete(qc, ata_status);
+				qc->tf.command = ata_status;
+				ata_qc_complete(qc,
+						ata_stat_err_mask(ata_status) |
+						err_mask);
+
 			}
 		}
 	}
@@ -1312,7 +1316,8 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		qc->tf.command = ATA_BUSY;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 63911f1..70fcdfc 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -399,7 +399,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		qc->tf.command = ATA_BUSY;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 		break;
 
 	default:
@@ -408,7 +409,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		qc->tf.command = drv_stat;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 		break;
 	}
 
@@ -427,7 +429,7 @@ static inline unsigned int pdc_host_intr
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
-		have_err = 1;
+		have_err = AC_ERR_UNKNOWN;
 		pdc_reset_port(ap);
 	}
 
@@ -435,9 +437,8 @@ static inline unsigned int pdc_host_intr
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		status = ata_wait_idle(ap);
-		if (have_err)
-			status |= ATA_ERR;
-		ata_qc_complete(qc, status);
+		qc->tf.command = status;
+		ata_qc_complete(qc, ata_stat_err_mask(status) | have_err);
 		handled = 1;
 		break;
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 250dafa..d12389d 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -399,12 +399,17 @@ static inline unsigned int qs_intr_pkt(s
 					continue;
 				qc = ata_qc_from_tag(ap, ap->active_tag);
 				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+					unsigned int err_mask = 0;
 					switch (sHST) {
-					case 0: /* sucessful CPB */
 					case 3: /* device error */
+						err_mask = AC_ERR_DEV;
+					case 0: /* successful CPB */
 						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
-						ata_qc_complete(qc, sDST);
+						err_mask |=
+							ata_stat_err_mask(sDST);
+						qc->tf.command = sDST;
+						ata_qc_complete(qc, err_mask);
 						break;
 					default:
 						break;
@@ -441,7 +446,8 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, status);
+				qc->tf.command = status;
+				ata_qc_complete(qc, ata_stat_err_mask(status));
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 32d730b..5ecdfd9 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -518,7 +518,8 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, ATA_ERR);
+	qc->tf.command = ATA_BUSY;
+	ata_qc_complete(qc, AC_ERR_UNKNOWN);
 
 	sil24_reset_controller(ap);
 }
@@ -529,6 +530,7 @@ static void sil24_error_intr(struct ata_
 	struct sil24_port_priv *pp = ap->private_data;
 	void *port = (void *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
+	unsigned int err_mask = 0;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
 	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
@@ -556,17 +558,20 @@ static void sil24_error_intr(struct ata_
 		 * Device is reporting error, tf registers are valid.
 		 */
 		sil24_update_tf(ap);
+		err_mask = ata_stat_err_mask(pp->tf.command);
+		qc->tf.command = pp->tf.command;
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
 		 * mechanism to report these errors.  Just turn on
 		 * ATA_ERR.
 		 */
-		pp->tf.command = ATA_ERR;
+		qc->tf.command = ATA_BUSY;
+		err_mask = AC_ERR_UNKNOWN;
 	}
 
 	if (qc)
-		ata_qc_complete(qc, pp->tf.command);
+		ata_qc_complete(qc, err_mask);
 
 	sil24_reset_controller(ap);
 }
@@ -591,7 +596,7 @@ static inline void sil24_host_intr(struc
 		sil24_update_tf(ap);
 
 		if (qc)
-			ata_qc_complete(qc, pp->tf.command);
+			ata_qc_complete(qc, ata_stat_err_mask(pp->tf.command));
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index af08f4f..cc713bd 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -718,7 +718,9 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			status = ata_wait_idle(ap);
+			qc->tf.command = status;
+			ata_qc_complete(qc, ata_stat_err_mask(status));
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -756,7 +758,9 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			status = ata_wait_idle(ap);
+			qc->tf.command = status;
+			ata_qc_complete(qc, ata_stat_err_mask(status));
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -766,7 +770,8 @@ static inline unsigned int pdc20621_host
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		qc->tf.command = status;
+		ata_qc_complete(qc, ata_stat_err_mask(status));
 		handled = 1;
 
 	} else {
@@ -881,7 +886,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		qc->tf.command = ATA_BUSY;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 		break;
 
 	default:
@@ -890,7 +896,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		qc->tf.command = drv_stat;
+		ata_qc_complete(qc, AC_ERR_UNKNOWN);
 		break;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 00a8a57..7791436 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,16 @@ enum hsm_task_states {
 	HSM_ST_ERR,
 };
 
+enum ata_err_mask {
+	AC_ERR_UNKNOWN		= (1 << 0),
+	AC_ERR_DEV		= (1 << 1),
+	AC_ERR_ATA_BUS		= (1 << 2),
+	AC_ERR_HOST_BUS		= (1 << 3),
+
+	AC_ERR_ALL		= AC_ERR_UNKNOWN | AC_ERR_DEV |
+				  AC_ERR_ATA_BUS | AC_ERR_HOST_BUS,
+};
+
 /* forward declarations */
 struct scsi_device;
 struct ata_port_operations;
@@ -179,7 +189,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -455,7 +465,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
+extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -718,4 +728,13 @@ static inline int ata_try_flush_cache(co
 	       ata_id_has_flush_ext(dev->id);
 }
 
+static inline unsigned int ata_stat_err_mask(u8 stat)
+{
+	if (stat & ATA_BUSY)
+		return AC_ERR_ATA_BUS;
+	if (stat & (ATA_ERR | ATA_DF))
+		return AC_ERR_DEV;
+	return 0;
+}
+
 #endif /* __LINUX_LIBATA_H__ */
