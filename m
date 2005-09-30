From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] irq-pio: rename atapi_packet_task() and comments
Date: Fri, 30 Sep 2005 19:09:31 +0800
Message-ID: <433D1CEB.8080009@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050105040300080104070206"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54436 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030274AbVI3LJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:09:36 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UB9Sro023043
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:09:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UB9SZQ081452
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:09:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8UB9RED028067
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:09:28 -0400
In-Reply-To: <433D1BC7.6060301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------050105040300080104070206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 2/4: rename atapi_packet_task() and change comments

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------050105040300080104070206
Content-Type: text/plain;
 name="idpio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio2.diff"

--- id1/include/linux/libata.h	2005-09-30 17:49:24.000000000 +0800
+++ id2/include/linux/libata.h	2005-09-30 17:48:55.000000000 +0800
@@ -129,8 +129,8 @@ enum {
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* hueristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
-	ATA_TMOUT_CDB		= 30 * HZ,
-	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
+	ATA_TMOUT_DATAOUT	= 30 * HZ,
+	ATA_TMOUT_DATAOUT_QUICK	= 5 * HZ,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
@@ -319,7 +319,7 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
-	struct work_struct	packet_task;
+	struct work_struct	dataout_task;
 
 	struct work_struct	pio_task;
 	unsigned int		hsm_task_state;
--- id1/drivers/scsi/libata-core.c	2005-09-30 14:31:28.000000000 +0800
+++ id2/drivers/scsi/libata-core.c	2005-09-30 18:04:29.000000000 +0800
@@ -3416,7 +3416,7 @@ int ata_qc_issue_prot(struct ata_queued_
 			if (qc->tf.flags & ATA_TFLAG_WRITE) {
 				/* PIO data out protocol */
 				ap->hsm_task_state = HSM_ST_FIRST;
-				queue_work(ata_wq, &ap->packet_task);
+				queue_work(ata_wq, &ap->dataout_task);
 
 				/* send first data block by polling */
 			} else {
@@ -3440,7 +3440,7 @@ int ata_qc_issue_prot(struct ata_queued_
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			queue_work(ata_wq, &ap->packet_task);
+			queue_work(ata_wq, &ap->dataout_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -3452,7 +3452,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			queue_work(ata_wq, &ap->packet_task);
+			queue_work(ata_wq, &ap->dataout_task);
 		break;
 
 	default:
@@ -3952,20 +3952,21 @@ irqreturn_t ata_interrupt (int irq, void
 }
 
 /**
- *	atapi_packet_task - Write CDB bytes to hardware
- *	@_data: Port to which ATAPI device is attached.
+ *	ata_dataout_task - Write first data block to hardware
+ *	@_data: Port to which ATA/ATAPI device is attached.
  *
  *	When device has indicated its readiness to accept
- *	a CDB, this function is called.  Send the CDB.
- *	If DMA is to be performed, exit immediately.
- *	Otherwise, we are in polling mode, so poll
- *	status under operation succeeds or fails.
+ *	the data, this function sends out the CDB or 
+ *	the first data block by PIO.
+ *	After this, 
+ *	  - If polling, ata_pio_task() handles the rest.
+ *	  - Otherwise, interrupt handler takes over.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
 
-static void atapi_packet_task(void *_data)
+static void ata_dataout_task(void *_data)
 {
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
@@ -3978,7 +3979,7 @@ static void atapi_packet_task(void *_dat
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT))
 		goto err_out;
 
 	/* make sure DRQ is set */
@@ -4141,7 +4142,7 @@ static void ata_host_init(struct ata_por
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
-	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
+	INIT_WORK(&ap->dataout_task, ata_dataout_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)

--------------050105040300080104070206--

