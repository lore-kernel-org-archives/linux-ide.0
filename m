From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/15] libata: pass qc around intead of ap during PIO
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <1143971513609-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:5252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932311AbWDBJwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:05 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447008nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:05 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The current code passes pointer to ap around and repeatedly performs
ata_qc_from_tag() to access the ongoing qc.  This is unnatural and
makes EH synchronization cumbersome.  Make PIO codes deal with qc
instead of ap.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   71 ++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 45 deletions(-)

8065c890ce165cfde0fba6454be169be9fbb8151
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 169adad..551f078 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3411,7 +3411,7 @@ void ata_poll_qc_complete(struct ata_que
 
 /**
  *	ata_pio_poll - poll using PIO, depending on current state
- *	@ap: the target ata_port
+ *	@qc: qc in progress
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
@@ -3419,17 +3419,13 @@ void ata_poll_qc_complete(struct ata_que
  *	RETURNS:
  *	timeout value to use
  */
-
-static unsigned long ata_pio_poll(struct ata_port *ap)
+static unsigned long ata_pio_poll(struct ata_queued_cmd *qc)
 {
-	struct ata_queued_cmd *qc;
+	struct ata_port *ap = qc->ap;
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
 	case HSM_ST_POLL:
@@ -3463,7 +3459,7 @@ static unsigned long ata_pio_poll(struct
 
 /**
  *	ata_pio_complete - check if drive is busy or idle
- *	@ap: the target ata_port
+ *	@qc: qc to complete
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
@@ -3471,10 +3467,9 @@ static unsigned long ata_pio_poll(struct
  *	RETURNS:
  *	Non-zero if qc completed, zero otherwise.
  */
-
-static int ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete(struct ata_queued_cmd *qc)
 {
-	struct ata_queued_cmd *qc;
+	struct ata_port *ap = qc->ap;
 	u8 drv_stat;
 
 	/*
@@ -3495,9 +3490,6 @@ static int ata_pio_complete (struct ata_
 		}
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		qc->err_mask |= __ac_err_mask(drv_stat);
@@ -3833,15 +3825,14 @@ err_out:
 
 /**
  *	ata_pio_block - start PIO on a block
- *	@ap: the target ata_port
+ *	@qc: qc to transfer block for
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
  */
-
-static void ata_pio_block(struct ata_port *ap)
+static void ata_pio_block(struct ata_queued_cmd *qc)
 {
-	struct ata_queued_cmd *qc;
+	struct ata_port *ap = qc->ap;
 	u8 status;
 
 	/*
@@ -3863,9 +3854,6 @@ static void ata_pio_block(struct ata_por
 		}
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
 	/* check error */
 	if (status & (ATA_ERR | ATA_DF)) {
 		qc->err_mask |= AC_ERR_DEV;
@@ -3894,12 +3882,9 @@ static void ata_pio_block(struct ata_por
 	}
 }
 
-static void ata_pio_error(struct ata_port *ap)
+static void ata_pio_error(struct ata_queued_cmd *qc)
 {
-	struct ata_queued_cmd *qc;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
+	struct ata_port *ap = qc->ap;
 
 	if (qc->tf.command != ATA_CMD_PACKET)
 		printk(KERN_WARNING "ata%u: dev %u PIO error\n",
@@ -3917,7 +3902,8 @@ static void ata_pio_error(struct ata_por
 
 static void ata_pio_task(void *_data)
 {
-	struct ata_port *ap = _data;
+	struct ata_queued_cmd *qc = _data;
+	struct ata_port *ap = qc->ap;
 	unsigned long timeout;
 	int qc_completed;
 
@@ -3930,33 +3916,33 @@ fsm_start:
 		return;
 
 	case HSM_ST:
-		ata_pio_block(ap);
+		ata_pio_block(qc);
 		break;
 
 	case HSM_ST_LAST:
-		qc_completed = ata_pio_complete(ap);
+		qc_completed = ata_pio_complete(qc);
 		break;
 
 	case HSM_ST_POLL:
 	case HSM_ST_LAST_POLL:
-		timeout = ata_pio_poll(ap);
+		timeout = ata_pio_poll(qc);
 		break;
 
 	case HSM_ST_TMOUT:
 	case HSM_ST_ERR:
-		ata_pio_error(ap);
+		ata_pio_error(qc);
 		return;
 	}
 
 	if (timeout)
-		ata_port_queue_task(ap, ata_pio_task, ap, timeout);
+		ata_port_queue_task(ap, ata_pio_task, qc, timeout);
 	else if (!qc_completed)
 		goto fsm_start;
 }
 
 /**
  *	atapi_packet_task - Write CDB bytes to hardware
- *	@_data: Port to which ATAPI device is attached.
+ *	@_data: qc in progress
  *
  *	When device has indicated its readiness to accept
  *	a CDB, this function is called.  Send the CDB.
@@ -3967,17 +3953,12 @@ fsm_start:
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-
 static void atapi_packet_task(void *_data)
 {
-	struct ata_port *ap = _data;
-	struct ata_queued_cmd *qc;
+	struct ata_queued_cmd *qc = _data;
+	struct ata_port *ap = qc->ap;
 	u8 status;
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
-
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
@@ -4017,7 +3998,7 @@ static void atapi_packet_task(void *_dat
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
-		ata_port_queue_task(ap, ata_pio_task, ap, 0);
+		ata_port_queue_task(ap, ata_pio_task, qc, 0);
 	}
 
 	return;
@@ -4323,26 +4304,26 @@ unsigned int ata_qc_issue_prot(struct at
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
-		ata_port_queue_task(ap, ata_pio_task, ap, 0);
+		ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
+		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host(ap, &qc->tf);
-		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
+		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
+		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
 		break;
 
 	default:
-- 
1.2.4


