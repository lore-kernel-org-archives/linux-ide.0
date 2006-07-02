From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 02 Jul 2006 12:32:40 +0200
Message-ID: <44A7A0C8.80108@free.fr>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306050305060706060604"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:24760 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750932AbWGBKcn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jul 2006 06:32:43 -0400
In-Reply-To: <44A78599.9060405@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------010306050305060706060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi Albert,
> 
> Albert Lee wrote:
> 
>> castet.matthieu@free.fr wrote:
>>
>>>
>>>> Could you please test the current libata-upstream tree and
>>>> turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>>>>
>>>
>>> Is there a easy way to get libata-upstream tree ?
>>> Do I need to install git for that or there are some snapshots 
>>> somewhere ?
>>>
>>>
>>
>>
>> Hi Matthieu,
>>
>> Tejun has a patch against 2.6.17:
>> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2 
>>
>>
> I don't know if I did someting wrong, but it didn't apply cleanly.
> So I enable the trace on lastest -mm kernel and I disable the via quirk.
> 
> But the printk in the interrupt handler takes some times and hides the 
> altstatus delay.
> 
> I will try to send you a trace, where I move the printk at the end of 
> the interrupt handler.
> 
> 
After apllying the following patch to -mm, I got 
http://castet.matthieu.free.fr/tmp/ata_log

Matthieu


--------------010306050305060706060604
Content-Type: text/plain;
 name="test_trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_trace"

Index: linux-2.6.16/drivers/scsi/libata-core.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/libata-core.c	2006-07-02 10:32:33.000000000 +0200
+++ linux-2.6.16/drivers/scsi/libata-core.c	2006-07-02 10:38:03.000000000 +0200
@@ -4722,9 +4722,6 @@
 {
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
-
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -4780,6 +4777,9 @@
 	ap->ops->irq_clear(ap);
 
 	ata_hsm_move(ap, qc, status, 0);
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
+
 	return 1;	/* irq handled */
 
 idle_irq:
@@ -4792,6 +4792,9 @@
 		return 1;
 	}
 #endif
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
+
 	return 0;	/* irq not handled */
 }
 
Index: linux-2.6.16/drivers/scsi/pata_via.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/pata_via.c	2006-07-01 19:38:41.000000000 +0200
+++ linux-2.6.16/drivers/scsi/pata_via.c	2006-07-01 19:38:54.000000000 +0200
@@ -324,7 +324,7 @@
 				continue;
 			if (!(qc->flags & ATA_QCFLAG_ACTIVE))
 				continue;
-			if (qc->tf.command == ATA_CMD_SET_FEATURES &&
+			if (0 && qc->tf.command == ATA_CMD_SET_FEATURES &&
 					qc->tf.feature == SETFEATURES_XFER) {
 				/*
 				 * With some ATAPI devices (CDR-6S48, ...), the
Index: linux-2.6.16/include/linux/libata.h
===================================================================
--- linux-2.6.16.orig/include/linux/libata.h	2006-07-01 19:37:51.000000000 +0200
+++ linux-2.6.16/include/linux/libata.h	2006-07-01 19:38:24.000000000 +0200
@@ -43,6 +43,8 @@
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
+#define ATA_DEBUG
+#define ATA_VERBOSE_DEBUG
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
 #define ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */

--------------010306050305060706060604--
