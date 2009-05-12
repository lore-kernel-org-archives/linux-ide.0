From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] New: dma_timer_expiry: DMA status (0x21)
Date: Tue, 12 May 2009 06:35:53 GMT
Message-ID: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34337 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZELGfw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 02:35:52 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4C6ZrQF014955
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2009 06:35:53 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286

           Summary: dma_timer_expiry: DMA status (0x21)
           Product: IO/Storage
           Version: 2.5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: fibre_optic@go2.pl
        Regression: No


Hello,

I have Dell Optiplex with ide->CF-Flash card interface. This configuration
works well with 2.6.27.21 but it generates the following messages on 2.6.29.3:
...
hda: dma_timer_expiry: DMA status (0x21)
hda: DMA timeout error
...

Here you have more data, if you need something more please let me know.

PS

This issue takes place with 2.6.28 too.

# dmesg
...
Scanning for low memory corruption every 60 seconds
squashfs: version 4.0 (2009/01/31) Phillip Lougher
msgmni has been set to 498
io scheduler noop registered (default)
pci 0000:00:01.0: Boot video device
brd: module loaded
Uniform Multi-Platform E-IDE driver
piix 0000:00:1f.1: IDE controller (0x8086:0x2411 rev 0x02)
piix 0000:00:1f.1: IDE port disabled
piix 0000:00:1f.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7
Probing IDE interface ide0...
hda: SanDisk SDCFJ-32, CFA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO2
hda: MWDMA2 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide_generic: please use "probe_mask=0x3f" module parameter for probing all
legacy ISA IDE ports
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 62720 sectors (32 MB) w/1KiB Cache, CHS=490/4/32
 hda:<4>hda: dma_timer_expiry: DMA status (0x21)
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
 hda1 hda2
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IO APIC resources could be not be allocated.
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
Clocksource tsc unstable (delta = 1024062479 ns)
hda: dma_timer_expiry: DMA status (0x21)
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
hda: dma_timer_expiry: DMA status (0x21)
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
hda: dma_timer_expiry: DMA status (0x21)
hda: DMA timeout error
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
VFS: Mounted root (ext2 filesystem) readonly on device 3:1.
Freeing unused kernel memory: 168k freed
...


# lspci
00:00.0 Host bridge: Intel Corporation 82810 DC-100 (GMCH) Graphics Memory
Controller Hub (rev 03)
00:01.0 VGA compatible controller: Intel Corporation 82810 DC-100 (CGC) Chipset
Graphics Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801AA IDE Controller (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801AA USB Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801AA SMBus Controller (rev 02)
01:07.0 PCI bridge: Digital Equipment Corporation DECchip 21153 (rev 04)
01:08.0 Ethernet controller: Atheros Communications, Inc. AR5005G 802.11abg NIC
(rev 01)
02:00.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
02:00.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal 10/100
Ethernet [hme] (rev 01)
02:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
02:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal 10/100
Ethernet [hme] (rev 01)
02:02.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
02:02.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal 10/100
Ethernet [hme] (rev 01)
02:03.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
02:03.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal 10/100
Ethernet [hme] (rev 01)

# lspci -n
00:00.0 0600: 8086:7122 (rev 03)
00:01.0 0300: 8086:7123 (rev 03)
00:1e.0 0604: 8086:2418 (rev 02)
00:1f.0 0601: 8086:2410 (rev 02)
00:1f.1 0101: 8086:2411 (rev 02)
00:1f.2 0c03: 8086:2412 (rev 02)
00:1f.3 0c05: 8086:2413 (rev 02)
01:07.0 0604: 1011:0025 (rev 04)
01:08.0 0200: 168c:001a (rev 01)
02:00.0 0680: 108e:1000 (rev 01)
02:00.1 0200: 108e:1001 (rev 01)
02:01.0 0680: 108e:1000 (rev 01)
02:01.1 0200: 108e:1001 (rev 01)
02:02.0 0680: 108e:1000 (rev 01)
02:02.1 0200: 108e:1001 (rev 01)
02:03.0 0680: 108e:1000 (rev 01)
02:03.1 0200: 108e:1001 (rev 01)

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
