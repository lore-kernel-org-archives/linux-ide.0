From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 5/5] sil24:  make error_intr less verbose
Date: Thu, 17 Nov 2005 11:03:57 +0800
Message-ID: <437BF31D.8010600@tw.ibm.com>
References: <20051116080935.GE22807@htj.dyndns.org> <437B285C.8020809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:61571 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161089AbVKQDEM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Nov 2005 22:04:12 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAH34BYT025524
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 22:04:11 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAH35Sie062890
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 20:05:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAH34BXP028086
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 20:04:11 -0700
In-Reply-To: <437B285C.8020809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> sil24_error_intr is too verbose.  Shut it up.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> Index: work/drivers/scsi/sata_sil24.c
>> ===================================================================
>> --- work.orig/drivers/scsi/sata_sil24.c    2005-11-16
>> 17:05:19.000000000 +0900
>> +++ work/drivers/scsi/sata_sil24.c    2005-11-16 17:08:05.000000000 +0900
>> @@ -678,9 +678,9 @@ static void sil24_error_intr(struct ata_
>>      if (serror)
>>          writel(serror, port + PORT_SERROR);
>>  
>> -    printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
>> -           "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> -           ap->id, ap->port_no, slot_stat, irq_stat, cmd_err,
>> sstatus, serror);
>> +    DPRINTK("ata%u: error interrupt on port%d\n"
>> +        "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> +        ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus,
>> serror);
> 
> 
> Mild NAK.
> 
> I am grappling with this on AHCI too :)  This is because ATA_ERR is much
> more common on ATAPI, yes?
> 
> My preferred change would be
> 
>     if ((class != ATA_DEV_ATAPI) ||
>         (sil24_cmd_err > PORT_CERR_SDB))
>         printk()
> 
> so that truly uncommon errors are always printed, but users logs are not
> spammed.
> 
> Another option is to do
> 
>     if (ata_ratelimit())
>         printk()
> 

The "PIO error" messages from ata_pio_error() are also noisy for ATAPI devices.

Ex.
scsi278 : pata_pdc2027x
  Vendor: ASUS      Model: CRW-5232AS        Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 05
Attached scsi generic sg3 at scsi277, channel 0, id 0, lun 0,  type 5
ata1: PIO error, drv_stat 0x51  <==
  Vendor: BENQ      Model: DVD DD DW1620     Rev: B7T9
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata1: PIO error, drv_stat 0x51  <==
ata1: PIO error, drv_stat 0x51  <==
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi277, channel 0, id 0, lun 0
ata1: PIO error, drv_stat 0x51  <==
ata1: PIO error, drv_stat 0x51  <==
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi277, channel 0, id 1, lun 0
Attached scsi generic sg4 at scsi277, channel 0, id 1, lun 0,  type 5
ata1: PIO error, drv_stat 0x51  <==
ata1: PIO error, drv_stat 0x51  <==

Seven "PIO error" messages were logged during module loading simply
because the hot-plug scripts are reading mode page unsupported by the ATAPI devices.
These are not errors that needs much attention.

Could we print out the error only for the non-packet commands?
(as in the attached patch)

Another idea, maybe we should not print out the error message in ata_pio_error().
ata_pio_error() doesn't have enough information to tell trivial errors from severe errors.
How about moving the prink() to the complete functions or EH?

Albert

==========

--- linux/drivers/scsi/libata-core.c	2005-11-17 10:08:02.000000000 +0800
+++ pio_err_msg/drivers/scsi/libata-core.c	2005-11-17 10:26:18.000000000 +0800
@@ -3212,11 +3212,12 @@ static void ata_pio_error(struct ata_por
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	if (qc->tf.command != ATA_CMD_PACKET)
+		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);




