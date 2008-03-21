From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Thu, 20 Mar 2008 21:06:32 -0700 (PDT)
Message-ID: <20080321040632.DF1DA11D10A@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36212 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716AbYCUEGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 00:06:36 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2L46WuB020619
	for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 21:06:33 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086


gordonfarquharson@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gordonfarquharson@gmail.com




------- Comment #5 from gordonfarquharson@gmail.com  2008-03-20 21:06 -------
I tested 2.6.25-rc5-git4 (which includes the commit) on a GLAN Tank
(arm/mach-iop32x), but I still get the following messages when I run smartctl:

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xb0

The system does not hang (although it never did when I first saw these
messages).

These messages definitely didn't happen with 2.6.24 on this platform.

Linux proteus 2.6.25-rc6-iop32x #1 Thu Mar 20 20:34:04 MDT 2008 armv5tel
GNU/Linux

00:01.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet
Controller (rev 05)
        Subsystem: I-O Data Device, Inc. Unknown device d02a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (63750ns min)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at 80020000 (64-bit, non-prefetchable) [size=64K]
        Region 4: I/O ports at 90000080 [size=64]
        [virtual] Expansion ROM at 80030000 [disabled] [size=64K]
        Capabilities: <access denied>
        Kernel driver in use: e1000
        Kernel modules: e1000

00:02.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 10)
        Subsystem: Artop Electronic Corp ATP865
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (2750ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 28
        Region 0: I/O ports at 900000c0 [size=8]
        Region 1: I/O ports at 900000d0 [size=4]
        Region 2: I/O ports at 900000c8 [size=8]
        Region 3: I/O ports at 900000d4 [size=4]
        Region 4: I/O ports at 90000000 [size=128]
        Region 5: Memory at 80050000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80040000 [disabled] [size=64K]
        Capabilities: <access denied>
        Kernel driver in use: AEC62xx_IDE
        Kernel modules: aec62xx

00:03.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation Hama USB 2.0 CardBus
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 8 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at 80051000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

00:03.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation Hama USB 2.0 CardBus
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 8 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 29
        Region 0: Memory at 80052000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

00:03.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
        Subsystem: NEC Corporation USB 2.0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 32 bytes
        Interrupt: pin C routed to IRQ 29
        Region 0: Memory at 80053000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

gordon@proteus:~$ sudo lspci -vvv
[sudo] password for gordon:
00:01.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet
Controller (rev 05)
        Subsystem: I-O Data Device, Inc. Unknown device d02a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (63750ns min)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at 80020000 (64-bit, non-prefetchable) [size=64K]
        Region 4: I/O ports at 90000080 [size=64]
        [virtual] Expansion ROM at 80030000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=1
                Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple
DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-
        Kernel driver in use: e1000
        Kernel modules: e1000

00:02.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 10)
        Subsystem: Artop Electronic Corp ATP865
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (2750ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 28
        Region 0: I/O ports at 900000c0 [size=8]
        Region 1: I/O ports at 900000d0 [size=4]
        Region 2: I/O ports at 900000c8 [size=8]
        Region 3: I/O ports at 900000d4 [size=4]
        Region 4: I/O ports at 90000000 [size=128]
        Region 5: Memory at 80050000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80040000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: AEC62xx_IDE
        Kernel modules: aec62xx

00:03.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation Hama USB 2.0 CardBus
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 8 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at 80051000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

00:03.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation Hama USB 2.0 CardBus
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 8 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 29
        Region 0: Memory at 80052000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

00:03.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
        Subsystem: NEC Corporation USB 2.0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 32 bytes
        Interrupt: pin C routed to IRQ 29
        Region 0: Memory at 80053000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

Module                  Size  Used by
ipv6                  289388  10
dm_snapshot            20448  0
dm_mirror              28992  0
dm_mod                 65736  2 dm_snapshot,dm_mirror
ext3                  138952  2
jbd                    49492  1 ext3
mbcache                 9216  1 ext3
ide_disk               16544  4
ehci_hcd               34380  0
ohci_hcd               21188  0
aec62xx                 4864  0 [permanent]
usbcore               140220  3 ehci_hcd,ohci_hcd
e1000                 124064  0
ide_core              105196  2 ide_disk,aec62xx


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
