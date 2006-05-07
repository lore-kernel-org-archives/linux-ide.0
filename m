From: Moritz Heiber <moritz-heiber@arcor.de>
Subject: Issues with AHCI and SATAII using JMD360
Date: Sun, 7 May 2006 04:37:02 +0200
Message-ID: <20060507043702.052e3f56.moritz-heiber@arcor.de>
Reply-To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:45992 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750879AbWEGChE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 22:37:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

as I skimmed through the mailinglist archives I noticed that support
for the JMD360 SATA chipset has just been added recently and so I went
ahead and tried to make use of my motherboard's SATAII capabilities.
Unfortunately, I did not succeed at it.

I'm using a ASRock 939Dual-SATA2 mainboard equipped with a JMD360 SATA
controller chip. A Hitachi Deskstar 7K250 (HDT722516DLA380), which is
supposed to support SATAII, is attached to the only available SATAII
compliant socket using the correct cables. The harddrive is recognized
correctly as SATAII device by the AMI BIOS (latest revision 1.8.0).

Currently, the drive only runs in SATA-mode at 1.5Gbps:

------

libata version 1.20 loaded.
ahci 0000:03:00.0: version 1.2
<...>
PCI: Setting latency timer of device 0000:03:00.0 to 64
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xF8814100 ctl 0x0 bmdma 0x0 irq 5
<...>
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
  Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0

------

(I see repeated output there ..)

The output of 'lspci -vv' for the JDM360 chipset is:

------

03:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (prog-if 01 [AHCI 1.0])
        Subsystem: ASRock Incorporation Unknown device 0360
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at c880 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at c480 [size=4]
        Region 4: I/O ports at c400 [size=16]
        Region 5: Memory at fe8fe000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Express Legacy Endpoint IRQ 1
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1

------

I'm running 2.6.16.14 without any apparent patches (obviously
through Lunar Linux).

So I'm wondering, is it just me .. or might the driver actually do
something wrong here? Could it be a mismatching PCI_ID?

Any hints on how I'd be able to solve this problem would be highly
appreciated. I can, of course, provide more data or apply some further
testing incase you want me to.

Please CC me as I'm not subscribed to the linux-ide mailinglist.
Thank you for your time and patience.

Regards,

Moritz Heiber
