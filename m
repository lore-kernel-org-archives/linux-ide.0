From: Gustav <ventilen@gmail.com>
Subject: Regular device resets on esata harddrives
Date: Thu, 24 Apr 2008 23:45:47 +0200
Message-ID: <4810FF8B.3070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:49693 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYDXVqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 17:46:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1363082nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 14:45:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got regular device resets on my harddrives. They have been there 
all the time since I bought the hardware. First used with 2.6.23 kernel 
with libata-tj patch and then with 2.6.24 without any patches and now 
with the 2.6.25 kernel and always got device resets.

The resets hang all disk activity for about 10 seconds and sometimes 
trigger a rebuild of my software raid5 array which are my greatest concern.

The storage controller are a Lycom 64-105e PCI-X eSATA adapter (Silicon 
Image 3124 chip) with three Lycom ST126RM port multipliers (Silicon 
Image 3726 chip) and a total of 13 harddrives, 10 samsung, 2 western 
digital and one Seagate.

Here's a cut from dmesg when the problem occur:

ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.01: NCQ disabled due to excessive errors
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x2 frozen
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.01: status: { DRDY }
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata6.00: hard resetting link
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:1:0:0: [sdi] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:2:0:0: [sdj] 488395055 512-byte hardware sectors (250058 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:3:0:0: [sdk] 488395055 512-byte hardware sectors (250058 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:4:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:1:0:0: [sdi] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:2:0:0: [sdj] 488395055 512-byte hardware sectors (250058 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:3:0:0: [sdk] 488395055 512-byte hardware sectors (250058 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:4:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x2 frozen
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 3
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.02: status: { DRDY }
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.04: status: { DRDY }
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata6.00: hard resetting link
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:1:0:0: [sdi] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:2:0:0: [sdj] 488395055 512-byte hardware sectors (250058 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:3:0:0: [sdk] 488395055 512-byte hardware sectors (250058 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:4:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:1:0:0: [sdi] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:2:0:0: [sdj] 488395055 512-byte hardware sectors (250058 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:3:0:0: [sdk] 488395055 512-byte hardware sectors (250058 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:4:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA

The problem almost only occur when I write files to the drives. 
Sometimes it can go over 10 GB and sometimes only a few MB between the 
resets.

Don't know what information is necessary for you but.

Some information about the storage controller:

09:01.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial 
ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. Unknown device 7124
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping+ SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at fdff0000 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at fdfe0000 (64-bit, non-prefetchable) [size=32K]
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [40] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=12
                Status: Dev=09:01.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
        Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: sata_sil24

Information about the kernel:

Linux filserver 2.6.25 #1 SMP Wed Apr 23 21:39:14 CEST 2008 x86_64 
Intel(R) Pentium(R) 4 CPU 3.40GHz GenuineIntel GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.18
util-linux             2.13.1
mount                  2.13.1
module-init-tools      3.4
e2fsprogs              1.40.6
reiserfsprogs          3.6.19
xfsprogs               2.9.5
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.10
udev                   119
Modules Loaded         ide_cd_mod cdrom floppy piix ide_core

Please let me know if you need any additional information.

Best regards,
Gustav
