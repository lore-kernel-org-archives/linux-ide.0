From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] libata: move err_mask to ata_queued_cmd
Date: Mon, 05 Dec 2005 15:38:02 +0800
Message-ID: <4393EE5A.2030708@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com> <43924E11.60500@pobox.com> <4393E513.5070203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:41630 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751349AbVLEHiF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 02:38:05 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jB57c0PG023816
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 02:38:00 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jB57bMaN056678
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:37:22 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jB57bx7X021009
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:38:00 -0700
In-Reply-To: <4393E513.5070203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 2/4:
  move err_mask to ata_queued_cmd

Changes:
  - remove err_mask from the parameter list of the complete functions
  - move err_mask to ata_queued_cmd
  - initialize qc->err_mask when needed
  - for each function call to ata_qc_complete(), replace the err_mask parameter with qc->err_mask.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===============

--- upstream/include/linux/libata.h	2005-12-05 10:13:59.000000000 +0800
+++ err_mask2/include/linux/libata.h	2005-12-05 10:30:34.000000000 +0800
@@ -194,7 +194,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -279,6 +279,8 @@ struct ata_queued_cmd {
 	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
 	struct scatterlist	*__sg;
 
+	unsigned int		err_mask;
+
 	ata_qc_cb_t		complete_fn;
 
 	struct completion	*waiting;
@@ -475,7 +477,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -667,6 +669,7 @@ static inline void ata_qc_reinit(struct 
 	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 	qc->nsect = 0;
 	qc->nbytes = qc->curbytes = 0;
+	qc->err_mask = 0;
 
 	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
 }
--- upstream/drivers/scsi/libata.h	2005-12-05 10:13:48.000000000 +0800
+++ err_mask2/drivers/scsi/libata.h	2005-12-05 10:26:14.000000000 +0800
@@ -39,7 +39,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern int ata_qc_complete_noop(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
--- err_mask1/drivers/scsi/libata-core.c	2005-12-05 12:32:33.000000000 +0800
+++ err_mask2/drivers/scsi/libata-core.c	2005-12-05 12:37:14.000000000 +0800
@@ -1053,9 +1053,9 @@ static int ata_qc_wait_err(struct ata_qu
 
 	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
 		/* timeout handling */
-		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
+		qc->err_mask |= ac_err_mask(ata_chk_status(qc->ap));
 
-		if (!err_mask) {
+		if (!qc->err_mask) {
 			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
 			       qc->ap->id, qc->tf.command);
 		} else {
@@ -1064,7 +1064,7 @@ static int ata_qc_wait_err(struct ata_qu
 			rc = -EIO;
 		}
 
-		ata_qc_complete(qc, err_mask);
+		ata_qc_complete(qc);
 	}
 
 	return rc;
@@ -1175,6 +1175,7 @@ retry:
 				qc->cursg_ofs = 0;
 				qc->cursect = 0;
 				qc->nsect = 1;
+				qc->err_mask = 0;
 				goto retry;
 			}
 		}
@@ -2777,7 +2778,7 @@ skip_map:
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_poll_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2785,7 +2786,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, err_mask);
+	ata_qc_complete(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2885,7 +2886,8 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, 0);
+	assert(qc->err_mask == 0);
+	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
 
@@ -3261,7 +3263,8 @@ static void ata_pio_error(struct ata_por
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
+	qc->err_mask |= AC_ERR_ATA_BUS;
+	ata_poll_qc_complete(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -3363,7 +3366,8 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -3462,7 +3466,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc)
 {
 	return 0;
 }
@@ -3521,7 +3525,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	int rc;
 
@@ -3538,7 +3542,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, err_mask);
+	rc = qc->complete_fn(qc);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3976,7 +3980,8 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -4111,7 +4116,8 @@ static void atapi_packet_task(void *_dat
 err_out_status:
 	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, __ac_err_mask(status));
+	qc->err_mask |= __ac_err_mask(status);
+	ata_poll_qc_complete(qc);
 }
 
 
--- upstream/drivers/scsi/libata-scsi.c	2005-12-05 10:13:48.000000000 +0800
+++ err_mask2/drivers/scsi/libata-scsi.c	2005-12-05 12:51:30.000000000 +0800
@@ -1203,12 +1203,11 @@ nothing_to_do:
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
@@ -1955,9 +1954,9 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_sense_complete(struct ata_queued_cmd *qc,unsigned int err_mask)
+static int atapi_sense_complete(struct ata_queued_cmd *qc)
 {
-	if (err_mask && ((err_mask & AC_ERR_DEV) == 0))
+	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
 		/* FIXME: not quite right; we don't want the
 		 * translation of taskfile registers into
 		 * a sense descriptors, since that's only
@@ -2015,15 +2014,18 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	if (ata_qc_issue(qc))
-		ata_qc_complete(qc, AC_ERR_OTHER);
+	if (ata_qc_issue(qc)) {
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
+	}
 
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+static int atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	unsigned int err_mask = qc->err_mask;
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
--- upstream/drivers/scsi/ahci.c	2005-12-05 10:13:48.000000000 +0800
+++ err_mask2/drivers/scsi/ahci.c	2005-12-05 10:36:41.000000000 +0800
@@ -643,7 +643,8 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -664,7 +665,8 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
-			ata_qc_complete(qc, 0);
+			assert(qc->err_mask == 0);
+			ata_qc_complete(qc);
 			qc = NULL;
 		}
 	}
@@ -681,8 +683,10 @@ static inline int ahci_host_intr(struct 
 		/* command processing has stopped due to error; restart */
 		ahci_restart_port(ap, status);
 
-		if (qc)
-			ata_qc_complete(qc, err_mask);
+		if (qc) {
+			qc->err_mask |= AC_ERR_OTHER;
+			ata_qc_complete(qc);
+		}
 	}
 
 	return 1;
--- upstream/drivers/scsi/pdc_adma.c	2005-12-05 10:13:48.000000000 +0800
+++ err_mask2/drivers/scsi/pdc_adma.c	2005-12-05 13:27:44.000000000 +0800
@@ -464,14 +464,12 @@ static inline unsigned int adma_intr_pkt
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
@@ -501,7 +499,8 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
--- upstream/drivers/scsi/sata_mv.c	2005-12-05 10:13:49.000000000 +0800
+++ err_mask2/drivers/scsi/sata_mv.c	2005-12-05 13:45:41.000000000 +0800
@@ -1242,8 +1242,10 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				if (!(qc->tf.ctl & ATA_NIEN))
-					ata_qc_complete(qc, err_mask);
+				if (!(qc->tf.ctl & ATA_NIEN)) {
+					qc->err_mask |= err_mask;
+					ata_qc_complete(qc);
+				}
 			}
 		}
 	}
@@ -1864,7 +1866,8 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
--- upstream/drivers/scsi/sata_promise.c	2005-12-05 10:13:49.000000000 +0800
+++ err_mask2/drivers/scsi/sata_promise.c	2005-12-05 10:43:12.000000000 +0800
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
 
--- upstream/drivers/scsi/sata_qstor.c	2005-12-05 10:13:49.000000000 +0800
+++ err_mask2/drivers/scsi/sata_qstor.c	2005-12-05 10:45:09.000000000 +0800
@@ -409,8 +409,8 @@ static inline unsigned int qs_intr_pkt(s
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
@@ -447,7 +447,8 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
--- upstream/drivers/scsi/sata_sil24.c	2005-12-05 10:13:49.000000000 +0800
+++ err_mask2/drivers/scsi/sata_sil24.c	2005-12-05 13:10:36.000000000 +0800
@@ -654,7 +654,8 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, AC_ERR_OTHER);
+	qc->err_mask |= AC_ERR_OTHER;
+	ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
@@ -711,8 +712,10 @@ static void sil24_error_intr(struct ata_
 		sil24_reset_controller(ap);
 	}
 
-	if (qc)
-		ata_qc_complete(qc, err_mask);
+	if (qc) {
+		qc->err_mask |= err_mask;
+		ata_qc_complete(qc);
+	}
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
@@ -734,8 +737,10 @@ static inline void sil24_host_intr(struc
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
--- upstream/drivers/scsi/sata_sx4.c	2005-12-05 10:13:49.000000000 +0800
+++ err_mask2/drivers/scsi/sata_sx4.c	2005-12-05 10:51:16.000000000 +0800
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
 


