From: Neil Romig <neil@romig.demon.co.uk>
Subject: File corruption in 2.6.18 thru 2.6.22
Date: Sat, 18 Aug 2007 14:42:45 +0000
Message-ID: <46C70565.1040308@romig.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:2015 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbXHROuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 10:50:13 -0400
Received: from dyn-62-56-123-88.dslaccess.co.uk ([62.56.123.88] helo=[127.0.0.1])
	by anchor-post-36.mail.demon.net with esmtpa (AUTH romig)
	(Exim 4.42)
	id 1IMPRg-0002Az-MW
	for linux-ide@vger.kernel.org; Sat, 18 Aug 2007 14:38:33 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have been upgrading my kernel from 2.6.14 to get at the new wireless
stuff, but have hit a big problem.
When copying files, I get random (?) corruption, which is preventing me
from using my linux system (Linux From Scratch) as it affects compiling
as well (assembler complains about garbage in files).

Some examples:

cp ../Changelog-2.6.18 .
diff Changelog-2.6.18 ../Changelog-2.6.18

16377c16377
<       LD      .top_vmlinux1
---
 >       LD      .tmp_vmlinux1
23954c23954
< Date:   Mon Jul 1% 04:45:11 2006 -0700
---
 > Date:   Mon Jul 10 04:45:11 2006 -0700
24955c24955
<     This is generally useful, but partacularly helps see if it is the same sector
---
 >     This is generally useful, but particularly helps see if it is the same sector
31879c31879
<     [MMC] sdhci: version bump cdhci
---
 >     [MMC] sdhci: version bump sdhci
42955c42955
<     Replace `he temp makefile hacks with proper CONFIG entries, which are also
---
 >     Replace the temp makefile hacks with proper CONFIG entries, which are also
49050c49050
<       and this task is(already holding:
---
 >       and this task is already holding:
[output clipped]


Everything is O.K using kernel 2.6.17.14, but 2.6.18 and beyond all have
this problem. It may take me months to sort this out on my own - any
suggestions?


My setup:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & Memory & AGP Controller (rev 01)
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64
	Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: ec100000-ec1fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 14)
	Flags: bus master, medium devsel, latency 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Flags: medium devsel
	I/O ports at 8100 [size=32]

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 34000000 [disabled] [size=128K]
	Capabilities: [64] Power Management version 2

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE](prog-if 80 [Master])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 128, IRQ 11
	I/O ports at 1000 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 4201
	Flags: medium devsel, IRQ 5
	I/O ports at 1400 [disabled] [size=256]
	I/O ports at 1080 [disabled] [size=128]
	Capabilities: [48] Power Management version 2

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 173, IRQ 5
	I/O ports at 1c00 [size=256]
	I/O ports at 1800 [size=128]
	Capabilities: [48] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at ec002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at ec004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 2000 [size=256]
	Memory at ec005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at 34020000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000 (prefetchable)
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0403
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 11
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 9000 [size=256]
	Memory at ec100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ec120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

ver_linux gives:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux romig 2.6.18.1 #1 Wed Aug 15 21:12:48 BST 2007 i686 pentium4 i386
GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.37
PPP                    2.4.3
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      6.0.3
Kbd                    1.12
Sh-utils               5.2.1
udev                   113
Modules Loaded

