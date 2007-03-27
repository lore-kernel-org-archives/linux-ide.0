From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Tue, 27 Mar 2007 01:00:24 -0300
Message-ID: <460896D8.8040203@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000408040105040707030000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:31981 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848AbXC0EAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 00:00:47 -0400
Received: by an-out-0708.google.com with SMTP id b33so2591092ana
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 21:00:46 -0700 (PDT)
In-Reply-To: <460883FB.1030000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408040105040707030000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


> Can you try with kernel parameter 'acpi=noirq' or 'irqpoll'?
I made a typo when passing the irqpoll parameter to the kernel. In 
kernel 2.6.20.4 with the irqpoll parameter passewd to kernel the SATA 
disk works:

[    1.320000] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[    1.320000] ahci 0000:00:12.0: version 2.0
[    1.320000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, 
low) -> IRQ 16
[    2.324000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
0xf impl SATA mode
[    2.324000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp 
pio slum part
[    2.324000] ata1: SATA max UDMA/133 cmd 0xF8824D00 ctl 0x0 bmdma 0x0 
irq 222
[    2.324000] ata2: SATA max UDMA/133 cmd 0xF8824D80 ctl 0x0 bmdma 0x0 
irq 222
[    2.324000] ata3: SATA max UDMA/133 cmd 0xF8824E00 ctl 0x0 bmdma 0x0 
irq 222
[    2.324000] ata4: SATA max UDMA/133 cmd 0xF8824E80 ctl 0x0 bmdma 0x0 
irq 222
[    2.324000] scsi0 : ahci
[    2.636000] ata1: SATA link down (SStatus 0 SControl 300)
[    2.636000] scsi1 : ahci
[    3.120000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.136000] ata2.00: ATA-7, max UDMA/133, 160836480 sectors: LBA48 
NCQ (depth 31/32)
[    3.136000] ata2.00: ata2: dev 0 multi count 16
[    3.144000] ata2.00: configured for UDMA/133
[    3.144000] scsi2 : ahci
[    3.456000] ata3: SATA link down (SStatus 0 SControl 300)
[    3.456000] scsi3 : ahci
[    3.768000] ata4: SATA link down (SStatus 0 SControl 300)
[    3.768000] scsi 1:0:0:0: Direct-Access     ATA      HDS728080PLA380  
PF2O PQ: 0 ANSI: 5
[    3.768000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 
0x60,0x64 irq 1,12
[    3.768000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.768000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.768000] mice: PS/2 mouse device common for all mice
[    3.768000] EISA: Probing bus 0 at eisa.0
[    3.768000] EISA: Detected 0 cards.
[    3.792000] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.800000] TCP cubic registered
[    3.800000] NET: Registered protocol family 1
[    3.800000] Starting balanced_irq
[    3.800000] Using IPI No-Shortcut mode
[    3.800000] ACPI: (supports S0 S1 S3 S4 S5)
[    3.800000] Freeing unused kernel memory: 316k freed
[    3.804000] Time: hpet clocksource has been installed.
[    3.876000] ACPI: duty_cycle spans bit 4
[    4.268000] SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
[    4.268000] sda: Write Protect is off
[    4.268000] sda: Mode Sense: 00 3a 00 00
[    4.268000] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    4.268000] SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
[    4.268000] sda: Write Protect is off
[    4.268000] sda: Mode Sense: 00 3a 00 00
[    4.268000] SCSI device sda: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    4.268000]  sda: sda1
[    4.292000] sd 1:0:0:0: Attached scsi disk sda

And the disk (lshw):

       *-storage
             description: SATA controller
             product: SB600 Non-Raid-5 SATA
             vendor: ATI Technologies Inc
             physical id: 12
             bus info: pci@00:12.0
             logical name: scsi1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: storage ahci_1.0 bus_master cap_list emulated
             configuration: driver=ahci
             resources: ioport:e800-e807 ioport:e400-e403 
ioport:e000-e007 ioport:dc00-dc03 ioport:d800-d80f 
iomemory:febffc00-febfffff irq:222
           *-disk
                description: SCSI Disk
                product: HDS728080PLA380
                vendor: ATA
                physical id: 0.0.0
                bus info: scsi@1:0.0.0
                logical name: /dev/sda
                version: PF2O
                serial: PFDH37SYTWKR9E
                size: 76GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5

Nice isn't it? I'm happy.

In the 2.6.21-rc5 version this hasn't worked (the typo was here too, 
copy, paste & destroy :P). Here's is the output of dmesg:

[    1.336000] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[    1.340000] ahci 0000:00:12.0: version 2.1
[    1.340000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, 
low) -> IRQ 16
[    2.344000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
0xf impl SATA mode
[    2.344000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp 
pio slum part
[    2.344000] ata1: SATA max UDMA/133 cmd 0xf8824d00 ctl 0x00000000 
bmdma 0x00000000 irq 222
[    2.344000] ata2: SATA max UDMA/133 cmd 0xf8824d80 ctl 0x00000000 
bmdma 0x00000000 irq 222
[    2.344000] ata3: SATA max UDMA/133 cmd 0xf8824e00 ctl 0x00000000 
bmdma 0x00000000 irq 222
[    2.344000] ata4: SATA max UDMA/133 cmd 0xf8824e80 ctl 0x00000000 
bmdma 0x00000000 irq 222
[    2.344000] scsi0 : ahci
[    2.656000] ata1: SATA link down (SStatus 0 SControl 300)
[    2.656000] scsi1 : ahci
[    3.140000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.140000] ata2.00: qc timeout (cmd 0xec)
[   33.140000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   34.120000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   64.120000] ata2.00: qc timeout (cmd 0xec)
[   64.120000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   64.120000] ata2.00: limiting speed to UDMA7:PIO5
[   65.100000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   95.100000] ata2.00: qc timeout (cmd 0xec)
[   95.100000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   96.080000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   96.080000] scsi2 : ahci
[   96.392000] ata3: SATA link down (SStatus 0 SControl 300)
[   96.392000] scsi3 : ahci
[   96.704000] ata4: SATA link down (SStatus 0 SControl 300)
[   96.704000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 
0x60,0x64 irq 1,12
[   96.704000] serio: i8042 KBD port at 0x60,0x64 irq 1
[   96.704000] serio: i8042 AUX port at 0x60,0x64 irq 12
[   96.704000] mice: PS/2 mouse device common for all mice
[   96.704000] EISA: Probing bus 0 at eisa.0
[   96.704000] EISA: Detected 0 cards.
[   96.704000] TCP cubic registered
[   96.704000] NET: Registered protocol family 1
[   96.704000] Starting balanced_irq
[   96.704000] Using IPI No-Shortcut mode
[   96.708000] Freeing unused kernel memory: 332k freed
[   96.724000] input: AT Translated Set 2 keyboard as /class/input/input0
[   96.780000] ACPI: duty_cycle spans bit 4
[   97.236000] SB600_PATA: IDE controller at PCI slot 0000:00:14.1
[   97.240000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, 
low) -> IRQ 17
[   97.240000] SB600_PATA: chipset revision 0
[   97.240000] SB600_PATA: not 100% native mode: will probe irqs later
[   97.240000]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: 
hda:DMA, hdb:DMA
[   97.240000] Probing IDE interface ide0...
[   97.528000] hda: HDS728080PLAT20, ATA DISK drive
[   97.976000] hdb: ASUS DRW-1608P3S, ATAPI CD/DVD-ROM drive
[   98.032000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   98.052000] hda: max request size: 512KiB
[   98.056000] hda: 160836480 sectors (82348 MB) w/1719KiB Cache, 
CHS=16383/255/63, UDMA(100)
[   98.056000] hda: cache flushes supported
[   98.056000]  hda: hda1 hda2 < hda5 hda6 >
[   98.108000] hdb: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB 
Cache, UDMA(66)
[   98.108000] Uniform CD-ROM driver Revision: 3.20
[   98.356000] Probing IDE interface ide1...


Why this happens? Any clue?

I attached those files too so you can take a better look at them. Thanks!

Matías

--------------000408040105040707030000
Content-Type: text/plain;
 name="dmesg.2.6.20.4.irqpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2.6.20.4.irqpoll"

[    0.000000] Linux version 2.6.20.4 (root@matias) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #1 SMP Sat Mar 24 13:19:32 ART 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000003fec0000 end: 000000003ffc0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000003ffc0000 size: 000000000000e000 end: 000000003ffce000 type: 3
[    0.000000] copy_e820_map() start: 000000003ffce000 size: 0000000000032000 end: 0000000040000000 type: 4
[    0.000000] copy_e820_map() start: 00000000ff780000 size: 0000000000880000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003ffce000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffce000 - 0000000040000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000ff780
[    0.000000] Entering add_active_range(0, 0, 262080) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   262080
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262080
[    0.000000] On node 0 totalpages: 262080
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 255 pages used for memmap
[    0.000000]   HighMem zone: 32449 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f84e0
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x07000604 MSFT 0x00000097) @ 0x3ffc0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x07000604 MSFT 0x00000097) @ 0x3ffc0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x07000604 MSFT 0x00000097) @ 0x3ffc0390
[    0.000000] ACPI: MCFG (v001 A M I  OEMMCFG  0x07000604 MSFT 0x00000097) @ 0x3ffc03f0
[    0.000000] ACPI: WDRT (v001 A M I  OEMWDRT  0x07000604 MSFT 0x00000097) @ 0x3ffc0430
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x07000604 MSFT 0x00000097) @ 0x3ffce040
[    0.000000] ACPI: HPET (v001 A M I  OEMHPET  0x07000604 MSFT 0x00000097) @ 0x3ffc4250
[    0.000000] ACPI: SSDT (v001 A M I  ACPI2PPC 0x00000001 AMI  0x00000001) @ 0x3ffc4290
[    0.000000] ACPI: DSDT (v001  AMMR_ AMMR_B36 0x00000b36 INTL 0x20051117) @ 0x00000000
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8000 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
[    0.000000] Detected 2000.179 MHz processor.
[   22.317443] Built 1 zonelists.  Total pages: 260033
[   22.317446] Kernel command line: root=/dev/hda5 ro irqpoll
[   22.317459] Misrouted IRQ fixup and polling support enabled
[   22.317461] This may significantly impact system performance
[   22.317571] mapped APIC to ffffd000 (fee00000)
[   22.317574] mapped IOAPIC to ffffc000 (fec00000)
[   22.317576] Enabling fast FPU save and restore... done.
[   22.317579] Enabling unmasked SIMD FPU exception support... done.
[   22.317586] Initializing CPU#0
[   22.317638] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   22.319942] Console: colour VGA+ 80x25
[   22.323228] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   22.324041] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   22.344370] Memory: 1029668k/1048320k available (2078k kernel code, 17936k reserved, 958k data, 316k init, 130816k highmem)
[   22.344452] virtual kernel memory layout:
[   22.344453]     fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
[   22.344454]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   22.344456]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   22.344457]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   22.344458]       .init : 0xc03fe000 - 0xc044d000   ( 316 kB)
[   22.344459]       .data : 0xc0307bb4 - 0xc03f76f4   ( 958 kB)
[   22.344460]       .text : 0xc0100000 - 0xc0307bb4   (2078 kB)
[   22.344905] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   22.345149] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[   22.345408] hpet0: 4 32-bit timers, 14318180 Hz
[   22.346467] Using HPET for base-timer
[   22.425010] Calibrating delay using timer specific routine.. 4009.85 BogoMIPS (lpj=8019714)
[   22.425158] Security Framework v1.0.0 initialized
[   22.425219] SELinux:  Disabled at boot.
[   22.425285] Mount-cache hash table entries: 512
[   22.425462] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   22.425470] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   22.425529] CPU: L2 Cache: 256K (64 bytes/line)
[   22.425586] CPU 0(2) -> Core 0
[   22.425640] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   22.425649] Compat vDSO mapped to ffffe000.
[   22.425712] Checking 'hlt' instruction... OK.
[   22.441159] SMP alternatives: switching to UP code
[   22.441408] ACPI: Core revision 20060707
[   22.444005] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[   22.444165] SMP alternatives: switching to SMP code
[   22.444338] Booting processor 1/1 eip 3000
[   22.454283] Initializing CPU#1
[   22.532516] Calibrating delay using timer specific routine.. 4000.22 BogoMIPS (lpj=8000442)
[   22.532523] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   22.532529] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   22.532531] CPU: L2 Cache: 256K (64 bytes/line)
[   22.532533] CPU 1(2) -> Core 1
[   22.532534] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   22.532881] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[   22.533317] Total of 2 processors activated (8010.07 BogoMIPS).
[   22.533516] ENABLING IO-APIC IRQs
[   22.533737] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   22.680517] checking TSC synchronization across 2 CPUs: 
[    0.000051] CPU#0 had 136 usecs TSC skew, fixed it up.
[    0.000107] CPU#1 had -136 usecs TSC skew, fixed it up.
[    0.003947] Brought up 2 CPUs
[    0.044808] migration_cost=140
[    0.045232] NET: Registered protocol family 16
[    0.045366] EISA bus registered
[    0.045422] ACPI: bus type pci registered
[    0.045485] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.045543] PCI: Not using MMCONFIG.
[    0.046366] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=2
[    0.046424] PCI: Using configuration type 1
[    0.046480] Setting up standard PCI resources
[    0.087854] ACPI: Interpreter enabled
[    0.087914] ACPI: Using IOAPIC for interrupt routing
[    0.088279] Error attaching device data
[    0.088338] Error attaching device data
[    0.088505] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.088563] PCI: Probing PCI hardware (bus 00)
[    0.090772] 0000:00:14.1: trying to change BAR0 from 0000 to 01F0
[    0.090832] 0000:00:14.1: trying to change BAR1 from 0000 to 03F4
[    0.090891] 0000:00:14.1: trying to change BAR2 from 0000 to 0170
[    0.090951] 0000:00:14.1: trying to change BAR3 from 0000 to 0374
[    0.091286] Boot video device is 0000:01:00.0
[    0.091482] PCI: Transparent bridge - 0000:00:14.4
[    0.091565] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.114083] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.116956] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE2._PRT]
[    0.118242] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.119028] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.119818] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.120598] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.121380] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.122161] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0, disabled.
[    0.122609] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.123390] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.124123] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.124188] pnp: PnP ACPI init
[    0.128327] pnp: PnP ACPI: found 17 devices
[    0.128388] PnPBIOS: Disabled by ACPI PNP
[    0.128575] SCSI subsystem initialized
[    0.128663] libata version 2.00 loaded.
[    0.128693] PCI: Using ACPI for IRQ routing
[    0.128750] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.137872] NET: Registered protocol family 8
[    0.137928] NET: Registered protocol family 20
[    0.138863] pnp: 00:0e: ioport range 0xa00-0xa0f has been reserved
[    0.138922] pnp: 00:0e: ioport range 0x600-0x60f has been reserved
[    0.139192] PCI: Bridge: 0000:00:02.0
[    0.139247]   IO window: disabled.
[    0.139304]   MEM window: fa900000-fe9fffff
[    0.139361]   PREFETCH window: bff00000-dfefffff
[    0.139419] PCI: Bridge: 0000:00:14.4
[    0.139475]   IO window: b000-bfff
[    0.139533]   MEM window: fea00000-feafffff
[    0.139591]   PREFETCH window: 50000000-500fffff
[    0.139661] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.139714] NET: Registered protocol family 2
[    0.175689] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.175896] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.177008] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.177578] TCP: Hash tables configured (established 131072 bind 65536)
[    0.177639] TCP reno registered
[    0.187722] checking if image is initramfs... it is
[    0.602396] Freeing initrd memory: 5076k freed
[    0.840000] audit: initializing netlink socket (disabled)
[    0.840000] audit(1174956175.024:1): initialized
[    0.840000] highmem bounce pool size: 64 pages
[    0.840000] VFS: Disk quotas dquot_6.5.1
[    0.840000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.840000] io scheduler noop registered
[    0.840000] io scheduler anticipatory registered
[    0.840000] io scheduler deadline registered
[    0.840000] io scheduler cfq registered (default)
[    0.940000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.940000] assign_interrupt_mode Found MSI capability
[    0.940000] Allocate Port Service[0000:00:02.0:pcie00]
[    0.940000] isapnp: Scanning for PnP cards...
[    1.292000] isapnp: No Plug & Play device found
[    1.320000] Real Time Clock Driver v1.12ac
[    1.320000] hpet_resources: 0xfed00000 is busy
[    1.320000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.320000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.320000] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.320000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.320000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.320000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    1.320000] ahci 0000:00:12.0: version 2.0
[    1.320000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 16
[    2.324000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    2.324000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp pio slum part 
[    2.324000] ata1: SATA max UDMA/133 cmd 0xF8824D00 ctl 0x0 bmdma 0x0 irq 222
[    2.324000] ata2: SATA max UDMA/133 cmd 0xF8824D80 ctl 0x0 bmdma 0x0 irq 222
[    2.324000] ata3: SATA max UDMA/133 cmd 0xF8824E00 ctl 0x0 bmdma 0x0 irq 222
[    2.324000] ata4: SATA max UDMA/133 cmd 0xF8824E80 ctl 0x0 bmdma 0x0 irq 222
[    2.324000] scsi0 : ahci
[    2.636000] ata1: SATA link down (SStatus 0 SControl 300)
[    2.636000] scsi1 : ahci
[    3.120000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.136000] ata2.00: ATA-7, max UDMA/133, 160836480 sectors: LBA48 NCQ (depth 31/32)
[    3.136000] ata2.00: ata2: dev 0 multi count 16
[    3.144000] ata2.00: configured for UDMA/133
[    3.144000] scsi2 : ahci
[    3.456000] ata3: SATA link down (SStatus 0 SControl 300)
[    3.456000] scsi3 : ahci
[    3.768000] ata4: SATA link down (SStatus 0 SControl 300)
[    3.768000] scsi 1:0:0:0: Direct-Access     ATA      HDS728080PLA380  PF2O PQ: 0 ANSI: 5
[    3.768000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    3.768000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.768000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.768000] mice: PS/2 mouse device common for all mice
[    3.768000] EISA: Probing bus 0 at eisa.0
[    3.768000] EISA: Detected 0 cards.
[    3.792000] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.800000] TCP cubic registered
[    3.800000] NET: Registered protocol family 1
[    3.800000] Starting balanced_irq
[    3.800000] Using IPI No-Shortcut mode
[    3.800000] ACPI: (supports S0 S1 S3 S4 S5)
[    3.800000] Freeing unused kernel memory: 316k freed
[    3.804000] Time: hpet clocksource has been installed.
[    3.876000] ACPI: duty_cycle spans bit 4
[    4.268000] SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
[    4.268000] sda: Write Protect is off
[    4.268000] sda: Mode Sense: 00 3a 00 00
[    4.268000] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.268000] SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
[    4.268000] sda: Write Protect is off
[    4.268000] sda: Mode Sense: 00 3a 00 00
[    4.268000] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.268000]  sda: sda1
[    4.292000] sd 1:0:0:0: Attached scsi disk sda
[    4.516000] SB600_PATA: IDE controller at PCI slot 0000:00:14.1
[    4.516000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 17
[    4.516000] SB600_PATA: chipset revision 0
[    4.520000] SB600_PATA: not 100% native mode: will probe irqs later
[    4.520000]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
[    4.520000] Probing IDE interface ide0...
[    4.808000] hda: HDS728080PLAT20, ATA DISK drive
[    5.256000] hdb: ASUS DRW-1608P3S, ATAPI CD/DVD-ROM drive
[    5.312000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.316000] hda: max request size: 512KiB
[    5.328000] hda: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63, UDMA(33)
[    5.328000] hda: cache flushes supported
[    5.328000]  hda: hda1 hda2 < hda5 hda6 >
[    5.388000] hdb: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB Cache, UDMA(66)
[    5.392000] Uniform CD-ROM driver Revision: 3.20
[    5.692000] Probing IDE interface ide1...
[    5.724000] usbcore: registered new interface driver usbfs
[    5.724000] usbcore: registered new interface driver hub
[    5.724000] usbcore: registered new device driver usb
[    5.724000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[    5.724000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 17
[    5.724000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    5.724000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[    5.724000] ohci_hcd 0000:00:13.0: irq 17, io mem 0xfebfe000
[    5.784000] usb usb1: configuration #1 chosen from 1 choice
[    5.784000] hub 1-0:1.0: USB hub found
[    5.784000] hub 1-0:1.0: 2 ports detected
[    5.888000] ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 18
[    5.888000] ehci_hcd 0000:00:13.5: EHCI Host Controller
[    5.888000] ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 2
[    5.888000] ehci_hcd 0000:00:13.5: debug port 1
[    5.888000] ehci_hcd 0000:00:13.5: irq 18, io mem 0xfebff800
[    5.888000] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    5.888000] usb usb2: configuration #1 chosen from 1 choice
[    5.888000] hub 2-0:1.0: USB hub found
[    5.888000] hub 2-0:1.0: 10 ports detected
[    5.992000] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 19
[    5.992000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    5.992000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
[    5.992000] ohci_hcd 0000:00:13.1: irq 19, io mem 0xfebfd000
[    6.052000] usb usb3: configuration #1 chosen from 1 choice
[    6.052000] hub 3-0:1.0: USB hub found
[    6.052000] hub 3-0:1.0: 2 ports detected
[    6.156000] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 20
[    6.156000] ohci_hcd 0000:00:13.2: OHCI Host Controller
[    6.156000] ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
[    6.156000] ohci_hcd 0000:00:13.2: irq 20, io mem 0xfebfc000
[    6.216000] usb usb4: configuration #1 chosen from 1 choice
[    6.216000] hub 4-0:1.0: USB hub found
[    6.216000] hub 4-0:1.0: 2 ports detected
[    6.320000] ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 19
[    6.320000] ohci_hcd 0000:00:13.3: OHCI Host Controller
[    6.320000] ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
[    6.320000] ohci_hcd 0000:00:13.3: irq 19, io mem 0xfebfb000
[    6.380000] usb usb5: configuration #1 chosen from 1 choice
[    6.380000] hub 5-0:1.0: USB hub found
[    6.380000] hub 5-0:1.0: 2 ports detected
[    6.484000] ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 20
[    6.484000] ohci_hcd 0000:00:13.4: OHCI Host Controller
[    6.484000] ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
[    6.484000] ohci_hcd 0000:00:13.4: irq 20, io mem 0xfebfa000
[    6.544000] usb usb6: configuration #1 chosen from 1 choice
[    6.544000] hub 6-0:1.0: USB hub found
[    6.544000] hub 6-0:1.0: 2 ports detected
[    6.716000] Attempting manual resume
[    6.736000] kjournald starting.  Commit interval 5 seconds
[    6.736000] EXT3-fs: mounted filesystem with ordered data mode.
[   16.968000] Floppy drive(s): fd0 is 1.44M
[   16.984000] FDC 0 is a post-1991 82077
[   17.328000] input: PC Speaker as /class/input/input1
[   17.884000] Linux agpgart interface v0.101 (c) Dave Jones
[   17.900000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   17.904000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   17.952000] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   17.988000] r8169 Gigabit Ethernet driver 2.2LK loaded
[   17.988000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 21 (level, low) -> IRQ 21
[   17.988000] eth0: RTL8169sc/8110sc at 0xf8896800, 00:16:17:c3:b8:f9, IRQ 21
[   18.036000] parport: PnPBIOS parport detected.
[   18.036000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   18.112000] r8169: eth0: link down
[   18.236000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 17
[   18.436000] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[   18.656000] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
[   18.728000] lp0: using parport0 (interrupt-driven).
[   18.856000] Adding 1052216k swap on /dev/disk/by-uuid/ba363ce4-0f51-4ff4-abdb-c02e7467cc43.  Priority:-1 extents:1 across:1052216k
[   18.980000] EXT3 FS on hda5, internal journal
[   19.200000] NET: Registered protocol family 17
[   19.380000] NTFS driver 2.1.28 [Flags: R/O MODULE].
[   19.576000] r8169: eth0: link up
[   19.728000] NTFS volume version 3.1.
[   22.372000] input: Power Button (FF) as /class/input/input3
[   22.372000] ACPI: Power Button (FF) [PWRF]
[   22.376000] input: Power Button (CM) as /class/input/input4
[   22.376000] ACPI: Power Button (CM) [PWRB]
[   22.404000] Using specific hotkey driver
[   22.468000] No dock devices found.
[   22.508000] ibm_acpi: ec object not found
[   22.576000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   22.888000] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ processors (version 2.00.00)
[   22.888000] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xe
[   22.888000] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x10
[   22.888000] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[   26.448000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   26.448000] apm: disabled - APM is not SMP safe.
[   27.332000] NET: Registered protocol family 10
[   27.332000] lo: Disabled Privacy Extensions
[   32.412000] hda-intel: Invalid position buffer, using LPIB read method instead.
[   32.872000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   33.008000] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   33.012000] NFSD: starting 90-second grace period
[   37.488000] eth0: no IPv6 routers present

--------------000408040105040707030000
Content-Type: text/plain;
 name="dmesg.2.6.21-rc5.irqpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2.6.21-rc5.irqpoll"

[    0.000000] Linux version 2.6.21-rc5 (root@matias) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #1 SMP Sun Mar 25 23:25:22 ART 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000003fec0000 end: 000000003ffc0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000003ffc0000 size: 000000000000e000 end: 000000003ffce000 type: 3
[    0.000000] copy_e820_map() start: 000000003ffce000 size: 0000000000032000 end: 0000000040000000 type: 4
[    0.000000] copy_e820_map() start: 00000000ff780000 size: 0000000000880000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003ffce000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffce000 - 0000000040000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000ff780
[    0.000000] Entering add_active_range(0, 0, 262080) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   262080
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262080
[    0.000000] On node 0 totalpages: 262080
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 255 pages used for memmap
[    0.000000]   HighMem zone: 32449 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F84E0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT 3FFC0000, 0040 (r1 A M I  OEMRSDT   7000604 MSFT       97)
[    0.000000] ACPI: FACP 3FFC0200, 0084 (r2 A M I  OEMFACP   7000604 MSFT       97)
[    0.000000] ACPI: DSDT 3FFC0480, 3DC9 (r1  AMMR_ AMMR_B36      B36 INTL 20051117)
[    0.000000] ACPI: FACS 3FFCE000, 0040
[    0.000000] ACPI: APIC 3FFC0390, 005C (r1 A M I  OEMAPIC   7000604 MSFT       97)
[    0.000000] ACPI: MCFG 3FFC03F0, 003C (r1 A M I  OEMMCFG   7000604 MSFT       97)
[    0.000000] ACPI: WDRT 3FFC0430, 0047 (r1 A M I  OEMWDRT   7000604 MSFT       97)
[    0.000000] ACPI: OEMB 3FFCE040, 0060 (r1 A M I  AMI_OEM   7000604 MSFT       97)
[    0.000000] ACPI: HPET 3FFC4250, 0038 (r1 A M I  OEMHPET   7000604 MSFT       97)
[    0.000000] ACPI: SSDT 3FFC4290, 01C4 (r1 A M I  ACPI2PPC        1 AMI         1)
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8000 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
[    0.000000] Built 1 zonelists.  Total pages: 260033
[    0.000000] Kernel command line: root=/dev/hda5 ro irqpoll
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 2000.238 MHz processor.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1029748k/1048320k available (2099k kernel code, 17928k reserved, 970k data, 332k init, 130816k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000000]       .init : 0xc0406000 - 0xc0459000   ( 332 kB)
[    0.000000]       .data : 0xc030cc9c - 0xc03ff754   ( 970 kB)
[    0.000000]       .text : 0xc0100000 - 0xc030cc9c   (2099 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.000000] hpet0: 4 32-bit timers, 14318180 Hz
[    0.084000] Calibrating delay using timer specific routine.. 4009.58 BogoMIPS (lpj=8019165)
[    0.084000] Security Framework v1.0.0 initialized
[    0.084000] SELinux:  Disabled at boot.
[    0.084000] Mount-cache hash table entries: 512
[    0.084000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.084000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.084000] CPU: L2 Cache: 256K (64 bytes/line)
[    0.084000] CPU 0(2) -> Core 0
[    0.084000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.084000] Compat vDSO mapped to ffffe000.
[    0.084000] Checking 'hlt' instruction... OK.
[    0.100000] SMP alternatives: switching to UP code
[    0.100000] ACPI: Core revision 20070126
[    0.100000] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[    0.100000] SMP alternatives: switching to SMP code
[    0.100000] Booting processor 1/1 eip 3000
[    0.112000] Initializing CPU#1
[    0.192000] Calibrating delay using timer specific routine.. 4000.15 BogoMIPS (lpj=8000314)
[    0.192000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.192000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.192000] CPU: L2 Cache: 256K (64 bytes/line)
[    0.192000] CPU 1(2) -> Core 1
[    0.192000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.192000] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[    0.192000] Total of 2 processors activated (8009.73 BogoMIPS).
[    0.192000] ENABLING IO-APIC IRQs
[    0.192000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.232000] Brought up 2 CPUs
[    0.272000] migration_cost=4000
[    0.272000] NET: Registered protocol family 16
[    0.272000] EISA bus registered
[    0.272000] ACPI: bus type pci registered
[    0.272000] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.272000] PCI: Not using MMCONFIG.
[    0.272000] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=2
[    0.272000] PCI: Using configuration type 1
[    0.272000] Setting up standard PCI resources
[    0.316000] ACPI: Interpreter enabled
[    0.316000] ACPI: (supports S0 S1 S3 S4 S5)
[    0.316000] ACPI: Using IOAPIC for interrupt routing
[    0.316000] Error attaching device data
[    0.316000] Error attaching device data
[    0.324000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.324000] PCI: Probing PCI hardware (bus 00)
[    0.324000] 0000:00:14.1: trying to change BAR0 from 0000 to 01F0
[    0.324000] 0000:00:14.1: trying to change BAR1 from 0000 to 03F4
[    0.324000] 0000:00:14.1: trying to change BAR2 from 0000 to 0170
[    0.324000] 0000:00:14.1: trying to change BAR3 from 0000 to 0374
[    0.324000] Boot video device is 0000:01:00.0
[    0.324000] PCI: Transparent bridge - 0000:00:14.4
[    0.324000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.324000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.324000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE2._PRT]
[    0.340000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.340000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.340000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.340000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.340000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.340000] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0, disabled.
[    0.344000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.344000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.344000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.344000] pnp: PnP ACPI init
[    0.348000] pnp: PnP ACPI: found 17 devices
[    0.348000] PnPBIOS: Disabled by ACPI PNP
[    0.348000] SCSI subsystem initialized
[    0.348000] libata version 2.20 loaded.
[    0.348000] PCI: Using ACPI for IRQ routing
[    0.348000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.356000] NET: Registered protocol family 8
[    0.356000] NET: Registered protocol family 20
[    0.356000] pnp: 00:01: iomem range 0x0-0x0 could not be reserved
[    0.356000] pnp: 00:09: iomem range 0xffb80000-0xffbfffff could not be reserved
[    0.356000] pnp: 00:09: iomem range 0xfed00000-0xfed003ff could not be reserved
[    0.356000] pnp: 00:09: iomem range 0xff6ff000-0xff6ff7ff has been reserved
[    0.356000] pnp: 00:09: iomem range 0xfff80000-0xffffffff could not be reserved
[    0.356000] pnp: 00:0d: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.356000] pnp: 00:0d: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.356000] pnp: 00:0e: ioport range 0xa00-0xa0f has been reserved
[    0.356000] pnp: 00:0e: ioport range 0x600-0x60f has been reserved
[    0.356000] pnp: 00:0f: iomem range 0xe0000000-0xefffffff has been reserved
[    0.356000] pnp: 00:10: iomem range 0x0-0x9ffff could not be reserved
[    0.356000] pnp: 00:10: iomem range 0xc0000-0xcffff could not be reserved
[    0.356000] pnp: 00:10: iomem range 0xe0000-0xfffff could not be reserved
[    0.356000] pnp: 00:10: iomem range 0x100000-0x3fffffff could not be reserved
[    0.360000] Time: hpet clocksource has been installed.
[    0.388000] PCI: Bridge: 0000:00:02.0
[    0.388000]   IO window: disabled.
[    0.388000]   MEM window: fa900000-fe9fffff
[    0.388000]   PREFETCH window: bff00000-dfefffff
[    0.388000] PCI: Bridge: 0000:00:14.4
[    0.388000]   IO window: b000-bfff
[    0.388000]   MEM window: fea00000-feafffff
[    0.388000]   PREFETCH window: 50000000-500fffff
[    0.388000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.388000] NET: Registered protocol family 2
[    0.428000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.428000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.428000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.428000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.432000] TCP reno registered
[    0.444000] checking if image is initramfs... it is
[    0.852000] Freeing initrd memory: 5020k freed
[    0.852000] audit: initializing netlink socket (disabled)
[    0.852000] audit(1174956492.848:1): initialized
[    0.852000] highmem bounce pool size: 64 pages
[    0.852000] VFS: Disk quotas dquot_6.5.1
[    0.852000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.856000] io scheduler noop registered
[    0.856000] io scheduler anticipatory registered
[    0.856000] io scheduler deadline registered
[    0.856000] io scheduler cfq registered (default)
[    0.956000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.956000] assign_interrupt_mode Found MSI capability
[    0.956000] Allocate Port Service[0000:00:02.0:pcie00]
[    0.956000] isapnp: Scanning for PnP cards...
[    1.308000] isapnp: No Plug & Play device found
[    1.336000] Real Time Clock Driver v1.12ac
[    1.336000] hpet_resources: 0xfed00000 is busy
[    1.336000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.336000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.336000] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.336000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.336000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.336000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    1.340000] ahci 0000:00:12.0: version 2.1
[    1.340000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 16
[    2.344000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    2.344000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp pio slum part 
[    2.344000] ata1: SATA max UDMA/133 cmd 0xf8824d00 ctl 0x00000000 bmdma 0x00000000 irq 222
[    2.344000] ata2: SATA max UDMA/133 cmd 0xf8824d80 ctl 0x00000000 bmdma 0x00000000 irq 222
[    2.344000] ata3: SATA max UDMA/133 cmd 0xf8824e00 ctl 0x00000000 bmdma 0x00000000 irq 222
[    2.344000] ata4: SATA max UDMA/133 cmd 0xf8824e80 ctl 0x00000000 bmdma 0x00000000 irq 222
[    2.344000] scsi0 : ahci
[    2.656000] ata1: SATA link down (SStatus 0 SControl 300)
[    2.656000] scsi1 : ahci
[    3.140000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.140000] ata2.00: qc timeout (cmd 0xec)
[   33.140000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   34.120000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   64.120000] ata2.00: qc timeout (cmd 0xec)
[   64.120000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   64.120000] ata2.00: limiting speed to UDMA7:PIO5
[   65.100000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   95.100000] ata2.00: qc timeout (cmd 0xec)
[   95.100000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   96.080000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   96.080000] scsi2 : ahci
[   96.392000] ata3: SATA link down (SStatus 0 SControl 300)
[   96.392000] scsi3 : ahci
[   96.704000] ata4: SATA link down (SStatus 0 SControl 300)
[   96.704000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   96.704000] serio: i8042 KBD port at 0x60,0x64 irq 1
[   96.704000] serio: i8042 AUX port at 0x60,0x64 irq 12
[   96.704000] mice: PS/2 mouse device common for all mice
[   96.704000] EISA: Probing bus 0 at eisa.0
[   96.704000] EISA: Detected 0 cards.
[   96.704000] TCP cubic registered
[   96.704000] NET: Registered protocol family 1
[   96.704000] Starting balanced_irq
[   96.704000] Using IPI No-Shortcut mode
[   96.708000] Freeing unused kernel memory: 332k freed
[   96.724000] input: AT Translated Set 2 keyboard as /class/input/input0
[   96.780000] ACPI: duty_cycle spans bit 4
[   97.236000] SB600_PATA: IDE controller at PCI slot 0000:00:14.1
[   97.240000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 17
[   97.240000] SB600_PATA: chipset revision 0
[   97.240000] SB600_PATA: not 100% native mode: will probe irqs later
[   97.240000]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
[   97.240000] Probing IDE interface ide0...
[   97.528000] hda: HDS728080PLAT20, ATA DISK drive
[   97.976000] hdb: ASUS DRW-1608P3S, ATAPI CD/DVD-ROM drive
[   98.032000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   98.052000] hda: max request size: 512KiB
[   98.056000] hda: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63, UDMA(100)
[   98.056000] hda: cache flushes supported
[   98.056000]  hda: hda1 hda2 < hda5 hda6 >
[   98.108000] hdb: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB Cache, UDMA(66)
[   98.108000] Uniform CD-ROM driver Revision: 3.20
[   98.356000] Probing IDE interface ide1...
[   98.368000] usbcore: registered new interface driver usbfs
[   98.368000] usbcore: registered new interface driver hub
[   98.368000] usbcore: registered new device driver usb
[   98.368000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   98.368000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 17
[   98.372000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   98.372000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[   98.372000] ohci_hcd 0000:00:13.0: irq 17, io mem 0xfebfe000
[   98.432000] usb usb1: configuration #1 chosen from 1 choice
[   98.432000] hub 1-0:1.0: USB hub found
[   98.432000] hub 1-0:1.0: 2 ports detected
[   98.536000] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 18
[   98.536000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   98.536000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
[   98.536000] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfebfd000
[   98.596000] usb usb2: configuration #1 chosen from 1 choice
[   98.596000] hub 2-0:1.0: USB hub found
[   98.596000] hub 2-0:1.0: 2 ports detected
[   98.700000] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 19
[   98.700000] ohci_hcd 0000:00:13.2: OHCI Host Controller
[   98.700000] ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
[   98.700000] ohci_hcd 0000:00:13.2: irq 19, io mem 0xfebfc000
[   98.760000] usb usb3: configuration #1 chosen from 1 choice
[   98.760000] hub 3-0:1.0: USB hub found
[   98.760000] hub 3-0:1.0: 2 ports detected
[   98.864000] ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 18
[   98.864000] ohci_hcd 0000:00:13.3: OHCI Host Controller
[   98.864000] ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
[   98.864000] ohci_hcd 0000:00:13.3: irq 18, io mem 0xfebfb000
[   98.924000] usb usb4: configuration #1 chosen from 1 choice
[   98.924000] hub 4-0:1.0: USB hub found
[   98.924000] hub 4-0:1.0: 2 ports detected
[   99.028000] ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 19
[   99.028000] ohci_hcd 0000:00:13.4: OHCI Host Controller
[   99.028000] ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 5
[   99.028000] ohci_hcd 0000:00:13.4: irq 19, io mem 0xfebfa000
[   99.088000] usb usb5: configuration #1 chosen from 1 choice
[   99.088000] hub 5-0:1.0: USB hub found
[   99.088000] hub 5-0:1.0: 2 ports detected
[   99.192000] ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 20
[   99.192000] ehci_hcd 0000:00:13.5: EHCI Host Controller
[   99.192000] ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 6
[   99.192000] ehci_hcd 0000:00:13.5: debug port 1
[   99.192000] ehci_hcd 0000:00:13.5: irq 20, io mem 0xfebff800
[   99.192000] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   99.192000] usb usb6: configuration #1 chosen from 1 choice
[   99.192000] hub 6-0:1.0: USB hub found
[   99.192000] hub 6-0:1.0: 10 ports detected
[   99.328000] Attempting manual resume
[   99.368000] kjournald starting.  Commit interval 5 seconds
[   99.368000] EXT3-fs: mounted filesystem with ordered data mode.
[  107.608000] input: PC Speaker as /class/input/input1
[  107.716000] Floppy drive(s): fd0 is 1.44M
[  107.772000] FDC 0 is a post-1991 82077
[  107.776000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  107.796000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[  107.856000] Linux agpgart interface v0.102 (c) Dave Jones
[  107.940000] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
[  108.180000] parport: PnPBIOS parport detected.
[  108.180000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[  108.272000] r8169 Gigabit Ethernet driver 2.2LK loaded
[  108.272000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 21 (level, low) -> IRQ 21
[  108.272000] eth0: RTL8169sc/8110sc at 0xf891e800, 00:16:17:c3:b8:f9, IRQ 21
[  108.344000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 17
[  108.404000] r8169: eth0: link down
[  108.544000] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[  108.828000] lp0: using parport0 (interrupt-driven).
[  108.888000] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
[  108.960000] w83627ehf: unsupported chip ID: 0xffff
[  109.020000] Adding 1052216k swap on /dev/disk/by-uuid/ba363ce4-0f51-4ff4-abdb-c02e7467cc43.  Priority:-1 extents:1 across:1052216k
[  109.108000] EXT3 FS on hda5, internal journal
[  109.428000] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  109.492000] NTFS volume version 3.1.
[  109.532000] NET: Registered protocol family 17
[  109.840000] r8169: eth0: link up
[  111.800000] input: Power Button (FF) as /class/input/input3
[  111.800000] ACPI: Power Button (FF) [PWRF]
[  111.800000] input: Power Button (CM) as /class/input/input4
[  111.800000] ACPI: Power Button (CM) [PWRB]
[  111.864000] No dock devices found.
[  111.892000] ibm_acpi: ec object not found
[  111.948000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[  112.192000] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ processors (version 2.00.00)
[  112.192000] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xe
[  112.192000] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x10
[  112.192000] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[  113.036000] NET: Registered protocol family 10
[  113.036000] lo: Disabled Privacy Extensions
[  114.868000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[  114.868000] apm: disabled - APM is not SMP safe.
[  116.824000] tsdev (compaq touchscreen emulation) is scheduled for removal.
[  116.824000] See Documentation/feature-removal-schedule.txt for details.
[  117.616000] hda-intel: Invalid position buffer, using LPIB read method instead.
[  120.228000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  120.344000] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  120.344000] NFSD: starting 90-second grace period
[  123.444000] eth0: no IPv6 routers present
[  124.000000] Clocksource tsc unstable (delta = -249947179 ns)
[  134.036000] ISO 9660 Extensions: RRIP_1991A

--------------000408040105040707030000
Content-Type: text/plain;
 name="lshw.2.6.20.4.irqpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lshw.2.6.20.4.irqpoll"

matias
    description: Desktop Computer
    product: MS-7242
    vendor: MSI
    version: 0A
    serial: To Be Filled By O.E.M.
    width: 32 bits
    capabilities: smbios-2.4 dmi-2.4
    configuration: chassis=desktop uuid=00020003-0004-0005-0006-000700080009
  *-core
       description: Motherboard
       product: MS-7242
       vendor: MSI
       physical id: 0
       version: 0A
       serial: To be filled by O.E.M.
       slot: To Be Filled By O.E.M.
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 080013 (07/04/2006)
          size: 64KB
          capacity: 448KB
          capabilities: isa pci pnp apm upgrade shadowing escd cdboot bootselect socketedrom edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+
          vendor: Advanced Micro Devices [AMD]
          physical id: 4
          bus info: cpu@0
          version: 15.11.2
          serial: To Be Filled By O.E.M.
          slot: CPU 1
          size: 1GHz
          capacity: 2GHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt x86-64 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp tm stc cpufreq
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1-Cache
             size: 128KB
             capacity: 128KB
             capabilities: pipeline-burst internal varies data
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2-Cache
             size: 256KB
             capacity: 512KB
             capabilities: pipeline-burst internal varies unified
        *-cache:2 DISABLED
             description: L3 cache
             physical id: 7
             slot: L3-Cache
             capabilities: internal
     *-memory
          description: System Memory
          physical id: 28
          slot: System board or motherboard
          size: 1GB
        *-bank:0
             description: DIMM Synchronous 266 MHz (3.8 ns)
             product: PartNum0
             vendor: Manufacturer0
             physical id: 0
             serial: SerNum0
             slot: DIMM0
             size: 512MB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:1
             description: DIMM SDRAM [empty]
             product: PartNum1
             vendor: Manufacturer1
             physical id: 1
             serial: SerNum1
             slot: DIMM1
        *-bank:2
             description: DIMM Synchronous 266 MHz (3.8 ns)
             product: PartNum2
             vendor: Manufacturer2
             physical id: 2
             serial: SerNum2
             slot: DIMM2
             size: 512MB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:3
             description: DIMM SDRAM [empty]
             product: PartNum3
             vendor: Manufacturer3
             physical id: 3
             serial: SerNum3
             slot: DIMM3
     *-pci:0
          description: Host bridge
          product: RS480 Host Bridge
          vendor: ATI Technologies Inc
          physical id: 100
          bus info: pci@00:00.0
          version: 10
          width: 32 bits
          clock: 66MHz
        *-pci:0
             description: PCI bridge
             product: RS480 PCI-X Root Port
             vendor: ATI Technologies Inc
             physical id: 2
             bus info: pci@00:02.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
             configuration: driver=pcieport-driver
           *-display
                description: VGA compatible controller
                product: G71 [GeForce 7300 GS]
                vendor: nVidia Corporation
                physical id: 0
                bus info: pci@01:00.0
                version: a1
                size: 256MB
                width: 64 bits
                clock: 33MHz
                capabilities: vga bus_master cap_list
                resources: iomemory:fd000000-fdffffff iomemory:c0000000-cfffffff iomemory:fc000000-fcffffff irq:10
        *-storage
             description: SATA controller
             product: SB600 Non-Raid-5 SATA
             vendor: ATI Technologies Inc
             physical id: 12
             bus info: pci@00:12.0
             logical name: scsi1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: storage ahci_1.0 bus_master cap_list emulated
             configuration: driver=ahci
             resources: ioport:e800-e807 ioport:e400-e403 ioport:e000-e007 ioport:dc00-dc03 ioport:d800-d80f iomemory:febffc00-febfffff irq:222
           *-disk
                description: SCSI Disk
                product: HDS728080PLA380
                vendor: ATA
                physical id: 0.0.0
                bus info: scsi@1:0.0.0
                logical name: /dev/sda
                version: PF2O
                serial: PFDH37SYTWKR9E
                size: 76GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume
                   description: HPFS/NTFS partition
                   physical id: 1
                   bus info: scsi@1:0.0.0,1
                   logical name: /dev/sda1
                   capacity: 19GB
                   capabilities: primary bootable
        *-usb:0
             description: USB Controller
             product: SB600 USB (OHCI0)
             vendor: ATI Technologies Inc
             physical id: 13
             bus info: pci@00:13.0
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci_hcd
             resources: iomemory:febfe000-febfefff irq:17
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.20.4 ohci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:1
             description: USB Controller
             product: SB600 USB (OHCI1)
             vendor: ATI Technologies Inc
             physical id: 13.1
             bus info: pci@00:13.1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci_hcd
             resources: iomemory:febfd000-febfdfff irq:19
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.20.4 ohci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:2
             description: USB Controller
             product: SB600 USB (OHCI2)
             vendor: ATI Technologies Inc
             physical id: 13.2
             bus info: pci@00:13.2
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci_hcd
             resources: iomemory:febfc000-febfcfff irq:20
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.20.4 ohci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:3
             description: USB Controller
             product: SB600 USB (OHCI3)
             vendor: ATI Technologies Inc
             physical id: 13.3
             bus info: pci@00:13.3
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci_hcd
             resources: iomemory:febfb000-febfbfff irq:19
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.20.4 ohci_hcd
                physical id: 1
                bus info: usb@5
                logical name: usb5
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:4
             description: USB Controller
             product: SB600 USB (OHCI4)
             vendor: ATI Technologies Inc
             physical id: 13.4
             bus info: pci@00:13.4
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci_hcd
             resources: iomemory:febfa000-febfafff irq:20
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.20.4 ohci_hcd
                physical id: 1
                bus info: usb@6
                logical name: usb6
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:5
             description: USB Controller
             product: SB600 USB Controller (EHCI)
             vendor: ATI Technologies Inc
             physical id: 13.5
             bus info: pci@00:13.5
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ehci bus_master cap_list
             configuration: driver=ehci_hcd
             resources: iomemory:febff800-febff8ff irq:18
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.20.4 ehci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=hub maxpower=0mA slots=10 speed=480.0MB/s
        *-serial UNCLAIMED
             description: SMBus
             product: SB600 SMBus
             vendor: ATI Technologies Inc
             physical id: 14
             bus info: pci@00:14.0
             version: 13
             width: 32 bits
             clock: 66MHz
             capabilities: cap_list
             resources: ioport:b00-b0f
        *-ide
             description: IDE interface
             product: SB600 IDE
             vendor: ATI Technologies Inc
             physical id: 14.1
             bus info: pci@00:14.1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ide bus_master cap_list
             configuration: driver=ATIIXP_IDE
             resources: ioport:1f0-1f7 ioport:3f4-3f3 ioport:170-177 ioport:374-373 ioport:ff00-ff0f irq:17
           *-ide
                description: IDE Channel 0
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 66MHz
              *-disk
                   description: ATA Disk
                   product: HDS728080PLAT20
                   physical id: 0
                   bus info: ide@0.0
                   logical name: /dev/hda
                   version: PF2OA21B
                   serial: PFD200E1DN2E7B
                   size: 76GB
                   capacity: 76GB
                   capabilities: ata dma lba iordy smart security pm apm partitioned partitioned:dos
                   configuration: apm=off mode=udma2 smart=on
                 *-volume:0
                      description: HPFS/NTFS partition
                      physical id: 1
                      bus info: ide@0.0,1
                      logical name: /dev/hda1
                      capacity: 18GB
                      capabilities: primary bootable
                 *-volume:1
                      description: W95 Ext'd (LBA) partition
                      physical id: 2
                      bus info: ide@0.0,2
                      logical name: /dev/hda2
                      capacity: 58GB
                      capabilities: primary
              *-cdrom
                   description: DVD-RAM writer
                   product: ASUS DRW-1608P3S
                   physical id: 1
                   bus info: ide@0.1
                   logical name: /dev/hdb
                   version: 1.24
                   capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy pm audio cd-r cd-rw dvd dvd-r dvd-ram
                   configuration: mode=udma4
                 *-disc
                      physical id: 0
                      logical name: /dev/hdb
        *-multimedia
             description: Audio device
             product: SB600 Azalia
             vendor: ATI Technologies Inc
             physical id: 14.2
             bus info: pci@00:14.2
             version: 00
             width: 64 bits
             clock: 33MHz
             capabilities: bus_master cap_list
             configuration: driver=HDA Intel
             resources: iomemory:febf4000-febf7fff irq:17
        *-isa UNCLAIMED
             description: ISA bridge
             product: SB600 PCI to LPC Bridge
             vendor: ATI Technologies Inc
             physical id: 14.3
             bus info: pci@00:14.3
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: isa bus_master
        *-pci:1
             description: PCI bridge
             product: SB600 PCI to PCI Bridge
             vendor: ATI Technologies Inc
             physical id: 14.4
             bus info: pci@00:14.4
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: pci subtractive_decode bus_master
           *-network
                description: Ethernet interface
                product: RTL-8110SC/8169SC Gigabit Ethernet
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 6
                bus info: pci@02:06.0
                logical name: eth0
                version: 10
                serial: 00:16:17:c3:b8:f9
                size: 100MB/s
                capacity: 1GB/s
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegociation
                configuration: autonegociation=on broadcast=yes driver=r8169 driverversion=2.2LK duplex=full ip=192.168.0.2 link=yes multicast=yes port=twisted pair speed=100MB/s
                resources: ioport:b800-b8ff iomemory:feaff800-feaff8ff irq:21
     *-pci:1
          description: Host bridge
          product: K8 [Athlon64/Opteron] HyperTransport Technology Configuration
          vendor: Advanced Micro Devices [AMD]
          physical id: 101
          bus info: pci@00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:2
          description: Host bridge
          product: K8 [Athlon64/Opteron] Address Map
          vendor: Advanced Micro Devices [AMD]
          physical id: 102
          bus info: pci@00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:3
          description: Host bridge
          product: K8 [Athlon64/Opteron] DRAM Controller
          vendor: Advanced Micro Devices [AMD]
          physical id: 103
          bus info: pci@00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:4
          description: Host bridge
          product: K8 [Athlon64/Opteron] Miscellaneous Control
          vendor: Advanced Micro Devices [AMD]
          physical id: 104
          bus info: pci@00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz

--------------000408040105040707030000--
