From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Fri, 16 Mar 2007 01:57:55 +0800
Message-ID: <45F98923.1040601@tw.ibm.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:44834 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbXCOR6E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 13:58:04 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2FHw12S026586
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 13:58:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2FHw0eX066484
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 11:58:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2FHw0Pl006474
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 11:58:00 -0600
In-Reply-To: <45F9516D.4090008@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Tejun Heo wrote:
> 
>> [cc'ing Albert Lee.  Hi!]
>>
>> Vlad Codrea wrote:
>>  
>>
>>>> Okay, now that you're on libata driver, it's easier for me to debug.
>>>> Can you apply the attached patch over 2.6.20 and report what the kernel
>>>> says? (the patch will apply with some noise, it's okay)
>>>>       
>>>
>>> I've applied your patch and recompiled the kernel, but the new dmesg
>>> (attached as dmesg_2.txt) doesn't seem to have changed much.
>>>     
>>
>>
>> Hmmm.. that's weird, can you please try the attached patch?
>>
>> Albert, can you take a look at this one?  I'm pretty sure you know much
>> better about this than me.  The whole thread can be read at...
>>
>>   http://thread.gmane.org/gmane.linux.ide/17052
>>
>> Thanks.
>>
>>  
> 
> 
> I've attached the dmesg after applying this patch. There is now a new
> line reading "ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58".
> 

This device is configured as MWDMA2:
  ata2.00: ATAPI, max MWDMA2, CDB intr
  ata2.00: configured for MWDMA2 
The state machine should start at HSM_ST_FIRST to transfer CDB then
transit to HSM_ST_LAST after DMA is completed.

Device status 0x58 looks good for HSM_ST_FIRST, maybe libata is
seeing 0x58 in the HSM_ST_LAST state?

Hi Vlad,

Could you please also apply the attached HSM debug patch and collect the dmesg,
thanks.

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




