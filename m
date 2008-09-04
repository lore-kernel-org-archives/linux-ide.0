From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG?] pata_marvell doesn't see ide on asus-p5q-pro m/b.
Date: Thu, 04 Sep 2008 11:56:09 +0200
Message-ID: <48BFB0B9.7050407@kernel.org>
References: <vIHEILms.1220518770.4586010.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44923 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbYIDJ5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 05:57:38 -0400
In-Reply-To: <vIHEILms.1220518770.4586010.pluto@agmk.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?UGF3ZcWCIFNpa29yYQ==?= <pluto@agmk.net>
Cc: linux-ide@vger.kernel.org

Pawe=C5=82 Sikora wrote:
> Hi,
>=20
> I have an asus-p5q pro m/b with two controllers:
>=20
> first, intel ich10 with 6 sata ports and 2 connected drives:
>=20
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SAT=
A
> AHCI Controller
>         Kernel driver in use: ahci
>         Kernel modules: ahci
>=20
> second, marvell chip with 2 sata ports and 1 ide slot.
>=20
> 03:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
> Controller (rev b2)
>         Kernel driver in use: ahci
>         Kernel modules: ide-pci-generic, pata_marvell, ahci, pata_acp=
i,
> ata_generic
>=20
> the ich10 part works fine and detects my disks,
> but the marvell part doesn't see my dvd writer connected
> to the ide slot. the marvell bios detects dvd correctlly,
> so it looks like a bug in pata_marvell module.
>=20
> here's fragment of dmesg:
>=20
> [    0.316653] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    0.317159] ata1.00: ATA-7: WDC WD1600YD-01NVB1, 10.02E01, max UDM=
A/133
> [    0.317191] ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth =
1)
> [    0.463303] ata1.00: configured for UDMA/133
> [    0.369983] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    0.379975] ata2.00: ATA-7: WDC WD1600YD-01NVB1, 10.02E01, max UDM=
A/133
> [    0.379975] ata2.00: 321672960 sectors, multi 0: LBA48 NCQ (depth =
1)
> [    0.733285] ata2.00: configured for UDMA/133
> [    0.413314] ata3: SATA link down (SStatus 0 SControl 300)
> [    0.456644] ata4: SATA link down (SStatus 0 SControl 300)
> [    0.509975] ata5: SATA link down (SStatus 0 SControl 300)
> [    0.553304] ata6: SATA link down (SStatus 0 SControl 300)
> [    0.383308] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600YD-=
01N
> 10.0 PQ: 0 ANSI: 5
> [    0.383308] scsi 1:0:0:0: Direct-Access     ATA      WDC WD1600YD-=
01N
> 10.0 PQ: 0 ANSI: 5
> [    0.383308] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, =
low)
> -> IRQ 16
> [    0.383308] ahci 0000:03:00.0: controller can't do NCQ, turning of=
f
> CAP_NCQ
> [    0.383308] ahci 0000:03:00.0: MV_AHCI HACK: port_map 7 -> 3
> [    0.403330] ahci 0000:03:00.0: AHCI 0001.0000 32 slots 3 ports 3 G=
bps
> 0x3 impl IDE mode
> [    0.403367] ahci 0000:03:00.0: flags: 64bit stag led pmp slum part
> [    0.403401] PCI: Setting latency timer of device 0000:03:00.0 to 6=
4
> [    0.403543] scsi6 : ahci
> [    0.403697] scsi7 : ahci
> [    0.403846] scsi8 : ahci
> [    0.403935] ata7: SATA max UDMA/133 abar m1024@0xfeaffc00 port
> 0xfeaffd00 irq 16
> [    0.403970] ata8: SATA max UDMA/133 abar m1024@0xfeaffc00 port
> 0xfeaffd80 irq 16
> [    0.404003] ata9: DUMMY
> [    0.519980] ata7: SATA link down (SStatus 0 SControl 300)
> [    0.563310] ata8: SATA link down (SStatus 0 SControl 300)
>=20
> i'm using the 2.6.25.16 modularized kernel.
> i can provide more info for debugging purposes if you want.

Does loading pata_marvell first fix the problem?


--=20
tejun
