From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Thu, 16 Mar 2006 15:22:10 +0800
Message-ID: <44191222.6000609@tw.ibm.com>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com> <441838B6.8060900@rtr.ca> <44183CDA.5010407@rtr.ca> <44183FC7.3020401@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:30161 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752187AbWCPHWk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Mar 2006 02:22:40 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2G7MT7M028868
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 02:22:29 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2G7JZ4l260772
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 00:19:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2G7MRf8002098
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 00:22:28 -0700
In-Reply-To: <44183FC7.3020401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Mark Lord wrote:
> 
>> Albert Lee wrote:
>>
>>> Jeff Garzik wrote:
>>>
>>>> Applied, though I think its an open question what happens with
>>>> CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an
>>>> interrupt event that we clear, then life proceeds as normal.
> 
> 
> Oh yeah, from experience I know that the interrupt and DRQ bit
> are *NOT* synchronized with these devices.. I believe that the IRQ
> sometimes arrives early, and sometimes late.

Hmm, this will be a headache to handle.
The cd-rom vendors don't follow the sff-8020i spec. :(

1. Maybe adding some read status loops to the CDB-interrupt handler
when checking the DRQ bit can workaround this problem?
Hopefully the DRQ bit will be 1 after some loops,
otherwise the HSM will consider it as AC_ERR_HSM error.
(Need some testing to determine the actual loops time needed.)

> 
> Reading the ATA status reg after the IRQ always clears the IRQ,
> and is usually necessary for the transfer to continue.
> 
> The last time I did a full ATAPI driver, it used both periodic polling
> and an IRQ handler to wait for (DRQ && !BUSY).
> 

2. Similar to this idea is always use polling to send the ATAPI CDB
(as if there is no CDB interrupt). Then, in the irq handler,
whenever we see an CDB-irq in the HSM_ST_FIRST state,
we just check whether the device may assert CDB irq.
If yes, irq handler only acks the irq and let the polling thread do the
sending CDB work. (Please see the attached patch.)

Either #1 or #2 should workaround the DRQ/INTRQ not synchronized problem.
(#2 is more intrusive and not 100% pure irq driven.)

Thanks for the valuable AOpen CD-936E/CD-940E information.
Will try to get some of the drives from the computer components
store this weekend. More test to follow and see how current mainline
and irq-pio branch work with these drives.

--
Albert

Patch for #2: always use polling to send CDB.
There is a minor problem in the patch: In the HSM_ST_FIRST state, 
we no longer move the HSM forward (and make the device BSY) in the irq handler
=> So, the irq handler may be entered more than once in HSM_ST_FIRST state
(and status register read/irq acked more than once) until the polling thread
moves the HSM forward. But this seems doesn't hurt.

--- 07_followup/drivers/scsi/libata-core.c	2006-03-13 16:25:52.000000000 +0800
+++ 09_cdb_intr/drivers/scsi/libata-core.c	2006-03-16 14:17:06.000000000 +0800
@@ -3519,8 +3519,7 @@ static inline int ata_hsm_ok_in_wq(struc
 		    (qc->tf.flags & ATA_TFLAG_WRITE))
 		    return 1;
 
-		if (is_atapi_taskfile(&qc->tf) &&
-		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+		if (is_atapi_taskfile(&qc->tf))
 			return 1;
 	}
 
@@ -4106,10 +4105,9 @@ unsigned int ata_qc_issue_prot(struct at
 
 		ap->hsm_task_state = HSM_ST_FIRST;
 
-		/* send cdb by polling if no cdb interrupt */
-		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
-		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+		/* always send cdb by polling */
+		ata_port_queue_task(ap, ata_pio_task, ap, 0);
+
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -4119,9 +4117,9 @@ unsigned int ata_qc_issue_prot(struct at
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->hsm_task_state = HSM_ST_FIRST;
 
-		/* send cdb by polling if no cdb interrupt */
-		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+		/* always send cdb by polling */
+		ata_port_queue_task(ap, ata_pio_task, ap, 0);
+
 		break;
 
 	default:
@@ -4444,7 +4442,14 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status, 0);
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* ATAPI CDB interrupt. Let polling handle this. */
+		break;
+	default:
+		ata_hsm_move(ap, qc, status, 0);
+	}
+
 	return 1;	/* irq handled */
 
 idle_irq:

