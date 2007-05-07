From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 19:54:28 +0800
Message-ID: <463F1374.1010100@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com> <463ED8B9.4060501@gmail.com> <463F0B25.40103@tw.ibm.com> <463F0DAD.5060307@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:45277 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbXEGLyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 07:54:37 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l47BpIow017407
	for <linux-ide@vger.kernel.org>; Mon, 7 May 2007 07:51:18 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l47Bsa4N164872
	for <linux-ide@vger.kernel.org>; Mon, 7 May 2007 05:54:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l47BsZBx028892
	for <linux-ide@vger.kernel.org>; Mon, 7 May 2007 05:54:36 -0600
In-Reply-To: <463F0DAD.5060307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Hello, Albert.
> 
> Albert Lee wrote:
> 
>>Tejun Heo wrote:
>>
>>>Also, this is a problem for not only IDENTIFY but all polling commands.
>>
>>Yes, other command might also assert INTRQ during polling.
>>However, for the specific BENQ DW1620 drive, only IDENTIFY_PACKET_DEVICE
>>has such behavior; other commands like READ or REQUEST_SENSE are ok.
> 
> 
> Oh I see.
> 
> 
>>>One solution I can think of is to let IRQ handler ack IRQ
>>>unconditionally during polling commands - ie. just read the TF Status
>>>register once and tell the IRQ subsystem that the IRQ is handled.  This
>>>shouldn't affect the operation of polling as the only side effect of
>>>reading Status is clearing pending IRQ && will give us a nice way to
>>>deal with the SATA bridge chip which chokes on nIEN.  Considering the
>>>sorry state of nIEN in SATA, I guess this might be the best way to deal
>>>with this.
>>>
>>>Albert, can you please test whether this works?  Modifying
>>>ata_interrupt() such that it reads TF Status if ATA_TFLAG_POLLING should
>>>do the trick.
>>
>>Yes, reading the Status register and acking interrupt also fixes the
>>problem (patch attached below). 
> 
> 
> Good to know it works.  With or without nIEN, I think this change is a
> good thing to have.  IRQ handler shouldn't interfere with polling as
> both acquire lock during operation. 

This reminds me of a possible issue with the patch:
Previously the polling code assumes that the interrupt handler won't interfere
with it and the polling code runs without holding ap->lock.
However, with the above patch, the interrupt handler might read the
Status register when the polling code is transfering data, etc. from the port.
Would this cause trouble to the ATA/ATAPI devices?

Should we have something like ATA_PFLAG_HSM_BUSY below, such that the interrupt
handler won't read the Status register when HSM is busy accessing the port?

--
albert

(Revised patch: Don't read the Status register when HSM is busy accessing the port)

diff -Nrup linux-2.6.21.1-ori/drivers/ata/libata-core.c linux-2.6.21.1-mod3/drivers/ata/libata-core.c
--- linux-2.6.21.1-ori/drivers/ata/libata-core.c	2007-05-04 11:22:23.000000000 +0800
+++ linux-2.6.21.1-mod3/drivers/ata/libata-core.c	2007-05-07 19:17:58.000000000 +0800
@@ -4389,6 +4389,14 @@ int ata_hsm_move(struct ata_port *ap, st
 	 */
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
+	if (in_wq) {
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags |= ATA_PFLAG_HSM_BUSY;
+		spin_unlock_irqrestore(ap->lock, flags);
+	} else {
+		ap->pflags |= ATA_PFLAG_HSM_BUSY;
+	}
+
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
@@ -4600,6 +4608,14 @@ fsm_start:
 		BUG();
 	}
 
+	if (in_wq) {
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags &= ~ATA_PFLAG_HSM_BUSY;
+		spin_unlock_irqrestore(ap->lock, flags);
+	} else {
+		ap->pflags &= ~ATA_PFLAG_HSM_BUSY;
+	}
+
 	return poll_next;
 }
 
@@ -5224,9 +5240,14 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
-			    (qc->flags & ATA_QCFLAG_ACTIVE))
-				handled |= ata_host_intr(ap, qc);
+			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
+				if (!(qc->tf.flags & ATA_TFLAG_POLLING)) {
+					handled |= ata_host_intr(ap, qc);
+				} else if (!(ap->pflags & ATA_PFLAG_HSM_BUSY)) {
+					ata_chk_status(ap);
+					handled = 1;
+				}
+			}
 		}
 	}
 
diff -Nrup linux-2.6.21.1-ori/include/linux/libata.h linux-2.6.21.1-mod3/include/linux/libata.h
--- linux-2.6.21.1-ori/include/linux/libata.h	2007-04-28 05:49:26.000000000 +0800
+++ linux-2.6.21.1-mod3/include/linux/libata.h	2007-05-07 18:41:01.000000000 +0800
@@ -195,6 +195,7 @@ enum {
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
+	ATA_PFLAG_HSM_BUSY	= (1 << 19), /* HSM accessing the port */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */






