From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 18:01:31 GMT
Message-ID: <200905131801.n4DI1Vro032174@demeter.kernel.org>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50706 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497AbZEMSBb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 14:01:31 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4DI1VRm032177
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 18:01:31 GMT
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286





--- Comment #4 from fibre_optic@go2.pl  2009-05-13 18:01:31 ---
"Does 2.6.27.21 use DMA?"

Here is part of dmesg output from 2.6.27.21:
...
platform rtc_cmos: registered platform RTC device (no PNP device found)
squashfs: version 3.4 (2008/08/26) Phillip Lougher
msgmni has been set to 498
io scheduler noop registered (default)
pci 0000:00:01.0: Boot video device
brd: module loaded
Uniform Multi-Platform E-IDE driver
ide_generic: please use "probe_mask=0x3f" module parameter for probing all
legacy ISA IDE ports
Probing IDE interface ide0...
hda: SanDisk SDCFJ-32, CFA DISK drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 62720 sectors (32 MB) w/1KiB Cache, CHS=490/4/32
 hda: hda1 hda2
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Using IPI Shortcut mode
Clocksource tsc unstable (delta = 1023003894 ns)
input: AT Translated Set 2 keyboard as /class/input/input0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 140k freed
NET: Registered protocol family 1
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
...

"Unfortunately there is no software method to check it so
you need to look at PCB and verify if there are any routes
connected to pins 21 and 29 (DMARQ and -DMACK lines)."

Take a look at attached pictures. Do they help to figure this out?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
