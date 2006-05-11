From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Thu, 11 May 2006 15:20:05 +0800
Message-ID: <4462E5A5.2010703@tw.ibm.com>
References: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:19656 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965187AbWEKHUW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 03:20:22 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4B7KLHd027493
	for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 03:20:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4B7KIW8188708
	for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 01:20:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4B7KHVV010290
	for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 01:20:18 -0600
In-Reply-To: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dario Oliva <DOliva@ARCOIDE.COM>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

Dario Oliva wrote:
 
> Attached are some kernel messeges. I ran dmesg several times and
> appended the output to the attached file, so there may be some
> redudancy. However some of the commands or debug lines do appear to
> repeat themselves. As you requested, I changed "#undef ATA_DEBUG" to
> "#define ATA_DEBUG".
> 
> As far as the device is concerned, is an unreleased product of the
> company I work for. That's why I did not give a name, because we don't
> have an official name yet. But like I said, it is SATA, removalbe ATAPI.
> If you want/need more information let me know.
> 

Is the ATAPI device native SATA or PATA with some bridge chip used?

>From the log, some MODE SENSE did work at first: (So, seems not DMADIR problem.)

ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)  <= irq received. ATAPI DMA ok
sda: Write Protect is off

===============================================================

Later, irq lost for the following MODE SENSE command:

ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_scsi_error: ENTER              <= timeout. 
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1   <= device is still busy. The old EH doesn't reset the device.
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
====================================================================

After the timeout, the device is in BUSY state and can't handle any new commands.
That's why the "infinite loop" seen. (Tejun's new EH can reset the device and bring
it back to work.)

Don't know what caused the timeout. From the device status 0xd0, it seems
the device is waiting for something (maybe data transfer?). It is not irq lost
because the irq is not yet generated when the device status is still BUSY.

Is it possible to attach a protocol analyzer to the SATA cable
and check whether the ATAPI DMA data is actually transferred?
Could you also post the dmesg log with ATA_DEBUG for the working Intel/nVidia
adapter? Maybe we can find some clue by comparing the problematic 
MODE SENSE transation of both logs.

I've done minimal testing with my VIA VT6421 + ATAPI but unable to reproduce
the problem.

Thanks,

Albert

