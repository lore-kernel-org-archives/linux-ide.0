From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Fri, 01 Apr 2005 15:25:37 +0800
Message-ID: <424CF771.60508@tw.ibm.com>
References: <424CE03C.7020903@tw.ibm.com> <424CE1B4.10107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:25570 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262650AbVDAH0Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 02:26:24 -0500
In-Reply-To: <424CE1B4.10107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bruss@alum.wpi.edu
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>


Brett Russ wrote:

> Albert Lee wrote:
> 
>> -    printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
>> -           ap->id, drv_stat);
>> +    DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);
> 
> 
> You'd probably want this to stay a printk so it persists when ATA_DEBUG 
> is off, right?
> 
> BR

Hi Brett,

The problem is ata_pio_error() doesn't know whether the error condition is normal or not.
Only the caller that issued the command knows what's going on.
Please see the attached dmesg for an example.
If we print out error message each time ata_pio_error() is called, it might be too noisy.

Albert
============================================================================================================
Mar 31 18:57:28 linux kernel: libata version 1.10 loaded.
Mar 31 18:57:28 linux kernel: pata_pdc2027x version 0.58
Mar 31 18:57:28 linux kernel: pata_pdc2027x: PLL input clock 65552 kHz
Mar 31 18:57:28 linux kernel: ata1: PATA max UDMA/133 cmd 0xDE400 ctl 0xDDC02 bmdma 0xDEC00 irq 134
Mar 31 18:57:28 linux kernel: ata2: PATA max UDMA/133 cmd 0xDE800 ctl 0xDE002 bmdma 0xDEC08 irq 134
Mar 31 18:57:28 linux kernel: ata1: dev 0 cfg 49:0f00 82:4210 83:4000 84:4000 85:0000 86:0000 87:0000 88:0407
Mar 31 18:57:28 linux kernel: ata1: dev 0 ATAPI, max UDMA/33
Mar 31 18:57:29 linux kernel: ata1: PIO error, drv_stat 0x0    <== We have single master (dev 0) configuration here.
                                <== The error was caused by phantom slave device. (please ref ATA-4 9.16.1 and 8.9.5)
                                <== It is normal and the end users should not see this as error.
Mar 31 18:57:29 linux kernel: ata1: dev 0 configured for UDMA/33
Mar 31 18:57:29 linux kernel: scsi11 : pata_pdc2027x
Mar 31 18:57:29 linux kernel: ATA: abnormal status 0x8 on port 0xDE807
Mar 31 18:57:29 linux kernel: ata2: disabling port
Mar 31 18:57:29 linux kernel: scsi12 : pata_pdc2027x
Mar 31 18:57:29 linux kernel:   Vendor: IBM       Model: CD-RW 1234        Rev: 123
Mar 31 18:57:29 linux kernel:   Type:   CD-ROM                             ANSI SCSI revision: 05
Mar 31 18:57:29 linux kernel: Attached scsi generic sg3 at scsi11, channel 0, id 0, lun 0,  type 5
Mar 31 18:57:29 linux /etc/hotplug/scsi_generic.agent[22556]: cd: can't cd to /sys/class/scsi_generic/sg3/device/block
Mar 31 18:57:29 linux kernel: sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
Mar 31 18:57:29 linux kernel: Attached scsi CD-ROM sr0 at scsi11, channel 0, id 0, lun 0
Mar 31 18:57:29 linux /etc/hotplug/block.agent[22638]: new block device /block/sr0


