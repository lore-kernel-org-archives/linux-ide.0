From: "Russell Howe" <rhowe@siksai.co.uk>
Subject: IDE/ATAPI timeouts & lost interrupts on alpha with 2.6.20.2
Date: Sat, 10 Mar 2007 22:56:43 +0000
Message-ID: <20070310225643.GB21407@xiao.rsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youju.siksai.co.uk ([87.127.14.180]:4722 "EHLO
	youju.siksai.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbXCJXjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 18:39:32 -0500
Received: from xiao.siksai.co.uk ([87.127.14.179] ident=rhowe)
	by youju.siksai.co.uk with smtp (Exim 4.50)
	id 1HQAUV-0000gG-EQ
	for linux-ide@vger.kernel.org; Sat, 10 Mar 2007 22:56:53 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Evening all,

I just built a 2.6.20.2 kernel for my alpha (a digital personal
workstation 500AU), and on bootup noticed the messages below, which took
a long time to print. There was no media in the CDROM, and there's
nothing else hanging off the IDE controller. The messages took several
minutes to appear, stalling the boot process.

Unrelated, no doubt, but the output from the init scripts doesn't seem
to have made it to the serial console, so I'm not sure what processes
were running at the time.

The last kernel I ran on this thing was 2.6.17.11, which I appreciate is
a long time ago, so if anyone could suggest a starting point for a
binary search to determine the change which caused this regression, I'm
all ears! Kernels take a while to build on this box, and I haven't got a
crosscompiling toolchain setup...

What's the best way to go about debugging this?

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[...]
CY82C693: IDE controller at PCI slot 0000:00:07.1
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
    ide0: BM-DMA at 0x9080-0x9087, BIOS settings: hda:pio, hdb:pio
PCI: Enabling device: (0000:00:07.2), cmd 47
CY82C693: port 0x01f0 already claimed by ide0
CY82C693: neither IDE port enabled (BIOS)
Probing IDE interface ide0...
hda: TOSHIBA CD-ROM XM-6202B, ATAPI CD/DVD-ROM drive
hda: IRQ probe failed (0xfffffffff73bfeea)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-cd: cmd 0x5a timed out
hda: lost interrupt
ide-cd: cmd 0x5a timed out
hda: lost interrupt
ide-cd: cmd 0x5a timed out
hda: lost interrupt
hda: ATAPI 32X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt

-- 
Russell Howe       | Why be just another cog in the machine,
rhowe@siksai.co.uk | when you can be the spanner in the works?
