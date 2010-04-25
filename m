From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [bug ?] device reported invalid CHS sector 0 / NCQ disabled due
	to excessive errors
Date: Sun, 25 Apr 2010 11:27:42 -0600
Message-ID: <q2n51f3faa71004251027j5c554599lc5c7156535a4b3bc@mail.gmail.com>
References: <o2l80b317761004250816q17a14763g812d9fbe32d42f80@mail.gmail.com>
	 <4BD4721D.2090202@gmail.com>
	 <r2x80b317761004250957l66922ba3x3a52b16e800ddf26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:47411 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0DYR1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Apr 2010 13:27:43 -0400
In-Reply-To: <r2x80b317761004250957l66922ba3x3a52b16e800ddf26@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Apr 25, 2010 at 10:57 AM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> 2010/4/25 Robert Hancock <hancockrwd@gmail.com>:
>> Usually this sort of thing is some kind of hardware problem - either=
 a
>> firmware bug in the drive, or else a SATA link communication problem=
 like a
>> bad cable, or the drives not getting clean power under load.
> I'll try other sata cables, but I'm afraid, like you said, that it's =
a
> firmware bug...
>
>> The log is missing the detail messages indicating what actually happ=
ened -
>> can you post the output from dmesg instead?
> you're right, there's more informations in there :
>
> [ =A0 =A02.701742] ahci 0000:00:1f.2: version 3.0
> [ =A0 =A02.701751] =A0 alloc irq_desc for 21 on node 0
> [ =A0 =A02.701752] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.701756] ahci 0000:00:1f.2: PCI INT D -> GSI 21 (level, low=
) -> IRQ 21
> [ =A0 =A02.701826] =A0 alloc irq_desc for 35 on node 0
> [ =A0 =A02.701827] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.701833] ahci 0000:00:1f.2: irq 35 for MSI/MSI-X
> [ =A0 =A02.701855] ahci: SSS flag set, parallel bus scan disabled
> [ =A0 =A02.719878] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports=
 3
> Gbps 0x3f impl SATA mode
> [ =A0 =A02.719947] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm l=
ed
> clo pmp pio slum part ems
> [ =A0 =A02.720011] ahci 0000:00:1f.2: setting latency timer to 64
> [ =A0 =A02.819723] scsi0 : ahci
> [ =A0 =A02.819817] scsi1 : ahci
> [ =A0 =A02.819888] scsi2 : ahci
> [ =A0 =A02.819960] scsi3 : ahci
> [ =A0 =A02.820034] scsi4 : ahci
> [ =A0 =A02.820104] scsi5 : ahci
> [ =A0 =A02.820226] ata1: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7100 irq 35
> [ =A0 =A02.820288] ata2: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7180 irq 35
> [ =A0 =A02.820349] ata3: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7200 irq 35
> [ =A0 =A02.820411] ata4: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7280 irq 35
> [ =A0 =A02.820472] ata5: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7300 irq 35
> [ =A0 =A02.820534] ata6: SATA max UDMA/133 abar m2048@0xfbaf7000 port
> 0xfbaf7380 irq 35
> [ =A0 =A02.820630] ahci 0000:03:00.0: PCI INT A -> GSI 18 (level, low=
) -> IRQ 18
> [ =A0 =A02.839665] ahci 0000:03:00.0: AHCI 0001.0000 32 slots 2 ports=
 3
> Gbps 0x3 impl SATA mode
> [ =A0 =A02.839736] ahci 0000:03:00.0: flags: 64bit ncq led clo pmp pi=
o
> [ =A0 =A02.839787] ahci 0000:03:00.0: setting latency timer to 64
> [ =A0 =A02.839869] scsi6 : ahci
> [ =A0 =A02.839939] scsi7 : ahci
> [ =A0 =A02.840024] ata7: SATA max UDMA/133 abar m8192@0xfbdfa000 port
> 0xfbdfa100 irq 18
> [ =A0 =A02.840086] ata8: SATA max UDMA/133 abar m8192@0xfbdfa000 port
> 0xfbdfa180 irq 18
> [ =A0 =A03.348939] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
> [ =A0 =A03.366808] ata1.00: ATA-7: HDS728080PLA380, PF2OA60A, max UDM=
A/133
> [ =A0 =A03.366869] ata1.00: 160836480 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
> [ =A0 =A03.368030] ata1.00: configured for UDMA/133
> [ =A0 =A04.317329] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
> [ =A0 =A04.338405] ata2.00: ATA-7: HDS728080PLA380, PF2OA60A, max UDM=
A/133
> [ =A0 =A04.338466] ata2.00: 160836480 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
> [ =A0 =A04.339643] ata2.00: configured for UDMA/133
> [ =A0 =A05.285674] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
> [ =A0 =A05.305917] ata3.00: ATA-8: Hitachi HDP725050GLA360, GM4OA5CA,=
 max UDMA/133
> [ =A0 =A05.305979] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
> [ =A0 =A05.307132] ata3.00: configured for UDMA/133
> [ =A0 =A05.675046] ata4: SATA link down (SStatus 0 SControl 300)
> [ =A0 =A06.044399] ata5: SATA link down (SStatus 0 SControl 300)
> [ =A0 =A06.413775] ata6: SATA link down (SStatus 0 SControl 300)
=2E.

> [16840.450530] ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action =
0x6 frozen
> [16840.450535] ata1.00: cmd 61/b8:00:20:d5:8b/02:00:05:00:00/40 tag 0
> ncq 356352 out
> [16840.450536] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:4f:c2/00:01:00:00:0=
0/00 Emask
> 0x4 (timeout)
> [16840.450538] ata1.00: status: { DRDY }
> [16840.450541] ata1.00: cmd 61/80:08:99:bd:86/01:00:09:00:00/40 tag 1
> ncq 196608 out
> [16840.450542] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask
> 0x4 (timeout)
> [16840.450543] ata1.00: status: { DRDY }
> [16840.450546] ata1: hard resetting link
> [16840.978820] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [16840.981055] ata1.00: configured for UDMA/133
> [16840.981064] ata1.00: device reported invalid CHS sector 0
> [16840.981069] ata1.00: device reported invalid CHS sector 0
> [16840.981078] ata1: EH complete

Looks like it's only happening on one of the drives, I'd suspect
there's some kind of drive fault or power problem specific to that
one..
