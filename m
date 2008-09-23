From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11630] New: SIS 5513 pata_sis exception
Date: Tue, 23 Sep 2008 15:59:44 -0700 (PDT)
Message-ID: <bug-11630-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50784 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752988AbYIWXAQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2008 19:00:16 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8NMxiNd028362
	for <linux-ide@vger.kernel.org>; Tue, 23 Sep 2008 15:59:45 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11630

           Summary: SIS 5513 pata_sis exception
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc6 2.6.27-rc5-mm1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: tomasz89@gmail.com


Latest working kernel version: None.
Earliest failing kernel version: 2.6.17-10 (Ubuntu)
Distribution: Ubuntu 8.04
Hardware Environment: (A horrible) PCChips M748LMRT (SiS 620 chipset). The IDE
controller is a SiS 5513. Below is the lspci -vvv output:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: <access denied>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller
(A,B step)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC
Bridge) (rev b3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 11) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at efffb000 (32-bit, non-prefetchable) [size=4K]

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge
(AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e7d00000-e7dfffff
        Prefetchable memory behind bridge: e6b00000-e7bfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:09.0 RAID bus controller: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to
ATA Host Controller (rev 02)
        Subsystem: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA Host
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at de00 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 2: I/O ports at da00 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at d600 [size=16]
        Expansion ROM at eff00000 [disabled] [size=512K]
        Capabilities: <access denied>

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d200 [size=256]
        Capabilities: <access denied>

00:0f.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CM8738
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at d400 [size=64]
        Capabilities: <access denied>

00:10.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
Adapter onboard [Asus P4SC-EA]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at efffa000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at effc0000 [disabled] [size=128K]
        Capabilities: <access denied>

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 530/620
PCI/AGP VGA Display Adapter (rev 2a) (prog-if 00 [VGA controller])
        Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI
Accelerator+3D
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min)
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at e7df0000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at ac00 [size=128]
        Capabilities: <access denied>


Software Environment: This is a fairly minimal cut down install, as I am only
trying to reproduce the problem.

Problem Description:
The pata_sis module causes all kinds of issues when in use and going through
this layer to access the HDD and CDROM results in the output below.
Interestingly however the older IDE layer driver "sis5513" works perfectly.

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 82 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 82 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 82 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: limiting speed to UDMA/25:PIO4
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 82 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/25
sr 3:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 3:0:0:0: [sr0] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0e 09 0c 00 00 00 02 00 00
        00 08 00 00 a0 40
sr 3:0:0:0: [sr0] ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sr0, sector 614920
Buffer I/O error on device sr0, logical block 76865
Buffer I/O error on device sr0, logical block 76866
Buffer I/O error on device sr0, logical block 76867
Buffer I/O error on device sr0, logical block 76868
Buffer I/O error on device sr0, logical block 76869
Buffer I/O error on device sr0, logical block 76870
Buffer I/O error on device sr0, logical block 76871
Buffer I/O error on device sr0, logical block 76872
Buffer I/O error on device sr0, logical block 76873
Buffer I/O error on device sr0, logical block 76874
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 c2 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/25
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 c2 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/25
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 c2 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: configured for UDMA/25
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 126976 in
         cdb 28 00 00 02 58 c2 00 00  3e 00 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: link is slow to respond, please be patient (ready=0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: soft resetting link
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata4.00: revalidation failed (errno=-5)
ata4: soft resetting link
ata4.00: configured for UDMA/25
sr 3:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 3:0:0:0: [sr0] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0e 09 0c 00 00 00 02 00 00
        00 08 00 00 a0 40
sr 3:0:0:0: [sr0] ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sr0, sector 615176
__ratelimit: 21 callbacks suppressed
Buffer I/O error on device sr0, logical block 76897
Buffer I/O error on device sr0, logical block 76898
Buffer I/O error on device sr0, logical block 76899
Buffer I/O error on device sr0, logical block 76900
Buffer I/O error on device sr0, logical block 76901
Buffer I/O error on device sr0, logical block 76902
Buffer I/O error on device sr0, logical block 76903
Buffer I/O error on device sr0, logical block 76904
Buffer I/O error on device sr0, logical block 76905
Buffer I/O error on device sr0, logical block 76906
ata4: EH complete


Steps to reproduce:
Any modern distro will no doubt favour the newly developed pata drivers over
the older ide layer where available, so trying to boot off for example an
Ubuntu Hardy live CD will generate these errors from either the CDROM or HDD as
it uses the new PATA layer to access the underlying devices.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
