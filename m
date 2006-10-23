From: "Uma Gavani" <ugavani@intrusion.com>
Subject: SATA timeout problems with kernel 2.4.33.3
Date: Mon, 23 Oct 2006 10:13:41 -0500
Message-ID: <97AC782D55FA734A80D81C2864817DAA04AFB640@PLUTO.intrusion.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pluto.intrusion.com ([160.86.12.20]:50861 "EHLO
	PLUTO.intrusion.com") by vger.kernel.org with ESMTP id S964917AbWJWPNl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 11:13:41 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Sending it again since the first attempt failed for the linx-ide group (
due to text format reasons).

_____________________________________________
From: Uma Gavani 
Sent: Monday, October 23, 2006 10:11 AM
To: 'jgarzik@pobox.com'
Cc: 'linux-ide@vger.kernel.org'
Subject: SATA timeout problems with kernel 2.4.33.3 

Hi,

I am trying to get a box with SATA drive to work with kernel 2.4.33.3 (
need to stick with 2.4 as far as possible).

The box comes up just fine with kernel 2.6.12.6 but times out on SATA
with 2.4 kernel with the following messages( added the status output to
libata-core.c)

libata version 1.20 loaded.
PCI(00:1f:2): AHCI  0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
PCI(00:1f:2): flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xF8851100 ctl 0x0 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8851180 ctl 0x0 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8851200 ctl 0x0 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8851280 ctl 0x0 bmdma 0x0 irq 17
ata1 is slow to respond, please be patient ( Status 0x80)
ata1 failed to respond ( 30 secs, Status 0x80)
ata2: no device found(phy stat 00000000)
ata3: no device found(phy stat 00000000)
ata4: no device found(phy stat 00000000)
scsi1 :  ahci
scsi2 :  ahci
scsi3 :  ahci
scsi4 :  ahci

attached below are lspci details when running 2.6. I would really
appreciate any help to resolve this.

Thanks,

Uma.
------------------------------------------------------------------------
---------------
00:00.0 Host bridge: Intel Corporation E7230/3000/3010 Memory Controller
Hub
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 5 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 6 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 48100000-481fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 3080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 3060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 3040 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 3020 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at 48200400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if
01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 48000000-480fffff
        Prefetchable memory behind bridge:
0000000040000000-0000000047f00000
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 30b0 [size=16]

00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 10
        I/O ports at 30c8 [size=8]
        I/O ports at 30e4 [size=4]
        I/O ports at 30c0 [size=8]
        I/O ports at 30e0 [size=4]
        I/O ports at 30a0 [size=16]
        Memory at 48200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
        Subsystem: Intel Corporation: Unknown device 346a
        Flags: medium devsel, IRQ 10
        I/O ports at 3000 [size=32]

01:00.0 PCI bridge: Intel Corporation 6702PXH PCI Express-to-PCI Bridge
A (rev 09) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [6c] Power Management version 2
        Capabilities: [d8] PCI-X bridge device.
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [300] Power Budgeting

04:00.0 Ethernet controller: Intel Corporation 82573E Gigabit Ethernet
Controller (Copper) (rev 03)
        Subsystem: Intel Corporation: Unknown device 30a2
        Flags: bus master, fast devsel, latency 0, IRQ 9
        Memory at 48180000 (32-bit, non-prefetchable) [size=128K]
        Memory at 48100000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 2000 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [e0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 36-a2-ea-ff-ff-20-13-00

04:00.2 IDE interface: Intel Corporation: Unknown device 108d (rev 03)
(prog-if 85 [Master SecO PriO])
        Subsystem: Intel Corporation: Unknown device 0000
        Flags: bus master, fast devsel, latency 0, IRQ 11
        I/O ports at 2040 [size=8]
        I/O ports at 2050 [size=4]
        I/O ports at 2038 [size=8]
        I/O ports at 204c [size=4]
        I/O ports at 2020 [size=16]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 36-a2-ea-ff-ff-20-13-00

04:00.3 Serial controller: Intel Corporation Active Management
Technology - SOL (rev 03) (prog-if 02 [16550])
        Subsystem: Intel Corporation: Unknown device 0000
        Flags: bus master, fast devsel, latency 0, IRQ 10
        I/O ports at 2030 [size=8]
        Memory at 481a1000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [e0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 36-a2-ea-ff-ff-20-13-00

04:00.4 Class 0c07: Intel Corporation 82573E KCS (Active Management)
(rev 03) (prog-if 01)
        Subsystem: Intel Corporation: Unknown device 0000
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 481a0000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 2048 [size=4]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [e0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 36-a2-ea-ff-ff-20-13-00

05:04.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
(prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 515e
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
        Memory at 40000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 1000 [size=256]
        Memory at 48040000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fffe0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

05:05.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet
Controller (rev 05)
        Subsystem: Intel Corporation: Unknown device 30a1
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 9
        Memory at 48020000 (32-bit, non-prefetchable) [size=128K]
        Memory at 48000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 1100 [size=64]
        Expansion ROM at fffe0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
