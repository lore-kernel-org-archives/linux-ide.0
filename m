From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: How to debug CompactFlash card fails on PATA port of an SATA
 controller ?
Date: Wed, 17 May 2006 13:18:52 +0800
Message-ID: <446AB23C.7090308@tw.ibm.com>
References: <20060516081121.78840@gmx.net>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:22981 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932130AbWEQFSz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 01:18:55 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4H5ItOA012817
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 01:18:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4H5ItKh252490
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 23:18:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4H5It5k004149
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 23:18:55 -0600
In-Reply-To: <20060516081121.78840@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raphael Bossek <raphael.bossek@gmx.de>
Cc: linux-ide@vger.kernel.org

Raphael Bossek wrote:
> Hi,
> 
> I get the PATA interface of my Promise PDC40775 (SATA 300 TX2plus) working.
> But now I run into trouble while connecting a SimpleTech CompactFlash card
> SLCF512J2U-F (512MB). This are are the messages from log:
> 
> sata_promise 0000:00:0a.0: version 1.04
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 217       
> sata_promise PATA port found
> ata9: SATA max UDMA/133 cmd 0xBE9D0200 ctl 0xBE9D0238 bmdma 0x0 irq 217
> ata10: SATA max UDMA/133 cmd 0xBE9D0280 ctl 0xBE9D02B8 bmdma 0x0 irq 217
> sata_promiseDisabling SATA for third port
> ata11: PATA max UDMA/133 cmd 0xBE9D0300 ctl 0xBE9D0338 bmdma 0x0 irq 217
> ata9: SATA link down (SStatus 0)
> scsi8 : sata_promise
> ata10: SATA link down (SStatus 0)
> scsi9 : sata_promise
> ata11: dev 0 cfg 49:0300 82:7068 83:4004 84:4000 85:7068 86:0004 87:4000 88:0000
> ata11: dev 0 ATA-0, max MWDMA2, 1000944 sectors: LBA
> ata11: dev 0 configured for MWDMA2
> scsi10 : sata_promise
>   Vendor: ATA       Model: STI Flash 7.3.0   Rev: 06/1
>   Type:   Direct-Access                      ANSI SCSI revision: 05 
> SCSI device sdb: 1000944 512-byte hdwr sectors (512 MB) 
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 1000944 512-byte hdwr sectors (512 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb:<3>ata11: command timeout
> ata11: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata11: status=0xff { Busy }
> sd 10:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> Info fld=0xfffffff
> end_request: I/O error, dev sdb, sector 0
> Buffer I/O error on device sdb, logical block 0
> ata11: command timeout
> ata11: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata11: status=0xff { Busy }
> sd 10:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> Info fld=0xfffffff
> end_request: I/O error, dev sdb, sector 0
> Buffer I/O error on device sdb, logical block 0
>  unable to read partition table
> sd 10:0:0:0: Attached scsi disk sdb
> 
> How can I identify the real problem for this device ?
> 

It seems MWDMA2 is turned on for the CF device.
Some CF to IDE adapter doesn't like DMA. Maybe that's the problem.

For debug, could you please #define ATA_DEBUG and ATA_VERBOSE_DEBUG in
<linux/libata.h> and recompile the kernel for detailed log.

Thanks,

Albert


