From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] libata: rename host states
Date: Tue, 27 Sep 2005 17:36:35 +0800
Message-ID: <433912A3.4010502@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com> <4339116D.30908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040007010303060701000706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:56280 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964881AbVI0Jgm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Sep 2005 05:36:42 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8R9ZF4S014712
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 05:35:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8R9aZrJ440164
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:36:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8R9aYFd006283
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:36:35 -0600
In-Reply-To: <4339116D.30908@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------040007010303060701000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 2/4: rename host states/variables

Changes:
s/PIO_ST_/HSM_ST_/ and s/pio_task_state/hsm_task_state/.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------040007010303060701000706
Content-Type: text/plain;
 name="idpio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio2.diff"

--- id1/include/linux/libata.h	2005-09-26 14:08:20.000000000 +0800
+++ id2/include/linux/libata.h	2005-09-26 14:23:20.000000000 +0800
@@ -156,15 +156,15 @@ enum {
 	ATA_SHIFT_PIO		= 11,
 };
 
-enum pio_task_states {
-	PIO_ST_UNKNOWN,
-	PIO_ST_IDLE,
-	PIO_ST_POLL,
-	PIO_ST_TMOUT,
-	PIO_ST,
-	PIO_ST_LAST,
-	PIO_ST_LAST_POLL,
-	PIO_ST_ERR,
+enum hsm_task_states {
+	HSM_ST_UNKNOWN,
+	HSM_ST_IDLE,
+	HSM_ST_POLL,
+	HSM_ST_TMOUT,
+	HSM_ST,
+	HSM_ST_LAST,
+	HSM_ST_LAST_POLL,
+	HSM_ST_ERR,
 };
 
 /* forward declarations */
@@ -319,7 +319,7 @@ struct ata_port {
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
-	unsigned int		pio_task_state;
+	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
--- id1/drivers/scsi/libata-core.c	2005-09-26 14:11:03.000000000 +0800
+++ id2/drivers/scsi/libata-core.c	2005-09-26 14:25:15.000000000 +0800
@@ -2425,20 +2425,20 @@ void ata_poll_qc_complete(struct ata_que
 static unsigned long ata_pio_poll(struct ata_port *ap)
 {
 	u8 status;
-	unsigned int poll_state = PIO_ST_UNKNOWN;
-	unsigned int reg_state = PIO_ST_UNKNOWN;
-	const unsigned int tmout_state = PIO_ST_TMOUT;
-
-	switch (ap->pio_task_state) {
-	case PIO_ST:
-	case PIO_ST_POLL:
-		poll_state = PIO_ST_POLL;
-		reg_state = PIO_ST;
+	unsigned int poll_state = HSM_ST_UNKNOWN;
+	unsigned int reg_state = HSM_ST_UNKNOWN;
+	const unsigned int tmout_state = HSM_ST_TMOUT;
+
+	switch (ap->hsm_task_state) {
+	case HSM_ST:
+	case HSM_ST_POLL:
+		poll_state = HSM_ST_POLL;
+		reg_state = HSM_ST;
 		break;
-	case PIO_ST_LAST:
-	case PIO_ST_LAST_POLL:
-		poll_state = PIO_ST_LAST_POLL;
-		reg_state = PIO_ST_LAST;
+	case HSM_ST_LAST:
+	case HSM_ST_LAST_POLL:
+		poll_state = HSM_ST_LAST_POLL;
+		reg_state = HSM_ST_LAST;
 		break;
 	default:
 		BUG();
@@ -2448,14 +2448,14 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			ap->pio_task_state = tmout_state;
+			ap->hsm_task_state = tmout_state;
 			return 0;
 		}
-		ap->pio_task_state = poll_state;
+		ap->hsm_task_state = poll_state;
 		return ATA_SHORT_PAUSE;
 	}
 
-	ap->pio_task_state = reg_state;
+	ap->hsm_task_state = reg_state;
 	return 0;
 }
 
@@ -2480,14 +2480,14 @@ static int ata_pio_complete (struct ata_
 	 * we enter, BSY will be cleared in a chk-status or two.  If not,
 	 * the drive is probably seeking or something.  Snooze for a couple
 	 * msecs, then chk-status again.  If still busy, fall back to
-	 * PIO_ST_POLL state.
+	 * HSM_ST_POLL state.
 	 */
 	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
 	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 		msleep(2);
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
-			ap->pio_task_state = PIO_ST_LAST_POLL;
+			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return 0;
 		}
@@ -2495,14 +2495,14 @@ static int ata_pio_complete (struct ata_
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
-		ap->pio_task_state = PIO_ST_ERR;
+		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	ap->pio_task_state = PIO_ST_IDLE;
+	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
 
@@ -2662,7 +2662,7 @@ static void ata_pio_sector(struct ata_qu
 	unsigned char *buf;
 
 	if (qc->cursect == (qc->nsect - 1))
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
@@ -2712,7 +2712,7 @@ static void __atapi_pio_bytes(struct ata
 	unsigned int offset, count;
 
 	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
@@ -2734,7 +2734,7 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ata_data_xfer(ap, (unsigned char*)pad_buf, 2, do_write);
 
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
 
@@ -2815,7 +2815,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
-	ap->pio_task_state = PIO_ST_ERR;
+	ap->hsm_task_state = HSM_ST_ERR;
 }
 
 /**
@@ -2837,14 +2837,14 @@ static void ata_pio_block(struct ata_por
 	 * a chk-status or two.  If not, the drive is probably seeking
 	 * or something.  Snooze for a couple msecs, then
 	 * chk-status again.  If still busy, fall back to
-	 * PIO_ST_POLL state.
+	 * HSM_ST_POLL state.
 	 */
 	status = ata_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
 		msleep(2);
 		status = ata_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
-			ap->pio_task_state = PIO_ST_POLL;
+			ap->hsm_task_state = HSM_ST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return;
 		}
@@ -2856,7 +2856,7 @@ static void ata_pio_block(struct ata_por
 	if (is_atapi_taskfile(&qc->tf)) {
 		/* no more data to transfer or unsupported ATAPI command */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_LAST;
+			ap->hsm_task_state = HSM_ST_LAST;
 			return;
 		}
 
@@ -2864,7 +2864,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_ERR;
+			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
 
@@ -2884,7 +2884,7 @@ static void ata_pio_error(struct ata_por
 	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
 	       ap->id, drv_stat);
 
-	ap->pio_task_state = PIO_ST_IDLE;
+	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
 }
@@ -2899,25 +2899,25 @@ fsm_start:
 	timeout = 0;
 	qc_completed = 0;
 
-	switch (ap->pio_task_state) {
-	case PIO_ST_IDLE:
+	switch (ap->hsm_task_state) {
+	case HSM_ST_IDLE:
 		return;
 
-	case PIO_ST:
+	case HSM_ST:
 		ata_pio_block(ap);
 		break;
 
-	case PIO_ST_LAST:
+	case HSM_ST_LAST:
 		qc_completed = ata_pio_complete(ap);
 		break;
 
-	case PIO_ST_POLL:
-	case PIO_ST_LAST_POLL:
+	case HSM_ST_POLL:
+	case HSM_ST_LAST_POLL:
 		timeout = ata_pio_poll(ap);
 		break;
 
-	case PIO_ST_TMOUT:
-	case PIO_ST_ERR:
+	case HSM_ST_TMOUT:
+	case HSM_ST_ERR:
 		ata_pio_error(ap);
 		return;
 	}
@@ -3360,7 +3360,7 @@ int ata_qc_issue_prot(struct ata_queued_
 	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
 		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST;
+		ap->hsm_task_state = HSM_ST;
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
@@ -3806,7 +3806,7 @@ static void atapi_packet_task(void *_dat
 		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
 		/* PIO commands are handled by polling */
-		ap->pio_task_state = PIO_ST;
+		ap->hsm_task_state = HSM_ST;
 		queue_work(ata_wq, &ap->pio_task);
 	}
 

--------------040007010303060701000706--

