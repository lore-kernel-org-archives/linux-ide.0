From: "Alexander V. Lukyanov" <lav@netis.ru>
Subject: strange errors with Promise 20268R (linux 2.6.9)
Date: Thu, 11 Nov 2004 13:25:25 +0300
Message-ID: <20041111102524.GA27596@night.netis.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fire.yars.free.net ([193.233.48.99]:712 "EHLO fire.netis.ru")
	by vger.kernel.org with ESMTP id S262188AbUKKKeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2004 05:34:19 -0500
Received: from night.yars.free.net (night.netis.priv [10.0.0.89])
	by fire.netis.ru (8.13.1/8.13.1) with ESMTP id iABAPRc7015219
	for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2004 13:25:28 +0300 (MSK)
Received: (from lav@localhost)
	by night.yars.free.net (8.11.6+Sun/8.11.6) id iABAPPp27618
	for linux-ide@vger.kernel.org; Thu, 11 Nov 2004 13:25:25 +0300 (MSK)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>From time to time I get these errors in the log. The error is apparently
retried and the data is not harmed.

hdk: dma_intr: bad DMA status (dma_stat=35)
hdk: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
hde: dma_intr: bad DMA status (dma_stat=35)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
hdg: dma_intr: bad DMA status (dma_stat=35)
hdg: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
hdi: dma_intr: bad DMA status (dma_stat=35)
hdi: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown

The disks are connected to Promise TX4 (20268R).

Here is my PCI configuration:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
        Flags: bus master, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d7ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
        Flags: medium devsel

00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: d8000000-d9ffffff
        Expansion ROM at 0000a000 [disabled] [size=12K]
        Capabilities: [dc] Power Management version 1

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Compex FN22-3(A) LinxPRO Ethernet Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 17
        I/O ports at d800
        Memory at db000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 03)
        Subsystem: Triones Technologies, Inc. HPT370A
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        I/O ports at dc00
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at ec00 [size=256]
        Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] (rev 15) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at d6000000 (32-bit, non-prefetchable)
        Memory at d4000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

02:01.0 RAID bus controller: Promise Technology, Inc. 20268R (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 17
        I/O ports at a000
        I/O ports at a400 [size=4]
        I/O ports at a800 [size=8]
        I/O ports at ac00 [size=4]
        I/O ports at b000 [size=16]
        Memory at d9000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [60] Power Management version 1

02:02.0 RAID bus controller: Promise Technology, Inc. 20268R (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 17
        I/O ports at b400
        I/O ports at b800 [size=4]
        I/O ports at bc00 [size=8]
        I/O ports at c000 [size=4]
        I/O ports at c400 [size=16]
        Memory at d9010000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [60] Power Management version 1
