From: YUP <yupadmin@gmail.com>
Subject: libata: CD and dvd devices not recognized
Date: Wed, 14 Mar 2007 23:14:04 +0100
Message-ID: <45F873AC.6010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:30745 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbXCNWOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 18:14:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so84543uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 15:14:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have the folowing problem. I'm running kubuntu box with
2.6.20-10 kernel with ubuntu patches and my cdrom as well as dvd drive
doesn't recognized at all. I've already reported this on kubuntu forum,
but nobody can answer me. The link is here:
http://kubuntuforums.net/forums/index.php?topic=3080227.0
I also tried to compile generic kernels from kernel.org with the same
result. Can anybody say what is going on with my hardware or kernel? 
Before 2.6.20 everything ran smoothly.


My latest dmesg output:


[    0.000000] Linux version 2.6.20-10-386 (root@vernadsky) (gcc version 
4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #2 Sun Mar 11 23:59:49 UTC 2007 (Ubuntu 
2.6.20-10.17-386)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 
000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 
0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 
0000000000010000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 
000000001fef0000 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000001fff0000 size: 
0000000000003000 end: 000000001fff3000 type: 4
[    0.000000] copy_e820_map() start: 000000001fff3000 size: 
000000000000d000 end: 0000000020000000 type: 3
[    0.000000] copy_e820_map() start: 00000000fec00000 size: 
0000000001400000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f4c80
[    0.000000] Entering add_active_range(0, 0, 131056) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   131056
[    0.000000]   HighMem    131056 ->   131056
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131056
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 991 pages used for memmap
[    0.000000]   Normal zone: 125969 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages used for memmap
[    0.000000] DMI not present or invalid.
[    0.000000] ACPI: RSDP (v000 GBT                                   ) 
@ 0x000f6710
[    0.000000] ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
[    0.000000] ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
[    0.000000] ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff6800
[    0.000000] ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
[    0.000000] ACPI: Disabling ACPI support
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
[    0.000000] Processor #0 15:1 APIC version 17
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 1
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 
20000000:dec00000)
[    0.000000] Detected 1800.141 MHz processor.
[   28.901063] Built 1 zonelists.  Total pages: 130033
[   28.901067] Kernel command line: 
root=UUID=bdcb0225-6620-4d74-9fe5-2f008da464c7 ro quiet splash
[   28.901313] mapped APIC to ffffd000 (fee00000)
[   28.901317] mapped IOAPIC to ffffc000 (fec00000)
[   28.901323] Enabling fast FPU save and restore... done.
[   28.901327] Enabling unmasked SIMD FPU exception support... done.
[   28.901352] Initializing CPU#0
[   28.901478] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   28.903160] Console: colour VGA+ 80x25
[   28.903823] Dentry cache hash table entries: 65536 (order: 6, 262144 
bytes)
[   28.904492] Inode-cache hash table entries: 32768 (order: 5, 131072 
bytes)
[   28.927726] Memory: 508900k/524224k available (1909k kernel code, 
14664k reserved, 855k data, 324k init, 0k highmem)
[   28.927741] virtual kernel memory layout:
[   28.927743]     fixmap  : 0xfffa9000 - 0xfffff000   ( 344 kB)
[   28.927745]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   28.927746]     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
[   28.927748]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   28.927750]       .init : 0xc03b6000 - 0xc0407000   ( 324 kB)
[   28.927751]       .data : 0xc02dd483 - 0xc03b3434   ( 855 kB)
[   28.927753]       .text : 0xc0100000 - 0xc02dd483   (1909 kB)
[   28.927757] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[   29.005328] Calibrating delay using timer specific routine.. 3603.20 
BogoMIPS (lpj=7206406)
[   29.005379] Security Framework v1.0.0 initialized
[   29.005391] SELinux:  Disabled at boot.
[   29.005407] Mount-cache hash table entries: 512
[   29.005567] CPU: After generic identify, caps: 3febfbff 00000000 
00000000 00000000 00000000 00000000 00000000
[   29.005582] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   29.005585] CPU: L2 cache: 256K
[   29.005588] CPU: After all inits, caps: 3febfbff 00000000 00000000 
00003080 00000000 00000000 00000000
[   29.005603] Compat vDSO mapped to ffffe000.
[   29.005617] CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
[   29.005630] Checking 'hlt' instruction... OK.
[   29.022034] Early unpacking initramfs... done
[   29.465585] ExtINT not setup in hardware but reported by MP table
[   29.465670] ENABLING IO-APIC IRQs
[   29.465900] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[   29.612735] Booting paravirtualized kernel on bare hardware
[   29.612845] Time: 19:44:46  Date: 02/14/107
[   29.612900] NET: Registered protocol family 16
[   29.613087] EISA bus registered
[   29.638722] PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=2
[   29.638726] PCI: Using configuration type 1
[   29.638729] Setting up standard PCI resources
[   29.645436] ACPI: Interpreter disabled.
[   29.645445] Linux Plug and Play Support v0.97 (c) Adam Belay
[   29.645456] pnp: PnP ACPI: disabled
[   29.645459] PnPBIOS: Scanning system for PnP BIOS support...
[   29.645515] PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc20
[   29.645519] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbc50, dseg 
0xf0000
[   29.646852] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
[   29.646930] PCI: Probing PCI hardware
[   29.646937] PCI: Probing PCI hardware (bus 00)
[   29.647200] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[   29.647206] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[   29.647575] Boot video device is 0000:01:00.0
[   29.647815] PCI: Transparent bridge - 0000:00:1e.0
[   29.648646] PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
[   29.648666] PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
[   29.648670] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   29.648674] PCI->APIC IRQ transform: 0000:00:1f.4[C] -> IRQ 23
[   29.648678] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   29.648682] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   29.648686] PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 21
[   29.648690] PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 21
[   29.664587] PCI: Bridge: 0000:00:01.0
[   29.664594]   IO window: c000-cfff
[   29.664600]   MEM window: ec000000-edffffff
[   29.664604]   PREFETCH window: e0000000-e7ffffff
[   29.664610] PCI: Bridge: 0000:00:1e.0
[   29.664614]   IO window: a000-bfff
[   29.664620]   MEM window: ee000000-efffffff
[   29.664626]   PREFETCH window: 30000000-300fffff
[   29.664650] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   29.664700] NET: Registered protocol family 2
[   29.692398] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[   29.692530] TCP established hash table entries: 16384 (order: 4, 
65536 bytes)
[   29.692624] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   29.692679] TCP: Hash tables configured (established 16384 bind 8192)
[   29.692683] TCP reno registered
[   29.704498] checking if image is initramfs... it is
[   30.589971] Freeing initrd memory: 6672k freed
[   30.590656] audit: initializing netlink socket (disabled)
[   30.590684] audit(1173901486.772:1): initialized
[   30.590890] VFS: Disk quotas dquot_6.5.1
[   30.590925] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   30.591052] io scheduler noop registered
[   30.591057] io scheduler anticipatory registered
[   30.591059] io scheduler deadline registered
[   30.591075] io scheduler cfq registered (default)
[   30.591462] isapnp: Scanning for PnP cards...
[   30.945192] isapnp: No Plug & Play device found
[   31.025152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing enabled
[   31.025309] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.025741] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.027338] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.028024] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.028591] mice: PS/2 mouse device common for all mice
[   31.029412] RAMDISK driver initialized: 16 RAM disks of 65536K size 
1024 blocksize
[   31.029671] input: Macintosh mouse button emulation as 
/class/input/input0
[   31.029732] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   31.029739] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[   31.030110] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[   31.032916] serio: i8042 KBD port at 0x60,0x64 irq 1
[   31.032925] serio: i8042 AUX port at 0x60,0x64 irq 12
[   31.033122] EISA: Probing bus 0 at eisa.0
[   31.033147] Cannot allocate resource for EISA slot 4
[   31.033150] Cannot allocate resource for EISA slot 5
[   31.033165] EISA: Detected 0 cards.
[   31.033308] TCP cubic registered
[   31.033327] NET: Registered protocol family 1
[   31.033336] NET: Registered protocol family 8
[   31.033338] NET: Registered protocol family 20
[   31.033391] Using IPI Shortcut mode
[   31.033430]   Magic number: 15:731:748
[   31.034301] Time: tsc clocksource has been installed.
[   31.034526] Freeing unused kernel memory: 324k freed
[   31.060782] input: AT Translated Set 2 keyboard as /class/input/input1
[   32.530947] Capability LSM initialized
[   32.625002] thermal: Unknown symbol acpi_processor_set_thermal_limit
[   33.640591] usbcore: registered new interface driver usbfs
[   33.640632] usbcore: registered new interface driver hub
[   33.640682] usbcore: registered new device driver usb
[   33.642221] USB Universal Host Controller Interface driver v3.0
[   33.642330] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   33.642335] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   33.642593] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned 
bus number 1
[   33.642636] uhci_hcd 0000:00:1f.2: irq 19, io base 0x0000d000
[   33.642847] usb usb1: configuration #1 chosen from 1 choice
[   33.642890] hub 1-0:1.0: USB hub found
[   33.642905] hub 1-0:1.0: 2 ports detected
[   33.707293] SCSI subsystem initialized
[   33.715511] libata version 2.00 loaded.
[   33.732227] Linux Tulip driver version 1.1.14 (December 15, 2004)
[   33.746542] PCI: Setting latency timer of device 0000:00:1f.4 to 64
[   33.746550] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[   33.746588] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned 
bus number 2
[   33.746624] uhci_hcd 0000:00:1f.4: irq 23, io base 0x0000d800
[   33.746776] usb usb2: configuration #1 chosen from 1 choice
[   33.746816] hub 2-0:1.0: USB hub found
[   33.746831] hub 2-0:1.0: 2 ports detected
[   33.877549] Floppy drive(s): fd0 is 1.44M
[   33.926133] ata_piix 0000:00:1f.1: version 2.00ac7
[   33.926178] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   33.926324] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 
irq 14
[   33.926388] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 
irq 15
[   33.926412] scsi0 : ata_piix
[   33.993985] FDC 0 is a post-1991 82077
[   34.245729] ata1.00: ATAPI, max UDMA/33
[   34.409478] ata1.01: ATAPI, max MWDMA2
[   34.573238] ata1.00: configured for UDMA/33
[   34.736993] ata1.01: configured for MWDMA2
[   34.737023] scsi1 : ata_piix
[   34.894993] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j 
  1.36 PQ: 0 ANSI: 5
[   34.896276] scsi 0:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH 
  A80  PQ: 0 ANSI: 5
[   34.909780] tulip0:  MII transceiver #1 config 1000 status 786d 
advertising 05e1.
[   34.917561] eth0: ADMtek Comet rev 17 at Port 0xb400, 
00:04:5A:8A:55:7B, IRQ 21.
[   34.917761] pata_pdc2027x 0000:02:01.0: version 0.74-ac5
[   35.016968] pata_pdc2027x 0000:02:01.0: PLL input clock 16550 kHz
[   35.051596] ata3: PATA max UDMA/133 cmd 0xE08297C0 ctl 0xE0829FDA 
bmdma 0xE0829000 irq 21
[   35.051661] ata4: PATA max UDMA/133 cmd 0xE08295C0 ctl 0xE0829DDA 
bmdma 0xE0829008 irq 21
[   35.051681] scsi2 : pata_pdc2027x
[   35.082740] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   35.082749] Uniform CD-ROM driver Revision: 3.20
[   35.083141] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   35.092019] sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray
[   35.092385] sr 0:0:1:0: Attached scsi CD-ROM sr1
[   35.099265] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   35.099296] sr 0:0:1:0: Attached scsi generic sg1 type 5
[   35.212468] ata3.00: ATA-7, max UDMA/100, 234493056 sectors: LBA48
[   35.212474] ata3.00: ata3: dev 0 multi count 16
[   35.220438] ata3.01: ATA-7, max UDMA/133, 320173056 sectors: LBA48
[   35.220441] ata3.01: ata3: dev 1 multi count 16
[   35.228424] ata3.00: Host Protected Area detected:
[   35.228426] 	current size: 234493056 sectors (120 GB)
[   35.228427] 	native size: 274965953385600 sectors (140782568 GB)
[   35.228431] ata3.00: configured for UDMA/100
[   35.236410] ata3.01: configured for UDMA/133
[   35.236440] scsi3 : pata_pdc2027x
[   35.403177] ATA: abnormal status 0x8 on port 0xE08295DF
[   35.404104] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP1203N 
  TL10 PQ: 0 ANSI: 5
[   35.404234] scsi 2:0:0:0: Attached scsi generic sg2 type 0
[   35.406414] scsi 2:0:1:0: Direct-Access     ATA      Maxtor 6Y160P0 
  YAR4 PQ: 0 ANSI: 5
[   35.406557] scsi 2:0:1:0: Attached scsi generic sg3 type 0
[   35.428061] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   35.428121] sda: Write Protect is off
[   35.428125] sda: Mode Sense: 00 3a 00 00
[   35.428146] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.428249] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   35.428261] sda: Write Protect is off
[   35.428264] sda: Mode Sense: 00 3a 00 00
[   35.428283] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.428288]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[   35.471341] sd 2:0:0:0: Attached scsi disk sda
[   35.471701] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   35.471722] sdb: Write Protect is off
[   35.471725] sdb: Mode Sense: 00 3a 00 00
[   35.471745] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.471835] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   35.471848] sdb: Write Protect is off
[   35.471851] sdb: Mode Sense: 00 3a 00 00
[   35.471869] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.471874]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 >
[   35.505434] sd 2:0:1:0: Attached scsi disk sdb
[   36.226710] Attempting manual resume
[   36.226716] swsusp: Resume From Partition 8:6
[   36.226718] PM: Checking swsusp image.
[   36.226998] PM: Resume from disk failed.
[   36.272428] kjournald starting.  Commit interval 5 seconds
[   36.272453] EXT3-fs: mounted filesystem with ordered data mode.
[   43.717504] NET: Registered protocol family 10
[   43.717652] lo: Disabled Privacy Extensions
[   45.315793] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   45.326258] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   45.383717] iTCO_vendor_support: vendor-support=0
[   45.385484] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
[   45.385607] iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled 
by hardware
[   45.385618] iTCO_wdt: No card detected
[   45.528961] Linux agpgart interface v0.101 (c) Dave Jones
[   45.538893] agpgart: Detected an Intel i845 Chipset.
[   45.543002] agpgart: AGP aperture is 64M @ 0xe8000000
[   45.658548] 0000:02:05.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 
CSR6 0xff972113)
[   45.658562] eth0: Setting full-duplex based on MII#1 link partner 
capability of 41e1.
[   46.160206] Real Time Clock Driver v1.12ac
[   46.409529] input: PC Speaker as /class/input/input2
[   46.721256] parport: PnPBIOS parport detected.
[   46.721325] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   46.970786] input: ImPS/2 Generic Wheel Mouse as /class/input/input3
[   47.578596] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   47.893095] intel8x0_measure_ac97_clock: measured 54928 usecs
[   47.893102] intel8x0: clocking to 48000
[   54.519171] eth0: no IPv6 routers present
[   65.095382] ata1.01: qc timeout (cmd 0xa0)
[   65.095404] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[   65.095409] ata1.01: (BMDMA stat 0x65)
[   65.095417] ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[   65.095419]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[   72.084934] ata1: port is slow to respond, please be patient (Status 
0xd8)
[   95.066527] ata1: port failed to respond (30 secs, Status 0xd8)
[   95.066538] ata1: soft resetting port
[   95.549849] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[   95.549856] ata1.01: revalidation failed (errno=-5)
[   95.549865] ata1: failed to recover some devices, retrying in 5 secs
[  100.546369] ata1: soft resetting port
[  101.193580] ata1.00: configured for UDMA/33
[  101.357350] ata1.01: configured for MWDMA2
[  101.357399] ata1: EH complete
[  131.348286] ata1.01: qc timeout (cmd 0xa0)
[  131.348308] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  131.348314] ata1.01: (BMDMA stat 0x65)
[  131.348322] ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  131.348324]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  138.337850] ata1: port is slow to respond, please be patient (Status 
0xd8)
[  161.319429] ata1: port failed to respond (30 secs, Status 0xd8)
[  161.319440] ata1: soft resetting port
[  161.802751] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  161.802759] ata1.01: revalidation failed (errno=-5)
[  161.802767] ata1: failed to recover some devices, retrying in 5 secs
[  166.799279] ata1: soft resetting port
[  167.446501] ata1.00: configured for UDMA/33
[  167.610263] ata1.01: configured for MWDMA2
[  167.610309] ata1: EH complete
[  197.581219] ata1.01: qc timeout (cmd 0xa0)
[  197.581238] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  197.581243] ata1.01: (BMDMA stat 0x65)
[  197.581251] ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  197.581254]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  204.570799] ata1: port is slow to respond, please be patient (Status 
0xd8)
[  222.413761] fuse init (API version 7.8)
[  222.455823] lp0: using parport0 (interrupt-driven).
[  222.677756] it87: Found IT8712F chip at 0x290, revision 4
[  222.682692] it87-isa 9191-0290: Detected broken BIOS defaults, 
disabling PWM interface
[  222.749640] Adding 1044184k swap on 
/dev/disk/by-uuid/5c6a2d8c-54c1-44cb-8f1b-4a159373a120.  Priority:-1 
extents:1 across:1044184k
[  222.988655] EXT3 FS on sda7, internal journal
[  226.546597] kjournald starting.  Commit interval 5 seconds
[  226.546759] EXT3 FS on sda1, internal journal
[  226.546768] EXT3-fs: mounted filesystem with ordered data mode.
[  226.572475] kjournald starting.  Commit interval 5 seconds
[  226.572662] EXT3 FS on sda3, internal journal
[  226.572670] EXT3-fs: mounted filesystem with ordered data mode.
[  226.622569] kjournald starting.  Commit interval 5 seconds
[  226.622821] EXT3 FS on sdb5, internal journal
[  226.622830] EXT3-fs: mounted filesystem with ordered data mode.
[  226.654728] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  226.722162] NTFS volume version 3.1.
[  226.813689] kjournald starting.  Commit interval 5 seconds
[  226.813910] EXT3 FS on sdb6, internal journal
[  226.813919] EXT3-fs: mounted filesystem with ordered data mode.
[  226.828535] kjournald starting.  Commit interval 5 seconds
[  226.828689] EXT3 FS on sda5, internal journal
[  226.828697] EXT3-fs: mounted filesystem with ordered data mode.
[  226.859417] kjournald starting.  Commit interval 5 seconds
[  226.859590] EXT3 FS on sda2, internal journal
[  226.859597] EXT3-fs: mounted filesystem with ordered data mode.
[  227.560360] ata1: port failed to respond (30 secs, Status 0xd8)
[  227.560371] ata1: soft resetting port
[  228.043665] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  228.043672] ata1.01: revalidation failed (errno=-5)
[  228.043680] ata1: failed to recover some devices, retrying in 5 secs
[  228.815175] NET: Registered protocol family 17
[  233.040220] ata1: soft resetting port
[  233.679451] ata1.00: configured for UDMA/33
[  233.843205] ata1.01: configured for MWDMA2
[  233.843250] ata1: EH complete
[  239.008402] ppdev: user-space parallel port driver
[  241.617434] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[  245.714461] [drm] Initialized drm 1.1.0 20060810
[  245.764993] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  246.443254] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  246.443476] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  246.443667] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  246.734936] [drm] Setting GART location based on new memory map
[  246.735007] [drm] writeback test succeeded in 1 usecs
[ 4906.833413] usb 2-2: new full speed USB device using uhci_hcd and 
address 2
[ 4907.027229] usb 2-2: configuration #1 chosen from 1 choice
[ 4907.568430] drivers/usb/class/usblp.c: usblp0: USB Bidirectional 
printer dev 2 if 1 alt 0 proto 2 vid 0x03F0 pid 0x4C11
[ 4907.569056] usbcore: registered new interface driver usblp
[ 4907.569339] drivers/usb/class/usblp.c: v0.13: USB Printer Device 
Class driver
[ 4962.925328] drivers/usb/class/usblp.c: usblp0: removed
[ 8919.303864] usb 2-2: USB disconnect, address 2
[10872.570238] usb 2-2: new full speed USB device using uhci_hcd and 
address 3
[10872.764030] usb 2-2: configuration #1 chosen from 1 choice
[10872.770976] drivers/usb/class/usblp.c: usblp0: USB Bidirectional 
printer dev 3 if 1 alt 0 proto 2 vid 0x03F0 pid 0x4C11
[10878.980584] drivers/usb/class/usblp.c: usblp0: removed



Regards,

Yarema

