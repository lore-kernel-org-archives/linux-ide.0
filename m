From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 7589] New: libata: does not work anymore on
 VIA VT8251 AHCI/SATA 4-Port Controller
Date: Tue, 28 Nov 2006 16:48:39 -0800
Message-ID: <20061128164839.3def8005.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:8929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758281AbWK2Aso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 19:48:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAT0mdix019583
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 16:48:42 -0800
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kAT0mdEp000678
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 16:48:39 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


oops, we went backwards.


Begin forwarded message:

Date: Tue, 28 Nov 2006 16:33:38 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7589] New: libata: does not work anymore on VIA VT8251 AHCI/SATA 4-Port Controller


http://bugzilla.kernel.org/show_bug.cgi?id=7589

           Summary: libata: does not work anymore on VIA VT8251 AHCI/SATA 4-
                    Port Controller
    Kernel Version: 2.6.19-rc6-git10
            Status: NEW
          Severity: blocking
             Owner: jgarzik@pobox.com
         Submitter: lxnay@lxnaydesign.net


Most recent kernel where this bug did *NOT* occur: 2.6.18.3
Distribution: Gentoo Linux
Hardware Environment:
- ASUS A8V-VM

00:00.0 Host bridge: VIA Technologies, Inc. Unknown device 0336
        Flags: bus master, medium devsel, latency 8
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.0
        Capabilities: [50] Power Management version 2
        Capabilities: [60] HyperTransport: Slave or Primary Interface
        Capabilities: [58] #00 [0000]

00:00.1 Host bridge: VIA Technologies, Inc. Unknown device 1336
        Flags: bus master, medium devsel, latency 0

00:00.2 Host bridge: VIA Technologies, Inc. Unknown device 2336
        Flags: bus master, medium devsel, latency 0

00:00.3 Host bridge: VIA Technologies, Inc. Unknown device 3336
        Flags: bus master, medium devsel, latency 0

00:00.4 Host bridge: VIA Technologies, Inc. Unknown device 4336
        Flags: bus master, medium devsel, latency 0

00:00.5 PIC: VIA Technologies, Inc. Unknown device 5336 (prog-if 20 
[IO(X)-APIC])
        Flags: bus master, fast devsel, latency 0

00:00.6 Host bridge: VIA Technologies, Inc. Unknown device 6290
        Subsystem: Unknown device 0008:0000
        Flags: bus master, medium devsel, latency 0

00:00.7 Host bridge: VIA Technologies, Inc. Unknown device 7336
        Flags: bus master, medium devsel, latency 0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 
South] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [70] Power Management version 2

00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: daf00000-dfffffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [68] Power Management version 2
        Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [dc] HyperTransport: MSI Mapping

00:0f.0 IDE interface: VIA Technologies, Inc. VT8251 AHCI/SATA 4-Port 
Controller (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 17
        I/O ports at d800 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d000 [size=8]
        I/O ports at c800 [size=4]
        I/O ports at c400 [size=16]
        Memory at daeffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [c0] Power Management version 2
        Capabilities: [e0] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-

00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07) (prog-if 8a 
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 32
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 19
        I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 18
        I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 17
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 20
        I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90) (prog-if 20 
[EHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: bus master, medium devsel, latency 192, IRQ 18
        Memory at daeff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
        Capabilities: [88] Debug port

00:11.0 ISA bridge: VIA Technologies, Inc. VT8251 PCI to ISA Bridge
        Subsystem: ASUSTeK Computer Inc. Unknown device 81b5
        Flags: medium devsel
        Capabilities: [c0] Power Management version 2

00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
        Subsystem: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
        Flags: bus master, medium devsel, latency 128
        Capabilities: [58] HyperTransport: Interrupt Discovery and 
Configuration

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ed
        Flags: bus master, medium devsel, latency 192, IRQ 20
        I/O ports at a800 [size=256]
        Memory at daeff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

00:13.0 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCIE Bridge (prog-if 
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0

00:13.1 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCI Bridge (prog-if 01 
[Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 0000e000-0000efff

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address 
Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
        Flags: fast devsel

02:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 PCIe] 
(rev a2) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81dc
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at dc000000 (32-bit, non-prefetchable) [size=64M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at db000000 (64-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at dafe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [78] Express Endpoint IRQ 0

05:09.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
        Subsystem: Creative Labs Unknown device 1021
        Flags: bus master, medium devsel, latency 192, IRQ 22
        I/O ports at e800 [size=64]
        Capabilities: [dc] Power Management version 2


Software Environment:

Problem Description: see dmesg & kernel config attached.

My SATA drives are not detected and the system does not boot.
I have two drives that compose a software RAID1 array.
Drives are attached to SATA1 and SATA2 connectors while SATA3 and SATA4 are 
free.
No IDE devices connected apart from a DVD-RW.

I'd like to have this fixed within 2.6.19 stable.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
