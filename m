From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Sat, 17 Mar 2007 12:43:22 +0800
Message-ID: <45FB71EA.7070602@tw.ibm.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu> <45FAC6FC.4020105@tw.ibm.com> <45FADD53.5030500@mail.utexas.edu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:55224 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbXCQEnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 00:43:35 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2H4hZrR025183
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 00:43:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2H4hYDE066300
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 22:43:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2H4hYx8006506
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 22:43:34 -0600
In-Reply-To: <45FADD53.5030500@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Albert Lee wrote:
> 
>> ata2: protocol 7 task_state 4   <=== The device interrupts to receive CDB
>> ata2: protocol 7 task_state 4 (dev_stat 0x58)  <== Good, DRQ seen. CDB
>> sent.
>> ata2: protocol 7 task_state 2   <=== interrupt. We expect DMA complete.
>> ata2: protocol 7 task_state 2 (dev_stat 0x58) <== What? DRQ set? No good.
>> ata2: protocol 7 task_state 3 (dev_stat 0x58) <== HSM violation.
>> (BMDMA stat 0x5) <=== Interrupted, DMA active.
>>
>> Still no clue why the device wrongly sets DRQ here for a DMA transfer...
>> Possibilities:
>> 1. HSM sent all CDB to the device, but the device is waiting for more
>> CDB data?
>> 2. HSM asked the drive to do ATAPI DMA, but the drive is doing PIO?
>>
>> Hi Vlad,
>>
>> Could you please turn off ATAPI DMA and see if the drive works under PIO,
>> thanks.
>>
>> -- 
>> albert
>>
>> (This is not a patch. Please edit drivers/ata/libata-core.c as below.)
>>
>> int ata_check_atapi_dma(struct ata_queued_cmd *qc)
>> {
>>     struct ata_port *ap = qc->ap;
>>     int rc = 0; /* Assume ATAPI DMA is OK by default */
>>
>>     if (ap->ops->check_atapi_dma)
>>         rc = ap->ops->check_atapi_dma(qc);
>>
>>  rc = 1; (<==== Please add "rc = 1;" here to turn off ATAPI DMA. )
>>
>>     return rc;
>> }
>>   
> 
> 
> Hi,
> 
> After adding "rc = 1;", the drive now appears as /dev/sr0. I've attached
> an annotated dmesg: the first part contains the messages immediately
> after booting. The second part contains messages after I inserted a CD
> and ran  "mount /dev/sr0 /root/cdrom". The third part contains messages
> after I ran "cp -r /root/cdrom /root/cdrom_copy". I separated the parts
> by adding lines containing "#####".
> 
> The recursive copy fails after about 10 seconds, even though a few files
> are copied.
> 

Ok, as Tejun said, PIO looks better than DMA, but still has problems.
Two problems seen:

> ata2: protocol 5 task_state 4
> ata2: protocol 5 task_state 4 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 2
> ata2: protocol 5 task_state 2
> ata2: protocol 5 task_state 2 (dev_stat 0x50)

1. The drive interrups when it is still BSY.

> ata2: protocol 5 task_state 4
> ata2: protocol 5 task_state 4 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x50)
> ata2: protocol 5 task_state 2 (dev_stat 0x50)
> ata2: protocol 5 task_state 4
> ata2: protocol 5 task_state 4 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 59392 bytes trailing data
> ata2: protocol 5 task_state 2
> ata2: protocol 5 task_state 2
> ata2: protocol 5 task_state 2 (dev_stat 0x58)
> ata2: protocol 5 task_state 3 (dev_stat 0x58)
> ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 79872 in
>          res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x2 (HSM violation)

2. The drive wants to transfer more data than expected.
   Libata transfers some of the trailing data. But when the drive asks
   to tranfer even more trailing data, libata forces it to stop by HSM violation.

> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ata2.00: qc timeout (cmd 0xa1)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs

3. After the HSM violation, the drive stays BSY after the EH resets it.
   It seems doesn't like the recovery actions and totally lost.

Could you please try the attached patch (together with the previous debug patches).
This patch let the drive transfer all of the trailing data it wants to.

The data transferred might be junk. So, please also verify the files copied.
(e.g. If the file copied from the CD is *.gz file, please do gunzip -tv foo.gz.)

--
albert

--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/libata-core.c	2007-03-17 12:16:36.000000000 +0800
@@ -4143,8 +4143,8 @@ static void __atapi_pio_bytes(struct ata
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->hsm_task_state = HSM_ST_LAST;
+	//if (qc->curbytes + bytes >= qc->nbytes)
+	//	ap->hsm_task_state = HSM_ST_LAST;
 
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
@@ -4166,7 +4166,7 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char*)pad_buf, 2, do_write);
 
-		ap->hsm_task_state = HSM_ST_LAST;
+		//ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
 

