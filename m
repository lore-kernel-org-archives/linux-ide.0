From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode) (resend: v0.22)
Date: Fri, 30 Sep 2005 13:37:47 +0200
Message-ID: <m3r7b6pz04.fsf@quimbies.gnus.org>
References: <20050930053600.F3B821CDD0@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quimbies.gnus.org ([80.91.231.2]:15571 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id S1751282AbVI3Ljn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:39:43 -0400
In-Reply-To: <20050930053600.F3B821CDD0@lns1058.lss.emc.com> (Brett Russ's
	message of "Fri, 30 Sep 2005 01:36:00 -0400 (EDT)")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>, Michael Madore <Michael.Madore@aslab.com>, Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, "Mr. Berkley Shands" <bshands@exegy.com>, Jim Edwards <jim@networkdesigning.com>, scott olson <scotto701@yahoo.com>

Brett Russ <russb@emc.com> writes:

> This is my libata compatible low level driver for the Marvell SATA
> family.  Currently it runs in DMA mode on a 6081 chip.

I've tried the new version of the driver on our Supermicro 6024H-T
server with the Marvell 88SX6081 8-port SATA controller.  There are
six disks in the server, if that makes any difference.

When booting up, the driver issued the following text:

sata_mv version 0.22
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 20
sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8922120 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8924120 bmdma 0x0 irq 20
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8926120 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8928120 bmdma 0x0 irq 20
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8932120 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8934120 bmdma 0x0 irq 20
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8936120 bmdma 0x0 irq 20
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8938120 bmdma 0x0 irq 20
ATA: abnormal status 0x80 on port 0xF892211C
ATA: abnormal status 0x80 on port 0xF892211C

At that point the machine freezes hard -- the SysRq key doesn't work. 

lspci -vxx output for the controller:

02:03.0 RAID bus controller: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
        Subsystem: Super Micro Computer Inc: Unknown device 6080
        Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at dd200000 (64-bit, non-prefetchable) [size=1M]
        I/O ports at 2000 [size=256]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [60] #07 [0030]
00: ab 11 81 60 17 03 b0 02 03 00 04 01 08 40 00 00
10: 04 00 20 dd 00 00 00 00 01 20 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 15 80 60
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00



-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen
