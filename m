From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Thu, 15 Mar 2007 12:29:22 +0800
Message-ID: <45F8CBA2.60204@tw.ibm.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com>	 <45F80841.EMEA5.EMEA5-1.100.1396E6E.1.3873.1@1:7.EMEA5.EMEA5-1.100.0.1.0.1@16> <1173904909.5181.16.camel@utx.utx.cz>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:40664 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965082AbXCOE3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 00:29:31 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2F4TU7Z030469
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 00:29:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2F4TUks067574
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 22:29:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2F4TTWu008462
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 22:29:30 -0600
In-Reply-To: <1173904909.5181.16.camel@utx.utx.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislav Brabec <sbrabec@novell.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, albertl@mail.com, jeff@garzik.org, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Stanislav Brabec wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>>On Wednesday 14 March 2007, Stanislav Brabec wrote:
>>
>>>Albert Lee wrote:
>>>
>>>>Tejun Heo wrote:
>>>
>>>>>Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
>>>>>don't think the low level driver is causing the difference.  They both
>>>>>use the standard libata HSM implementation.  Any ideas?  Stanislav, can
>>>>>you try to connect that zip drive to another IDE controller?
>>>
>>>>Maybe it's also worth a try to replace the medium, cable or even the
>>>>drive itself to rule out the possibility of hardware problem.
>>>
>>>I'll try it. I cannot replace the drive, I don't have any spare one, but
>>>my colleague has. He will try it on his machine. So let's wait for
>>>result.
>>>
>>>Looking at the syslog in Novell bug 232086 in detail, following line may
>>>indicate hardware failure:
>>>usb 5-1: string descriptor 0 read error: -22
>>>
>>>My drive is a slave on bus, where master is a modern Seagate ST3160812A.
>>>
>>>On my system I see two regressions:
> 
> 
>>It is reproduceable, SuSE 10.1 kernel is "good" and SuSE 10.2 is "bad".
>>So even if this is caused by some hardware problems or different
>>initialization order git-bisect on 2.6.16-2.6.20 should tell us what
>>change caused the problem.
> 
> 
> After more kernels testing I am inclined to suspect broken hardware.
> 
> 2.4.20 (SuSE 8.1) and newer kernels  exhibits this "DRQ isn't asserted"
> error. The latest kernel working without any problem is five years old
> 2.4.18 (SuSE 8.0).
> 
> In some older systems the delay was "hidden" somewhere in the boot
> process, now userspace processes repeatedly scan all media, which makes
> delay permanent.
> 

Hi Stanislav,

Could you apply the attached HSM debug patch and post the dmesg, thanks.
(Hopefully we can get some clue from the HSM trace.)

--
albert

--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-15 12:13:12.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/libata-core.c	2007-03-15 12:13:55.000000000 +0800
@@ -4371,8 +4371,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+	if (is_atapi_taskfile(&qc->tf))
+		printk(KERN_ERR "ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5091,8 +5092,9 @@ inline unsigned int ata_host_intr (struc
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+	if (is_atapi_taskfile(&qc->tf))
+		printk(KERN_ERR "ata%u: protocol %d task_state %d\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {




