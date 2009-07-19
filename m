From: "Benjamin S." <sbenni@gmx.de>
Subject: ahci sometimes fails to suspend controller
Date: Sun, 19 Jul 2009 22:04:23 +0200
Message-ID: <20090719220423.54e8c75d@uranus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751047AbZGSUE1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Jul 2009 16:04:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hello,

I have a Gigabyte GA-MA78G-DS3H mainboard with SB700 chipset and the 
controller is recognized by ahci. It works great until I have suspended 
(to ram) and resumed my system several times and then the kernel fails
to suspend (or maybe resume). Please note that although it happened
the first time I have suspend in the case of the dmesg output below, it 
usually sometimes works and sometimes not.

part of lspci -v:
 00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [IDE mode] (prog-if 01
[AHCI 1.0]) Subsystem: Giga-byte Technology Device b002
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 27
        I/O ports at ff00 [size=8]
        I/O ports at fe00 [size=4]
        I/O ports at fd00 [size=8]
        I/O ports at fc00 [size=4]
        I/O ports at fb00 [size=16]
        Memory at fe02f000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable+
        Capabilities: [70] SATA HBA <?>
        Kernel driver in use: ahci
        Kernel modules: ahci

dmesg after resume (I know that fglrx taints the kernel, but
the same happens with radeonhd)
: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.900156] usb usb2: Product: EHCI Host Controller
[    2.900192] usb usb2: Manufacturer: Linux 2.6.30 ehci_hcd
[    2.900227] usb usb2: SerialNumber: 0000:00:12.2
[    2.900300] PM: Adding info for usb:usb2
[    2.900327] usb usb2: configuration #1 chosen from 1 choice
[    2.900381] PM: Adding info for usb:2-0:1.0
[    2.900397] hub 2-0:1.0: USB hub found
[    2.900439] hub 2-0:1.0: 6 ports detected
[    2.900518] PM: Adding info for No Bus:usbdev2.1_ep81
[    2.900540] PM: Adding info for No Bus:usbdev2.1
[    2.900574] PM: Adding info for No Bus:usbdev2.1_ep00
[    2.900640] ahci 0000:00:11.0: version 3.0
[    2.900664] ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    2.900760] ahci 0000:00:11.0: irq 27 for MSI/MSI-X
[    2.900868] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    2.900910] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.900917] Uniform Multi-Platform E-IDE driver
[    2.901390] scsi0 : ahci
[    2.901606] PM: Adding info for No Bus:host0
[    2.901630] PM: Adding info for No Bus:host0
[    2.901674] scsi1 : ahci
[    2.901724] PM: Adding info for No Bus:host1
[    2.901743] PM: Adding info for No Bus:host1
[    2.901772] scsi2 : ahci
[    2.901813] PM: Adding info for No Bus:host2
[    2.901831] PM: Adding info for No Bus:host2
[    2.901866] scsi3 : ahci
[    2.901906] PM: Adding info for No Bus:host3
[    2.901925] PM: Adding info for No Bus:host3
[    2.902022] ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 27
[    2.902063] ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 27
[    2.902104] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 27
[    2.902145] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 27
[    2.902280] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.902338] ohci_hcd 0000:00:12.1: OHCI Host Controller
[    2.902388] PM: Adding info for No Bus:usb_host3
[    2.902438] PM: Adding info for No Bus:usbmon3
[    2.902448] ohci_hcd 0000:00:12.1: new USB bus registered, assigned bus number 3
[    2.902508] ohci_hcd 0000:00:12.1: irq 16, io mem 0xfe02d000
[    2.960065] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.960108] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.960147] usb usb3: Product: OHCI Host Controller
[    2.960183] usb usb3: Manufacturer: Linux 2.6.30 ohci_hcd
[    2.960219] usb usb3: SerialNumber: 0000:00:12.1
[    2.960302] PM: Adding info for usb:usb3
[    2.960347] usb usb3: configuration #1 chosen from 1 choice
[    2.960401] PM: Adding info for usb:3-0:1.0
[    2.960417] hub 3-0:1.0: USB hub found
[    2.960463] hub 3-0:1.0: 3 ports detected
[    2.960530] PM: Adding info for No Bus:usbdev3.1_ep81
[    2.960553] PM: Adding info for No Bus:usbdev3.1
[    2.960588] PM: Adding info for No Bus:usbdev3.1_ep00
[    2.976063] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    2.976128] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    2.976192] PM: Adding info for No Bus:usb_host4
[    2.976262] PM: Adding info for No Bus:usbmon4
[    2.976272] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
[    2.976343] ehci_hcd 0000:00:13.2: applying AMD SB600/SB700 USB freeze workaround
[    2.976400] ehci_hcd 0000:00:13.2: debug port 1
[    2.976468] ehci_hcd 0000:00:13.2: irq 19, io mem 0xfe029000
[    2.988062] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.988133] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.988171] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.988213] usb usb4: Product: EHCI Host Controller
[    2.988250] usb usb4: Manufacturer: Linux 2.6.30 ehci_hcd
[    2.988287] usb usb4: SerialNumber: 0000:00:13.2
[    2.988379] PM: Adding info for usb:usb4
[    2.988413] usb usb4: configuration #1 chosen from 1 choice
[    2.988472] PM: Adding info for usb:4-0:1.0
[    2.988489] hub 4-0:1.0: USB hub found
[    2.988539] hub 4-0:1.0: 6 ports detected
[    2.988622] PM: Adding info for No Bus:usbdev4.1_ep81
[    2.988646] PM: Adding info for No Bus:usbdev4.1
[    2.988682] PM: Adding info for No Bus:usbdev4.1_ep00
[    2.988787] atiixp 0000:00:14.1: IDE controller (0x1002:0x439c rev 0x00)
[    2.988835] ATIIXP_IDE 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.988899] atiixp 0000:00:14.1: not 100% native mode: will probe irqs later
[    2.988943]     ide0: BM-DMA at 0xfa00-0xfa07
[    2.988987]     ide1: BM-DMA at 0xfa08-0xfa0f
[    2.989028] Probing IDE interface ide0...
[    3.224040] ata4: SATA link down (SStatus 0 SControl 300)
[    3.224107] ata1: SATA link down (SStatus 0 SControl 300)
[    3.224167] ata2: SATA link down (SStatus 0 SControl 300)
[    3.224229] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.225067] ata3.00: HPA detected: current 1250261615, native 1250263728
[    3.225106] ata3.00: ATA-8: WDC WD6400AAKS-00A7B0, 01.03B01, max UDMA/133
[    3.225144] ata3.00: 1250261615 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.226054] ata3.00: configured for UDMA/133
[    3.240162] scsi 2:0:0:0: Direct-Access     ATA      WDC WD6400AAKS-0 01.0 PQ: 0 ANSI: 5
[    3.240220] PM: Adding info for No Bus:target2:0:0
[    3.240243] PM: Adding info for scsi:2:0:0:0
[    3.240270] PM: Adding info for No Bus:2:0:0:0
[    3.240313] PM: Adding info for No Bus:2:0:0:0
[    3.426010] Driver 'sd' needs updating - please use bus_type methods
[    3.426115] PM: Adding info for No Bus:2:0:0:0
[    3.426196] sd 2:0:0:0: [sda] 1250261615 512-byte hardware sectors: (640 GB/596 GiB)
[    3.426250] sd 2:0:0:0: [sda] Write Protect is off
[    3.426287] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.426308] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.426370] PM: Adding info for No Bus:sda
[    3.426433]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
[    3.484578] PM: Adding info for No Bus:sda1
[    3.484613] PM: Adding info for No Bus:sda2
[    3.484640] PM: Adding info for No Bus:sda3
[    3.484667] PM: Adding info for No Bus:sda5
[    3.484694] PM: Adding info for No Bus:sda6
[    3.484721] PM: Adding info for No Bus:sda7
[    3.484748] PM: Adding info for No Bus:sda8
[    3.484774] PM: Adding info for No Bus:sda9
[    3.484802] PM: Adding info for No Bus:sda10
[    3.484828] PM: Adding info for No Bus:sda11
[    3.484991] PM: Adding info for No Bus:8:0
[    3.485009] sd 2:0:0:0: [sda] Attached SCSI disk
[    3.719826] usb 1-2: new full speed USB device using ohci_hcd and address 2
[    3.885109] usb 1-2: New USB device found, idVendor=0489, idProduct=e000
[    3.885150] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.885188] usb 1-2: Product: TC 300
[    3.885224] usb 1-2: Manufacturer: Silicon Labs
[    3.885259] usb 1-2: SerialNumber: 0001
[    3.885345] PM: Adding info for usb:1-2
[    3.885376] usb 1-2: configuration #1 chosen from 1 choice
[    3.891829] PM: Adding info for usb:1-2:1.0
[    3.892159] PM: Adding info for No Bus:usbdev1.2_ep81
[    3.892195] PM: Adding info for No Bus:usbdev1.2_ep01
[    3.892220] PM: Adding info for No Bus:usbdev1.2
[    3.892261] PM: Adding info for No Bus:usbdev1.2_ep00
[    4.064034] hdb: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
[    4.064155] PM: Adding info for No Bus:ide0
[    4.064168] PM: Adding info for No Bus:ide0
[    4.064188] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    4.064990] hdb: UDMA/33 mode selected
[    4.065469] Probing IDE interface ide1...
[    4.152017] usb 1-3: new full speed USB device using ohci_hcd and address 3
[    4.319122] usb 1-3: New USB device found, idVendor=04a9, idProduct=220e
[    4.319160] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.319197] usb 1-3: Product: CanoScan
[    4.319233] usb 1-3: Manufacturer: Canon
[    4.319319] PM: Adding info for usb:1-3
[    4.319350] usb 1-3: configuration #1 chosen from 1 choice
[    4.325664] PM: Adding info for usb:1-3:1.0
[    4.325716] PM: Adding info for No Bus:usbdev1.3_ep81
[    4.325749] PM: Adding info for No Bus:usbdev1.3_ep82
[    4.325781] PM: Adding info for No Bus:usbdev1.3_ep03
[    4.325806] PM: Adding info for No Bus:usbdev1.3
[    4.325845] PM: Adding info for No Bus:usbdev1.3_ep00
[    4.588016] usb 3-1: new full speed USB device using ohci_hcd and address 2
[    4.632025] PM: Adding info for No Bus:ide1
[    4.632037] PM: Adding info for No Bus:ide1
[    4.632079] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.635832] ide1 at 0x170-0x177,0x376 on irq 15
[    4.635946] PM: Adding info for ide:0.1
[    4.636174] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    4.636231] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    4.636283] PM: Adding info for No Bus:usb_host5
[    4.636335] PM: Adding info for No Bus:usbmon5
[    4.636345] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[    4.636419] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02b000
[    4.656128] ide-cd driver 5.00
[    4.656191] PM: Adding info for No Bus:0.1
[    4.658671] ide-cd: hdb: ATAPI 40X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
[    4.658893] Uniform CD-ROM driver Revision: 3.20
[    4.681788] PM: Adding info for No Bus:hdb
[    4.681839] PM: Adding info for No Bus:3:64
[    4.696035] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    4.696076] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.696116] usb usb5: Product: OHCI Host Controller
[    4.696151] usb usb5: Manufacturer: Linux 2.6.30 ohci_hcd
[    4.696188] usb usb5: SerialNumber: 0000:00:13.0
[    4.696265] PM: Adding info for usb:usb5
[    4.696293] usb usb5: configuration #1 chosen from 1 choice
[    4.696346] PM: Adding info for usb:5-0:1.0
[    4.696363] hub 5-0:1.0: USB hub found
[    4.696408] hub 5-0:1.0: 3 ports detected
[    4.696475] PM: Adding info for No Bus:usbdev5.1_ep81
[    4.696501] PM: Adding info for No Bus:usbdev5.1
[    4.696547] PM: Adding info for No Bus:usbdev5.1_ep00
[    4.696646] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    4.696706] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    4.696757] PM: Adding info for No Bus:usb_host6
[    4.696795] PM: Adding info for No Bus:usbmon6
[    4.696805] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 6
[    4.696866] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfe02a000
[    4.760038] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    4.760081] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.760121] usb usb6: Product: OHCI Host Controller
[    4.760157] usb usb6: Manufacturer: Linux 2.6.30 ohci_hcd
[    4.760194] usb usb6: SerialNumber: 0000:00:13.1
[    4.760280] PM: Adding info for usb:usb6
[    4.760312] usb usb6: configuration #1 chosen from 1 choice
[    4.760368] PM: Adding info for usb:6-0:1.0
[    4.760387] hub 6-0:1.0: USB hub found
[    4.760434] hub 6-0:1.0: 3 ports detected
[    4.760506] PM: Adding info for No Bus:usbdev6.1_ep81
[    4.760531] PM: Adding info for No Bus:usbdev6.1
[    4.760569] PM: Adding info for No Bus:usbdev6.1_ep00
[    4.773235] usb 3-1: New USB device found, idVendor=1532, idProduct=00fb
[    4.773277] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.773315] usb 3-1: Product: Habu Mouse
[    4.773350] usb 3-1: Manufacturer: Tempest
[    4.773443] PM: Adding info for usb:3-1
[    4.773475] usb 3-1: configuration #1 chosen from 1 choice
[    4.779985] PM: Adding info for usb:3-1:1.0
[    4.780047] PM: Adding info for No Bus:usbdev3.2_ep81
[    4.780076] PM: Adding info for No Bus:usbdev3.2
[    4.780116] PM: Adding info for No Bus:usbdev3.2_ep00
[    4.818961] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.819020] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    4.819074] PM: Adding info for No Bus:usb_host7
[    4.819114] PM: Adding info for No Bus:usbmon7
[    4.819124] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
[    4.819186] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe028000
[    4.880032] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    4.880073] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.880114] usb usb7: Product: OHCI Host Controller
[    4.880150] usb usb7: Manufacturer: Linux 2.6.30 ohci_hcd
[    4.880186] usb usb7: SerialNumber: 0000:00:14.5
[    4.880274] PM: Adding info for usb:usb7
[    4.880307] usb usb7: configuration #1 chosen from 1 choice
[    4.880363] PM: Adding info for usb:7-0:1.0
[    4.880382] hub 7-0:1.0: USB hub found
[    4.880428] hub 7-0:1.0: 2 ports detected
[    4.880497] PM: Adding info for No Bus:usbdev7.1_ep81
[    4.880522] PM: Adding info for No Bus:usbdev7.1
[    4.880559] PM: Adding info for No Bus:usbdev7.1_ep00
[    4.977944] usbcore: registered new interface driver hiddev
[    4.978030] PM: Adding info for hid:0003:1532:00FB.0001
[    4.995045] PM: Adding info for No Bus:input1
[    4.995094] input: Tempest Habu Mouse as /class/input/input1
[    4.995165] PM: Adding info for No Bus:mouse0
[    4.995192] PM: Adding info for No Bus:hidraw0
[    4.995205] generic-usb 0003:1532:00FB.0001: input,hidraw0: USB HID v1.00 Mouse [Tempest Habu Mouse] on usb-0000:00:12.1-1/input0
[    4.995267] usbcore: registered new interface driver usbhid
[    4.995304] usbhid: v2.6:USB HID core driver
[    5.153671] device-mapper: uevent: version 1.0.3
[    5.160323] PM: Adding info for No Bus:device-mapper
[    5.160344] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[    5.234501] PM: Adding info for No Bus:dm-0
[    5.234538] PM: Adding info for No Bus:254:0
[    5.355210] PM: Starting manual resume from disk
[    5.356940] PM: Resume from partition 8:1
[    5.356941] PM: Checking hibernation image.
[    5.357117] PM: Resume from disk failed.
[    5.366016] REISERFS (device dm-0): found reiserfs format "3.6" with standard journal
[    5.366075] REISERFS (device dm-0): using ordered data mode
[    5.379320] REISERFS (device dm-0): journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[    5.380497] REISERFS (device dm-0): checking transaction log (dm-0)
[    5.423845] REISERFS (device dm-0): Using r5 hash to sort names
[    6.291027] udevd version 125 started
[    7.439916] PM: Adding info for No Bus:event0
[    7.439949] PM: Adding info for No Bus:event1
[    8.291961] PM: Adding info for No Bus:cooling_device0
[    8.291976] processor ACPI_CPU:00: registered as cooling_device0
[    8.292063] PM: Adding info for No Bus:cooling_device1
[    8.292074] processor ACPI_CPU:01: registered as cooling_device1
[    8.304296] PM: Adding info for No Bus:input2
[    8.304335] input: Power Button as /class/input/input2
[    8.304409] PM: Adding info for No Bus:event2
[    8.304420] ACPI: Power Button [PWRF]
[    8.304498] PM: Adding info for No Bus:input3
[    8.304566] input: Power Button as /class/input/input3
[    8.304619] PM: Adding info for No Bus:event3
[    8.304629] ACPI: Power Button [PWRB]
[    8.635000] PM: Adding info for No Bus:timer
[    8.700067] PM: Adding info for No Bus:seq
[    8.765081] PM: Adding info for No Bus:sequencer
[    8.765104] PM: Adding info for No Bus:sequencer2
[    8.876937] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    8.877018] PM: Adding info for No Bus:i2c-0
[    8.909091] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    8.955281] PM: Adding info for No Bus:input4
[    8.955347] input: PC Speaker as /class/input/input4
[    8.955427] PM: Adding info for No Bus:event4
[    9.203479] PM: Adding info for No Bus:pcmC0D2c
[    9.203522] PM: Adding info for No Bus:pcmC0D1p
[    9.203549] PM: Adding info for No Bus:pcmC0D1c
[    9.203577] PM: Adding info for No Bus:adsp
[    9.203607] PM: Adding info for No Bus:pcmC0D0p
[    9.203636] PM: Adding info for No Bus:pcmC0D0c
[    9.203663] PM: Adding info for No Bus:dsp
[    9.203688] PM: Adding info for No Bus:audio
[    9.203719] PM: Adding info for No Bus:controlC0
[    9.203755] PM: Adding info for No Bus:mixer
[    9.204471] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    9.204546] HDA Intel 0000:01:05.1: setting latency timer to 64
[    9.363729] PM: Adding info for No Bus:pcmC1D3p
[    9.363771] PM: Adding info for No Bus:controlC1
[    9.363808] PM: Adding info for No Bus:mixer1
[   10.404273] Adding 7823612k swap on /dev/sda1.  Priority:-1 extents:1 across:7823612k 
[   16.412428] it87: Found IT8718F chip at 0x228, revision 5
[   16.412478] it87: in3 is VCC (+5V)
[   16.412587] PM: Adding info for platform:it87.552
[   16.412848] PM: Adding info for No Bus:hwmon0
[   16.450930] PM: Adding info for No Bus:loop0
[   16.450960] PM: Adding info for No Bus:7:0
[   16.450994] PM: Adding info for No Bus:loop1
[   16.451016] PM: Adding info for No Bus:7:1
[   16.451055] PM: Adding info for No Bus:loop2
[   16.451075] PM: Adding info for No Bus:7:2
[   16.451099] PM: Adding info for No Bus:loop3
[   16.451119] PM: Adding info for No Bus:7:3
[   16.451144] PM: Adding info for No Bus:loop4
[   16.451164] PM: Adding info for No Bus:7:4
[   16.451190] PM: Adding info for No Bus:loop5
[   16.451209] PM: Adding info for No Bus:7:5
[   16.451240] PM: Adding info for No Bus:loop6
[   16.451260] PM: Adding info for No Bus:7:6
[   16.451286] PM: Adding info for No Bus:loop7
[   16.451306] PM: Adding info for No Bus:7:7
[   16.451317] loop: module loaded
[   16.974190] PM: Adding info for No Bus:dm-1
[   16.974229] PM: Adding info for No Bus:254:1
[   17.007534] PM: Adding info for No Bus:dm-2
[   17.007573] PM: Adding info for No Bus:254:2
[   17.043432] PM: Adding info for No Bus:dm-3
[   17.043472] PM: Adding info for No Bus:254:3
[   17.220161] fuse init (API version 7.11)
[   17.220366] PM: Adding info for No Bus:fuse
[   17.252146] REISERFS (device sda7): found reiserfs format "3.6" with standard journal
[   17.252222] REISERFS (device sda7): using ordered data mode
[   17.261857] REISERFS (device sda7): journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   17.263012] REISERFS (device sda7): checking transaction log (sda7)
[   17.275402] REISERFS (device sda7): Using r5 hash to sort names
[   17.367909] EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
[   17.368723] REISERFS (device dm-1): found reiserfs format "3.6" with standard journal
[   17.368799] REISERFS (device dm-1): using ordered data mode
[   17.375424] REISERFS (device dm-1): journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   17.376633] REISERFS (device dm-1): checking transaction log (dm-1)
[   17.409218] REISERFS (device dm-1): Using r5 hash to sort names
[   17.485816] REISERFS (device sda11): found reiserfs format "3.6" with standard journal
[   17.485903] REISERFS (device sda11): using ordered data mode
[   17.490321] REISERFS (device sda11): journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   17.491509] REISERFS (device sda11): checking transaction log (sda11)
[   17.552999] REISERFS (device sda11): Using r5 hash to sort names
[   18.154070] Bridge firewalling registered
[   18.161021] PM: Adding info for No Bus:br0
[   18.171829] device eth0 entered promiscuous mode
[   18.173665] r8169: eth0: link up
[   18.173709] r8169: eth0: link up
[   18.178436] br0: port 1(eth0) entering learning state
[   33.176016] br0: port 1(eth0) entering forwarding state
[   37.812784] NET: Registered protocol family 10
[   37.813914] lo: Disabled Privacy Extensions
[   38.687710] PM: Adding info for No Bus:vcs2
[   38.687750] PM: Adding info for No Bus:vcsa2
[   38.709667] PM: Adding info for No Bus:vcs3
[   38.709704] PM: Adding info for No Bus:vcsa3
[   38.729220] PM: Adding info for No Bus:vcs4
[   38.729258] PM: Adding info for No Bus:vcsa4
[   38.749706] PM: Adding info for No Bus:vcs5
[   38.749744] PM: Adding info for No Bus:vcsa5
[   38.805207] PM: Adding info for No Bus:vcs6
[   38.805247] PM: Adding info for No Bus:vcsa6
[   39.724696] powernow-k8: Found 1 AMD Athlon(tm) Dual Core Processor 4850e processors (2 cpu cores) (version 2.20.00)
[   39.724784] powernow-k8:    0 : fid 0x11 (2500 MHz), vid 0xc
[   39.724787] powernow-k8:    1 : fid 0x10 (2400 MHz), vid 0xd
[   39.724790] powernow-k8:    2 : fid 0xe (2200 MHz), vid 0xf
[   39.724792] powernow-k8:    3 : fid 0xc (2000 MHz), vid 0x11
[   39.724795] powernow-k8:    4 : fid 0xa (1800 MHz), vid 0x13
[   39.724797] powernow-k8:    5 : fid 0x2 (1000 MHz), vid 0x16
[   41.000522] Clocksource tsc unstable (delta = -297659657 ns)
[   42.527917] PM: Adding info for No Bus:kvm
[   48.756015] eth0: no IPv6 routers present
[   48.776016] br0: no IPv6 routers present
[   57.442347] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[   57.442411] Disabling lock debugging due to kernel taint
[   57.508574] [fglrx] Maximum main memory to use for locked dma buffers: 3480 MBytes.
[   57.508672] [fglrx]   vendor: 1002 device: 9610 count: 1
[   57.509272] [fglrx] ioport: bar 1, base 0xee00, size: 0x100
[   57.509341] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   57.509393] pci 0000:01:05.0: setting latency timer to 64
[   57.510653] [fglrx] Driver built-in PAT support is enabled successfully
[   57.510794] [fglrx] module loaded - fglrx 8.62.4 [May 20 2009] with 1 minors
[   63.914070] PM: Adding info for No Bus:vcs7
[   63.914153] PM: Adding info for No Bus:vcsa7
[   65.306942] [fglrx] GART Table is not in FRAME_BUFFER range 
[   65.308065] [fglrx] Firegl kernel thread PID: 3181
[   65.331865] [fglrx] Gart USWC size:1135 M.
[   65.331870] [fglrx] Gart cacheable size:450 M.
[   65.331877] [fglrx] Reserved FB block: Shared offset:0, size:1000000 
[   65.331882] [fglrx] Reserved FB block: Unshared offset:fffc000, size:4000 
[   65.353036] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7481f57000,handle:0xc0000000
[   65.548577] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[   65.559419] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea8000,handle:0xc120e000
[   65.578142] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea7000,handle:0xc1212000
[   65.578208] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487cd2000,handle:0xc1213000
[   66.154011] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747ff6e000,handle:0xfdfe0000
[   66.154401] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f5eb000,handle:0xc1214000
[   66.160119] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f5eb000,handle:0xc1214000
[   66.215859] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f560000,handle:0xfdfe0000
[   66.316474] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f560000,handle:0xfdfe0000
[   66.316900] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747ff6e000,handle:0xfdfe0000
[   66.317017] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[   66.317289] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7481f57000,handle:0xc0000000
[   66.317709] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487cd2000,handle:0xc1213000
[   66.317755] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea7000,handle:0xc1212000
[   66.317772] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea8000,handle:0xc120e000
[   66.319499] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f560000,handle:0xfdfe0000
[   66.319523] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747ff6e000,handle:0xfdfe0000
[   66.319539] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[   66.319554] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7481f57000,handle:0xc0000000
[   66.319592] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487cd2000,handle:0xc1213000
[   66.319609] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea7000,handle:0xc1212000
[   66.319623] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea8000,handle:0xc120e000
[   66.710814] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f560000,handle:0xfdfe0000
[   66.710917] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747ff6e000,handle:0xfdfe0000
[   66.711026] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[   66.711319] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7481f57000,handle:0xc0000000
[   66.711787] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487cd2000,handle:0xc1213000
[   66.711835] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea7000,handle:0xc1212000
[   66.711852] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea8000,handle:0xc120e000
[   66.713544] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747f560000,handle:0xfdfe0000
[   66.713567] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f747ff6e000,handle:0xfdfe0000
[   66.713581] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[   66.713597] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7481f57000,handle:0xc0000000
[   66.713635] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487cd2000,handle:0xc1213000
[   66.713652] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea7000,handle:0xc1212000
[   66.713665] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f7487ea8000,handle:0xc120e000
[ 2737.052052] usb 2-1: new high speed USB device using ehci_hcd and address 5
[ 2737.896658] usb 2-1: New USB device found, idVendor=0000, idProduct=0000
[ 2737.896674] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2737.896682] usb 2-1: Product: USB
[ 2737.896687] usb 2-1: Manufacturer: SMI Corporation
[ 2737.896693] usb 2-1: SerialNumber: AA627082800700000495
[ 2737.896835] PM: Adding info for usb:2-1
[ 2737.896925] usb 2-1: configuration #1 chosen from 1 choice
[ 2737.897313] PM: Adding info for usb:2-1:1.0
[ 2737.897442] PM: Adding info for No Bus:usbdev2.5_ep81
[ 2737.897534] PM: Adding info for No Bus:usbdev2.5_ep02
[ 2737.897599] PM: Adding info for No Bus:usbdev2.5
[ 2737.897714] PM: Adding info for No Bus:usbdev2.5_ep00
[ 2738.024288] Initializing USB Mass Storage driver...
[ 2738.038884] scsi4 : SCSI emulation for USB Mass Storage devices
[ 2738.038908] PM: Adding info for No Bus:host4
[ 2738.038934] PM: Adding info for No Bus:host4
[ 2738.045547] usbcore: registered new interface driver usb-storage
[ 2738.045550] USB Mass Storage support registered.
[ 2738.070220] usb-storage: device found at 5
[ 2738.070224] usb-storage: waiting for device to settle before scanning
[ 2743.069048] usb-storage: device scan complete
[ 2743.070196] scsi 4:0:0:0: Direct-Access     ST       8GB              0000 PQ: 0 ANSI: 0 CCS
[ 2743.070840] PM: Adding info for No Bus:target4:0:0
[ 2743.070908] PM: Adding info for scsi:4:0:0:0
[ 2743.071022] PM: Adding info for No Bus:4:0:0:0
[ 2743.071132] PM: Adding info for No Bus:4:0:0:0
[ 2743.073646] PM: Adding info for No Bus:4:0:0:0
[ 2743.075785] sd 4:0:0:0: [sdb] 15663104 512-byte hardware sectors: (8.01 GB/7.46 GiB)
[ 2743.076850] sd 4:0:0:0: [sdb] Write Protect is off
[ 2743.076858] sd 4:0:0:0: [sdb] Mode Sense: 43 00 00 00
[ 2743.076864] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[ 2743.076944] PM: Adding info for No Bus:sdb
[ 2743.080138] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[ 2743.080159]  sdb: sdb1
[ 2743.081772] PM: Adding info for No Bus:sdb1
[ 2743.081989] PM: Adding info for No Bus:8:16
[ 2743.082039] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[ 2743.544865] FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[ 2902.333585] usb 2-1: USB disconnect, address 5
[ 2902.333622] PM: Removing info for No Bus:usbdev2.5_ep81
[ 2902.333807] PM: Removing info for No Bus:usbdev2.5_ep02
[ 2902.333922] PM: Removing info for usb:2-1:1.0
[ 2902.334035] PM: Removing info for No Bus:4:0:0:0
[ 2902.334134] PM: Removing info for No Bus:4:0:0:0
[ 2902.334207] PM: Removing info for scsi:4:0:0:0
[ 2902.334308] PM: Removing info for No Bus:4:0:0:0
[ 2902.334418] PM: Removing info for No Bus:sdb1
[ 2902.334559] PM: Removing info for No Bus:8:16
[ 2902.334668] PM: Removing info for No Bus:sdb
[ 2902.334864] PM: Removing info for No Bus:target4:0:0
[ 2902.334901] PM: Removing info for No Bus:host4
[ 2902.335002] PM: Removing info for No Bus:host4
[ 2902.336872] PM: Removing info for No Bus:usbdev2.5_ep00
[ 2902.337011] PM: Removing info for usb:2-1
[ 2902.337208] PM: Removing info for No Bus:usbdev2.5
[ 3080.486286] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7fcdde0f8000,handle:0xfdfe0000
[ 3080.496789] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7fcddd88a000,handle:0xc1218000
[ 3080.499623] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7fcddd88a000,handle:0xc1218000
[ 3080.529442] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7fcdde0f8000,handle:0xfdfe0000
[ 3925.762735] PM: Adding info for No Bus:vcs63
[ 3925.762819] PM: Adding info for No Bus:vcsa63
[ 3925.809199] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[ 3927.858221] PM: Syncing filesystems ... done.
[ 3927.874180] PM: Preparing system for mem sleep
[ 3927.874190] Freezing user space processes ... (elapsed 0.00 seconds) done.
[ 3927.874771] Freezing remaining freezable tasks ... (elapsed 6.98 seconds) done.
[ 3934.860614] PM: Entering mem sleep
[ 3934.860652] pci 0000:00:00.0: preparing suspend
[ 3934.860655] pci 0000:00:01.0: preparing suspend
[ 3934.860658] pcieport-driver 0000:00:0a.0: preparing suspend
[ 3934.860661] ahci 0000:00:11.0: preparing suspend
[ 3934.860663] ohci_hcd 0000:00:12.0: preparing suspend
[ 3934.860666] ohci_hcd 0000:00:12.1: preparing suspend
[ 3934.860668] ehci_hcd 0000:00:12.2: preparing suspend
[ 3934.860671] ohci_hcd 0000:00:13.0: preparing suspend
[ 3934.860673] ohci_hcd 0000:00:13.1: preparing suspend
[ 3934.860676] ehci_hcd 0000:00:13.2: preparing suspend
[ 3934.860679] piix4_smbus 0000:00:14.0: preparing suspend
[ 3934.860681] ATIIXP_IDE 0000:00:14.1: preparing suspend
[ 3934.860684] HDA Intel 0000:00:14.2: preparing suspend
[ 3934.860686] pci 0000:00:14.3: preparing suspend
[ 3934.860689] pci 0000:00:14.4: preparing suspend
[ 3934.860692] ohci_hcd 0000:00:14.5: preparing suspend
[ 3934.860694] pci 0000:00:18.0: preparing suspend
[ 3934.860696] pci 0000:00:18.1: preparing suspend
[ 3934.860699] pci 0000:00:18.2: preparing suspend
[ 3934.860701] pci 0000:00:18.3: preparing suspend
[ 3934.860704] fglrx_pci 0000:01:05.0: preparing suspend
[ 3934.860706] HDA Intel 0000:01:05.1: preparing suspend
[ 3934.860709] r8169 0000:02:00.0: preparing suspend, may wakeup
[ 3934.860720] pcspkr pcspkr: preparing suspend
[ 3934.860745] serial8250 serial8250: preparing suspend
[ 3934.860759] i8042 i8042: preparing suspend
[ 3934.860765] usb usb1: preparing type suspend, may wakeup
[ 3934.860770] usb usb2: preparing type suspend, may wakeup
[ 3934.860776] usb usb3: preparing type suspend, may wakeup
[ 3934.860781] usb usb4: preparing type suspend, may wakeup
[ 3934.860790] usb 1-2: preparing type suspend
[ 3934.860794] usb 1-3: preparing type suspend, may wakeup
[ 3934.860802] usb usb5: preparing type suspend, may wakeup
[ 3934.860806] usb usb6: preparing type suspend, may wakeup
[ 3934.860810] usb 3-1: preparing type suspend, may wakeup
[ 3934.860814] usb usb7: preparing type suspend, may wakeup
[ 3934.860830] it87 it87.552: preparing suspend
[ 3934.860851] it87 it87.552: suspend
[ 3934.860859] usb usb7: type suspend, may wakeup
[ 3934.860862] usb 3-1: type suspend, may wakeup
[ 3934.876023] usb usb6: type suspend, may wakeup
[ 3934.876029] usb usb5: type suspend, may wakeup
[ 3934.876034] ide-cdrom 0.1: legacy suspend
[ 3934.876723] usb 1-3: type suspend, may wakeup
[ 3934.892019] usb 1-2: type suspend
[ 3934.908022] sd 2:0:0:0: legacy suspend
[ 3934.908028] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[ 3934.908221] sd 2:0:0:0: [sda] Stopping disk
[ 3935.336515] usb usb4: type suspend, may wakeup
[ 3935.336520] usb usb3: type suspend, may wakeup
[ 3935.336535] usb usb2: type suspend, may wakeup
[ 3935.336540] usb usb1: type suspend, may wakeup
[ 3935.336552] rtc rtc0: legacy class suspend
[ 3935.336575] atkbd serio0: legacy suspend
[ 3935.800014] i8042 i8042: suspend
[ 3935.800039] serial8250 serial8250: suspend
[ 3935.800066] pcspkr pcspkr: suspend
[ 3935.800077] system 00:0b: legacy suspend
[ 3935.800083] system 00:0a: legacy suspend
[ 3935.800084] ACPI handle has no context!
[ 3935.800087] i8042 kbd 00:09: legacy suspend
[ 3935.800091] pnp 00:08: legacy suspend
[ 3935.800094] pnp 00:07: legacy suspend
[ 3935.800096] pnp 00:06: legacy suspend
[ 3935.800099] rtc_cmos 00:05: legacy suspend, may wakeup
[ 3935.800106] pnp 00:04: legacy suspend
[ 3935.800108] pnp 00:03: legacy suspend
[ 3935.800110] system 00:02: legacy suspend
[ 3935.800114] system 00:01: legacy suspend
[ 3935.800118] pnp 00:00: legacy suspend
[ 3935.800122] r8169 0000:02:00.0: suspend, may wakeup
[ 3935.800173] ACPI handle has no context!
[ 3935.800179] r8169 0000:02:00.0: PME# enabled
[ 3935.800216] ACPI handle has no context!
[ 3935.816515] HDA Intel 0000:01:05.1: suspend
[ 3935.832024] HDA Intel 0000:01:05.1: PCI INT B disabled
[ 3935.832074] ACPI handle has no context!
[ 3935.848016] fglrx_pci 0000:01:05.0: suspend
[ 3935.848022] [fglrx] Power down the ASIC .
[ 3941.600284] fglrx_pci 0000:01:05.0: PCI INT A disabled
[ 3941.600359] pci 0000:00:18.3: suspend
[ 3941.600362] pci 0000:00:18.2: suspend
[ 3941.600365] pci 0000:00:18.1: suspend
[ 3941.600367] pci 0000:00:18.0: suspend
[ 3941.600369] ohci_hcd 0000:00:14.5: suspend
[ 3941.600378] ohci_hcd 0000:00:14.5: PCI INT C disabled
[ 3941.600439] pci 0000:00:14.4: suspend
[ 3941.600442] pci 0000:00:14.3: suspend
[ 3941.600444] HDA Intel 0000:00:14.2: suspend
[ 3941.612038] HDA Intel 0000:00:14.2: PCI INT A disabled
[ 3941.628018] ATIIXP_IDE 0000:00:14.1: suspend
[ 3941.628053] ATIIXP_IDE 0000:00:14.1: PCI INT A disabled
[ 3941.628095] piix4_smbus 0000:00:14.0: suspend
[ 3941.628098] ehci_hcd 0000:00:13.2: suspend
[ 3941.628105] ehci_hcd 0000:00:13.2: PCI INT B disabled
[ 3941.628179] ehci_hcd 0000:00:13.2: PME# disabled
[ 3941.644015] ohci_hcd 0000:00:13.1: suspend
[ 3941.644023] ohci_hcd 0000:00:13.1: PCI INT A disabled
[ 3941.644081] ohci_hcd 0000:00:13.0: suspend
[ 3941.644088] ohci_hcd 0000:00:13.0: PCI INT A disabled
[ 3941.644146] ehci_hcd 0000:00:12.2: suspend
[ 3941.644153] ehci_hcd 0000:00:12.2: PCI INT B disabled
[ 3941.644224] ehci_hcd 0000:00:12.2: PME# disabled
[ 3941.660015] ohci_hcd 0000:00:12.1: suspend
[ 3941.660022] ohci_hcd 0000:00:12.1: PCI INT A disabled
[ 3941.660082] ohci_hcd 0000:00:12.0: suspend
[ 3941.660089] ohci_hcd 0000:00:12.0: PCI INT A disabled
[ 3941.660148] ahci 0000:00:11.0: suspend
[ 3942.044046] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3947.044033] ata3.00: qc timeout (cmd 0xec)
[ 3947.044075] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 3947.044110] ata3.00: revalidation failed (errno=-5)
[ 3947.364045] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3957.364032] ata3.00: qc timeout (cmd 0xec)
[ 3957.364075] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 3957.364111] ata3.00: revalidation failed (errno=-5)
[ 3957.364150] ata3: limiting SATA link speed to 1.5 Gbps
[ 3957.684043] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3987.684032] ata3.00: qc timeout (cmd 0xec)
[ 3987.684076] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 3987.684112] ata3.00: revalidation failed (errno=-5)
[ 3987.684149] ata3.00: disabled
[ 3987.684284] pcieport-driver 0000:00:0a.0: suspend
[ 3987.684289] pci 0000:00:01.0: suspend
[ 3987.684291] pci 0000:00:00.0: suspend
[ 3987.684295] acpi PNP0C14:00: legacy suspend
[ 3987.684298] acpi LNXTHERM:00: legacy suspend
[ 3987.684300] acpi PNP0C01:00: legacy suspend
[ 3987.684303] acpi PNP0C02:02: legacy suspend
[ 3987.684305] acpi device:21: legacy suspend
[ 3987.684307] acpi PNP0303:00: legacy suspend
[ 3987.684310] acpi PNP0700:00: legacy suspend
[ 3987.684312] acpi device:20: legacy suspend
[ 3987.684314] acpi device:1f: legacy suspend
[ 3987.684317] acpi device:1e: legacy suspend
[ 3987.684319] acpi device:1d: legacy suspend
[ 3987.684321] acpi device:1c: legacy suspend
[ 3987.684324] acpi device:1b: legacy suspend
[ 3987.684326] acpi device:1a: legacy suspend
[ 3987.684328] acpi device:19: legacy suspend
[ 3987.684331] acpi device:18: legacy suspend
[ 3987.684333] acpi device:17: legacy suspend
[ 3987.684336] acpi device:16: legacy suspend
[ 3987.684338] acpi device:15: legacy suspend
[ 3987.684340] acpi device:14: legacy suspend
[ 3987.684343] acpi device:13: legacy suspend
[ 3987.684345] acpi device:12: legacy suspend
[ 3987.684347] acpi device:11: legacy suspend
[ 3987.684350] acpi device:10: legacy suspend
[ 3987.684352] acpi device:0f: legacy suspend
[ 3987.684354] acpi PNP0C04:00: legacy suspend
[ 3987.684357] acpi PNP0800:00: legacy suspend
[ 3987.684359] acpi PNP0B00:00: legacy suspend
[ 3987.684361] acpi PNP0103:00: legacy suspend
[ 3987.684364] acpi PNP0100:00: legacy suspend
[ 3987.684366] acpi PNP0200:00: legacy suspend
[ 3987.684369] acpi PNP0000:00: legacy suspend
[ 3987.684371] pci_link PNP0C0F:07: legacy suspend
[ 3987.684374] pci_link PNP0C0F:06: legacy suspend
[ 3987.684378] pci_link PNP0C0F:05: legacy suspend
[ 3987.684381] pci_link PNP0C0F:04: legacy suspend
[ 3987.684384] pci_link PNP0C0F:03: legacy suspend
[ 3987.684386] pci_link PNP0C0F:02: legacy suspend
[ 3987.684389] pci_link PNP0C0F:01: legacy suspend
[ 3987.684391] pci_link PNP0C0F:00: legacy suspend
[ 3987.684394] acpi PNP0C02:01: legacy suspend
[ 3987.684396] acpi device:0e: legacy suspend
[ 3987.684399] acpi device:0d: legacy suspend
[ 3987.684402] acpi device:0c: legacy suspend
[ 3987.684404] acpi device:0b: legacy suspend
[ 3987.684407] acpi device:0a: legacy suspend
[ 3987.684409] acpi device:09: legacy suspend
[ 3987.684412] acpi device:08: legacy suspend
[ 3987.684414] acpi device:07: legacy suspend
[ 3987.684417] acpi device:06: legacy suspend
[ 3987.684419] acpi device:05: legacy suspend
[ 3987.684422] acpi device:04: legacy suspend
[ 3987.684424] acpi device:03: legacy suspend
[ 3987.684426] acpi device:02: legacy suspend
[ 3987.684429] acpi device:01: legacy suspend
[ 3987.684431] acpi PNP0C02:00: legacy suspend
[ 3987.684434] pci_root PNP0A03:00: legacy suspend
[ 3987.684437] button PNP0C0C:00: legacy suspend
[ 3987.684440] acpi device:00: legacy suspend
[ 3987.684442] processor ACPI_CPU:03: legacy suspend
[ 3987.684448] processor ACPI_CPU:02: legacy suspend
[ 3987.684450] processor ACPI_CPU:01: legacy suspend
[ 3987.684453] processor ACPI_CPU:00: legacy suspend
[ 3987.684456] button LNXPWRBN:00: legacy suspend
[ 3987.684459] acpi LNXSYSTM:00: legacy suspend
[ 3987.684887] it87 it87.552: LATE suspend
[ 3987.684902] i8042 i8042: LATE suspend
[ 3987.684907] serial8250 serial8250: LATE suspend
[ 3987.684914] pcspkr pcspkr: LATE suspend
[ 3987.684918] r8169 0000:02:00.0: LATE suspend, may wakeup
[ 3987.684921] HDA Intel 0000:01:05.1: LATE suspend
[ 3987.684924] fglrx_pci 0000:01:05.0: LATE suspend
[ 3987.684940] pci 0000:00:18.3: LATE suspend
[ 3987.684948] pci 0000:00:18.2: LATE suspend
[ 3987.684953] pci 0000:00:18.1: LATE suspend
[ 3987.684959] pci 0000:00:18.0: LATE suspend
[ 3987.684966] ohci_hcd 0000:00:14.5: LATE suspend
[ 3987.684968] pci 0000:00:14.4: LATE suspend
[ 3987.684992] pci 0000:00:14.3: LATE suspend
[ 3987.685018] HDA Intel 0000:00:14.2: LATE suspend
[ 3987.685020] ATIIXP_IDE 0000:00:14.1: LATE suspend
[ 3987.685023] piix4_smbus 0000:00:14.0: LATE suspend
[ 3987.685054] ehci_hcd 0000:00:13.2: LATE suspend
[ 3987.685056] ohci_hcd 0000:00:13.1: LATE suspend
[ 3987.685058] ohci_hcd 0000:00:13.0: LATE suspend
[ 3987.685060] ehci_hcd 0000:00:12.2: LATE suspend
[ 3987.685062] ohci_hcd 0000:00:12.1: LATE suspend
[ 3987.685064] ohci_hcd 0000:00:12.0: LATE suspend
[ 3987.685067] ahci 0000:00:11.0: LATE suspend
[ 3987.685069] pcieport-driver 0000:00:0a.0: LATE suspend
[ 3987.685096] pci 0000:00:01.0: LATE suspend
[ 3987.685110] pci 0000:00:00.0: LATE suspend
[ 3987.685238] ACPI: Preparing to enter system sleep state S3
[ 3987.685659] Disabling non-boot CPUs ...
[ 3987.688641] kvm: disabling virtualization on CPU1
[ 3987.688676] CPU 1 is now offline
[ 3987.688761] SMP alternatives: switching to UP code
[ 3987.695062] CPU0 attaching NULL sched-domain.
[ 3987.695066] CPU1 attaching NULL sched-domain.
[ 3987.695146] CPU0 attaching NULL sched-domain.
[ 3987.695351] CPU1 is down
[ 3987.695396] Back to C!
[ 3987.695396] PCI-DMA: Resuming GART IOMMU
[ 3987.695396] PCI-DMA: Restoring GART aperture settings
[ 3987.695396] Enabling non-boot CPUs ...
[ 3987.696611] SMP alternatives: switching to SMP code
[ 3987.702369] Booting processor 1 APIC 0x1 ip 0x6000
[ 3987.694873] Initializing CPU#1
[ 3987.694873] Calibrating delay using timer specific routine.. 5010.61 BogoMIPS (lpj=10021239)
[ 3987.694873] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[ 3987.694873] CPU: L2 Cache: 512K (64 bytes/line)
[ 3987.694873] CPU 1/0x1 -> Node 0
[ 3987.694873] CPU: Physical Processor ID: 0
[ 3987.694873] CPU: Processor Core ID: 1
[ 3987.792137] CPU1: AMD Athlon(tm) Dual Core Processor 4850e stepping 02
[ 3987.792488] kvm: enabling virtualization on CPU1
[ 3987.792588] CPU0 attaching NULL sched-domain.
[ 3987.796024] Switched to high resolution mode on CPU 1
[ 3987.808110] CPU0 attaching sched-domain:
[ 3987.808114]  domain 0: span 0-1 level CPU
[ 3987.808116]   groups: 0 1
[ 3987.808121] CPU1 attaching sched-domain:
[ 3987.808124]  domain 0: span 0-1 level CPU
[ 3987.808126]   groups: 1 0
[ 3987.812027] CPU1 is up
[ 3987.812066] ACPI: Waking up from system sleep state S3
[ 3987.812362] pci 0000:00:00.0: EARLY resume
[ 3987.812377] pci 0000:00:00.0: restoring config space at offset 0x7 (was 0x0, writing 0xe0000004)
[ 3987.812383] pci 0000:00:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x2000)
[ 3987.812393] pci 0000:00:01.0: EARLY resume
[ 3987.812402] pci 0000:00:01.0: restoring config space at offset 0x7 (was 0x2220e1e1, writing 0x220e1e1)
[ 3987.812411] pcieport-driver 0000:00:0a.0: EARLY resume
[ 3987.812427] pcieport-driver 0000:00:0a.0: restoring config space at offset 0x1 (was 0x100007, writing 0x100407)
[ 3987.812444] ahci 0000:00:11.0: EARLY resume
[ 3987.812474] ahci 0000:00:11.0: restoring config space at offset 0x2 (was 0x1018f00, writing 0x1060100)
[ 3987.812524] ahci 0000:00:11.0: set SATA to AHCI mode
[ 3987.812561] ohci_hcd 0000:00:12.0: EARLY resume
[ 3987.812587] ohci_hcd 0000:00:12.1: EARLY resume
[ 3987.812611] ehci_hcd 0000:00:12.2: EARLY resume
[ 3987.828540] ehci_hcd 0000:00:12.2: restoring config space at offset 0x1 (was 0x2b00000, writing 0x2b00012)
[ 3987.828554] ohci_hcd 0000:00:13.0: EARLY resume
[ 3987.828579] ohci_hcd 0000:00:13.1: EARLY resume
[ 3987.828604] ehci_hcd 0000:00:13.2: EARLY resume
[ 3987.844041] ehci_hcd 0000:00:13.2: restoring config space at offset 0x1 (was 0x2b00000, writing 0x2b00012)
[ 3987.844054] piix4_smbus 0000:00:14.0: EARLY resume
[ 3987.844086] ATIIXP_IDE 0000:00:14.1: EARLY resume
[ 3987.844118] HDA Intel 0000:00:14.2: EARLY resume
[ 3987.844128] HDA Intel 0000:00:14.2: restoring config space at offset 0xf (was 0x100, writing 0x5)
[ 3987.844147] HDA Intel 0000:00:14.2: restoring config space at offset 0x3 (was 0x0, writing 0x2001)
[ 3987.844160] pci 0000:00:14.3: EARLY resume
[ 3987.844185] pci 0000:00:14.4: EARLY resume
[ 3987.844210] ohci_hcd 0000:00:14.5: EARLY resume
[ 3987.844235] pci 0000:00:18.0: EARLY resume
[ 3987.844242] pci 0000:00:18.1: EARLY resume
[ 3987.844248] pci 0000:00:18.2: EARLY resume
[ 3987.844253] pci 0000:00:18.3: EARLY resume
[ 3987.844261] fglrx_pci 0000:01:05.0: EARLY resume
[ 3987.844273] fglrx_pci 0000:01:05.0: restoring config space at offset 0x1 (was 0x100007, writing 0x100003)
[ 3987.844280] HDA Intel 0000:01:05.1: EARLY resume
[ 3987.844287] HDA Intel 0000:01:05.1: restoring config space at offset 0xf (was 0x2ff, writing 0x207)
[ 3987.844295] HDA Intel 0000:01:05.1: restoring config space at offset 0x4 (was 0x0, writing 0xfdffc000)
[ 3987.844299] HDA Intel 0000:01:05.1: restoring config space at offset 0x3 (was 0x800000, writing 0x800001)
[ 3987.844304] HDA Intel 0000:01:05.1: restoring config space at offset 0x1 (was 0x100000, writing 0x100002)
[ 3987.844311] r8169 0000:02:00.0: EARLY resume
[ 3987.844340] r8169 0000:02:00.0: restoring config space at offset 0x3 (was 0x1, writing 0x10)
[ 3987.844346] r8169 0000:02:00.0: restoring config space at offset 0x1 (was 0x100007, writing 0x100407)
[ 3987.844384] pcspkr pcspkr: EARLY resume
[ 3987.844391] serial8250 serial8250: EARLY resume
[ 3987.844395] i8042 i8042: EARLY resume
[ 3987.844408] it87 it87.552: EARLY resume
[ 3987.844592] acpi LNXSYSTM:00: legacy resume
[ 3987.844595] button LNXPWRBN:00: legacy resume
[ 3987.844597] processor ACPI_CPU:00: legacy resume
[ 3987.844602] processor ACPI_CPU:01: legacy resume
[ 3987.844604] processor ACPI_CPU:02: legacy resume
[ 3987.844607] processor ACPI_CPU:03: legacy resume
[ 3987.844609] acpi device:00: legacy resume
[ 3987.844611] button PNP0C0C:00: legacy resume
[ 3987.844614] pci_root PNP0A03:00: legacy resume
[ 3987.844617] acpi PNP0C02:00: legacy resume
[ 3987.844619] acpi device:01: legacy resume
[ 3987.844621] acpi device:02: legacy resume
[ 3987.844624] acpi device:03: legacy resume
[ 3987.844626] acpi device:04: legacy resume
[ 3987.844628] acpi device:05: legacy resume
[ 3987.844631] acpi device:06: legacy resume
[ 3987.844633] acpi device:07: legacy resume
[ 3987.844635] acpi device:08: legacy resume
[ 3987.844637] acpi device:09: legacy resume
[ 3987.844640] acpi device:0a: legacy resume
[ 3987.844642] acpi device:0b: legacy resume
[ 3987.844644] acpi device:0c: legacy resume
[ 3987.844647] acpi device:0d: legacy resume
[ 3987.844649] acpi device:0e: legacy resume
[ 3987.844651] acpi PNP0C02:01: legacy resume
[ 3987.844654] pci_link PNP0C0F:00: legacy resume
[ 3987.844656] pci_link PNP0C0F:01: legacy resume
[ 3987.844659] pci_link PNP0C0F:02: legacy resume
[ 3987.844661] pci_link PNP0C0F:03: legacy resume
[ 3987.844663] pci_link PNP0C0F:04: legacy resume
[ 3987.844666] pci_link PNP0C0F:05: legacy resume
[ 3987.844668] pci_link PNP0C0F:06: legacy resume
[ 3987.844671] pci_link PNP0C0F:07: legacy resume
[ 3987.844673] acpi PNP0000:00: legacy resume
[ 3987.844675] acpi PNP0200:00: legacy resume
[ 3987.844678] acpi PNP0100:00: legacy resume
[ 3987.844680] acpi PNP0103:00: legacy resume
[ 3987.844682] acpi PNP0B00:00: legacy resume
[ 3987.844685] acpi PNP0800:00: legacy resume
[ 3987.844687] acpi PNP0C04:00: legacy resume
[ 3987.844689] acpi device:0f: legacy resume
[ 3987.844691] acpi device:10: legacy resume
[ 3987.844694] acpi device:11: legacy resume
[ 3987.844696] acpi device:12: legacy resume
[ 3987.844698] acpi device:13: legacy resume
[ 3987.844700] acpi device:14: legacy resume
[ 3987.844703] acpi device:15: legacy resume
[ 3987.844705] acpi device:16: legacy resume
[ 3987.844707] acpi device:17: legacy resume
[ 3987.844709] acpi device:18: legacy resume
[ 3987.844712] acpi device:19: legacy resume
[ 3987.844714] acpi device:1a: legacy resume
[ 3987.844716] acpi device:1b: legacy resume
[ 3987.844718] acpi device:1c: legacy resume
[ 3987.844721] acpi device:1d: legacy resume
[ 3987.844723] acpi device:1e: legacy resume
[ 3987.844725] acpi device:1f: legacy resume
[ 3987.844727] acpi device:20: legacy resume
[ 3987.844730] acpi PNP0700:00: legacy resume
[ 3987.844732] acpi PNP0303:00: legacy resume
[ 3987.844734] acpi device:21: legacy resume
[ 3987.844736] acpi PNP0C02:02: legacy resume
[ 3987.844738] acpi PNP0C01:00: legacy resume
[ 3987.844741] acpi LNXTHERM:00: legacy resume
[ 3987.844743] acpi PNP0C14:00: legacy resume
[ 3987.844745] pci 0000:00:00.0: resume
[ 3987.844750] pci 0000:00:01.0: resume
[ 3987.844756] pcieport-driver 0000:00:0a.0: resume
[ 3987.844760] ahci 0000:00:11.0: resume
[ 3987.844882] ohci_hcd 0000:00:12.0: resume
[ 3987.844924] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 3987.868016] ohci_hcd 0000:00:12.1: resume
[ 3987.868044] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 3987.892013] ehci_hcd 0000:00:12.2: resume
[ 3987.892053] ehci_hcd 0000:00:12.2: PME# disabled
[ 3987.892092] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[ 3987.892136] ehci_hcd 0000:00:12.2: PME# disabled
[ 3987.892177] ohci_hcd 0000:00:13.0: resume
[ 3987.892204] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[ 3987.916013] ohci_hcd 0000:00:13.1: resume
[ 3987.916041] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[ 3987.940013] ehci_hcd 0000:00:13.2: resume
[ 3987.940053] ehci_hcd 0000:00:13.2: PME# disabled
[ 3987.940093] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[ 3987.940137] ehci_hcd 0000:00:13.2: PME# disabled
[ 3987.940177] piix4_smbus 0000:00:14.0: resume
[ 3987.940180] ATIIXP_IDE 0000:00:14.1: resume
[ 3987.940185] ATIIXP_IDE 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 3987.940258] HDA Intel 0000:00:14.2: resume
[ 3987.940267] HDA Intel 0000:00:14.2: restoring config space at offset 0xf (was 0x105, writing 0x5)
[ 3987.940296] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 3988.036345] pci 0000:00:14.3: resume
[ 3988.036348] pci 0000:00:14.4: resume
[ 3988.036355] ohci_hcd 0000:00:14.5: resume
[ 3988.036393] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[ 3988.060014] pci 0000:00:18.0: resume
[ 3988.060017] pci 0000:00:18.1: resume
[ 3988.060020] pci 0000:00:18.2: resume
[ 3988.060022] pci 0000:00:18.3: resume
[ 3988.060024] fglrx_pci 0000:01:05.0: resume
[ 3988.060292] fglrx_pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[ 3988.060298] fglrx_pci 0000:01:05.0: setting latency timer to 64
[ 3988.168043] ata2: SATA link down (SStatus 0 SControl 300)
[ 3988.168075] ata4: SATA link down (SStatus 0 SControl 300)
[ 3988.168109] ata1: SATA link down (SStatus 0 SControl 300)
[ 3988.404768] [fglrx] Power up the ASIC
[ 3988.405123] HDA Intel 0000:01:05.1: resume
[ 3988.405146] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[ 3988.405189] HDA Intel 0000:01:05.1: setting latency timer to 64
[ 3988.405204] r8169 0000:02:00.0: resume
[ 3988.405269] r8169 0000:02:00.0: PME# disabled
[ 3988.405315] pnp 00:00: legacy resume
[ 3988.405318] system 00:01: legacy resume
[ 3988.405323] system 00:02: legacy resume
[ 3988.405325] pnp 00:03: legacy resume
[ 3988.405328] pnp 00:04: legacy resume
[ 3988.405330] rtc_cmos 00:05: legacy resume
[ 3988.405333] pnp 00:06: legacy resume
[ 3988.405336] pnp 00:07: legacy resume
[ 3988.405338] pnp 00:08: legacy resume
[ 3988.405340] i8042 kbd 00:09: legacy resume
[ 3988.405343] system 00:0a: legacy resume
[ 3988.405346] system 00:0b: legacy resume
[ 3988.405352] pcspkr pcspkr: resume
[ 3988.405376] serial8250 serial8250: resume
[ 3988.405390] i8042 i8042: resume
[ 3988.405412] atkbd serio0: legacy resume
[ 3988.405416] rtc rtc0: legacy class resume
[ 3988.405457] usb usb1: type resume
[ 3988.420046] r8169: eth0: link up
[ 3988.484034] usb usb2: type resume
[ 3988.536034] usb usb3: type resume
[ 3988.616024] usb usb4: type resume
[ 3988.644031] sd 2:0:0:0: legacy resume
[ 3988.644035] sd 2:0:0:0: [sda] Starting disk
[ 3993.206674] ata3: link is slow to respond, please be patient (ready=0)
[ 3995.055756] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3995.072044] sd 2:0:0:0: [sda] START_STOP FAILED
[ 3995.072082] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.072157] PM: Device 2:0:0:0 failed to resume: error 262144
[ 3995.072199] usb 1-2: type resume
[ 3995.116309] usb 1-3: type resume
[ 3995.120299] ide-cdrom 0.1: legacy resume
[ 3995.123150] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[ 3995.123963] hdb: UDMA/33 mode selected
[ 3995.124448] usb usb5: type resume
[ 3995.124453] usb usb6: type resume
[ 3995.124456] usb 3-1: type resume
[ 3995.174291] usb usb7: type resume
[ 3995.174309] it87 it87.552: resume
[ 3995.174332] it87 it87.552: completing resume
[ 3995.174340] usb usb7: completing type resume
[ 3995.174343] usb 3-1: completing type resume
[ 3995.174347] usb usb6: completing type resume
[ 3995.174350] usb usb5: completing type resume
[ 3995.174354] usb 1-3: completing type resume
[ 3995.174359] usb 1-2: completing type resume
[ 3995.174370] usb usb4: completing type resume
[ 3995.174375] usb usb3: completing type resume
[ 3995.174383] usb usb2: completing type resume
[ 3995.174388] usb usb1: completing type resume
[ 3995.174395] i8042 i8042: completing resume
[ 3995.174410] serial8250 serial8250: completing resume
[ 3995.174437] pcspkr pcspkr: completing resume
[ 3995.174448] r8169 0000:02:00.0: completing resume
[ 3995.174451] HDA Intel 0000:01:05.1: completing resume
[ 3995.174454] fglrx_pci 0000:01:05.0: completing resume
[ 3995.174457] pci 0000:00:18.3: completing resume
[ 3995.174459] pci 0000:00:18.2: completing resume
[ 3995.174462] pci 0000:00:18.1: completing resume
[ 3995.174464] pci 0000:00:18.0: completing resume
[ 3995.174467] ohci_hcd 0000:00:14.5: completing resume
[ 3995.174469] pci 0000:00:14.4: completing resume
[ 3995.174472] pci 0000:00:14.3: completing resume
[ 3995.174474] HDA Intel 0000:00:14.2: completing resume
[ 3995.174477] ATIIXP_IDE 0000:00:14.1: completing resume
[ 3995.174480] piix4_smbus 0000:00:14.0: completing resume
[ 3995.174482] ehci_hcd 0000:00:13.2: completing resume
[ 3995.174485] ohci_hcd 0000:00:13.1: completing resume
[ 3995.174487] ohci_hcd 0000:00:13.0: completing resume
[ 3995.174490] ehci_hcd 0000:00:12.2: completing resume
[ 3995.174492] ohci_hcd 0000:00:12.1: completing resume
[ 3995.174494] ohci_hcd 0000:00:12.0: completing resume
[ 3995.174497] ahci 0000:00:11.0: completing resume
[ 3995.174499] pcieport-driver 0000:00:0a.0: completing resume
[ 3995.174502] pci 0000:00:01.0: completing resume
[ 3995.174504] pci 0000:00:00.0: completing resume
[ 3995.174537] PM: Finishing wakeup.
[ 3995.174539] Restarting tasks ... done.
[ 3995.266170] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.266212] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.266283] end_request: I/O error, dev sda, sector 88297349
[ 3995.266330] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.266366] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.266436] end_request: I/O error, dev sda, sector 88297381
[ 3995.266496] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.266532] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.266603] end_request: I/O error, dev sda, sector 88297349
[ 3995.266640] Buffer I/O error on device dm-0, logical block 2590939
[ 3995.714675] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.714752] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.714897] end_request: I/O error, dev sda, sector 58042547
[ 3995.714974] Buffer I/O error on device sda7, logical block 275068
[ 3995.715048] lost page write due to I/O error on sda7
[ 3995.715135] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.715210] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.715354] end_request: I/O error, dev sda, sector 58044235
[ 3995.715429] Buffer I/O error on device sda7, logical block 275279
[ 3995.715501] lost page write due to I/O error on sda7
[ 3995.715579] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.715653] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.715797] end_request: I/O error, dev sda, sector 58044523
[ 3995.715872] Buffer I/O error on device sda7, logical block 275315
[ 3995.715946] lost page write due to I/O error on sda7
[ 3995.716022] Buffer I/O error on device sda7, logical block 275316
[ 3995.716096] lost page write due to I/O error on sda7
[ 3995.716170] Buffer I/O error on device sda7, logical block 275317
[ 3995.716243] lost page write due to I/O error on sda7
[ 3995.716323] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.716397] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.716569] end_request: I/O error, dev sda, sector 58044555
[ 3995.716614] Buffer I/O error on device sda7, logical block 275319
[ 3995.716652] lost page write due to I/O error on sda7
[ 3995.716710] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.716762] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.716841] end_request: I/O error, dev sda, sector 58044579
[ 3995.716878] Buffer I/O error on device sda7, logical block 275322
[ 3995.716915] lost page write due to I/O error on sda7
[ 3995.716955] Buffer I/O error on device sda7, logical block 275323
[ 3995.716994] lost page write due to I/O error on sda7
[ 3995.717032] Buffer I/O error on device sda7, logical block 275324
[ 3995.717072] lost page write due to I/O error on sda7
[ 3995.717117] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.717157] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.717233] end_request: I/O error, dev sda, sector 58044771
[ 3995.717387] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.717426] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.717503] end_request: I/O error, dev sda, sector 58044787
[ 3995.717556] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.717595] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.717672] end_request: I/O error, dev sda, sector 58083907
[ 3995.717716] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.717754] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.717852] end_request: I/O error, dev sda, sector 58084091
[ 3995.717945] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.718020] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.718163] end_request: I/O error, dev sda, sector 58084363
[ 3995.718241] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.718314] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.718463] end_request: I/O error, dev sda, sector 58084371
[ 3995.718543] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.718617] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.718762] end_request: I/O error, dev sda, sector 58084459
[ 3995.718862] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.718937] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.719084] end_request: I/O error, dev sda, sector 58084499
[ 3995.721405] sd 2:0:0:0: [sda] Unhandled error code
[ 3995.721447] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3995.721524] end_request: I/O error, dev sda, sector 58042547
[ 3996.293055] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.293060] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.293065] end_request: I/O error, dev sda, sector 77622165
[ 3996.293097] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.293100] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.293103] end_request: I/O error, dev sda, sector 77622165
[ 3996.293155] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.293157] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.293160] end_request: I/O error, dev sda, sector 77622165
[ 3996.318391] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.318396] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.318400] end_request: I/O error, dev sda, sector 77724581
[ 3996.318432] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.318434] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.318438] end_request: I/O error, dev sda, sector 77724581
[ 3996.318485] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.318487] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.318490] end_request: I/O error, dev sda, sector 77724581
[ 3996.319403] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.319408] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.319412] end_request: I/O error, dev sda, sector 77724581
[ 3996.319464] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.319466] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.319469] end_request: I/O error, dev sda, sector 77724581
[ 3996.328154] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.328160] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.328164] end_request: I/O error, dev sda, sector 77724581
[ 3996.328225] sd 2:0:0:0: [sda] Unhandled error code
[ 3996.328228] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 3996.328231] end_request: I/O error, dev sda, sector 77724581
[ 3996.455110] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_open] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[ 4000.173248] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173260] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173272] end_request: I/O error, dev sda, sector 84374421
[ 4000.173306] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173312] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173320] end_request: I/O error, dev sda, sector 84416261
[ 4000.173341] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173346] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173354] end_request: I/O error, dev sda, sector 84417181
[ 4000.173374] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173379] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173387] end_request: I/O error, dev sda, sector 84577309
[ 4000.173406] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173412] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173419] end_request: I/O error, dev sda, sector 84374541
[ 4000.173437] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173442] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173450] end_request: I/O error, dev sda, sector 84417013
[ 4000.173469] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173474] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173483] end_request: I/O error, dev sda, sector 84417189
[ 4000.173500] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173505] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173513] end_request: I/O error, dev sda, sector 84417325
[ 4000.173531] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173537] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173545] end_request: I/O error, dev sda, sector 84417333
[ 4000.173563] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173568] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173576] end_request: I/O error, dev sda, sector 84417197
[ 4000.173596] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173602] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173609] end_request: I/O error, dev sda, sector 84577317
[ 4000.173627] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173633] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173640] end_request: I/O error, dev sda, sector 84374549
[ 4000.173657] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173663] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173672] end_request: I/O error, dev sda, sector 84374733
[ 4000.173689] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173694] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173702] end_request: I/O error, dev sda, sector 84417213
[ 4000.173719] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173724] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173732] end_request: I/O error, dev sda, sector 84417341
[ 4000.173748] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173753] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173762] end_request: I/O error, dev sda, sector 84417365
[ 4000.173779] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173785] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173792] end_request: I/O error, dev sda, sector 84417373
[ 4000.173812] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173817] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173825] end_request: I/O error, dev sda, sector 84417421
[ 4000.173842] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173847] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173856] end_request: I/O error, dev sda, sector 84417221
[ 4000.173886] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173891] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173898] end_request: I/O error, dev sda, sector 84419981
[ 4000.173920] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173925] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173933] end_request: I/O error, dev sda, sector 84420101
[ 4000.173945] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173950] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173958] end_request: I/O error, dev sda, sector 84412973
[ 4000.173974] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.173979] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.173987] end_request: I/O error, dev sda, sector 84577325
[ 4000.174001] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174006] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174014] end_request: I/O error, dev sda, sector 86191157
[ 4000.174026] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174031] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174039] end_request: I/O error, dev sda, sector 89518573
[ 4000.174054] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174059] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174067] end_request: I/O error, dev sda, sector 81474453
[ 4000.174082] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174087] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174094] end_request: I/O error, dev sda, sector 84366021
[ 4000.174108] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174113] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174121] end_request: I/O error, dev sda, sector 84374413
[ 4000.174138] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174144] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174151] end_request: I/O error, dev sda, sector 84374501
[ 4000.174164] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174169] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174177] end_request: I/O error, dev sda, sector 84374533
[ 4000.174190] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174195] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174203] end_request: I/O error, dev sda, sector 84374741
[ 4000.174215] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174220] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174228] end_request: I/O error, dev sda, sector 84374757
[ 4000.174242] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174247] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174255] end_request: I/O error, dev sda, sector 84374973
[ 4000.174270] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174275] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174283] end_request: I/O error, dev sda, sector 84374997
[ 4000.174608] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.174613] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.174621] end_request: I/O error, dev sda, sector 67613501
[ 4000.174731] REISERFS abort (device dm-0): Journal write error in flush_commit_list
[ 4000.177184] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.177193] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.177202] end_request: I/O error, dev sda, sector 55907683
[ 4000.177231] REISERFS warning (device sda7): journal-837 _update_journal_header_block: IO error during journal replay
[ 4000.177240] REISERFS abort (device sda7): Write error while updating journal header in flush_journal_list
[ 4000.177406] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.177418] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.177431] end_request: I/O error, dev sda, sector 58083875
[ 4000.177453] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.177460] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.177477] end_request: I/O error, dev sda, sector 58084731
[ 4000.177492] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.177499] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.177511] end_request: I/O error, dev sda, sector 63379435
[ 4000.177963] sd 2:0:0:0: [sda] Unhandled error code
[ 4000.177969] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4000.177977] end_request: I/O error, dev sda, sector 55883827
[ 4030.176900] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.176912] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.176922] end_request: I/O error, dev sda, sector 56644843
[ 4030.176931] __ratelimit: 108 callbacks suppressed
[ 4030.176938] Buffer I/O error on device sda7, logical block 100355
[ 4030.176944] lost page write due to I/O error on sda7
[ 4030.176978] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.176984] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.176992] end_request: I/O error, dev sda, sector 56644859
[ 4030.176999] Buffer I/O error on device sda7, logical block 100357
[ 4030.177004] lost page write due to I/O error on sda7
[ 4030.177017] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177022] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177031] end_request: I/O error, dev sda, sector 56973483
[ 4030.177037] Buffer I/O error on device sda7, logical block 141435
[ 4030.177043] lost page write due to I/O error on sda7
[ 4030.177055] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177060] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177068] end_request: I/O error, dev sda, sector 64735675
[ 4030.177075] Buffer I/O error on device sda7, logical block 1111709
[ 4030.177080] lost page write due to I/O error on sda7
[ 4030.177093] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177098] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177106] end_request: I/O error, dev sda, sector 84417285
[ 4030.177114] Buffer I/O error on device dm-0, logical block 2105931
[ 4030.177119] lost page write due to I/O error on dm-0
[ 4030.177132] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177137] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177145] end_request: I/O error, dev sda, sector 84420021
[ 4030.177153] Buffer I/O error on device dm-0, logical block 2106273
[ 4030.177158] lost page write due to I/O error on dm-0
[ 4030.177170] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177175] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177183] end_request: I/O error, dev sda, sector 84577333
[ 4030.177190] Buffer I/O error on device dm-0, logical block 2125937
[ 4030.177195] lost page write due to I/O error on dm-0
[ 4030.177207] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177212] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177220] end_request: I/O error, dev sda, sector 56645059
[ 4030.177227] Buffer I/O error on device sda7, logical block 100382
[ 4030.177233] lost page write due to I/O error on sda7
[ 4030.177245] Buffer I/O error on device sda7, logical block 100383
[ 4030.177250] lost page write due to I/O error on sda7
[ 4030.177263] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177268] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177276] end_request: I/O error, dev sda, sector 75195053
[ 4030.177283] Buffer I/O error on device dm-0, logical block 953152
[ 4030.177288] lost page write due to I/O error on dm-0
[ 4030.177319] sd 2:0:0:0: [sda] Unhandled error code
[ 4030.177325] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4030.177333] end_request: I/O error, dev sda, sector 84374533
[ 4070.180050] sd 2:0:0:0: [sda] Unhandled error code
[ 4070.180056] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4070.180060] end_request: I/O error, dev sda, sector 56644843
[ 4070.180063] __ratelimit: 7 callbacks suppressed
[ 4070.180066] Buffer I/O error on device sda7, logical block 100355
[ 4070.180069] lost page write due to I/O error on sda7
[ 4070.180081] sd 2:0:0:0: [sda] Unhandled error code
[ 4070.180083] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4070.180086] end_request: I/O error, dev sda, sector 56644859
[ 4070.180089] Buffer I/O error on device sda7, logical block 100357
[ 4070.180092] lost page write due to I/O error on sda7
[ 4090.180096] sd 2:0:0:0: [sda] Unhandled error code
[ 4090.180108] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4090.180118] end_request: I/O error, dev sda, sector 56645059
[ 4090.180128] Buffer I/O error on device sda7, logical block 100382
[ 4090.180135] lost page write due to I/O error on sda7
[ 4090.180146] Buffer I/O error on device sda7, logical block 100383
[ 4090.180152] lost page write due to I/O error on sda7
[ 4110.180090] sd 2:0:0:0: [sda] Unhandled error code
[ 4110.180102] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4110.180112] end_request: I/O error, dev sda, sector 56644859
[ 4110.180122] Buffer I/O error on device sda7, logical block 100357
[ 4110.180129] lost page write due to I/O error on sda7
[ 4110.180153] sd 2:0:0:0: [sda] Unhandled error code
[ 4110.180158] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4110.180166] end_request: I/O error, dev sda, sector 56644843
[ 4110.180173] Buffer I/O error on device sda7, logical block 100355
[ 4110.180178] lost page write due to I/O error on sda7
[ 4125.180086] sd 2:0:0:0: [sda] Unhandled error code
[ 4125.180098] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4125.180109] end_request: I/O error, dev sda, sector 56645059
[ 4125.180119] Buffer I/O error on device sda7, logical block 100382
[ 4125.180125] lost page write due to I/O error on sda7
[ 4125.180137] Buffer I/O error on device sda7, logical block 100383
[ 4125.180142] lost page write due to I/O error on sda7
[ 4145.180081] sd 2:0:0:0: [sda] Unhandled error code
[ 4145.180092] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4145.180102] end_request: I/O error, dev sda, sector 84366021
[ 4145.180113] Buffer I/O error on device dm-0, logical block 2099523
[ 4145.180119] lost page write due to I/O error on dm-0
[ 4150.180075] sd 2:0:0:0: [sda] Unhandled error code
[ 4150.180086] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4150.180096] end_request: I/O error, dev sda, sector 56644843
[ 4150.180106] Buffer I/O error on device sda7, logical block 100355
[ 4150.180112] lost page write due to I/O error on sda7
[ 4150.180133] sd 2:0:0:0: [sda] Unhandled error code
[ 4150.180138] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4150.180147] end_request: I/O error, dev sda, sector 56644859
[ 4150.180153] Buffer I/O error on device sda7, logical block 100357
[ 4150.180159] lost page write due to I/O error on sda7
[ 4176.079605] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079611] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079615] end_request: I/O error, dev sda, sector 58042547
[ 4176.079619] Buffer I/O error on device sda7, logical block 275068
[ 4176.079621] lost page write due to I/O error on sda7
[ 4176.079637] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079640] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079643] end_request: I/O error, dev sda, sector 58044235
[ 4176.079646] Buffer I/O error on device sda7, logical block 275279
[ 4176.079648] lost page write due to I/O error on sda7
[ 4176.079654] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079656] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079659] end_request: I/O error, dev sda, sector 58044523
[ 4176.079662] Buffer I/O error on device sda7, logical block 275315
[ 4176.079664] lost page write due to I/O error on sda7
[ 4176.079668] Buffer I/O error on device sda7, logical block 275316
[ 4176.079670] lost page write due to I/O error on sda7
[ 4176.079673] Buffer I/O error on device sda7, logical block 275317
[ 4176.079675] lost page write due to I/O error on sda7
[ 4176.079680] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079682] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079686] end_request: I/O error, dev sda, sector 58044555
[ 4176.079688] Buffer I/O error on device sda7, logical block 275319
[ 4176.079690] lost page write due to I/O error on sda7
[ 4176.079696] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079698] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079701] end_request: I/O error, dev sda, sector 58044579
[ 4176.079704] Buffer I/O error on device sda7, logical block 275322
[ 4176.079706] lost page write due to I/O error on sda7
[ 4176.079709] Buffer I/O error on device sda7, logical block 275323
[ 4176.079711] lost page write due to I/O error on sda7
[ 4176.079715] Buffer I/O error on device sda7, logical block 275324
[ 4176.079717] lost page write due to I/O error on sda7
[ 4176.079721] Buffer I/O error on device sda7, logical block 275325
[ 4176.079723] lost page write due to I/O error on sda7
[ 4176.079730] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079732] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079736] end_request: I/O error, dev sda, sector 58044771
[ 4176.079859] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079861] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079864] end_request: I/O error, dev sda, sector 58044787
[ 4176.079882] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079884] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079887] end_request: I/O error, dev sda, sector 58083907
[ 4176.079896] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079898] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079901] end_request: I/O error, dev sda, sector 58084091
[ 4176.079918] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079920] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079923] end_request: I/O error, dev sda, sector 58084363
[ 4176.079929] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079931] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079934] end_request: I/O error, dev sda, sector 58084371
[ 4176.079942] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.079944] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.079947] end_request: I/O error, dev sda, sector 58084459
[ 4176.082576] sd 2:0:0:0: [sda] Unhandled error code
[ 4176.082580] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4176.082584] end_request: I/O error, dev sda, sector 58042547
[ 4182.218505] sd 2:0:0:0: [sda] Unhandled error code
[ 4182.218510] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4182.218514] end_request: I/O error, dev sda, sector 73120973
[ 4182.218548] sd 2:0:0:0: [sda] Unhandled error code
[ 4182.218551] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4182.218554] end_request: I/O error, dev sda, sector 73121093
[ 4182.218557] __ratelimit: 45 callbacks suppressed
[ 4182.218560] Buffer I/O error on device dm-0, logical block 693907
[ 4185.180084] sd 2:0:0:0: [sda] Unhandled error code
[ 4185.180095] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4185.180105] end_request: I/O error, dev sda, sector 56644843
[ 4185.180115] Buffer I/O error on device sda7, logical block 100355
[ 4185.180121] lost page write due to I/O error on sda7
[ 4185.180146] sd 2:0:0:0: [sda] Unhandled error code
[ 4185.180151] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4185.180159] end_request: I/O error, dev sda, sector 56644859
[ 4185.180167] Buffer I/O error on device sda7, logical block 100357
[ 4185.180172] lost page write due to I/O error on sda7
[ 4185.180186] sd 2:0:0:0: [sda] Unhandled error code
[ 4185.180191] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4185.180199] end_request: I/O error, dev sda, sector 56645059
[ 4185.180206] Buffer I/O error on device sda7, logical block 100382
[ 4185.180211] lost page write due to I/O error on sda7
[ 4185.180219] Buffer I/O error on device sda7, logical block 100383
[ 4185.180224] lost page write due to I/O error on sda7
[ 4210.180076] sd 2:0:0:0: [sda] Unhandled error code
[ 4210.180088] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4210.180098] end_request: I/O error, dev sda, sector 75195053
[ 4210.180109] Buffer I/O error on device dm-0, logical block 953152
[ 4210.180116] lost page write due to I/O error on dm-0
[ 4210.180127] Buffer I/O error on device dm-0, logical block 953153
[ 4210.180132] lost page write due to I/O error on dm-0
[ 4210.180141] Buffer I/O error on device dm-0, logical block 953154
[ 4210.180146] lost page write due to I/O error on dm-0
[ 4210.180155] Buffer I/O error on device dm-0, logical block 953155
[ 4210.180160] lost page write due to I/O error on dm-0
[ 4210.180168] Buffer I/O error on device dm-0, logical block 953156
[ 4210.180174] lost page write due to I/O error on dm-0
[ 4210.180182] Buffer I/O error on device dm-0, logical block 953157
[ 4210.180187] lost page write due to I/O error on dm-0
[ 4210.180196] Buffer I/O error on device dm-0, logical block 953158
[ 4210.180201] lost page write due to I/O error on dm-0
[ 4220.180102] sd 2:0:0:0: [sda] Unhandled error code
[ 4220.180114] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4220.180124] end_request: I/O error, dev sda, sector 56644843
[ 4220.180134] Buffer I/O error on device sda7, logical block 100355
[ 4220.180140] lost page write due to I/O error on sda7
[ 4220.180166] sd 2:0:0:0: [sda] Unhandled error code
[ 4220.180172] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4220.180180] end_request: I/O error, dev sda, sector 56644859
[ 4220.180187] Buffer I/O error on device sda7, logical block 100357
[ 4220.180193] lost page write due to I/O error on sda7
[ 4220.180206] sd 2:0:0:0: [sda] Unhandled error code
[ 4220.180212] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4220.180220] end_request: I/O error, dev sda, sector 56645059
[ 4220.180226] Buffer I/O error on device sda7, logical block 100382
[ 4220.180232] lost page write due to I/O error on sda7
[ 4220.180240] Buffer I/O error on device sda7, logical block 100383
[ 4220.180245] lost page write due to I/O error on sda7
[ 4255.180088] sd 2:0:0:0: [sda] Unhandled error code
[ 4255.180101] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4255.180112] end_request: I/O error, dev sda, sector 56644859
[ 4255.180122] Buffer I/O error on device sda7, logical block 100357
[ 4255.180129] lost page write due to I/O error on sda7
[ 4255.180151] sd 2:0:0:0: [sda] Unhandled error code
[ 4255.180156] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4255.180164] end_request: I/O error, dev sda, sector 56644843
[ 4255.180171] Buffer I/O error on device sda7, logical block 100355
[ 4255.180177] lost page write due to I/O error on sda7
[ 4285.180089] sd 2:0:0:0: [sda] Unhandled error code
[ 4285.180103] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4285.180113] end_request: I/O error, dev sda, sector 56645059
[ 4285.180123] Buffer I/O error on device sda7, logical block 100382
[ 4285.180130] lost page write due to I/O error on sda7
[ 4285.180141] Buffer I/O error on device sda7, logical block 100383
[ 4285.180146] lost page write due to I/O error on sda7
[ 4295.180097] sd 2:0:0:0: [sda] Unhandled error code
[ 4295.180109] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4295.180119] end_request: I/O error, dev sda, sector 56644859
[ 4295.180129] Buffer I/O error on device sda7, logical block 100357
[ 4295.180136] lost page write due to I/O error on sda7
[ 4295.180163] sd 2:0:0:0: [sda] Unhandled error code
[ 4295.180168] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4295.180176] end_request: I/O error, dev sda, sector 56644843
[ 4295.180183] Buffer I/O error on device sda7, logical block 100355
[ 4295.180189] lost page write due to I/O error on sda7
[ 4296.527015] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.527020] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.527024] end_request: I/O error, dev sda, sector 65301979
[ 4296.527055] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.527057] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.527061] end_request: I/O error, dev sda, sector 65301979
[ 4296.527064] Buffer I/O error on device sda7, logical block 1182497
[ 4296.527175] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.527177] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.527181] end_request: I/O error, dev sda, sector 65301979
[ 4296.527184] Buffer I/O error on device sda7, logical block 1182497
[ 4296.571362] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571368] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571372] end_request: I/O error, dev sda, sector 58042547
[ 4296.571377] Buffer I/O error on device sda7, logical block 275068
[ 4296.571379] lost page write due to I/O error on sda7
[ 4296.571396] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571398] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571401] end_request: I/O error, dev sda, sector 58044235
[ 4296.571404] Buffer I/O error on device sda7, logical block 275279
[ 4296.571407] lost page write due to I/O error on sda7
[ 4296.571413] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571415] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571421] end_request: I/O error, dev sda, sector 58044523
[ 4296.571424] Buffer I/O error on device sda7, logical block 275315
[ 4296.571426] lost page write due to I/O error on sda7
[ 4296.571429] Buffer I/O error on device sda7, logical block 275316
[ 4296.571431] lost page write due to I/O error on sda7
[ 4296.571434] Buffer I/O error on device sda7, logical block 275317
[ 4296.571437] lost page write due to I/O error on sda7
[ 4296.571442] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571444] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571447] end_request: I/O error, dev sda, sector 58044555
[ 4296.571450] Buffer I/O error on device sda7, logical block 275319
[ 4296.571453] lost page write due to I/O error on sda7
[ 4296.571458] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571461] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571464] end_request: I/O error, dev sda, sector 58044579
[ 4296.571473] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571475] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571479] end_request: I/O error, dev sda, sector 58044771
[ 4296.571590] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571593] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571596] end_request: I/O error, dev sda, sector 58044787
[ 4296.571613] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571616] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571619] end_request: I/O error, dev sda, sector 58083907
[ 4296.571627] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571629] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571632] end_request: I/O error, dev sda, sector 58084091
[ 4296.571649] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571652] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571655] end_request: I/O error, dev sda, sector 58084363
[ 4296.571660] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.571664] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.571667] end_request: I/O error, dev sda, sector 58084371
[ 4296.573887] sd 2:0:0:0: [sda] Unhandled error code
[ 4296.573891] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4296.573895] end_request: I/O error, dev sda, sector 58042547
[ 4297.811297] sd 2:0:0:0: [sda] Unhandled error code
[ 4297.811310] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4297.811320] end_request: I/O error, dev sda, sector 58042251
[ 4297.811420] sd 2:0:0:0: [sda] Unhandled error code
[ 4297.811426] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4297.811434] end_request: I/O error, dev sda, sector 58042251
[ 4297.811452] sd 2:0:0:0: [sda] Unhandled error code
[ 4297.811457] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4297.811465] end_request: I/O error, dev sda, sector 58042579
[ 4297.811716] sd 2:0:0:0: [sda] Unhandled error code
[ 4297.811723] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4297.811731] end_request: I/O error, dev sda, sector 58042251
[ 4330.176315] sd 2:0:0:0: [sda] Unhandled error code
[ 4330.176330] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4330.176340] end_request: I/O error, dev sda, sector 63379435
[ 4330.176348] __ratelimit: 47 callbacks suppressed
[ 4330.176355] Buffer I/O error on device sda7, logical block 942179
[ 4330.176362] lost page write due to I/O error on sda7
[ 4330.176404] sd 2:0:0:0: [sda] Unhandled error code
[ 4330.176410] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4330.176418] end_request: I/O error, dev sda, sector 75195053
[ 4330.176427] Buffer I/O error on device dm-0, logical block 953152
[ 4330.176432] lost page write due to I/O error on dm-0
[ 4330.176441] Buffer I/O error on device dm-0, logical block 953153
[ 4330.176446] lost page write due to I/O error on dm-0
[ 4330.176455] Buffer I/O error on device dm-0, logical block 953154
[ 4330.176460] lost page write due to I/O error on dm-0
[ 4330.176469] Buffer I/O error on device dm-0, logical block 953155
[ 4330.176474] lost page write due to I/O error on dm-0
[ 4330.176482] Buffer I/O error on device dm-0, logical block 953156
[ 4330.176487] lost page write due to I/O error on dm-0
[ 4330.176496] Buffer I/O error on device dm-0, logical block 953157
[ 4330.176501] lost page write due to I/O error on dm-0
[ 4330.176510] Buffer I/O error on device dm-0, logical block 953158
[ 4330.176515] lost page write due to I/O error on dm-0
[ 4330.176529] sd 2:0:0:0: [sda] Unhandled error code
[ 4330.176535] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4330.176543] end_request: I/O error, dev sda, sector 56924787
[ 4330.176549] Buffer I/O error on device sda7, logical block 135348
[ 4330.176555] lost page write due to I/O error on sda7
[ 4335.180093] sd 2:0:0:0: [sda] Unhandled error code
[ 4335.180107] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4335.180117] end_request: I/O error, dev sda, sector 56644843
[ 4335.180130] Buffer I/O error on device sda7, logical block 100355
[ 4335.180137] lost page write due to I/O error on sda7
[ 4335.180163] sd 2:0:0:0: [sda] Unhandled error code
[ 4335.180168] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4335.180179] end_request: I/O error, dev sda, sector 56644859
[ 4335.180186] Buffer I/O error on device sda7, logical block 100357
[ 4335.180192] lost page write due to I/O error on sda7
[ 4345.180126] sd 2:0:0:0: [sda] Unhandled error code
[ 4345.180139] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4345.180149] end_request: I/O error, dev sda, sector 56645059
[ 4345.180161] Buffer I/O error on device sda7, logical block 100382
[ 4345.180167] lost page write due to I/O error on sda7
[ 4345.180184] Buffer I/O error on device sda7, logical block 100383
[ 4345.180189] lost page write due to I/O error on sda7
[ 4357.091255] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091261] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091265] end_request: I/O error, dev sda, sector 58042547
[ 4357.091270] Buffer I/O error on device sda7, logical block 275068
[ 4357.091272] lost page write due to I/O error on sda7
[ 4357.091288] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091291] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091294] end_request: I/O error, dev sda, sector 58044235
[ 4357.091297] Buffer I/O error on device sda7, logical block 275279
[ 4357.091300] lost page write due to I/O error on sda7
[ 4357.091305] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091307] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091310] end_request: I/O error, dev sda, sector 58044523
[ 4357.091313] Buffer I/O error on device sda7, logical block 275315
[ 4357.091315] lost page write due to I/O error on sda7
[ 4357.091318] Buffer I/O error on device sda7, logical block 275316
[ 4357.091320] lost page write due to I/O error on sda7
[ 4357.091324] Buffer I/O error on device sda7, logical block 275317
[ 4357.091326] lost page write due to I/O error on sda7
[ 4357.091331] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091333] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091336] end_request: I/O error, dev sda, sector 58044555
[ 4357.091339] Buffer I/O error on device sda7, logical block 275319
[ 4357.091342] lost page write due to I/O error on sda7
[ 4357.091347] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091349] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091353] end_request: I/O error, dev sda, sector 58044579
[ 4357.091355] Buffer I/O error on device sda7, logical block 275322
[ 4357.091357] lost page write due to I/O error on sda7
[ 4357.091361] Buffer I/O error on device sda7, logical block 275323
[ 4357.091363] lost page write due to I/O error on sda7
[ 4357.091366] Buffer I/O error on device sda7, logical block 275324
[ 4357.091368] lost page write due to I/O error on sda7
[ 4357.091371] Buffer I/O error on device sda7, logical block 275325
[ 4357.091373] lost page write due to I/O error on sda7
[ 4357.091380] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091382] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091385] end_request: I/O error, dev sda, sector 58044771
[ 4357.091488] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091490] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091493] end_request: I/O error, dev sda, sector 58044787
[ 4357.091509] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091511] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091514] end_request: I/O error, dev sda, sector 58083907
[ 4357.091522] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091524] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091528] end_request: I/O error, dev sda, sector 58084091
[ 4357.091545] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091547] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091550] end_request: I/O error, dev sda, sector 58084363
[ 4357.091556] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.091558] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.091561] end_request: I/O error, dev sda, sector 58084371
[ 4357.094432] sd 2:0:0:0: [sda] Unhandled error code
[ 4357.094437] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4357.094441] end_request: I/O error, dev sda, sector 58042547
[ 4375.180097] sd 2:0:0:0: [sda] Unhandled error code
[ 4375.180110] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4375.180120] end_request: I/O error, dev sda, sector 56644843
[ 4375.180128] __ratelimit: 39 callbacks suppressed
[ 4375.180136] Buffer I/O error on device sda7, logical block 100355
[ 4375.180142] lost page write due to I/O error on sda7
[ 4375.180168] sd 2:0:0:0: [sda] Unhandled error code
[ 4375.180173] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4375.180182] end_request: I/O error, dev sda, sector 56644859
[ 4375.180188] Buffer I/O error on device sda7, logical block 100357
[ 4375.180194] lost page write due to I/O error on sda7
[ 4380.180086] sd 2:0:0:0: [sda] Unhandled error code
[ 4380.180100] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4380.180111] end_request: I/O error, dev sda, sector 56645059
[ 4380.180121] Buffer I/O error on device sda7, logical block 100382
[ 4380.180129] lost page write due to I/O error on sda7
[ 4380.180140] Buffer I/O error on device sda7, logical block 100383
[ 4380.180146] lost page write due to I/O error on sda7
[ 4390.180089] sd 2:0:0:0: [sda] Unhandled error code
[ 4390.180102] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4390.180112] end_request: I/O error, dev sda, sector 75195053
[ 4390.180126] Buffer I/O error on device dm-0, logical block 953152
[ 4390.180132] lost page write due to I/O error on dm-0
[ 4390.180143] Buffer I/O error on device dm-0, logical block 953153
[ 4390.180149] lost page write due to I/O error on dm-0
[ 4390.180157] Buffer I/O error on device dm-0, logical block 953154
[ 4390.180162] lost page write due to I/O error on dm-0
[ 4390.180170] Buffer I/O error on device dm-0, logical block 953155
[ 4390.180175] lost page write due to I/O error on dm-0
[ 4390.180183] Buffer I/O error on device dm-0, logical block 953156
[ 4390.180188] lost page write due to I/O error on dm-0
[ 4390.180196] Buffer I/O error on device dm-0, logical block 953157
[ 4390.180201] lost page write due to I/O error on dm-0
[ 4390.180209] Buffer I/O error on device dm-0, logical block 953158
[ 4390.180214] lost page write due to I/O error on dm-0
[ 4390.180235] sd 2:0:0:0: [sda] Unhandled error code
[ 4390.180241] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4390.180249] end_request: I/O error, dev sda, sector 75195453
[ 4390.180257] Buffer I/O error on device dm-0, logical block 953202
[ 4390.180262] lost page write due to I/O error on dm-0
[ 4410.180094] sd 2:0:0:0: [sda] Unhandled error code
[ 4410.180107] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4410.180118] end_request: I/O error, dev sda, sector 56644843
[ 4410.180130] Buffer I/O error on device sda7, logical block 100355
[ 4410.180136] lost page write due to I/O error on sda7
[ 4410.180163] sd 2:0:0:0: [sda] Unhandled error code
[ 4410.180168] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4410.180176] end_request: I/O error, dev sda, sector 56644859
[ 4410.180183] Buffer I/O error on device sda7, logical block 100357
[ 4410.180189] lost page write due to I/O error on sda7
[ 4417.588312] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588318] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588322] end_request: I/O error, dev sda, sector 58042547
[ 4417.588327] Buffer I/O error on device sda7, logical block 275068
[ 4417.588329] lost page write due to I/O error on sda7
[ 4417.588346] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588348] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588352] end_request: I/O error, dev sda, sector 58044235
[ 4417.588354] Buffer I/O error on device sda7, logical block 275279
[ 4417.588357] lost page write due to I/O error on sda7
[ 4417.588362] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588364] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588368] end_request: I/O error, dev sda, sector 58044523
[ 4417.588370] Buffer I/O error on device sda7, logical block 275315
[ 4417.588372] lost page write due to I/O error on sda7
[ 4417.588375] Buffer I/O error on device sda7, logical block 275316
[ 4417.588378] lost page write due to I/O error on sda7
[ 4417.588381] Buffer I/O error on device sda7, logical block 275317
[ 4417.588383] lost page write due to I/O error on sda7
[ 4417.588388] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588391] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588394] end_request: I/O error, dev sda, sector 58044555
[ 4417.588397] Buffer I/O error on device sda7, logical block 275319
[ 4417.588399] lost page write due to I/O error on sda7
[ 4417.588404] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588406] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588410] end_request: I/O error, dev sda, sector 58044579
[ 4417.588412] Buffer I/O error on device sda7, logical block 275322
[ 4417.588414] lost page write due to I/O error on sda7
[ 4417.588417] Buffer I/O error on device sda7, logical block 275323
[ 4417.588420] lost page write due to I/O error on sda7
[ 4417.588423] Buffer I/O error on device sda7, logical block 275324
[ 4417.588425] lost page write due to I/O error on sda7
[ 4417.588428] Buffer I/O error on device sda7, logical block 275325
[ 4417.588430] lost page write due to I/O error on sda7
[ 4417.588436] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588438] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588442] end_request: I/O error, dev sda, sector 58044771
[ 4417.588546] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588549] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588552] end_request: I/O error, dev sda, sector 58044787
[ 4417.588567] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588570] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588573] end_request: I/O error, dev sda, sector 58083907
[ 4417.588580] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588582] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588586] end_request: I/O error, dev sda, sector 58084091
[ 4417.588602] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588605] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588608] end_request: I/O error, dev sda, sector 58084363
[ 4417.588613] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.588615] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.588618] end_request: I/O error, dev sda, sector 58084371
[ 4417.590759] sd 2:0:0:0: [sda] Unhandled error code
[ 4417.590763] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4417.590766] end_request: I/O error, dev sda, sector 58042547
[ 4440.180089] sd 2:0:0:0: [sda] Unhandled error code
[ 4440.180101] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4440.180112] end_request: I/O error, dev sda, sector 56645059
[ 4440.180120] __ratelimit: 41 callbacks suppressed
[ 4440.180128] Buffer I/O error on device sda7, logical block 100382
[ 4440.180134] lost page write due to I/O error on sda7
[ 4440.180145] Buffer I/O error on device sda7, logical block 100383
[ 4440.180150] lost page write due to I/O error on sda7
[ 4445.180086] sd 2:0:0:0: [sda] Unhandled error code
[ 4445.180097] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4445.180108] end_request: I/O error, dev sda, sector 56644859
[ 4445.180121] Buffer I/O error on device sda7, logical block 100357
[ 4445.180127] lost page write due to I/O error on sda7
[ 4445.180154] sd 2:0:0:0: [sda] Unhandled error code
[ 4445.180160] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4445.180168] end_request: I/O error, dev sda, sector 56644843
[ 4445.180175] Buffer I/O error on device sda7, logical block 100355
[ 4445.180181] lost page write due to I/O error on sda7
[ 4450.180098] sd 2:0:0:0: [sda] Unhandled error code
[ 4450.180111] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4450.180121] end_request: I/O error, dev sda, sector 75195053
[ 4450.180132] Buffer I/O error on device dm-0, logical block 953152
[ 4450.180139] lost page write due to I/O error on dm-0
[ 4450.180150] Buffer I/O error on device dm-0, logical block 953153
[ 4450.180155] lost page write due to I/O error on dm-0
[ 4450.180163] Buffer I/O error on device dm-0, logical block 953154
[ 4450.180168] lost page write due to I/O error on dm-0
[ 4450.180176] Buffer I/O error on device dm-0, logical block 953155
[ 4450.180181] lost page write due to I/O error on dm-0
[ 4450.180189] Buffer I/O error on device dm-0, logical block 953156
[ 4450.180195] lost page write due to I/O error on dm-0
[ 4450.180203] Buffer I/O error on device dm-0, logical block 953157
[ 4450.180208] lost page write due to I/O error on dm-0
[ 4450.180216] Buffer I/O error on device dm-0, logical block 953158
[ 4450.180223] lost page write due to I/O error on dm-0
[ 4450.180242] sd 2:0:0:0: [sda] Unhandled error code
[ 4450.180248] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4450.180256] end_request: I/O error, dev sda, sector 75195453
[ 4450.180264] Buffer I/O error on device dm-0, logical block 953202
[ 4450.180269] lost page write due to I/O error on dm-0
[ 4455.326133] sd 2:0:0:0: [sda] Unhandled error code
[ 4455.326144] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4455.326154] end_request: I/O error, dev sda, sector 77713181
[ 4455.326236] sd 2:0:0:0: [sda] Unhandled error code
[ 4455.326242] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4455.326250] end_request: I/O error, dev sda, sector 77713181
[ 4455.326259] Buffer I/O error on device dm-0, logical block 1267918
[ 4475.180053] sd 2:0:0:0: [sda] Unhandled error code
[ 4475.180060] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4475.180065] end_request: I/O error, dev sda, sector 56645059
[ 4475.180071] Buffer I/O error on device sda7, logical block 100382
[ 4475.180074] lost page write due to I/O error on sda7
[ 4475.180081] Buffer I/O error on device sda7, logical block 100383
[ 4475.180084] lost page write due to I/O error on sda7
[ 4480.180095] sd 2:0:0:0: [sda] Unhandled error code
[ 4480.180107] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4480.180118] end_request: I/O error, dev sda, sector 56644859
[ 4480.180128] Buffer I/O error on device sda7, logical block 100357
[ 4480.180134] lost page write due to I/O error on sda7
[ 4480.180164] sd 2:0:0:0: [sda] Unhandled error code
[ 4480.180169] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4480.180177] end_request: I/O error, dev sda, sector 56644843
[ 4480.180185] Buffer I/O error on device sda7, logical block 100355
[ 4480.180191] lost page write due to I/O error on sda7
[ 4490.180103] sd 2:0:0:0: [sda] Unhandled error code
[ 4490.180117] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4490.180128] end_request: I/O error, dev sda, sector 84374501
[ 4490.180141] Buffer I/O error on device dm-0, logical block 2100583
[ 4490.180147] lost page write due to I/O error on dm-0
[ 4490.180174] sd 2:0:0:0: [sda] Unhandled error code
[ 4490.180179] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4490.180188] end_request: I/O error, dev sda, sector 84420101
[ 4490.180196] Buffer I/O error on device dm-0, logical block 2106283
[ 4490.180201] lost page write due to I/O error on dm-0
[ 4490.180215] sd 2:0:0:0: [sda] Unhandled error code
[ 4490.180220] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4490.180228] end_request: I/O error, dev sda, sector 89518573
[ 4490.180236] Buffer I/O error on device dm-0, logical block 2743592
[ 4490.180241] lost page write due to I/O error on dm-0
[ 4520.180096] sd 2:0:0:0: [sda] Unhandled error code
[ 4520.180108] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4520.180120] end_request: I/O error, dev sda, sector 56644843
[ 4520.180130] Buffer I/O error on device sda7, logical block 100355
[ 4520.180137] lost page write due to I/O error on sda7
[ 4520.180162] sd 2:0:0:0: [sda] Unhandled error code
[ 4520.180167] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4520.180177] end_request: I/O error, dev sda, sector 56644859
[ 4520.180184] Buffer I/O error on device sda7, logical block 100357
[ 4520.180190] lost page write due to I/O error on sda7
[ 4525.737190] [fglrx:firegl_find_any_map] *ERROR* Invalid map handle!<3>[fglrx:drm_vm_close] *ERROR* map not found -> inconsistent kernel data!!! vma_start:0x7f74814a6000,handle:0xc100e000
[ 4534.557896] sd 2:0:0:0: [sda] Unhandled error code
[ 4534.557951] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4534.558039] end_request: I/O error, dev sda, sector 77794373
[ 4534.558150] sd 2:0:0:0: [sda] Unhandled error code
[ 4534.558197] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4534.558282] end_request: I/O error, dev sda, sector 77794373
[ 4534.558334] Buffer I/O error on device dm-0, logical block 1278067
[ 4534.558490] sd 2:0:0:0: [sda] Unhandled error code
[ 4534.558536] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4534.558622] end_request: I/O error, dev sda, sector 77794373
[ 4534.558671] Buffer I/O error on device dm-0, logical block 1278067
[ 4535.188874] sd 2:0:0:0: [sda] Unhandled error code
[ 4535.188927] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4535.189012] end_request: I/O error, dev sda, sector 56645059
[ 4535.189062] Buffer I/O error on device sda7, logical block 100382
[ 4535.189110] lost page write due to I/O error on sda7
[ 4535.189164] Buffer I/O error on device sda7, logical block 100383
[ 4535.189212] lost page write due to I/O error on sda7
[ 4560.184092] sd 2:0:0:0: [sda] Unhandled error code
[ 4560.184147] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4560.184235] end_request: I/O error, dev sda, sector 56644859
[ 4560.184284] Buffer I/O error on device sda7, logical block 100357
[ 4560.184332] lost page write due to I/O error on sda7
[ 4560.184393] sd 2:0:0:0: [sda] Unhandled error code
[ 4560.184439] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4560.184529] end_request: I/O error, dev sda, sector 56644843
[ 4560.184577] Buffer I/O error on device sda7, logical block 100355
[ 4560.184623] lost page write due to I/O error on sda7
[ 4560.184676] sd 2:0:0:0: [sda] Unhandled error code
[ 4560.184720] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4560.184806] end_request: I/O error, dev sda, sector 84420101
[ 4560.184855] Buffer I/O error on device dm-0, logical block 2106283
[ 4560.184903] lost page write due to I/O error on dm-0
[ 4570.184080] sd 2:0:0:0: [sda] Unhandled error code
[ 4570.184137] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4570.184225] end_request: I/O error, dev sda, sector 56645059
[ 4570.184277] Buffer I/O error on device sda7, logical block 100382
[ 4570.184324] lost page write due to I/O error on sda7
[ 4570.184373] Buffer I/O error on device sda7, logical block 100383
[ 4570.184420] lost page write due to I/O error on sda7
[ 4600.184092] sd 2:0:0:0: [sda] Unhandled error code
[ 4600.184148] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4600.184236] end_request: I/O error, dev sda, sector 56644859
[ 4600.184286] Buffer I/O error on device sda7, logical block 100357
[ 4600.184334] lost page write due to I/O error on sda7
[ 4600.184399] sd 2:0:0:0: [sda] Unhandled error code
[ 4600.184442] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4600.184528] end_request: I/O error, dev sda, sector 56644843
[ 4600.184577] Buffer I/O error on device sda7, logical block 100355
[ 4600.184622] lost page write due to I/O error on sda7
[ 4635.180124] sd 2:0:0:0: [sda] Unhandled error code
[ 4635.180165] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4635.180236] end_request: I/O error, dev sda, sector 56644859
[ 4635.180275] Buffer I/O error on device sda7, logical block 100357
[ 4635.180311] lost page write due to I/O error on sda7
[ 4635.180359] sd 2:0:0:0: [sda] Unhandled error code
[ 4635.180395] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4635.180466] end_request: I/O error, dev sda, sector 56644843
[ 4635.180502] Buffer I/O error on device sda7, logical block 100355
[ 4635.180540] lost page write due to I/O error on sda7
[ 4635.180579] sd 2:0:0:0: [sda] Unhandled error code
[ 4635.180616] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4635.180687] end_request: I/O error, dev sda, sector 56645059
[ 4635.180724] Buffer I/O error on device sda7, logical block 100382
[ 4635.180761] lost page write due to I/O error on sda7
[ 4635.180798] Buffer I/O error on device sda7, logical block 100383
[ 4635.180836] lost page write due to I/O error on sda7
[ 4635.180874] sd 2:0:0:0: [sda] Unhandled error code
[ 4635.180911] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4635.180980] end_request: I/O error, dev sda, sector 63379435
[ 4635.181018] Buffer I/O error on device sda7, logical block 942179
[ 4635.181054] lost page write due to I/O error on sda7
[ 4635.181094] sd 2:0:0:0: [sda] Unhandled error code
[ 4635.181130] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4635.181201] end_request: I/O error, dev sda, sector 56924787
[ 4635.181239] Buffer I/O error on device sda7, logical block 135348
[ 4635.181275] lost page write due to I/O error on sda7
[ 4657.151531] sd 2:0:0:0: [sda] Unhandled error code
[ 4657.151589] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4657.151677] end_request: I/O error, dev sda, sector 67900637
[ 4657.151797] sd 2:0:0:0: [sda] Unhandled error code
[ 4657.151842] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4657.151929] end_request: I/O error, dev sda, sector 67900637
[ 4657.151980] Buffer I/O error on device dm-0, logical block 41350
[ 4657.152508] sd 2:0:0:0: [sda] Unhandled error code
[ 4657.152558] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4657.152648] end_request: I/O error, dev sda, sector 67900637
[ 4657.152699] Buffer I/O error on device dm-0, logical block 41350
[ 4660.242249] sd 2:0:0:0: [sda] Unhandled error code
[ 4660.242305] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4660.242391] end_request: I/O error, dev sda, sector 77777301
[ 4660.242509] sd 2:0:0:0: [sda] Unhandled error code
[ 4660.242555] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4660.242641] end_request: I/O error, dev sda, sector 77777301
[ 4660.242693] Buffer I/O error on device dm-0, logical block 1275933
[ 4660.242884] sd 2:0:0:0: [sda] Unhandled error code
[ 4660.242931] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4660.243023] end_request: I/O error, dev sda, sector 77777301
[ 4660.243071] Buffer I/O error on device dm-0, logical block 1275933
[ 4682.099118] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.099175] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.099264] end_request: I/O error, dev sda, sector 82512101
[ 4682.099374] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.099419] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.099504] end_request: I/O error, dev sda, sector 82512101
[ 4682.099604] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.099651] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.099737] end_request: I/O error, dev sda, sector 82512101
[ 4682.099895] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.099942] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.100057] end_request: I/O error, dev sda, sector 82512101
[ 4682.114760] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.114797] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.114868] end_request: I/O error, dev sda, sector 82512101
[ 4682.114944] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.114982] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.115057] end_request: I/O error, dev sda, sector 82512101
[ 4682.115106] REISERFS error (device dm-0): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [10723 11616 0x0 SD]
[ 4682.143741] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.143781] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.143853] end_request: I/O error, dev sda, sector 89734373
[ 4682.143918] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.143954] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.144048] end_request: I/O error, dev sda, sector 89734373
[ 4682.144086] Buffer I/O error on device dm-0, logical block 2770567
[ 4682.144323] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.144359] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.144431] end_request: I/O error, dev sda, sector 89734373
[ 4682.144470] Buffer I/O error on device dm-0, logical block 2770567
[ 4682.144554] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.144590] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.144661] end_request: I/O error, dev sda, sector 89734373
[ 4682.144699] Buffer I/O error on device dm-0, logical block 2770567
[ 4682.144793] sd 2:0:0:0: [sda] Unhandled error code
[ 4682.144830] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4682.144901] end_request: I/O error, dev sda, sector 89734373
[ 4682.144939] Buffer I/O error on device dm-0, logical block 2770567
[ 4684.228879] sd 2:0:0:0: [sda] Unhandled error code
[ 4684.228936] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4684.229024] end_request: I/O error, dev sda, sector 82512101
[ 4685.184084] sd 2:0:0:0: [sda] Unhandled error code
[ 4685.184144] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4685.184230] end_request: I/O error, dev sda, sector 56644843
[ 4685.184281] Buffer I/O error on device sda7, logical block 100355
[ 4685.184327] lost page write due to I/O error on sda7
[ 4685.184392] sd 2:0:0:0: [sda] Unhandled error code
[ 4685.184439] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4685.184526] end_request: I/O error, dev sda, sector 56644859
[ 4685.184572] Buffer I/O error on device sda7, logical block 100357
[ 4685.184619] lost page write due to I/O error on sda7
[ 4695.184082] sd 2:0:0:0: [sda] Unhandled error code
[ 4695.184139] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 4695.184226] end_request: I/O error, dev sda, sector 56645059
[ 4695.184276] Buffer I/O error on device sda7, logical block 100382
[ 4695.184322] lost page write due to I/O error on sda7
[ 4695.184375] Buffer I/O error on device sda7, logical block 100383
[ 4695.184421] lost page write due to I/O error on sda7
[ 4713.934647]  CIFS VFS: No response for cmd 50 mid 71


regards,
Benjamin
