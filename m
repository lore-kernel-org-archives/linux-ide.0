From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [Fwd: promise-sata-pata, No release code PATA port on Promise
 PDC20579, TODO?]
Date: Tue, 26 Jun 2007 20:40:25 +0200
Message-ID: <46815D99.3050301@gmx.de>
References: <4555C0B0.1020608@gmx.de> <45579B4D.2010303@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757337AbXFZSk2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 14:40:28 -0400
In-Reply-To: <45579B4D.2010303@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

thomas schorpp wrote:
> thomas schorpp wrote:
>>
>> ------------------------------------------------------------------------
>>
>> Subject:
>> promise-sata-pata, No release code PATA port on Promise PDC20579, TODO?
>> From:
>> thomas schorpp <t.schorpp@gmx.de>
>> Date:
>> Fri, 10 Nov 2006 14:41:53 +0100
>> To:
>> Linux SCSI list <linux-scsi@vger.kernel.org>
>>
>> To:
>> Linux SCSI list <linux-scsi@vger.kernel.org>
>>
>>
>> hi,
>>
>> got a msi neo-2 fir now, cause nforce4 is incompatible with scsi+2xdvb 
>> on its pci.
>>
>> like to use the PATA port of PDC20579 SATA II 150.
>>
>> pls list TODOs and outstanding issues blocking the release.
>>
>> some testcases for me?
>>
>> y
>> tom
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> no support at all for this chip's PATA in libata-dev.git:
> 
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 21
> ata1: SATA max UDMA/133 cmd 0xE0EE4200 ctl 0xE0EE4238 bmdma 0x0 irq 21
> ata2: SATA max UDMA/133 cmd 0xE0EE4280 ctl 0xE0EE42B8 bmdma 0x0 irq 21
> scsi1 : sata_promise
> ata1: SATA link down (SStatus 0 SControl 300)
> scsi2 : sata_promise
> ata2: SATA link down (SStatus 0 SControl 300)
>     sata_promise: loaded successfully
>     ohci1394: already loaded
>     ata_generic: loaded successfully
>     pata_via: loaded successfully
> 
> but it is mentioned in source, some hints to enable it, pls.
> 
> thx,
> y
> tom
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

thx for releasing (missed it), it's working, done great:

libata version 2.20 loaded.
sata_promise 0000:00:0d.0: version 2.00
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xffffc20000022200 ctl 0xffffc20000022238 
bmdma 0x0000000000000000 irq 17
ata2: SATA max UDMA/133 cmd 0xffffc20000022280 ctl 0xffffc200000222b8 
bmdma 0x0000000000000000 irq 17
ata3: PATA max UDMA/133 cmd 0xffffc20000022300 ctl 0xffffc20000022338 
bmdma 0x0000000000000000 irq 17
scsi1 : sata_promise

ata1: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_promise

ata3.00: ATA-6: ST3120026A, 8.01, max UDMA/100
ata3.00: 234441648 sectors, multi 0: LBA48
ata3.00: configured for UDMA/100
scsi 3:0:0:0: Direct-Access     ATA      ST3120026A       8.01 PQ: 0 ANSI: 5
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdb: sdb1 sdb2
sd 3:0:0:0: Attached scsi disk sdb
sd 3:0:0:0: Attached scsi generic sg1 type 0

smartmontools and hddtemp are working, too.

i'll report if any issues or regression.

y
tom

