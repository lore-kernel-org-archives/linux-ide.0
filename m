From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Sat, 17 Mar 2007 01:21:08 +0800
Message-ID: <45FAD204.2060700@tw.ibm.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com> <45FAB418.2070402@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:43534 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965711AbXCPRV3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 13:21:29 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2GHJs9c030814
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 13:19:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2GHLS0f062272
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 11:21:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2GHLRdP020874
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 11:21:28 -0600
In-Reply-To: <45FAB418.2070402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Albert Lee wrote:
> 
>> Could you please apply the attached debugging patch for clue about
>> what caused the HSM violation, thanks.
> 
> 
> I had to edit the patch to get it to apply on 2.6.21-rc3-git9,
> but here (attached) is the output from syslog.
> 
> zip_insert.txt :: response to inserting a disc into the drive.
> zip_button.txt :: response to pressing the eject button.
> zip_eject.txt  :: response to using "eject /dev/sdc".
> 
> Enjoy!
> 
> 
> ------------------------------------------------------------------------
> 
> 11:08:57: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
> 11:08:57:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> 11:08:57: ata4: soft resetting port
> 11:08:57: ATA: abnormal status 0x7F on port 0x00010177
> 11:08:57: ATA: abnormal status 0x7F on port 0x00010177
> 11:08:58: ata4.00: configured for PIO2
> 11:08:58: ata4: EH complete

Thanks for this good clue.

<3>ata port 1: protocol 6 task_state 4
11:08:57:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)

>From the trace, the zip 100 drive clears BSY and raises irq to tell libata
when it is ready to transfer the CDB. However, the DRQ is not set yet. The status
0x00 causes libata HSM violation.

Maybe we can wait a moment and give the slow ATAPI devices some time to set DRQ.
Could you please try if the attached patch works, thanks.
--
albert

--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-15 18:03:27.000000000 +0800
+++ linux-2.6.20.3-mod2/drivers/ata/libata-core.c	2007-03-17 01:12:53.000000000 +0800
@@ -4384,6 +4384,19 @@ fsm_start:
 		 */
 		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
 
+		/* wait for some slow ATAPI devices to set DRQ */
+		if (unlikely((status & ATA_DRQ) == 0) &&
+		    is_atapi_taskfile(&qc->tf)) {
+			int max = 100;
+
+			do {
+				udelay(10);
+				status = ata_chk_status(ap);
+				max--;
+				ata_port_printk(ap, KERN_ERR, "wait for DRQ %d\n", 100-max);	
+			} while (((status & ATA_DRQ) == 0) && (max > 0));
+		}
+
 		/* check device status */
 		if (unlikely((status & ATA_DRQ) == 0)) {
 			/* handle BSY=0, DRQ=0 as error */

