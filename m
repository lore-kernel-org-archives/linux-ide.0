From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 15 Mar 2007 14:11:42 +0100
Message-ID: <45F9460E.7020701@gmail.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:23135 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459AbXCONLy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 09:11:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so161638wxd
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 06:11:52 -0700 (PDT)
In-Reply-To: <45F8C3E1.3080805@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

Hi Albert,

Thanks for quick answer.

>> [   35.082749] Uniform CD-ROM driver Revision: 3.20
>> [   35.083141] sr 0:0:0:0: Attached scsi CD-ROM sr0
>> [   35.092019] sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray
>> [   35.092385] sr 0:0:1:0: Attached scsi CD-ROM sr1
>> [   35.099265] sr 0:0:0:0: Attached scsi generic sg0 type 5
>> [   35.099296] sr 0:0:1:0: Attached scsi generic sg1 type 5
> 
> Both your HP DVD Writer 200j and AOpen 56X/AKH are detected correctly
> as sr0 and sr1. (It might be /dev/scd0 and /dev/scd1 on your distro.)
> 
> However, there are problems with the AOpen "E-IDE    CD-ROM 56X/AKH"
> drive. It reports the strange "231x" speed and later timeout on INQUIRY.

I've seen that, but! I have no devices like /dev/sr0 and /dev/sr1 nor
/dev/scd0 and /dev/scd1.


> 
> Could you please replace the cable and/or connect the AOpen drive to
> another PATA port and see if it makes the "qc timeout" go away, thanks.

I tried replace the cable with no result. The second experiment was 
successful: I plugged DVD and cdrom separately to the different ports 
(before they were on one cable as master and slave), this time dvd runs 
well, but I can't see cdrom. I also tried play with master-slave, 
different combination with different cables etc. Result is the same - 
dvd is OK, cdrom causes annoying messages.  Maybe something is wrong 
with my cdrom. But under windows  everything works fine... And with 
2.6.18 kernel everything was fine.

Yarema

Here is my dmesg:

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
[    0.000000] Detected 1800.171 MHz processor.
[   29.455466] Built 1 zonelists.  Total pages: 130033
[   29.455470] Kernel command line: 
root=UUID=bdcb0225-6620-4d74-9fe5-2f008da464c7 ro quiet splash
[   29.455717] mapped APIC to ffffd000 (fee00000)
[   29.455721] mapped IOAPIC to ffffc000 (fec00000)
[   29.455727] Enabling fast FPU save and restore... done.
[   29.455731] Enabling unmasked SIMD FPU exception support... done.
[   29.455756] Initializing CPU#0
[   29.455875] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   29.457532] Console: colour VGA+ 80x25
[   29.458199] Dentry cache hash table entries: 65536 (order: 6, 262144 
bytes)
[   29.458869] Inode-cache hash table entries: 32768 (order: 5, 131072 
bytes)
[   29.480398] Memory: 508900k/524224k available (1909k kernel code, 
14664k reserved, 855k data, 324k init, 0k highmem)
[   29.480412] virtual kernel memory layout:
[   29.480414]     fixmap  : 0xfffa9000 - 0xfffff000   ( 344 kB)
[   29.480416]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   29.480418]     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
[   29.480419]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   29.480421]       .init : 0xc03b6000 - 0xc0407000   ( 324 kB)
[   29.480423]       .data : 0xc02dd483 - 0xc03b3434   ( 855 kB)
[   29.480424]       .text : 0xc0100000 - 0xc02dd483   (1909 kB)
[   29.480429] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[   29.559726] Calibrating delay using timer specific routine.. 3603.21 
BogoMIPS (lpj=7206423)
[   29.559776] Security Framework v1.0.0 initialized
[   29.559787] SELinux:  Disabled at boot.
[   29.559803] Mount-cache hash table entries: 512
[   29.559964] CPU: After generic identify, caps: 3febfbff 00000000 
00000000 00000000 00000000 00000000 00000000
[   29.559979] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   29.559982] CPU: L2 cache: 256K
[   29.559985] CPU: After all inits, caps: 3febfbff 00000000 00000000 
00003080 00000000 00000000 00000000
[   29.560000] Compat vDSO mapped to ffffe000.
[   29.560014] CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
[   29.560026] Checking 'hlt' instruction... OK.
[   29.576433] Early unpacking initramfs... done
[   30.020000] ExtINT not setup in hardware but reported by MP table
[   30.020085] ENABLING IO-APIC IRQs
[   30.020316] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[   30.167137] Booting paravirtualized kernel on bare hardware
[   30.167250] Time: 13:54:27  Date: 02/15/107
[   30.167305] NET: Registered protocol family 16
[   30.167496] EISA bus registered
[   30.193128] PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=2
[   30.193132] PCI: Using configuration type 1
[   30.193134] Setting up standard PCI resources
[   30.199841] ACPI: Interpreter disabled.
[   30.199849] Linux Plug and Play Support v0.97 (c) Adam Belay
[   30.199860] pnp: PnP ACPI: disabled
[   30.199864] PnPBIOS: Scanning system for PnP BIOS support...
[   30.199916] PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc20
[   30.199920] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbc50, dseg 
0xf0000
[   30.201260] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
[   30.201341] PCI: Probing PCI hardware
[   30.201348] PCI: Probing PCI hardware (bus 00)
[   30.201613] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[   30.201618] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[   30.201987] Boot video device is 0000:01:00.0
[   30.202228] PCI: Transparent bridge - 0000:00:1e.0
[   30.203057] PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
[   30.203077] PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
[   30.203081] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   30.203085] PCI->APIC IRQ transform: 0000:00:1f.4[C] -> IRQ 23
[   30.203089] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   30.203093] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   30.203097] PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 21
[   30.203101] PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 21
[   30.219006] PCI: Bridge: 0000:00:01.0
[   30.219012]   IO window: c000-cfff
[   30.219018]   MEM window: ec000000-edffffff
[   30.219023]   PREFETCH window: e0000000-e7ffffff
[   30.219029] PCI: Bridge: 0000:00:1e.0
[   30.219033]   IO window: a000-bfff
[   30.219039]   MEM window: ee000000-efffffff
[   30.219044]   PREFETCH window: 30000000-300fffff
[   30.219069] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   30.219121] NET: Registered protocol family 2
[   30.246800] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[   30.246936] TCP established hash table entries: 16384 (order: 4, 
65536 bytes)
[   30.247030] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   30.247085] TCP: Hash tables configured (established 16384 bind 8192)
[   30.247088] TCP reno registered
[   30.258891] checking if image is initramfs... it is
[   31.143842] Freeing initrd memory: 6672k freed
[   31.144533] audit: initializing netlink socket (disabled)
[   31.144561] audit(1173966867.768:1): initialized
[   31.144772] VFS: Disk quotas dquot_6.5.1
[   31.144806] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   31.144908] io scheduler noop registered
[   31.144912] io scheduler anticipatory registered
[   31.144915] io scheduler deadline registered
[   31.144932] io scheduler cfq registered (default)
[   31.145318] isapnp: Scanning for PnP cards...
[   31.499036] isapnp: No Plug & Play device found
[   31.579514] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing enabled
[   31.579672] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.580109] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.581783] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.582462] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.583028] mice: PS/2 mouse device common for all mice
[   31.583803] RAMDISK driver initialized: 16 RAM disks of 65536K size 
1024 blocksize
[   31.584267] input: Macintosh mouse button emulation as 
/class/input/input0
[   31.584328] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   31.584335] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[   31.584774] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[   31.588348] serio: i8042 KBD port at 0x60,0x64 irq 1
[   31.588361] serio: i8042 AUX port at 0x60,0x64 irq 12
[   31.588632] EISA: Probing bus 0 at eisa.0
[   31.588660] Cannot allocate resource for EISA slot 4
[   31.588663] Cannot allocate resource for EISA slot 5
[   31.588678] EISA: Detected 0 cards.
[   31.588837] TCP cubic registered
[   31.588856] NET: Registered protocol family 1
[   31.588866] NET: Registered protocol family 8
[   31.588868] NET: Registered protocol family 20
[   31.588923] Using IPI Shortcut mode
[   31.588962]   Magic number: 15:376:938
[   31.590013] Freeing unused kernel memory: 324k freed
[   31.592694] Time: tsc clocksource has been installed.
[   31.617427] input: AT Translated Set 2 keyboard as /class/input/input1
[   33.117461] Capability LSM initialized
[   33.211373] thermal: Unknown symbol acpi_processor_set_thermal_limit
[   34.215236] SCSI subsystem initialized
[   34.252968] libata version 2.00 loaded.
[   34.255515] ata_piix 0000:00:1f.1: version 2.00ac7
[   34.255556] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   34.255697] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 
irq 14
[   34.255756] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 
irq 15
[   34.255777] scsi0 : ata_piix
[   34.296839] Linux Tulip driver version 1.1.14 (December 15, 2004)
[   34.340884] usbcore: registered new interface driver usbfs
[   34.340931] usbcore: registered new interface driver hub
[   34.340971] usbcore: registered new device driver usb
[   34.342547] USB Universal Host Controller Interface driver v3.0
[   34.534069] Floppy drive(s): fd0 is 1.44M
[   34.566101] FDC 0 is a post-1991 82077
[   34.572543] ata1.00: ATAPI, max UDMA/33
[   34.736223] ata1.00: configured for UDMA/33
[   34.736252] scsi1 : ata_piix
[   34.894233] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j 
  1.36 PQ: 0 ANSI: 5
[   34.900160] pata_pdc2027x 0000:02:01.0: version 0.74-ac5
[   34.999368] pata_pdc2027x 0000:02:01.0: PLL input clock 16550 kHz
[   35.029543] ata3: PATA max UDMA/133 cmd 0xE08617C0 ctl 0xE0861FDA 
bmdma 0xE0861000 irq 21
[   35.029600] ata4: PATA max UDMA/133 cmd 0xE08615C0 ctl 0xE0861DDA 
bmdma 0xE0861008 irq 21
[   35.029617] scsi2 : pata_pdc2027x
[   35.048373] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   35.048383] Uniform CD-ROM driver Revision: 3.20
[   35.048479] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   35.055422] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   35.191725] ata3.00: ATA-7, max UDMA/100, 234493056 sectors: LBA48
[   35.191732] ata3.00: ata3: dev 0 multi count 16
[   35.199693] ata3.01: ATA-7, max UDMA/133, 320173056 sectors: LBA48
[   35.199697] ata3.01: ata3: dev 1 multi count 16
[   35.207679] ata3.00: Host Protected Area detected:
[   35.207681]  current size: 234493056 sectors (120 GB)
[   35.207683]  native size: 274965953385600 sectors (140782568 GB)
[   35.207687] ata3.00: configured for UDMA/100
[   35.215664] ata3.01: configured for UDMA/133
[   35.215694] scsi3 : pata_pdc2027x
[   35.382452] ATA: abnormal status 0x7F on port 0xE08615DF
[   35.393825] ATA: abnormal status 0x7F on port 0xE08615DF
[   35.555096] ata4.01: ATAPI, max MWDMA2
[   35.718854] ata4.01: configured for MWDMA2
[   35.721044] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP1203N 
  TL10 PQ: 0 ANSI: 5
[   35.721824] scsi 2:0:0:0: Attached scsi generic sg1 type 0
[   35.722015] scsi 2:0:1:0: Direct-Access     ATA      Maxtor 6Y160P0 
  YAR4 PQ: 0 ANSI: 5
[   35.722742] scsi 2:0:1:0: Attached scsi generic sg2 type 0
[   35.723427] scsi 3:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH 
  A80  PQ: 0 ANSI: 5
[   35.732888] sr1: scsi3-mmc drive: 229x/52x cd/rw xa/form2 cdda tray
[   35.733222] sr 3:0:1:0: Attached scsi CD-ROM sr1
[   35.733642] sr 3:0:1:0: Attached scsi generic sg3 type 5
[   35.734643] tulip0:  MII transceiver #1 config 3100 status 7869 
advertising 05e1.
[   35.742236] eth0: ADMtek Comet rev 17 at Port 0xb400, 
00:04:5A:8A:55:7B, IRQ 21.
[   35.744659] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   35.744669] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   35.745018] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned 
bus number 1
[   35.745060] uhci_hcd 0000:00:1f.2: irq 19, io base 0x0000d000
[   35.745265] usb usb1: configuration #1 chosen from 1 choice
[   35.745310] hub 1-0:1.0: USB hub found
[   35.745325] hub 1-0:1.0: 2 ports detected
[   35.774910] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   35.774980] sda: Write Protect is off
[   35.774984] sda: Mode Sense: 00 3a 00 00
[   35.775004] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.775115] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   35.775128] sda: Write Protect is off
[   35.775132] sda: Mode Sense: 00 3a 00 00
[   35.775151] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.775156]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[   35.823059] sd 2:0:0:0: Attached scsi disk sda
[   35.823396] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   35.823415] sdb: Write Protect is off
[   35.823419] sdb: Mode Sense: 00 3a 00 00
[   35.823437] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.823529] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   35.823541] sdb: Write Protect is off
[   35.823544] sdb: Mode Sense: 00 3a 00 00
[   35.823562] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.823567]  sdb: sdb1 sdb2 sdb3 < sdb5<7>PCI: Setting latency timer 
of device 0000:00:1f.4 to 64
[   35.846562] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[   35.846602] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned 
bus number 2
[   35.846639] uhci_hcd 0000:00:1f.4: irq 23, io base 0x0000d800
[   35.846796] usb usb2: configuration #1 chosen from 1 choice
[   35.846837] hub 2-0:1.0: USB hub found
[   35.846852] hub 2-0:1.0: 2 ports detected
[   35.858930]  sdb6 >
[   35.860216] sd 2:0:1:0: Attached scsi disk sdb
[   36.524306] kjournald starting.  Commit interval 5 seconds
[   36.524332] EXT3-fs: mounted filesystem with ordered data mode.
[   43.894970] NET: Registered protocol family 10
[   43.895117] lo: Disabled Privacy Extensions
[   45.335580] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   45.345886] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   45.511545] iTCO_vendor_support: vendor-support=0
[   45.521224] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
[   45.521345] iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled 
by hardware
[   45.521355] iTCO_wdt: No card detected
[   45.809539] 0000:02:05.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 
CSR6 0xff972113)
[   45.809553] eth0: Setting full-duplex based on MII#1 link partner 
capability of 41e1.
[   45.895396] Linux agpgart interface v0.101 (c) Dave Jones
[   46.159436] agpgart: Detected an Intel i845 Chipset.
[   46.163439] agpgart: AGP aperture is 64M @ 0xe8000000
[   46.171919] Real Time Clock Driver v1.12ac
[   46.865081] parport: PnPBIOS parport detected.
[   46.865149] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   46.878482] input: PC Speaker as /class/input/input2
[   46.975046] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   47.289213] intel8x0_measure_ac97_clock: measured 54646 usecs
[   47.289220] intel8x0: clocking to 48000
[   47.305146] input: ImPS/2 Generic Wheel Mouse as /class/input/input3
[   54.442512] eth0: no IPv6 routers present
[   65.749627] ata4.01: qc timeout (cmd 0xa0)
[   65.749644] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[   65.749656] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[   65.749658]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[   72.739179] ata4: port is slow to respond, please be patient (Status 
0xd8)
[   95.720773] ata4: port failed to respond (30 secs, Status 0xd8)
[   95.720785] ata4: soft resetting port
[   95.887933] ATA: abnormal status 0x7F on port 0xE08615DF
[   95.899315] ATA: abnormal status 0x7F on port 0xE08615DF
[   96.060304] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[   96.060311] ata4.01: revalidation failed (errno=-5)
[   96.060321] ata4: failed to recover some devices, retrying in 5 secs
[  101.056818] ata4: soft resetting port
[  101.223969] ATA: abnormal status 0x7F on port 0xE08615DF
[  101.235354] ATA: abnormal status 0x7F on port 0xE08615DF
[  101.560374] ata4.01: configured for MWDMA2
[  101.560425] ata4: EH complete
[  131.535236] ata4.01: qc timeout (cmd 0xa0)
[  131.535253] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  131.535265] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  131.535268]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  138.524781] ata4: port is slow to respond, please be patient (Status 
0xd8)
[  161.506376] ata4: port failed to respond (30 secs, Status 0xd8)
[  161.506387] ata4: soft resetting port
[  161.673536] ATA: abnormal status 0x7F on port 0xE08615DF
[  161.684917] ATA: abnormal status 0x7F on port 0xE08615DF
[  161.845906] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  161.845913] ata4.01: revalidation failed (errno=-5)
[  161.845923] ata4: failed to recover some devices, retrying in 5 secs
[  166.842421] ata4: soft resetting port
[  167.009572] ATA: abnormal status 0x7F on port 0xE08615DF
[  167.020954] ATA: abnormal status 0x7F on port 0xE08615DF
[  167.345977] ata4.01: configured for MWDMA2
[  167.346031] ata4: EH complete
[  197.308849] ata4.01: qc timeout (cmd 0xa0)
[  197.308866] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  197.308927] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  197.308929]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  204.298412] ata4: port is slow to respond, please be patient (Status 
0xd8)
[  222.621206] fuse init (API version 7.8)
[  222.668357] lp0: using parport0 (interrupt-driven).
[  222.882014] it87: Found IT8712F chip at 0x290, revision 4
[  222.886999] it87-isa 9191-0290: Detected broken BIOS defaults, 
disabling PWM interface
[  222.959348] Adding 1044184k swap on 
/dev/disk/by-uuid/5c6a2d8c-54c1-44cb-8f1b-4a159373a120.  Priority:-1 
extents:1 across:1044184k
[  223.209655] EXT3 FS on sda7, internal journal
[  226.626339] kjournald starting.  Commit interval 5 seconds
[  226.626500] EXT3 FS on sda1, internal journal
[  226.626507] EXT3-fs: mounted filesystem with ordered data mode.
[  226.652213] kjournald starting.  Commit interval 5 seconds
[  226.652396] EXT3 FS on sda3, internal journal
[  226.652403] EXT3-fs: mounted filesystem with ordered data mode.
[  226.699841] kjournald starting.  Commit interval 5 seconds
[  226.700075] EXT3 FS on sdb5, internal journal
[  226.700083] EXT3-fs: mounted filesystem with ordered data mode.
[  226.742721] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  226.807748] NTFS volume version 3.1.
[  226.907585] kjournald starting.  Commit interval 5 seconds
[  226.907810] EXT3 FS on sdb6, internal journal
[  226.907818] EXT3-fs: mounted filesystem with ordered data mode.
[  226.924917] kjournald starting.  Commit interval 5 seconds
[  226.925073] EXT3 FS on sda5, internal journal
[  226.925080] EXT3-fs: mounted filesystem with ordered data mode.
[  226.955687] kjournald starting.  Commit interval 5 seconds
[  226.955847] EXT3 FS on sda2, internal journal
[  226.955854] EXT3-fs: mounted filesystem with ordered data mode.
[  227.280029] ata4: port failed to respond (30 secs, Status 0xd8)
[  227.280106] ata4: soft resetting port
[  227.447161] ATA: abnormal status 0x7F on port 0xE08615DF
[  227.458549] ATA: abnormal status 0x7F on port 0xE08615DF
[  227.619595] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  227.619602] ata4.01: revalidation failed (errno=-5)
[  227.619676] ata4: failed to recover some devices, retrying in 5 secs
[  228.961532] NET: Registered protocol family 17
[  232.616042] ata4: soft resetting port
[  232.783248] ATA: abnormal status 0x7F on port 0xE08615DF
[  232.794665] ATA: abnormal status 0x7F on port 0xE08615DF
[  233.119644] ata4.01: configured for MWDMA2
[  233.119696] ata4: EH complete
[  240.102736] ppdev: user-space parallel port driver
[  242.695559] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[  246.376081] [drm] Initialized drm 1.1.0 20060810
[  246.436220] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  247.097487] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  247.097713] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  247.097907] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  247.397555] [drm] Setting GART location based on new memory map
[  247.397628] [drm] writeback test succeeded in 1 usecs
[  273.918469] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  273.918499] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  273.918519] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

