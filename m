From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Sat, 20 Oct 2007 01:09:58 +0200
Message-ID: <200710200109.58872.marogge@onlinehome.de>
References: <200710142211.03382.marogge@onlinehome.de> <200710192158.03836.marogge@onlinehome.de> <471912EF.4020208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49774 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbXJSXKI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 19:10:08 -0400
In-Reply-To: <471912EF.4020208@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Friday 19 October 2007 22:26:23 Sergei Shtylyov wrote:
> Hello.
>
> Martin Rogge wrote:
> >>    BTW, can you try adding #define DEBUG to the driver meanwhile?..
> >
> > Yoda said: Try not. Do or do not. There is no try.
> >
>     :-)
> >
> > So I did it. To be precise, I #defined both DEBUG and CMD_DEBUG. However,
> > I am not sure the result is conclusive.
> >
> > On a good kernel I get a lot of lines of the type
> >
> > hda: dma_stat: 0x24 irq_stat: 0x44 mask: 0x04
> > hdc: dma_stat: 0x24 irq_stat: 0x5c mask: 0x10
>
>     Yeah, this is what's emitted by the dma_end() method which used
> CFR/ARTTIM23 PCI config. regs. to chack the interrupt status.
>
> > and variations thereof. On a broken kernel the middle part changes to
> >
> > hda: dma_stat: 0x24 mrdmode: 0x00 mask: 0x04
>
>     Hm... this means that the chip doesn't work as documented in the spec,
> i.e. MRDMODE reg. seems write only, like on older chips.  Could you post
> the output of 'lspci -v'?
>
> > Hope this is of any help,
>
>     It is of great help. :-)
>
> > cu Martin
>
> MBR, Sergei

Here you go:

root@fred:~# lspci -v
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8025
        Flags: bus master, medium devsel, latency 64
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: da000000-dbdfffff
        Prefetchable memory behind bridge: dbf00000-dfffffff

00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Flags: medium devsel
        [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] 
[size=8]
        [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] 
[size=1]
        [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] 
[size=8]
        [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] 
[size=1]
        I/O ports at d800 [disabled] [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

00:07.0 IDE interface: Silicon Image, Inc. PCI0648 (rev 01) (prog-if 8f 
[Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc. CUBX motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 15
        I/O ports at d000 [size=8]
        I/O ports at b800 [size=4]
        I/O ports at b400 [size=8]
        I/O ports at b000 [size=4]
        I/O ports at a800 [size=16]
        Capabilities: [60] Power Management version 1

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at a400 [size=32]
        Capabilities: [dc] Power Management version 1

00:09.1 Input device controller: Creative Labs SB Live! Game Port (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at a000 [size=8]
        Capabilities: [dc] Power Management version 1

00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 Controller 
(prog-if 10 [OHCI])
        Subsystem: Texas Instruments Unknown device 8010
        Flags: bus master, medium devsel, latency 32, IRQ 14
        Memory at d9800000 (32-bit, non-prefetchable) [size=2K]
        Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
        Subsystem: LSI Logic / Symbios Logic LSI53C810AE PCI to SCSI I/O 
Processor
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9800 [size=256]
        Memory at d8800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 1

00:0e.0 Ethernet controller: D-Link System Inc DGE-528T Gigabit Ethernet 
Adapter (rev 10)
        Subsystem: D-Link System Inc DGE-528T Gigabit Ethernet Adapter
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 14
        I/O ports at 9400 [size=256]
        Memory at d8000000 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 4200 
AGP 8x] (rev a1) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 8948
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at da000000 (32-bit, non-prefetchable) [size=16M]
        Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at dbfe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

cu Martin
