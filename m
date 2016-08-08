From: Ondrej Zary <linux@rainbow-software.org>
Subject: DMA on master drive stopped working after adding a slave drive
Date: Mon, 8 Aug 2016 13:42:57 +0200
Message-ID: <201608081342.58181.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,
I have a weird problem with IDE DMA on Asus Eee PC 701.

The master drive is onboard 4GB CF-card-like SSD:
ata2.00: CFA: SILICONMOTION SM223AC, , max UDMA/66

2nd drive can be added through FLASH_CON connector - physically a mini PCI-e
slot but wired to the IDE controller. The connector was not populated on my
netbook so I soldered it and plugged a 2nd drive (slave) there:
ata2.01: CFA: ASUS-PHISON SSD, TST2.04U, max UDMA/66

BIOS sees both drives and kernel too. The problem is that adding this 2nd
drive killed DMA on the 1st one. Kernel is unable to read MBR and downgrades
UDMA modes until it disables DMA completely. DMA works fine on the slave drive:

[    1.372511] libata version 3.00 loaded.
[    1.375674] ahci 0000:00:1f.2: version 3.0
[    1.375965] ahci 0000:00:1f.2: controller is in combined mode, can't enable AHCI mode
[    1.386327] ata_piix 0000:00:1f.2: version 2.13
[    1.386610] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    1.423355] scsi0 : ata_piix
[    1.432739] scsi1 : ata_piix
[    1.433108] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
[    1.433218] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
[    1.616356] ata2.00: CFA: SILICONMOTION SM223AC, , max UDMA/66
[    1.616390] ata2.00: 7815024 sectors, multi 0: LBA
[    1.616416] ata2.01: CFA: ASUS-PHISON SSD, TST2.04U, max UDMA/66
[    1.616432] ata2.01: 7880544 sectors, multi 0: LBA
[    1.633197] ata2.00: configured for UDMA/66
[    1.640288] ata2.01: configured for UDMA/66
[    1.640661] scsi 1:0:0:0: Direct-Access     ATA      SILICONMOTION SM n/a  PQ: 0 ANSI: 5
[    1.642067] scsi 1:0:1:0: Direct-Access     ATA      ASUS-PHISON SSD  .04U PQ: 0 ANSI: 5
[    2.670905] sd 1:0:0:0: [sda] 7815024 512-byte logical blocks: (4.00 GB/3.72 GiB)
[    2.678935] sd 1:0:0:0: [sda] Write Protect is off
[    2.682525] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.683957] sd 1:0:1:0: [sdb] 7880544 512-byte logical blocks: (4.03 GB/3.75 GiB)
[    2.690096] sd 1:0:1:0: [sdb] Write Protect is off
[    2.693654] sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    2.693758] sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.701162] sd 1:0:1:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   32.872048] ata2: lost interrupt (Status 0x58)
[   32.876005] ata2: drained 65536 bytes to clear DRQ
[   32.955525] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   32.959493] ata2.00: failed command: READ DMA
[   32.963405] ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   32.971213] ata2.00: status: { DRDY }
[   32.975069] ata2: soft resetting link
[   33.164226] ata2.00: configured for UDMA/66
[   33.176224] ata2.01: configured for UDMA/66
[   33.179895] ata2.00: device reported invalid CHS sector 0
[   33.183586] ata2: EH complete
[   63.848050] ata2: lost interrupt (Status 0x58)
[   63.852005] ata2: drained 65536 bytes to clear DRQ
[   63.931326] ata2.00: limiting speed to UDMA/44:PIO4
[   63.935005] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   63.938716] ata2.00: failed command: READ DMA
[   63.942430] ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   63.949798] ata2.00: status: { DRDY }
[   63.953419] ata2: soft resetting link
[   64.144224] ata2.00: configured for UDMA/44
[   64.152225] ata2.01: configured for UDMA/66
[   64.155618] ata2.00: device reported invalid CHS sector 0
[   64.159035] ata2: EH complete
[   94.888050] ata2: lost interrupt (Status 0x58)
[   94.892005] ata2: drained 65536 bytes to clear DRQ
[   94.970957] ata2.00: limiting speed to UDMA/33:PIO4
[   94.974214] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   94.977477] ata2.00: failed command: READ DMA
[   94.980607] ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   94.986825] ata2.00: status: { DRDY }
[   94.989919] ata2: soft resetting link
[   95.180224] ata2.00: configured for UDMA/33
[   95.188224] ata2.01: configured for UDMA/66
[   95.191079] ata2.00: device reported invalid CHS sector 0
[   95.193990] ata2: EH complete
[  125.864051] ata2: lost interrupt (Status 0x58)
[  125.868005] ata2: drained 65536 bytes to clear DRQ
[  125.946485] ata2.00: limiting speed to PIO4
[  125.949324] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  125.952348] ata2.00: failed command: READ DMA
[  125.955327] ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  125.961491] ata2.00: status: { DRDY }
[  125.964596] ata2: soft resetting link
[  126.152224] ata2.00: configured for PIO4
[  126.160224] ata2.01: configured for UDMA/66
[  126.163057] ata2.00: device reported invalid CHS sector 0
[  126.165962] ata2: EH complete
[  126.170218]  sda: sda1 sda4
[  126.174713]  sdb: sdb1
[  126.177685] sda: detected capacity change from 0 to 4001292288
[  126.182155] sdb: detected capacity change from 0 to 4034838528
[  126.185277] sd 1:0:0:0: [sda] Attached SCSI disk
[  126.188286] sd 1:0:1:0: [sdb] Attached SCSI disk


Disabling the slave drive by libata.force=2.1:disable kernel parameter is
enough for the DMA to work again on the master drive:

[    1.353421] libata version 3.00 loaded.
[    2.590769] ahci 0000:00:1f.2: version 3.0
[    2.591015] ahci 0000:00:1f.2: controller is in combined mode, can't enable AHCI mode
[    2.594148] ata_piix 0000:00:1f.2: version 2.13
[    2.594430] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    2.655992] scsi0 : ata_piix
[    2.656611] scsi1 : ata_piix
[    2.656863] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
[    2.656873] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
[    2.836344] ata2.00: CFA: SILICONMOTION SM223AC, , max UDMA/66
[    2.836356] ata2.00: 7815024 sectors, multi 0: LBA
[    2.836373] ata2.01: FORCE: horkage modified (disable)
[    2.836380] ata2.01: unsupported device, disabling
[    2.836386] ata2.01: disabled
[    2.852223] ata2.00: configured for UDMA/66
[    2.852566] scsi 1:0:0:0: Direct-Access     ATA      SILICONMOTION SM n/a  PQ: 0 ANSI: 5
[    2.869386] sd 1:0:0:0: [sda] 7815024 512-byte logical blocks: (4.00 GB/3.72 GiB)
[    2.869556] sd 1:0:0:0: [sda] Write Protect is off
[    2.869567] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.869643] sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.871934]  sda: sda1 sda4
[    2.873566] sd 1:0:0:0: [sda] Attached SCSI disk

So it looks like configuring something on the slave drive causes it to disturb
the communication on the bus?
Forcing the slave drive to PIO does not help. What else can I try?

-- 
Ondrej Zary
