From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 8988] via82cxxx: SATA DVD-RW Pioneer DVR-212BK with CX700, system hangs
Date: Sat, 16 Feb 2008 11:47:19 -0800 (PST)
Message-ID: <20080216194719.2B181108077@picon.linux-foundation.org>
References: <bug-8988-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46913 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758081AbYBPTr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 14:47:57 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GJkuSK010383
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 11:47:25 -0800
In-Reply-To: <bug-8988-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=8988


slava@fizlesh.org.ru changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |slava@fizlesh.org.ru




------- Comment #5 from slava@fizlesh.org.ru  2008-02-16 11:47 -------
I have the similar problem with kernel 2.6.24.1 and IDE cd/dvd-rom (the system
doesn't have SATA controller at all). IDE controller is intel ICH4. During
kernel boot, the following messages appear:

Feb 16 20:04:45 fpfe Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 16 20:04:45 fpfe ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
Feb 16 20:04:45 fpfe ICH4: IDE controller (0x8086:0x24cb rev 0x02) at  PCI slot
0000:00:1f.1
Feb 16 20:04:45 fpfe ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low)
-> IRQ 16
Feb 16 20:04:45 fpfe ICH4: not 100% native mode: will probe irqs later
Feb 16 20:04:45 fpfe ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA,
hdb:DMA
Feb 16 20:04:45 fpfe ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA,
hdd:pio
Feb 16 20:04:45 fpfe Probing IDE interface ide0...
Feb 16 20:04:45 fpfe hdb: Hitachi HDT725025VLAT80, ATA DISK drive
Feb 16 20:04:45 fpfe hda: SAMSUNG SP0612N, ATA DISK drive
Feb 16 20:04:45 fpfe hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
Feb 16 20:04:45 fpfe hda: UDMA/100 mode selected
Feb 16 20:04:45 fpfe hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
Feb 16 20:04:45 fpfe hdb: UDMA/100 mode selected
Feb 16 20:04:45 fpfe ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 16 20:04:45 fpfe Probing IDE interface ide1...
Feb 16 20:04:45 fpfe hdc: BENQ DVD DD DW1640, ATAPI CD/DVD-ROM drive
Feb 16 20:04:45 fpfe hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
Feb 16 20:04:45 fpfe hdc: UDMA/33 mode selected
Feb 16 20:04:45 fpfe ide1 at 0x170-0x177,0x376 on irq 15 <=== the system waits
here for several seconds
Feb 16 20:04:45 fpfe hdc: lost interrupt
Feb 16 20:04:45 fpfe hdc: task_in_intr: status=0x59 { DriveReady SeekComplete
DataRequest Error }
Feb 16 20:04:45 fpfe hdc: task_in_intr: error=0x00 { }
Feb 16 20:04:45 fpfe ide: failed opcode was: 0xa1
Feb 16 20:04:45 fpfe hda: max request size: 512KiB

Later, when cdrom module is loaded, the following errors are reported:

Feb 16 20:04:45 fpfe hdc: status error: status=0x59 { DriveReady SeekComplete
DataRequest Error }
Feb 16 20:04:45 fpfe hdc: status error: error=0x00 { }
Feb 16 20:04:45 fpfe ide: failed opcode was: unknown
Feb 16 20:04:45 fpfe hdc: drive not ready for command
Feb 16 20:04:45 fpfe hdc: ATAPI CD-ROM drive, 0kB Cache
Feb 16 20:04:45 fpfe Uniform CD-ROM driver Revision: 3.20
Feb 16 20:04:45 fpfe hdc: status error: status=0x59 { DriveReady SeekComplete
DataRequest Error }
Feb 16 20:04:45 fpfe hdc: status error: error=0x00 { }
Feb 16 20:04:45 fpfe ide: failed opcode was: unknown
Feb 16 20:04:45 fpfe hdc: drive not ready for command

The drive becomes locked (i. e. it doesn't eject when you press eject button or
execute 'eject' command).

The libata driver works with dvd without noticeable problems. Kernel 2.6.22
works, too.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
