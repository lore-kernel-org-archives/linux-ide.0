From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Date: Sat, 12 Feb 2005 20:47:15 -0200
Message-ID: <20050212224715.GA8249@ime.usp.br>
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from smtpout2.uol.com.br ([200.221.4.193]:2968 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261210AbVBLWrS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Feb 2005 17:47:18 -0500
Received: from dumont.rtb.ath.cx (unknown [200.221.104.251])
	by scorpion2.uol.com.br (Postfix) with ESMTP id 54075DE40
	for <linux-ide@vger.kernel.org>; Sat, 12 Feb 2005 20:47:17 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <20050212222104.GA1965@node1.opengeometry.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Feb 12 2005, William Park wrote:
> On Sat, Feb 05, 2005 at 08:45:58PM -0200, Rog?rio Brito wrote:
> > For some kernel versions (say, since 2.6.10 proper, all the 2.6.11-=
rc's,
> > some -mm trees and also -ac) I have been getting the message "irq 1=
0:
> > nobody cared!".
>=20
> Try 'acpi=3Dnoirq'.

Unfortunately, I have already tried that and I still get stack traces l=
ike
this one (this time, booted without any acpi-related option):

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 - -
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: QUANTUM FIREBALL CX13.0A, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020fb94>] probe_hwif+0x2f7/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 - -

I can provide any information that is necessary about my system to fix =
the
problem.

I just finished compiling kernel 2.6.11-rc3-mm2 and I will report back =
if
there is any difference.


Thank you very much for any help, Rog=E9rio.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
  Rog=E9rio Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
