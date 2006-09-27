From: Jim Paris <jim@jtan.com>
Subject: sata_nv hotplug in 2.6.18
Date: Wed, 27 Sep 2006 04:20:05 -0400
Message-ID: <20060927082005.GA14569@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:14496 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S964774AbWI0IUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Sep 2006 04:20:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

I set up a new machine with a NVIDIA SATA controller and 2.6.18.
Hotplug did not work correctly.  I discovered that it's the same
problem Philipp Wagner had a few months ago with 2.6.18-rc4:

  http://www.spinics.net/lists/linux-ide/msg04081.html

The patch you provided there solves the problem on my system as well.
I haven't seen this patch mentioned anywhere else, and I don't see 
it in libata-dev.git, so I just wanted to check on its status.

Relevant logs below.

Thanks,
-jim

######

Affected device:

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: Tyan Computer Unknown device 2877
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 58
        Region 0: I/O ports at 1440 [size=8]
        Region 1: I/O ports at 1434 [size=4]
        Region 2: I/O ports at 1438 [size=8]
        Region 3: I/O ports at 1430 [size=4]
        Region 4: I/O ports at 1410 [size=16]
        Region 5: Memory at d8002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

######

Without patch:

Removed disk:

[  298.452420] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1910000 action 0x2 frozen
[  299.169503] ata3: soft resetting port
[  299.169509] ata3: SATA link down (SStatus 0 SControl 300)
[  299.169514] ata3: failed to recover some devices, retrying in 5 secs
[  304.171105] ata3: hard resetting port
[  304.894753] ata3: SATA link down (SStatus 0 SControl 300)
[  304.894758] ata3: failed to recover some devices, retrying in 5 secs
[  309.896354] ata3: hard resetting port
[  310.620003] ata3: SATA link down (SStatus 0 SControl 300)
[  310.620010] ata3.00: disabled
[  311.123763] ata3: EH complete
[  311.123774] ata3.00: detaching (SCSI 2:0:0:0)

Plugged disk back in:

[  352.429871] ata3: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
[  360.148230] ata3: port is slow to respond, please be patient
[  383.153148] ata3: port failed to respond (30 secs)
[  383.153198] ata3: soft resetting port
[  390.309735] ata3: port is slow to respond, please be patient
[  413.318647] ata3: port failed to respond (30 secs)
[  413.318705] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  413.318712] ata3: EH complete

The disk never comes back.

######

With patch:

Removed disk:

[  132.414496] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
[  132.925157] ata3: hard resetting port
[  133.648811] ata3: SATA link down (SStatus 0 SControl 300)
[  133.648818] ata3: failed to recover some devices, retrying in 5 secs
[  139.162162] ata3: hard resetting port
[  139.885815] ata3: SATA link down (SStatus 0 SControl 300)
[  139.885821] ata3: failed to recover some devices, retrying in 5 secs
[  145.399165] ata3: hard resetting port
[  146.122816] ata3: SATA link down (SStatus 0 SControl 300)
[  146.122821] ata3.00: disabled
[  146.626577] ata3: EH pending after completion, repeating EH (cnt=4)
[  146.626590] ata3: EH complete
[  146.626597] ata3.00: detaching (SCSI 2:0:0:0)

Plugged disk back in:

[  174.511797] ata3: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
[  175.024925] ata3: waiting for device to spin up (8 secs)
[  175.027704] ata3: hard resetting port
[  181.621773] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  181.622628] ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
[  181.623677] ata3.00: configured for UDMA/133
[  181.623681] ata3: EH pending after completion, repeating EH (cnt=4)
[  181.623691] ata3: EH complete
[  181.623810]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[  181.623821]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  181.623910] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[  181.623923] sdc: Write Protect is off
[  181.623926] sdc: Mode Sense: 00 3a 00 00
[  181.623946] SCSI device sdc: drive cache: write back
[  181.624005] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[  181.624017] sdc: Write Protect is off
[  181.624020] sdc: Mode Sense: 00 3a 00 00
[  181.624039] SCSI device sdc: drive cache: write back
[  181.624044]  sdc: sdc1
[  181.636017] sd 2:0:0:0: Attached scsi disk sdc

Everything is fine.

