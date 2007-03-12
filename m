From: Jamie Clark <jclark@metaparadigm.com>
Subject: Re: Adaptec 1220SA (Sil3132) & sata_sil24 question
Date: Mon, 12 Mar 2007 21:37:34 +0800
Message-ID: <45F5579E.2020201@metaparadigm.com>
References: <45E65540.6090308@metaparadigm.com> <45F533F8.3050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moof.zeroth.org ([203.117.131.35]:62798 "EHLO moof.zeroth.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965570AbXCLNhq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 09:37:46 -0400
In-Reply-To: <45F533F8.3050401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
>
> James Clark wrote:
>   
>> sata_sil24 0000:04:00.0: version 0.3
>> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 32 (level, low) -> IRQ 32
>> PCI: Setting latency timer of device 0000:04:00.0 to 64
>> ata3: SATA max UDMA/100 cmd 0xFFFFC20012378000 ctl 0x0 bmdma 0x0 irq 32
>> ata4: SATA max UDMA/100 cmd 0xFFFFC2001237A000 ctl 0x0 bmdma 0x0 irq 32
>> scsi2 : sata_sil24
>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> ata3: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x0)
>>     
>
> But this is weird.  libata somehow thought the drive is a really old one
> and tried to do INIT_DEV_PARAMS on it.  Does this always happen?  Can
> you give a shot at 2.6.20 with your patch applied?
>   
Sure. 2.6.20.2 (with PCI ID patch) gives similar probe (below) with the 
Adaptec. I have a pair of newer Barracudas (320GB) with the 3.AA 
firmware on the mainboard sata_via controller and they don't give the 
INIT_DEV_PARAMS message. Would it be useful to try them on the Adapted 
SIL3132?

[snip]
sata_sil24 0000:04:00.0: version 0.3
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 32 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:04:00.0 to 64
ata1: SATA max UDMA/100 cmd 0xF8838000 ctl 0x0 bmdma 0x0 irq 21
ata2: SATA max UDMA/100 cmd 0xF883A000 ctl 0x0 bmdma 0x0 irq 21
scsi0 : sata_sil24
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : sata_sil24
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata2.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb

-Jamie
