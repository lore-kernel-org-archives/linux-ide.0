From: "Danny Sung" <dsung@lantronix.com>
Subject: RE: SATA driver issues?
Date: Tue, 24 Oct 2006 09:53:52 -0700
Message-ID: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD63@3putt.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ltrxmail.lantronix.com ([67.134.254.86]:47628 "EHLO
	double-bogey.int.lantronix.com") by vger.kernel.org with ESMTP
	id S965159AbWJXQxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2006 12:53:53 -0400
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

 

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
Sent: Monday, October 23, 2006 6:56 PM
To: Danny Sung
Cc: Jeff Garzik; linux-ide@vger.kernel.org
Subject: Re: SATA driver issues?


Interestingly, I didn't get any drive resets last night.  Maybe one of
those flags (pci=noacpi idebus=66) fixed the problem.  I'll try removing
the idebus line since Alan Cox said I shouldn't need it.

> The HT1000 is using a frodo SATA cell ? (me doesn't know for sure :)
> What is the lspci output ?

00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge
00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller
00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:04.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
00:06.0 PCI bridge: Broadcom HT1000 PCI-X bridge (rev a3)
00:07.0 PCI bridge: Broadcom HT1000 PCI-X bridge (rev a3)
00:08.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3)
00:09.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3)
00:0a.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3)
00:0b.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev b2)
01:0e.0 IDE interface: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
01:0e.1 IDE interface: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
04:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5780
Gigabit Ethernet (rev 03)
04:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5780
Gigabit Ethernet (rev 03)

(verbose at bottom)

>BTW. Please remove that completely bogus disclaimer at the end of your
emails,
>especially when posting to a public list. It's a total nonsense and may
cause
>quite a few people to decide to ignore your message completely.

I know, it's horribly embarrassing.  I wish I could do something about
it, but it's from my company's outgoing mail server.  I'll see what I
can get out of my IT people, but I doubt there's much I can do.  Many
sincere appologies.  Can I legally put a disclaimer that nullifies the
disclaimer? ;-)



Here's the lspci -v output:

00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge:
0000000088000000-0000000088000000
        Capabilities: [90] PCI-X bridge device
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] HyperTransport: Slave or Primary Interface

00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
        Subsystem: Broadcom Unknown device 0201
        Flags: bus master, medium devsel, latency 64

00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller (prog-if 8a
[Master SecP PriP])
        Subsystem: Broadcom HT1000 Legacy IDE controller
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 2000 [size=16]
        Capabilities: [b0] Power Management version 2

00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
        Subsystem: Broadcom Unknown device 0230
        Flags: bus master, medium devsel, latency 0

00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if
10 [OHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
        Memory at e8011000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1000 [size=256]
        Capabilities: [dc] Power Management version 2

00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if
10 [OHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
        Memory at e8012000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1400 [size=256]
        Capabilities: [dc] Power Management version 2

00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if
20 [EHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
        Memory at e8013000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1800 [size=256]
        Capabilities: [dc] Power Management version 2

00:04.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
(prog-if 00 [VGA])
        Subsystem: IBM Unknown device 0325
        Flags: stepping, medium devsel, IRQ 169
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 1c00 [size=256]
        Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 88100000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

00:06.0 PCI bridge: Broadcom HT1000 PCI-X bridge (rev a3) (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        Capabilities: [90] PCI-X bridge device
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] HyperTransport: Slave or Primary Interface

00:07.0 PCI bridge: Broadcom HT1000 PCI-X bridge (rev a3) (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        Memory behind bridge: e8200000-e82fffff
        Capabilities: [90] PCI-X bridge device
        Capabilities: [a0] HyperTransport: MSI Mapping

00:08.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3) (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] Express Root Port (Slot-) IRQ 0

00:09.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3) (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=64
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] Express Root Port (Slot-) IRQ 0

00:0a.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3) (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] Express Root Port (Slot-) IRQ 0

00:0b.0 PCI bridge: Broadcom HT1000 PCI-Express bridge (rev a3) (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=64
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] Express Root Port (Slot-) IRQ 0

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuratio
n
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Flags: fast devsel

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuratio
n
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
        Flags: fast devsel

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        Flags: fast devsel

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Flags: fast devsel

01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev b2) (prog-if
00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        Capabilities: [90] PCI-X bridge device

01:0e.0 IDE interface: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
(prog-if 8f [Master SecP SecO PriP PriO
])
        Subsystem: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 3040 [size=8]
        I/O ports at 3034 [size=4]
        I/O ports at 3038 [size=8]
        I/O ports at 3030 [size=4]
        I/O ports at 3000 [size=16]
        Memory at e8100000 (32-bit, non-prefetchable) [size=8K]
        [virtual] Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [60] PCI-X non-bridge device
        Capabilities: [90] Power Management version 2
        Capabilities: [a0] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-

01:0e.1 IDE interface: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
(prog-if 8f [Master SecP SecO PriP PriO
])
        Subsystem: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        I/O ports at 3058 [size=8]
        I/O ports at 304c [size=4]
        I/O ports at 3050 [size=8]
        I/O ports at 3048 [size=4]
        I/O ports at 3020 [size=16]
        Capabilities: [60] PCI-X non-bridge device
        Capabilities: [90] Power Management version 2
        Capabilities: [a0] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-

04:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5780
Gigabit Ethernet (rev 03)
        Subsystem: IBM Unknown device 0329
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 201
        Memory at e8210000 (64-bit, non-prefetchable) [size=64K]
        Memory at e8200000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable+

04:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5780
Gigabit Ethernet (rev 03)
        Subsystem: IBM Unknown device 0329
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 185
        Memory at e8230000 (64-bit, non-prefetchable) [size=64K]
        Memory at e8220000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited.

