From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/3] libata: move err_mask to ata_queued_cmd
Date: Wed, 09 Nov 2005 13:07:12 +0800
Message-ID: <43718400.5000409@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:54748 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030384AbVKIFHY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 00:07:24 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA957GPD027850
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 00:07:16 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jA957DuN025964
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:07:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA957FTh030444
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:07:16 -0700
In-Reply-To: <437181D5.8070903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 2/3:
  move err_mask to ata_queued_cmd.

Changes:
  - Move the err_mask parameter of the complete functions to ata_queued_cmd.
    This can make the err_mask more accessible outside the complete functions;
    also makes the HSM easier to pass err_mask between states.

For your review and advice, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- linux/include/linux/libata.h	2005-11-07 18:25:47.000000000 +0800
+++ err_mask/include/linux/libata.h	2005-11-08 16:43:25.000000000 +0800
@@ -190,7 +190,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -275,6 +275,8 @@ struct ata_queued_cmd {
 	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
 	struct scatterlist	*__sg;
 
+	unsigned int		err_mask;
+
 	ata_qc_cb_t		complete_fn;
 
 	struct completion	*waiting;
@@ -472,7 +474,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
--- linux/drivers/scsi/libata.h	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/libata.h	2005-11-08 16:31:00.000000000 +0800
@@ -39,7 +39,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern int ata_qc_complete_noop(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
--- identify/drivers/scsi/libata-core.c	2005-11-09 10:14:41.000000000 +0800
+++ err_mask/drivers/scsi/libata-core.c	2005-11-09 10:15:33.000000000 +0800
@@ -1152,6 +1152,7 @@ retry:
 				qc->cursg_ofs = 0;
 				qc->cursect = 0;
 				qc->nsect = 1;
+				qc->err_mask = 0;
 				goto retry;
 			}
 		}
@@ -2719,7 +2720,7 @@ static int ata_sg_setup(struct ata_queue
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_poll_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2727,7 +2728,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, err_mask);
+	ata_qc_complete(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2744,10 +2745,14 @@ void ata_poll_qc_complete(struct ata_que
 
 static unsigned long ata_pio_poll(struct ata_port *ap)
 {
+	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
 	case HSM_ST_POLL:
@@ -2767,6 +2772,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
@@ -2812,18 +2818,19 @@ static int ata_pio_complete (struct ata_
 		}
 	}
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, 0);
+	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
 
@@ -3131,6 +3138,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
+	qc->err_mask |= AC_ERR_ATA_BUS;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
 
@@ -3180,6 +3188,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
@@ -3199,7 +3208,7 @@ static void ata_pio_error(struct ata_por
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
+	ata_poll_qc_complete(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -3322,7 +3331,8 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -3420,6 +3430,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
 		qc->nbytes = qc->curbytes = 0;
+		qc->err_mask = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 	}
@@ -3427,7 +3438,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc)
 {
 	return 0;
 }
@@ -3486,7 +3497,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	int rc;
 
@@ -3503,7 +3514,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, err_mask);
+	rc = qc->complete_fn(qc);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3941,7 +3952,8 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -4035,13 +4047,17 @@ static void atapi_packet_task(void *_dat
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out_status;
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
+		goto err_out;
+	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		goto err_out;
+	}
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
@@ -4073,10 +4089,8 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
-err_out_status:
-	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, __ac_err_mask(status));
+	ata_poll_qc_complete(qc);
 }
 
 
--- linux/drivers/scsi/libata-scsi.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/libata-scsi.c	2005-11-08 16:25:51.000000000 +0800
@@ -1218,12 +1218,11 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc,
-				unsigned int err_mask)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
- 	int need_sense = (err_mask != 0);
+ 	int need_sense = (qc->err_mask != 0);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -2016,9 +2015,10 @@ void atapi_request_sense(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+static int atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	unsigned int err_mask = qc->err_mask;
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
--- linux/drivers/scsi/ahci.c	2005-11-07 18:25:36.000000000 +0800
+++ err_mask/drivers/scsi/ahci.c	2005-11-08 16:48:47.000000000 +0800
@@ -610,7 +610,8 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -631,15 +632,17 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
-			ata_qc_complete(qc, 0);
+			ata_qc_complete(qc);
 			qc = NULL;
 		}
 	}
 
 	if (status & PORT_IRQ_FATAL) {
 		ahci_intr_error(ap, status);
-		if (qc)
-			ata_qc_complete(qc, AC_ERR_OTHER);
+		if (qc) {
+			qc->err_mask |= AC_ERR_OTHER;
+			ata_qc_complete(qc);
+		}
 	}
 
 	return 1;
--- linux/drivers/scsi/pdc_adma.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/pdc_adma.c	2005-11-08 16:52:12.000000000 +0800
@@ -465,14 +465,12 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
-			unsigned int err_mask = 0;
-
 			if ((status & (aPERR | aPSD | aUIRQ)))
-				err_mask = AC_ERR_OTHER;
+				qc->err_mask |= AC_ERR_OTHER;
 			else if (pp->pkt[0] != cDONE)
-				err_mask = AC_ERR_OTHER;
+				qc->err_mask |= AC_ERR_OTHER;
 
-			ata_qc_complete(qc, err_mask);
+			ata_qc_complete(qc);
 		}
 	}
 	return handled;
@@ -502,7 +500,8 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
--- linux/drivers/scsi/sata_mv.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/sata_mv.c	2005-11-08 17:09:25.000000000 +0800
@@ -1136,7 +1136,8 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				ata_qc_complete(qc, err_mask);
+				qc->err_mask |= err_mask;
+				ata_qc_complete(qc);
 			}
 		}
 	}
@@ -1312,7 +1313,8 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
--- linux/drivers/scsi/sata_promise.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/sata_promise.c	2005-11-08 17:10:54.000000000 +0800
@@ -401,7 +401,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		drv_stat = ata_wait_idle(ap);
-		ata_qc_complete(qc, __ac_err_mask(drv_stat));
+		qc->err_mask |= __ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -410,7 +411,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -422,21 +424,21 @@ out:
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
-	unsigned int handled = 0, err_mask = 0;
+	unsigned int handled = 0;
 	u32 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
-		err_mask = AC_ERR_DEV;
+		qc->err_mask |= AC_ERR_DEV;
 		pdc_reset_port(ap);
 	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		err_mask |= ac_err_mask(ata_wait_idle(ap));
-		ata_qc_complete(qc, err_mask);
+		qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc);
 		handled = 1;
 		break;
 
--- linux/drivers/scsi/sata_qstor.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/sata_qstor.c	2005-11-08 17:37:19.000000000 +0800
@@ -407,8 +407,8 @@ static inline unsigned int qs_intr_pkt(s
 					case 3: /* device error */
 						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
-						ata_qc_complete(qc,
-							ac_err_mask(sDST));
+						qc->err_mask |= ac_err_mask(sDST);
+						ata_qc_complete(qc);
 						break;
 					default:
 						break;
@@ -445,7 +445,8 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
--- linux/drivers/scsi/sata_sil24.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/sata_sil24.c	2005-11-09 10:33:32.000000000 +0800
@@ -518,7 +518,8 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, AC_ERR_OTHER);
+	qc->err_mask |= AC_ERR_OTHER;
+	ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
@@ -567,8 +568,10 @@ static void sil24_error_intr(struct ata_
 		err_mask = AC_ERR_OTHER;
 	}
 
-	if (qc)
-		ata_qc_complete(qc, err_mask);
+	if (qc) {
+		qc->err_mask |= err_mask;
+		ata_qc_complete(qc);
+	}
 
 	sil24_reset_controller(ap);
 }
@@ -592,8 +595,10 @@ static inline void sil24_host_intr(struc
 		 */
 		sil24_update_tf(ap);
 
-		if (qc)
-			ata_qc_complete(qc, ac_err_mask(pp->tf.command));
+		if (qc) {
+			qc->err_mask |= ac_err_mask(pp->tf.command);
+			ata_qc_complete(qc);
+		}
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
--- linux/drivers/scsi/sata_sx4.c	2005-11-07 18:25:38.000000000 +0800
+++ err_mask/drivers/scsi/sata_sx4.c	2005-11-08 17:00:45.000000000 +0800
@@ -718,7 +718,8 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
+			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+			ata_qc_complete(qc);
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -756,7 +757,8 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
+			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+			ata_qc_complete(qc);
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -766,7 +768,8 @@ static inline unsigned int pdc20621_host
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		handled = 1;
 
 	} else {
@@ -881,7 +884,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, __ac_err_mask(ata_wait_idle(ap)));
+		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -890,7 +894,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 


