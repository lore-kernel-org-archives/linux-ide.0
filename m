From: Daniel Brahneborg <daniel.com@wtnord.net>
Subject: Re: siimage and two nics (was: drive order problem)
Date: Fri, 26 Dec 2003 19:57:05 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031226195705.B4045@nettis.grimsta>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-141-193.v-by.wtnord.net ([212.214.141.193]:35727 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S265206AbTLZS5I
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Dec 2003 13:57:08 -0500
Content-Disposition: inline
In-Reply-To: <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org>; from heretic@clanhk.org on Fri, Dec 26, 2003 at 07:14:39AM -0600
List-Id: linux-ide@vger.kernel.org
To: Ryan Earl <heretic@clanhk.org>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-ide@vger.kernel.org

On Fri, Dec 26, 2003 at 07:14:39AM -0600, Ryan Earl wrote:
> On Friday 26 December 2003 07:54 am, Daniel Brahneborg wrote:
> The motherboard has two
> > additional serial-ata slots on a VIA chip, and a normal
> > IDE disk on ide0.
> > My problem is that when I boot with siimage.c enabled
> > or try to insert it as a module after booting, it forces
> > the drives on that card to become hda and hdb
> 
> Are you sure about the module?  If you boot with your southbridge's ATA
> driver
> built directly into the kernel it should be initialized first, and show your
> PATA ports starting at hda.  After those are assigned, if you modprobe 

If I boot with the siimage module builtin, the kernel doesn't
find the root device (set to /dev/hda2).

> siimage those ports should be hde and hdg or hdi and hdk if that
> southbridge has 4 PATA ports.  It does right?

No, it has 2 PATA connectors and 2 SATA (via82cxxx) connectors.
In addition, I have that Silicon Image 3112 card with 2 SATA
connectors.

> That's what works for me anyway with a KT333 chipset = via82cxxx
> southbridge.
> What does the ordering mess up that modifications to fstab or raidtab 
> couldn't fix?  You bootloader should have some way of setting a different 
> root directory right after the POST.

I'm running Grub, so I guess it could set the root device to
just about anything.  The question is why it changes when the
siimage module is loaded, and what the new name of the hda
device is.

As a workaround, I now skip the siimage module entirely, and only
load the sata_via and sata_sil modules.  This makes all 4 SATA
drives come alive as sda, sdb etc, leaving hda untouched.  I get
50 MB/s with hdparm -tT, so it seems to work fine.

New Problem:

I still have a rather serious problem, also SATA related.  I want
to have two network cards in that machine, one of them being a
common 8139 card.  As the other one I want to use the via-rhine
card on the motherboard.  The first network card comes alive
without problem, but when I try to do "ifconfig eth1 up", the
entire machine comes to a complete stop.  Not even Caps Lock work,
and I have to power cycle it.  Two 8139 cards have the same effect.
Removing the Silicon Image card makes it work fine.  How do I do
to get some debug information on what happens?

Here is the output from lspci -v.

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [80] Power Management version 2

00:08.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Flags: stepping, medium devsel, IRQ 12
	Memory at 20000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=256]
	Memory at ea000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0b.0 Unknown mass storage controller: CMD Technology Inc: Unknown device 3112 (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 3112
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at b400 [size=16]
	Memory at ea001000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at b800 [size=8]
	I/O ports at bc00 [size=4]
	I/O ports at c000 [size=8]
	I/O ports at c400 [size=4]
	I/O ports at c800 [size=16]
	I/O ports at cc00 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ea002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at e400 [size=256]
	Memory at ea003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

/Basic

