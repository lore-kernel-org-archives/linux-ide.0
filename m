From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Tue, 27 Mar 2007 13:13:08 +0900
Message-ID: <460899D4.6070708@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:32011 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933962AbXC0ENR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 00:13:17 -0400
Received: by ik-out-1112.google.com with SMTP id c21so1987877ika
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 21:13:15 -0700 (PDT)
In-Reply-To: <460896D8.8040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Mat=ED=ADas Alejandro Torres wrote:
>=20
>> Can you try with kernel parameter 'acpi=3Dnoirq' or 'irqpoll'?
> I made a typo when passing the irqpoll parameter to the kernel. In=20
> kernel 2.6.20.4 with the irqpoll parameter passewd to kernel the SATA=
=20
> disk works:
>=20
> [    1.320000] ide: Assuming 33MHz system bus speed for PIO modes;=20
> override with idebus=3Dxx
> [    1.320000] ahci 0000:00:12.0: version 2.0
> [    1.320000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,=20
> low) -> IRQ 16
> [    2.324000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 G=
bps=20
> 0xf impl SATA mode
> [    2.324000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pm=
p=20
> pio slum part
> [    2.324000] ata1: SATA max UDMA/133 cmd 0xF8824D00 ctl 0x0 bmdma 0=
x0=20
> irq 222
> [    2.324000] ata2: SATA max UDMA/133 cmd 0xF8824D80 ctl 0x0 bmdma 0=
x0=20
> irq 222
> [    2.324000] ata3: SATA max UDMA/133 cmd 0xF8824E00 ctl 0x0 bmdma 0=
x0=20
> irq 222
> [    2.324000] ata4: SATA max UDMA/133 cmd 0xF8824E80 ctl 0x0 bmdma 0=
x0=20
> irq 222
> [    2.324000] scsi0 : ahci
> [    2.636000] ata1: SATA link down (SStatus 0 SControl 300)
> [    2.636000] scsi1 : ahci
> [    3.120000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    3.136000] ata2.00: ATA-7, max UDMA/133, 160836480 sectors: LBA48=
=20
> NCQ (depth 31/32)
> [    3.136000] ata2.00: ata2: dev 0 multi count 16
> [    3.144000] ata2.00: configured for UDMA/133
 >
[--snip--]
>=20
> Nice isn't it? I'm happy.

Me happy too.

> In the 2.6.21-rc5 version this hasn't worked (the typo was here too,=20
> copy, paste & destroy :P). Here's is the output of dmesg:

That's weird.  So, with irqpoll, 2.6.21-rc5 doesn't work while 2.6.20.4=
=20
does?  I looked through the changelog but nothing looks suspicious at=20
the first glance.

Can you try 'pci=3Dnomsi'?  At first, I though you weren't using MSI.  =
You=20
apparently are.

--=20
tejun
