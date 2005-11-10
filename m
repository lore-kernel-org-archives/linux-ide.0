From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] libata: move err_mask to ata_queued_cmd
Date: Thu, 10 Nov 2005 16:01:21 +0800
Message-ID: <4372FE51.1050704@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:62103 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751366AbVKJIBj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 03:01:39 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAA81TxH017418
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 03:01:29 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAA81PxP072498
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:01:25 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAA81Tjh000779
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:01:29 -0700
In-Reply-To: <4372FD45.8080404@tw.ibm.com>
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

For your review and advice, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- linux/include/linux/libata.h	2005-11-10 11:03:23.000000000 +0800
+++ err_mask2/include/linux/libata.h	2005-11-10 11:08:42.000000000 +0800
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
--- linux/drivers/scsi/libata.h	2005-11-10 11:03:03.000000000 +0800
+++ err_mask2/drivers/scsi/libata.h	2005-11-10 11:09:01.000000000 +0800
@@ -39,7 +39,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern int ata_qc_complete_noop(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
--- err_mask1/drivers/scsi/libata-core.c	2005-11-10 11:13:54.000000000 +0800
+++ err_mask2/drivers/scsi/libata-core.c	2005-11-10 11:28:51.000000000 +0800
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
 
@@ -2827,7 +2828,8 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, 0);
+	assert(qc->err_mask == 0);
+	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
 
@@ -3203,7 +3205,8 @@ static void ata_pio_error(struct ata_por
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
+	qc->err_mask |= AC_ERR_ATA_BUS;
+	ata_poll_qc_complete(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -3326,7 +3329,8 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -3424,6 +3428,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
 		qc->nbytes = qc->curbytes = 0;
+		qc->err_mask = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 	}
@@ -3431,7 +3436,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc)
 {
 	return 0;
 }
@@ -3490,7 +3495,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	int rc;
 
@@ -3507,7 +3512,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, err_mask);
+	rc = qc->complete_fn(qc);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3945,7 +3950,8 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -4080,7 +4086,8 @@ static void atapi_packet_task(void *_dat
 err_out_status:
 	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, __ac_err_mask(status));
+	qc->err_mask |= __ac_err_mask(status);
+	ata_poll_qc_complete(qc);
 }
 
 
--- linux/drivers/scsi/libata-scsi.c	2005-11-10 11:03:03.000000000 +0800
+++ err_mask2/drivers/scsi/libata-scsi.c	2005-11-10 11:25:13.000000000 +0800
@@ -1219,12 +1219,11 @@ nothing_to_do:
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
@@ -2017,9 +2016,10 @@ void atapi_request_sense(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+static int atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	unsigned int err_mask = qc->err_mask;
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
--- linux/drivers/scsi/ahci.c	2005-11-10 11:03:03.000000000 +0800
+++ err_mask2/drivers/scsi/ahci.c	2005-11-10 11:32:02.000000000 +0800
@@ -610,7 +610,8 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -631,15 +632,18 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
-			ata_qc_complete(qc, 0);
+			assert(qc->err_mask == 0);
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
--- linux/drivers/scsi/pdc_adma.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/pdc_adma.c	2005-11-10 12:30:16.000000000 +0800
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
--- linux/drivers/scsi/sata_mv.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/sata_mv.c	2005-11-10 11:35:19.000000000 +0800
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
--- linux/drivers/scsi/sata_promise.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/sata_promise.c	2005-11-10 12:43:52.000000000 +0800
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
 
--- linux/drivers/scsi/sata_qstor.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/sata_qstor.c	2005-11-10 11:38:29.000000000 +0800
@@ -406,8 +406,8 @@ static inline unsigned int qs_intr_pkt(s
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
@@ -444,7 +444,8 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
--- linux/drivers/scsi/sata_sil24.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/sata_sil24.c	2005-11-10 11:41:38.000000000 +0800
@@ -518,7 +518,8 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, AC_ERR_OTHER);
+	qc->err_mask |= AC_ERR_OTHER;
+	ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
@@ -529,7 +530,6 @@ static void sil24_error_intr(struct ata_
 	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
-	unsigned int err_mask;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
 	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
@@ -557,18 +557,18 @@ static void sil24_error_intr(struct ata_
 		 * Device is reporting error, tf registers are valid.
 		 */
 		sil24_update_tf(ap);
-		err_mask = ac_err_mask(pp->tf.command);
+		qc->err_mask |= ac_err_mask(pp->tf.command);
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
 		 * mechanism to report these errors.  Just turn on
 		 * ATA_ERR.
 		 */
-		err_mask = AC_ERR_OTHER;
+		qc->err_mask |= AC_ERR_OTHER;
 	}
 
 	if (qc)
-		ata_qc_complete(qc, err_mask);
+		ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
@@ -592,8 +592,10 @@ static inline void sil24_host_intr(struc
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
--- linux/drivers/scsi/sata_sx4.c	2005-11-10 11:03:04.000000000 +0800
+++ err_mask2/drivers/scsi/sata_sx4.c	2005-11-10 11:43:38.000000000 +0800
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
 


