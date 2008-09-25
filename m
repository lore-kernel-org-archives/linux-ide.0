From: "George Spelvin" <linux@horizon.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Wed, 24 Sep 2008 23:24:37 -0400
Message-ID: <20080925032437.6802.qmail@science.horizon.com>
References: <20080920151712.10515.qmail@science.horizon.com>
 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
 <20080921001529.23400.qmail@science.horizon.com>
 <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
 <48DA0C8B.3000406@gmail.com>
 <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:12496 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752286AbYIYDYl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 23:24:41 -0400
In-Reply-To: <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mdnelson8@gmail.com, htejun@gmail.com
Cc: Shane.Huang@amd.com, linux@horizon.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

Just a little followup... I currently have the machine with 8 GB RAM,
all 4 SB600 channels populated, and 64-bit DMA enabled, operating in
production.  No problems so far.

Q: Does the fact that I'm using the GART IOMMU mean that I'm not really using
64-bit DMA at all?

> PCI: Using ACPI for IRQ routing
> pci 0000:00:00.0: BAR 3: can't allocate resource
> PCI-DMA: Disabling AGP.
> PCI-DMA: aperture base @ 20000000 size 65536 KB
> PCI-DMA: using GART IOMMU.
> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> hpet0: 4 32-bit timers, 14318180 Hz
> ACPI: RTC can wake from S4
> Switched to high resolution mode on CPU 0
> Switched to high resolution mode on CPU 2
> Switched to high resolution mode on CPU 1
> Switched to high resolution mode on CPU 3


# lspci -s 00:12.0 -vvv -nn -xxx
00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380] (prog-if 01)
        Subsystem: Micro-Star International Co., Ltd. Device [1462:7378]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 8000 [size=8]
        Region 1: I/O ports at 7000 [size=4]
        Region 2: I/O ports at 6000 [size=8]
        Region 3: I/O ports at 5000 [size=4]
        Region 4: I/O ports at 4000 [size=16]
        Region 5: Memory at fe7ff800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ahci
00: 02 10 80 43 07 01 30 02 00 01 06 01 10 40 00 00
10: 01 80 00 00 01 70 00 00 01 60 00 00 01 50 00 00
20: 01 40 00 00 00 f8 7f fe 00 00 00 00 62 14 78 73
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 10 00 80 02 01 00 10 00 01 00 00 00 00 00 00 00
50: 05 00 84 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 12 00 10 00 0f 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 06 00 00 2c d6 01 b4 00 d6 01 b4 00
90: d6 01 b4 00 d6 01 b4 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 78 00 00 00 00 00 00 00 78 00 00
b0: 00 00 00 00 00 78 00 00 00 00 00 00 00 78 00 00
c0: 00 20 00 00 80 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# lspci -s 02:00.0 -vvv -nn -xxx
02:00.0 RAID bus controller [0104]: Promise Technology, Inc. Device [105a:3f20]
        Subsystem: Micro-Star International Co., Ltd. Device [1462:3716]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at a800 [size=128]
        Region 2: I/O ports at a400 [size=256]
        Region 3: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fe9c0000 (32-bit, non-prefetchable) [size=128K]
        Region 5: Memory at fe9fc000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [94] SATA HBA <?>
        Capabilities: [100] Advanced Error Reporting <?>
        Capabilities: [140] Virtual Channel <?>
        Capabilities: [160] Device Serial Number 01-00-00-00-02-00-00-00
        Capabilities: [170] Power Budgeting <?>
        Kernel driver in use: ahci
00: 5a 10 20 3f 07 01 10 00 00 00 04 01 10 00 00 00
10: 01 a8 00 00 00 00 00 00 01 a4 00 00 00 f0 9f fe
20: 00 00 9c fe 00 c0 9f fe 00 00 00 00 62 14 16 37
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 70 22 02 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 70 80 00 00 00 fa df 5a 00 00 00 00 00 00 00
70: 10 94 11 00 01 00 00 00 10 28 0a 00 11 0c 00 00
80: 42 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 12 00 10 00 46 02 00 00 09 00 4c 01
a0: 01 1c 00 00 fb ff ff 00 07 20 16 1b 38 81 0b 00
b0: de d0 0b 00 be 0d 00 00 02 28 11 00 00 00 00 00
c0: 00 02 00 00 03 00 03 00 00 00 00 00 10 00 20 09
d0: 0a 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


dmesg excerpt:
ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe7ff800 port 0xfe7ff900 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe7ff800 port 0xfe7ff980 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe7ff800 port 0xfe7ffa00 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe7ff800 port 0xfe7ffa80 irq 22
ata1: softreset failed (device not ready)
ata1: failed due to HW bug, retry pmp=0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata1.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/133
ata2: softreset failed (device not ready)
ata2: failed due to HW bug, retry pmp=0
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata2.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: SB600 AHCI: limiting to 255 sectors per cmd
ata2.00: SB600 AHCI: limiting to 255 sectors per cmd
ata2.00: configured for UDMA/133
ata3: softreset failed (device not ready)
ata3: failed due to HW bug, retry pmp=0
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata3.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: configured for UDMA/133
ata4: softreset failed (device not ready)
ata4: failed due to HW bug, retry pmp=0
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata4.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 2:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3 sdc4
sd 2:0:0:0: [sdc] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2 sdd3 sdd4
sd 3:0:0:0: [sdd] Attached SCSI disk
ahci 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
ahci 0000:02:00.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl RAID mode
ahci 0000:02:00.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
ahci 0000:02:00.0: setting latency timer to 64
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
scsi7 : ahci
ata5: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc100 irq 17
ata6: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc180 irq 17
ata7: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc200 irq 17
ata8: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc280 irq 17
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
ata5.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata5.00: configured for UDMA/133
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata6.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/133
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
scsi 4:0:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 4:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sde: sde1 sde2 sde3 sde4
sd 4:0:0:0: [sde] Attached SCSI disk
scsi 5:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1 sdf2 sdf3 sdf4
sd 5:0:0:0: [sdf] Attached SCSI disk

