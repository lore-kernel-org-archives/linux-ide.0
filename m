From: "Darrick Burch" <darrick@tuffmail.com>
Subject: Re: SB600 in AHCI mode will not run SATA optical drive
Date: Mon, 5 Jan 2009 21:42:12 -0500 (EST)
Message-ID: <7701.72.218.132.189.1231209732.squirrel@webmail.tuffmail.net>
References: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net>
    <4961A39C.30405@shaw.ca>
    <19325.72.218.132.189.1231202477.squirrel@webmail.tuffmail.net>
    <4962ADD2.3010007@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-03.mxes.net ([216.86.168.178]:4969 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZAFCmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 21:42:14 -0500
In-Reply-To: <4962ADD2.3010007@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

>> Robert Hancock wrote:
>>
>>> Could be some kind of SATA PHY quirk or incompatibility that only shows
>>> up in AHCI mode or something. It seems from the output that the SATA
>>> link may be going up and down. You could try forcing 1.5Gbps
>>> (libata.force=1.5Gbps if libata is built in, or force=1.5Gbps when the
>>> libata module gets loaded) and see if that helps.
>>
>> That appears to have done it--thanks!  I feel kinda bad now because I
>> was
>> suspecting a speed issue, but couldn't figure out how to force it.  If I
>> had read the kernel documentation a little more, I would have found the
>> kernel option you mentioned.  Duh.  At any rate, thanks again.
>

> Could be we need a quirk in libata for that drive to do that
> automatically, or something.. Can you post the dmesg output from bootup
> with the force 1.5Gbps option in place?

Robert:

I hope I got the part of the log that you're looking for.  If not, let me
know because there's more where that came from.  Anyway:

libata version 3.00 loaded.
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:14.1 to 64
scsi0 : pata_atiixp
scsi1 : pata_atiixp
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
ata1.00: ATA-6: WDC WD1600JB-00GVC0, 08.02D08, max UDMA/100
ata1.00: 312581808 sectors, multi 16: LBA48
ata1.01: ATA-6: WDC WD1600JB-00GVC0, 08.02D08, max UDMA/100
ata1.01: 312581808 sectors, multi 16: LBA48
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JB-00G 08.0 PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      WDC WD1600JB-00G 08.0 PQ: 0 ANSI: 5
ahci 0000:00:12.0: version 3.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl IDE mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata3: FORCE: PHY spd limit set to 1.5Gbps
ata3: SATA max UDMA/133 irq_stat 0x00000040 irq 22, connection status changed
ata4: FORCE: PHY spd limit set to 1.5Gbps
ata4: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ff980 irq 22
ata5: FORCE: PHY spd limit set to 1.5Gbps
ata5: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ffa00 irq 22
ata6: FORCE: PHY spd limit set to 1.5Gbps
ata6: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ffa80 irq 22
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATAPI: PIONEER BD-ROM  BDC-202, 1.07, max UDMA/66
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: configured for UDMA/66
ata4: SATA link down (SStatus 0 SControl 310)
ata5: SATA link down (SStatus 0 SControl 310)
ata6: SATA link down (SStatus 0 SControl 310)
scsi 2:0:0:0: CD-ROM            PIONEER  BD-ROM  BDC-202  1.07 PQ: 0 ANSI: 5

Oh, yeah, in case it matters: I'm running SuSE 11.0 with x86_64 kernel
2.6.25.18-0.2-default.

Thanks!
-Darrick

