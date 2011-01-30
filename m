From: Chris Webb <chris.webb@elastichosts.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Sun, 30 Jan 2011 01:54:42 +0000
Message-ID: <20110130015442.GB13204@arachsys.com>
References: <20110129112456.GA13204@arachsys.com>
 <4D44433F.1040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:60896 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1A3Byn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2011 20:54:43 -0500
Content-Disposition: inline
In-Reply-To: <4D44433F.1040607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock <hancockrwd@gmail.com> writes:

> On 01/29/2011 05:24 AM, Chris Webb wrote:
> >I have several Supermicro H8DGT-HF motherboards (BIOS version 1.1) with Star
> >Tech PEXSAT32 PCI Express SATA cards attached, and am seeing an
> >IO_PAGE_FAULT during boot corresponding to this card:
> >
> >   IO_PAGE_FAULT device=03:00.1 domain=0x0000 address=0x00000000000403c0 flags=0x0050]
> 
> What's that device 03:00.1? The AHCI controller itself seems to be
> 03:00.0. Can you post the lspci -v output? Though it could be that
> maybe the IOMMU can't tell functions on the same device apart, not
> sure.

Thanks for the reply. Sure, no problem---here's the lspci -v output in full:

00:00.0 Class 0600: Device 1002:5a12 (rev 02)
	Subsystem: Device 15d9:aa11
	Flags: fast devsel
	Capabilities: [f0] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [c4] HyperTransport: Slave or Primary Interface
	Capabilities: [40] HyperTransport: Retry Mode
	Capabilities: [54] HyperTransport: UnitID Clumping
	Capabilities: [9c] HyperTransport: #1a
	Capabilities: [70] MSI: Enable- Count=1/4 Maskable- 64bit-

00:00.2 Class 0806: Device 1002:5a23
	Subsystem: Device 1002:5a23
	Flags: bus master, fast devsel, latency 0, IRQ 40
	Capabilities: [40] Secure device <?>
	Capabilities: [54] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:02.0 Class 0604: Device 1002:5a16
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: feb00000-febfffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [b0] Subsystem: Device 15d9:aa11
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [190] Access Control Services

00:04.0 Class 0604: Device 1002:5a18
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fea00000-feafffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [b0] Subsystem: Device 15d9:aa11
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [190] Access Control Services

00:11.0 Class 0106: Device 1002:4391 (prog-if 01)
	Subsystem: Device 1002:4391
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
	I/O ports at b000 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at 9000 [size=8]
	I/O ports at 8000 [size=4]
	I/O ports at 7000 [size=16]
	Memory at fe9fa400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] SATA HBA v1.0
	Kernel driver in use: ahci

00:12.0 Class 0c03: Device 1002:4397 (prog-if 10)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe9f6000 (32-bit, non-prefetchable) [size=4K]

00:12.1 Class 0c03: Device 1002:4398 (prog-if 10)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe9f7000 (32-bit, non-prefetchable) [size=4K]

00:12.2 Class 0c03: Device 1002:4396 (prog-if 20)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
	Memory at fe9fa800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci_hcd

00:13.0 Class 0c03: Device 1002:4397 (prog-if 10)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at fe9f8000 (32-bit, non-prefetchable) [size=4K]

00:13.1 Class 0c03: Device 1002:4398 (prog-if 10)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at fe9f9000 (32-bit, non-prefetchable) [size=4K]

00:13.2 Class 0c03: Device 1002:4396 (prog-if 20)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
	Memory at fe9fac00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci_hcd

00:14.0 Class 0c05: Device 1002:4385 (rev 3d)
	Subsystem: Device 15d9:aa11
	Flags: 66MHz, medium devsel
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+

00:14.1 Class 0101: Device 1002:439c (prog-if 8a [Master SecP PriP])
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 0
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at ff00 [size=16]
	Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit-

00:14.3 Class 0601: Device 1002:439d
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 Class 0604: Device 1002:4384 (prog-if 01)
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fdf00000-fe7fffff
	Prefetchable memory behind bridge: fc000000-fcffffff

00:14.5 Class 0c03: Device 1002:4399 (prog-if 10)
	Subsystem: Device 15d9:aa11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at fe9fb000 (32-bit, non-prefetchable) [size=4K]

00:18.0 Class 0600: Device 1022:1200
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
	Capabilities: [e0] HyperTransport: Host or Secondary Interface

00:18.1 Class 0600: Device 1022:1201
	Flags: fast devsel

00:18.2 Class 0600: Device 1022:1202
	Flags: fast devsel

00:18.3 Class 0600: Device 1022:1203
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>

00:18.4 Class 0600: Device 1022:1204
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:19.0 Class 0600: Device 1022:1200
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 Class 0600: Device 1022:1201
	Flags: fast devsel

00:19.2 Class 0600: Device 1022:1202
	Flags: fast devsel

00:19.3 Class 0600: Device 1022:1203
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>

00:19.4 Class 0600: Device 1022:1204
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:1a.0 Class 0600: Device 1022:1200
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:1a.1 Class 0600: Device 1022:1201
	Flags: fast devsel

00:1a.2 Class 0600: Device 1022:1202
	Flags: fast devsel

00:1a.3 Class 0600: Device 1022:1203
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>

00:1a.4 Class 0600: Device 1022:1204
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:1b.0 Class 0600: Device 1022:1200
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
	Capabilities: [e0] HyperTransport: Host or Secondary Interface

00:1b.1 Class 0600: Device 1022:1201
	Flags: fast devsel

00:1b.2 Class 0600: Device 1022:1202
	Flags: fast devsel

00:1b.3 Class 0600: Device 1022:1203
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>

00:1b.4 Class 0600: Device 1022:1204
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [e0] HyperTransport: Host or Secondary Interface

01:04.0 Class 0300: Device 102b:0532 (rev 0a)
	Subsystem: Device 15d9:aa11
	Flags: bus master, medium devsel, latency 64, IRQ 7
	Memory at fc000000 (32-bit, prefetchable) [size=16M]
	Memory at fdffc000 (32-bit, non-prefetchable) [size=16K]
	Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1

02:00.0 Class 0200: Device 8086:10c9 (rev 01)
	Subsystem: Device 15d9:10c9
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at fea60000 (32-bit, non-prefetchable) [size=128K]
	Memory at fea40000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at c400 [size=32]
	Memory at fea1c000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at fea20000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-25-90-ff-ff-13-c3-26
	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
	Kernel driver in use: igb

02:00.1 Class 0200: Device 8086:10c9 (rev 01)
	Subsystem: Device 15d9:10c9
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at feae0000 (32-bit, non-prefetchable) [size=128K]
	Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at c800 [size=32]
	Memory at fea9c000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at feaa0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-25-90-ff-ff-13-c3-26
	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
	Kernel driver in use: igb

03:00.0 Class 0106: Device 1b4b:9123 (rev 11) (prog-if 01)
	Subsystem: Device 18ab:9115
	Flags: bus master, fast devsel, latency 0, IRQ 41
	I/O ports at d800 [size=8]
	I/O ports at d400 [size=4]
	I/O ports at e800 [size=8]
	I/O ports at e400 [size=4]
	I/O ports at e000 [size=16]
	Memory at febef800 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at febf0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [70] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Kernel driver in use: ahci

Best wishes,

Chris.
