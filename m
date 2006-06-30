From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 5/9] libata-eh.c conversion
Date: Fri, 30 Jun 2006 08:49:50 +0200
Message-ID: <20060630064950.GA17697@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.plus.mail.re2.yahoo.com ([206.190.53.27]:34487 "HELO
	smtp102.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751195AbWF3Gty (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:49:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the libata-eh.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bf5a72a..a117aa9 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -152,7 +152,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 	struct ata_queued_cmd *qc;
 	enum scsi_eh_timer_return ret;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (ap->ops->error_handler) {
 		ret = EH_NOT_HANDLED;
@@ -171,7 +171,8 @@ enum scsi_eh_timer_return ata_scsi_timed
 	spin_unlock_irqrestore(ap->lock, flags);
 
  out:
-	DPRINTK("EXIT, ret=%d\n", ret);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, ret=%d\n", 
+			__FUNCTION__, ret);
 	return ret;
 }
 
@@ -194,7 +195,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	/* synchronize with port task */
 	ata_port_flush_task(ap);
@@ -289,13 +290,13 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		if (ap->flags & ATA_FLAG_EH_PENDING) {
 			if (--repeat_cnt) {
-				ata_port_printk(ap, KERN_INFO,
+				ata_port_printk(ap, ATA_MSG_INFO,
 					"EH pending after completion, "
 					"repeating EH (cnt=%d)\n", repeat_cnt);
 				spin_unlock_irqrestore(ap_lock, flags);
 				goto repeat;
 			}
-			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
+			ata_port_printk(ap, ATA_MSG_ERR, "EH pending after %d "
 					"tries, giving up\n", ATA_EH_MAX_REPEAT);
 		}
 
@@ -329,7 +330,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
 			queue_work(ata_aux_wq, &ap->hotplug_task);
 		if (ap->flags & ATA_FLAG_RECOVERED)
-			ata_port_printk(ap, KERN_INFO, "EH complete\n");
+			ata_port_printk(ap, ATA_MSG_INFO, "EH complete\n");
 	}
 
 	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
@@ -340,7 +341,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 	spin_unlock_irqrestore(ap_lock, flags);
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -403,7 +404,7 @@ static void ata_qc_timeout(struct ata_qu
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
@@ -427,7 +428,7 @@ static void ata_qc_timeout(struct ata_qu
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
-		ata_dev_printk(qc->dev, KERN_ERR, "command 0x%x timeout, "
+		ata_dev_printk(qc->dev, ATA_MSG_ERR, "command 0x%x timeout, "
 			       "stat 0x%x host_stat 0x%x\n",
 			       qc->tf.command, drv_stat, host_stat);
 
@@ -440,7 +441,7 @@ static void ata_qc_timeout(struct ata_qu
 
 	ata_eh_qc_complete(qc);
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -465,11 +466,11 @@ static void ata_qc_timeout(struct ata_qu
  */
 void ata_eng_timeout(struct ata_port *ap)
 {
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -516,7 +517,7 @@ void ata_port_schedule_eh(struct ata_por
 	ap->flags |= ATA_FLAG_EH_PENDING;
 	scsi_schedule_eh(ap->host);
 
-	DPRINTK("port EH scheduled\n");
+	ata_port_printk(ap, ATA_MSG_DEBUG, "port EH scheduled\n");
 }
 
 /**
@@ -580,7 +581,7 @@ static void __ata_port_freeze(struct ata
 
 	ap->flags |= ATA_FLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_DEBUG, "ata%u port frozen\n", ap->id);
 }
 
 /**
@@ -653,7 +654,7 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_DEBUG, "ata%u port thawed\n", ap->id);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
@@ -839,7 +840,7 @@ static unsigned int ata_read_log_page(st
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	DPRINTK("read log page - page %d\n", page);
+	ata_dev_printk(dev, ATA_MSG_DEBUG, "read log page - page %d\n", page);
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_READ_LOG_EXT;
@@ -852,7 +853,8 @@ static unsigned int ata_read_log_page(st
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     buf, sectors * ATA_SECT_SIZE);
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: EXIT, err_mask=%x\n", 
+			__FUNCTION__, err_mask);
 	return err_mask;
 }
 
@@ -887,7 +889,7 @@ static int ata_eh_read_log_10h(struct at
 	for (i = 0; i < ATA_SECT_SIZE; i++)
 		csum += buf[i];
 	if (csum)
-		ata_dev_printk(dev, KERN_WARNING,
+		ata_dev_printk(dev, ATA_MSG_WARN,
 			       "invalid checksum 0x%x on log page 10h\n", csum);
 
 	if (buf[0] & 0x80)
@@ -931,7 +933,7 @@ static unsigned int atapi_eh_request_sen
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
-	DPRINTK("ATAPI request sense\n");
+	ata_port_printk(ap, ATA_MSG_DEBUG, "ATAPI request sense\n");
 
 	ata_tf_init(dev, &tf);
 
@@ -1048,13 +1050,13 @@ static void ata_eh_analyze_ncq_error(str
 	/* okay, this error is ours */
 	rc = ata_eh_read_log_10h(dev, &tag, &tf);
 	if (rc) {
-		ata_port_printk(ap, KERN_ERR, "failed to read log page 10h "
+		ata_port_printk(ap, ATA_MSG_ERR, "failed to read log page 10h "
 				"(errno=%d)\n", rc);
 		return;
 	}
 
 	if (!(ap->sactive & (1 << tag))) {
-		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
+		ata_port_printk(ap, ATA_MSG_ERR, "log page 10h reported "
 				"inactive tag %d\n", tag);
 		return;
 	}
@@ -1247,7 +1249,7 @@ static int ata_eh_speed_down(struct ata_
 	if (ata_down_xfermask_limit(dev, 0) == 0)
 		return ATA_EH_SOFTRESET;
 
-	ata_dev_printk(dev, KERN_ERR,
+	ata_dev_printk(dev, ATA_MSG_ERR,
 		       "speed down requested but no transfer mode left\n");
 	return 0;
 }
@@ -1273,7 +1275,8 @@ static void ata_eh_autopsy(struct ata_po
 	u32 serror;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
+
 
 	/* obtain and analyze SError */
 	rc = sata_scr_read(ap, SCR_ERROR, &serror);
@@ -1348,7 +1351,7 @@ static void ata_eh_autopsy(struct ata_po
 	ehc->i.dev = failed_dev;
 	ehc->i.action = action;
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -1389,19 +1392,19 @@ static void ata_eh_report(struct ata_por
 		frozen = " frozen";
 
 	if (ehc->i.dev) {
-		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
+		ata_dev_printk(ehc->i.dev, ATA_MSG_ERR, "exception Emask 0x%x "
 			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
 			       ehc->i.err_mask, ap->sactive, ehc->i.serror,
 			       ehc->i.action, frozen);
 		if (desc)
-			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
+			ata_dev_printk(ehc->i.dev, ATA_MSG_ERR, "(%s)\n", desc);
 	} else {
-		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
+		ata_port_printk(ap, ATA_MSG_ERR, "exception Emask 0x%x "
 				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
 				ehc->i.err_mask, ap->sactive, ehc->i.serror,
 				ehc->i.action, frozen);
 		if (desc)
-			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
+			ata_port_printk(ap, ATA_MSG_ERR, "(%s)\n", desc);
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
@@ -1410,7 +1413,7 @@ static void ata_eh_report(struct ata_por
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
 
-		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
+		ata_dev_printk(qc->dev, ATA_MSG_ERR, "tag %d cmd 0x%x "
 			       "Emask 0x%x stat 0x%x err 0x%x (%s)\n",
 			       qc->tag, qc->tf.command, qc->err_mask,
 			       qc->result_tf.command, qc->result_tf.feature,
@@ -1484,7 +1487,7 @@ static int ata_eh_reset(struct ata_port 
 	if (prereset) {
 		rc = prereset(ap);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_port_printk(ap, ATA_MSG_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			return rc;
 		}
@@ -1504,7 +1507,7 @@ static int ata_eh_reset(struct ata_port 
 
 	/* did prereset() screw up?  if so, fix up to avoid oopsing */
 	if (!reset) {
-		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
+		ata_port_printk(ap, ATA_MSG_ERR, "BUG: prereset() requested "
 				"invalid reset type\n");
 		if (softreset)
 			reset = softreset;
@@ -1515,7 +1518,7 @@ static int ata_eh_reset(struct ata_port 
  retry:
 	/* shut up during boot probing */
 	if (verbose)
-		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+		ata_port_printk(ap, ATA_MSG_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
 	/* reset */
@@ -1532,7 +1535,7 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 
 		if (!reset) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_port_printk(ap, ATA_MSG_ERR,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
 			return -EINVAL;
@@ -1543,7 +1546,7 @@ static int ata_eh_reset(struct ata_port 
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_port_printk(ap, ATA_MSG_ERR,
 					"classification failed\n");
 			return -EINVAL;
 		}
@@ -1560,7 +1563,7 @@ static int ata_eh_reset(struct ata_port 
 		} else
 			type = "hard";
 
-		ata_port_printk(ap, KERN_WARNING,
+		ata_port_printk(ap, ATA_MSG_WARN,
 				"%sreset failed, retrying in 5 secs\n", type);
 		ssleep(5);
 
@@ -1597,7 +1600,8 @@ static int ata_eh_revalidate_and_attach(
 	unsigned long flags;
 	int i, rc = 0;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
+
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int action;
@@ -1644,7 +1648,7 @@ static int ata_eh_revalidate_and_attach(
 	if (rc)
 		*r_failed_dev = dev;
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 	return rc;
 }
 
@@ -1717,7 +1721,8 @@ static int ata_eh_recover(struct ata_por
 	struct ata_device *dev;
 	int down_xfermask, i, rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
+
 
 	/* prep for recovery */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1761,7 +1766,7 @@ static int ata_eh_recover(struct ata_por
 		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_port_printk(ap, ATA_MSG_ERR,
 					"reset failed, giving up\n");
 			goto out;
 		}
@@ -1829,7 +1834,7 @@ static int ata_eh_recover(struct ata_por
 	}
 
 	if (ata_port_nr_enabled(ap)) {
-		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
+		ata_port_printk(ap, ATA_MSG_WARN, "failed to recover some "
 				"devices, retrying in 5 secs\n");
 		ssleep(5);
 	} else {
@@ -1845,7 +1850,7 @@ static int ata_eh_recover(struct ata_por
 			ata_dev_disable(&ap->device[i]);
 	}
 
-	DPRINTK("EXIT, rc=%d\n", rc);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, rc=%d\n", __FUNCTION__, rc);
 	return rc;
 }
 

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

