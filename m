From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:30:56 +0000
Message-ID: <20100104173055.GE18335@flint.arm.linux.org.uk>
References: <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org> <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk> <4B421827.6050308@garzik.org> <20100104170236.5d85959f@lxorguk.ukuu.org.uk> <4B42251A.9030106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33680 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0ADRbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:31:09 -0500
Content-Disposition: inline
In-Reply-To: <4B42251A.9030106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 12:27:54PM -0500, Jeff Garzik wrote:
> On 01/04/2010 12:02 PM, Alan Cox wrote:
>>> (1b)  The solution for MMIO controllers is a bit more complex:  replace
>>> the dummy AltStatus register read with something else.
>>
>> If we had any SFF PATA controllers using MMIO. I can't find any. SATA is
>> different anyway. In fact we probably want to avoid such delays on a pure
>> SATA controller.
>
> Early SATA controllers are just PATA controllers in disguise.  All SFF  
> controllers want that 400ns delay.  The 400ns delay should -not- be 
> avoided.

Note that ICH5 SATA is SFF, which only offers non-MMIO addressing; the
change I made is running there just fine:

libata version 3.00 loaded.
pata_acpi 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
pata_acpi 0000:00:1f.1: setting latency timer to 64
pata_acpi 0000:00:1f.1: PCI INT A disabled
pata_acpi 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
pata_acpi 0000:00:1f.2: setting latency timer to 64
pata_acpi 0000:00:1f.2: PCI INT A disabled
input: PS/2 Logitech Mouse as /devices/platform/i8042/serio1/input/input3
ata_piix 0000:00:1f.1: version 2.13
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xd800 ctl 0xd400 bmdma 0xc800 irq 18
ata4: SATA max UDMA/133 cmd 0xd000 ctl 0xcc00 bmdma 0xc808 irq 18
ata4.00: ATA-7: MAXTOR STM3160811AS, 3.AAE, max UDMA/133
ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      MAXTOR STM316081 3.AA PQ: 0 ANSI: 5
sd 3:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
sd 3:0:0:0: [sda] Write Protect is off
sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 3:0:0:0: [sda] Attached SCSI disk


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
