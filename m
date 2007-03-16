From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Fri, 16 Mar 2007 22:30:58 +0800
Message-ID: <45FAAA22.7060000@tw.ibm.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:35651 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965287AbXCPObX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 10:31:23 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2GEVNmb013475
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 10:31:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2GEVM5c041634
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 08:31:22 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2GEVK3X001158
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 08:31:22 -0600
In-Reply-To: <45F9C4B2.20906@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
> 
>> Mark Lord wrote:
>>
>>> Really?  I didn't notice when libata gained ATAPI-disk support.
>>>
>>> Are you *sure* about that??
>>
>>
>> Not sure sure but almost sure.  :-)  What ide-scsi does is borrowing
>> SCSI mid and high level drivers while using ide as SCSI low level
>> driver.  To SCSI, libata and ide-scsi aren't very different except that
>> libata also exports SBC device to it.  So, if SCSI could handle ATAPI
>> disk via ide-scsi, I don't think there is any reason it can't with
>> libata.
> 
> 
> Okay, I dusted off one of my old (actually, I believe *the oldest*)
> Zip100 drives in the collection, and tried it out here with both
> 2.6.20 and 2.6.21-rc3-git9.   It works mostly fine with each.
> 
> A couple of minor issues, though.
> 
> (1) When ejecting a disk, either with the "eject /dev/sdc" command
> or using the front-panel soft-eject button on the drive,
> I get the following in syslog from libata:
> 
> sdc: Spinning up disk...<3>ata4.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2
>         res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata4: soft resetting port
> ATA: abnormal status 0x7F on port 0x00010177
> ATA: abnormal status 0x7F on port 0x00010177
> ata4.00: configured for PIO2
> ata4: EH complete

The device status of 0x00 looks strange.
Could you please apply the attached debugging patch for 
clue about what caused the HSM violation, thanks.

> 
> 
> (2) The above log says PIO2, but the IDENTIFY data for this drive,
> which I had to patch the kernel to get (ATAPI ATA_16 support),
> indicates max PIO0 for this unit.  I suppose maybe the chipset
> doesn't go that low, but no big deal since IORDY handshakes it anyway.
> 

I saw this strange behavior, too.
The Promise BIOS identified my zip 100 drive as "PIO 0" during boot,
but libata identified it as "PIO2":

ata4.00: ATAPI, max PIO2, CDB intr
ata4.00: configured for PIO2

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

