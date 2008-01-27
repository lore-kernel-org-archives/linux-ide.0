From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: 2.6.24 sata_sil Sil3114 drive clicking / restarting?
Date: Sun, 27 Jan 2008 13:19:49 -0500
Message-ID: <76366b180801271019w47e5fafan6ec6b7f3086e3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:62195 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYA0STu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 13:19:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1439852rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 10:19:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been noticing something strange on an AMD Geode LX board that I
have.. I have two SATA drives connected to the onboard Sil3114 chip,
and the drives appear to be continually restarting (soft resetting?)
during normal operation when nothing at all is happening on the
machine. You can hear the drives doing it as well as feel it
physically if you touch the drive. They are spinning down and back up
again over and over again. All the while the OS never prints out any
ata/scsi problems. The only manifestation of this in the kernel is
that if you're doing something w/ the drives, it pauses momentarily
while this happens (for instance, during an ext3 format).

I thought this might be a bad drive because smartctl listed some
errors, but I have a stack of drives here and after swapping out the
drive doing this, the replacement is doing it as well. These drives
are all new 1TB Hitachi drives less than 6 months old. Now, I'm
wondering if this is some Sil3114 problem w/ libata. Has anyone else
seen this type of behavior before with no errors showing up in the
console?

Thanks,
-Andrew

Some info (unknown partition tables are because these are an md RAID1 pair):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: , ATA DISK drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 256000 sectors (131 MB) w/0KiB Cache, CHS=500/16/32
 hda: hda1
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:00:11.0: version 2.3
ACPI: PCI Interrupt Link [LNKD] BIOS reported IRQ 0, using IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKD] -> GSI 10 (level,
low) -> IRQ 10
sata_sil 0000:00:11.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:00:11.0 to 64
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0xefffb000 tf 0xefffb080 irq 10
ata2: SATA max UDMA/100 mmio m1024@0xefffb000 tf 0xefffb0c0 irq 10
ata3: SATA max UDMA/100 mmio m1024@0xefffb000 tf 0xefffb280 irq 10
ata4: SATA max UDMA/100 mmio m1024@0xefffb000 tf 0xefffb2c0 irq 10
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/100
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: unknown partition table
sd 1:0:0:0: [sdb] Attached SCSI disk

# hdparm -i /dev/sda

/dev/sda:
hdparm: ioctl 0x304 failed: Inappropriate ioctl for device

 Model=Hitachi HDS721010KLA330                 , FwRev=GKAOA70F,
SerialNo=      GTJ000PAG2L50C
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=(3) DualPortCache, BuffSize=31157kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D rev.1:  ATA/ATAPI-2
ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * current active mode

# smartctl -a /dev/sda
...
=== START OF INFORMATION SECTION ===
Device Model:     Hitachi HDS721010KLA330
Serial Number:    GTJ000PAG2L50C
Firmware Version: GKAOA70F
User Capacity:    1,000,204,886,016 bytes
...
Error 1 occurred at disk power-on lifetime: 3 hours (0 days + 3 hours)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 a0 5f 06 15 ee  Error: ICRC, ABRT 160 sectors at LBA =
0x0e15065f = 236258911

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 00 06 15 e0 00      03:18:09.100  READ DMA EXT
  25 00 00 00 05 15 e0 00      03:18:09.100  READ DMA EXT
  25 00 80 80 04 15 e0 00      03:18:09.100  READ DMA EXT
  25 00 80 00 02 15 e0 00      03:18:09.100  READ DMA EXT
  25 00 00 00 01 15 e0 00      03:18:09.100  READ DMA EXT

# lspci -vvnnxxxx -s 00:11.0
00:11.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller [1095:3114] (rev 02)
        Subsystem: Silicon Image, Inc. SiI 3114 SATARaid Controller [1095:6114]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at fd00 [size=8]
        Region 1: I/O ports at fc00 [size=4]
        Region 2: I/O ports at fb00 [size=8]
        Region 3: I/O ports at fa00 [size=4]
        Region 4: I/O ports at f900 [size=16]
        Region 5: Memory at efffb000 (32-bit, non-prefetchable) [size=1K]
        [virtual] Expansion ROM at 10000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 14 31 07 00 b0 02 02 00 04 01 08 40 00 00
10: 01 fd 00 00 01 fc 00 00 01 fb 00 00 01 fa 00 00
20: 01 f9 00 00 00 b0 ff ef 00 00 00 00 95 10 14 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 60 00 00 b0 1a 0f 00 00 60 00 00 a0 1a 0f
80: 03 00 00 00 03 00 00 00 00 00 00 00 3f 7f e9 d7
90: 00 00 00 08 ff ff 00 00 00 00 00 19 00 00 00 00
a0: 01 31 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 31 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
