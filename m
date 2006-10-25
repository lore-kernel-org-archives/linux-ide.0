From: Stephen Hemminger <shemminger@osdl.org>
Subject: Slow SATA detection on bootup
Date: Wed, 25 Oct 2006 11:45:04 -0700
Message-ID: <20061025114504.450b3425@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:18832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161368AbWJYSrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 14:47:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This laptop has long timeouts during bootup.  Something is
wrong. This is a Sony VAIO NG170. On a positive note suspend works.

Here is the console log during the 40 seconds of dead time.

[    2.942000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    2.942000] ata1: SATA max UDMA/133 cmd 0x18B0 ctl 0x18A6 bmdma 0x1890 irq 225
[    2.942000] ata2: SATA max UDMA/133 cmd 0x18A8 ctl 0x18A2 bmdma 0x1898 irq 225
[    2.942000] scsi0 : ata_piix
[    3.094000] ata1.00: ATA-7, max UDMA/100, 234441648 sectors: LBA48 NCQ (depth 0/32)
[    3.094000] ata1.00: ata1: dev 0 multi count 16
[    3.097000] ata1.00: configured for UDMA/100
[    3.097000] scsi1 : ata_piix
[   10.144000] ata2: port is slow to respond, please be patient
[   33.104000] ata2: port failed to respond (30 secs)
[   33.255000] ata2: SRST failed (status 0xFF)
[   33.255000] ata2: SRST failed (err_mask=0x100)
[   33.255000] ata2: softreset failed, retrying in 5 secs
[   38.407000] ata2: SRST failed (status 0xFF)
[   38.407000] ata2: SRST failed (err_mask=0x100)
[   38.407000] ata2: softreset failed, retrying in 5 secs
[   43.560000] ata2: SRST failed (status 0xFF)
[   43.560000] ata2: SRST failed (err_mask=0x100)
[   43.560000] ata2: reset failed, giving up
[   43.560000]   Vendor: ATA       Model: FUJITSU MHV2120B  Rev: 0000
[   43.561000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   43.567000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)

Full log:

[    0.000000] Linux version 2.6.18.1 (shemminger@sony-laptop) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Fri Oct 20 15:14:44 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f690000 (usable)
[    0.000000]  BIOS-e820: 000000003f690000 - 000000003f698000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003f698000 - 000000003f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Warning only 896MB will be used.
[    0.000000] Use a HIGHMEM enabled kernel.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f71b0
[    0.000000] On node 0 totalpages: 229376
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 225280 pages, LIFO batch:31
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f70e0
[    0.000000] ACPI: RSDT (v001   SONY       J4 0x20060907 PTL  0x00000000) @ 0x3f6916ca
[    0.000000] ACPI: FADT (v002   SONY       J4 0x20060907 PTL  0x0000005a) @ 0x3f697e48
[    0.000000] ACPI: MADT (v001   SONY       J4 0x20060907 PTL  0x0000005a) @ 0x3f697ecc
[    0.000000] ACPI: MCFG (v001   SONY       J4 0x20060907 PTL  0x0000005a) @ 0x3f697f34
[    0.000000] ACPI: MADT (v001   SONY       J4 0x20060907 PTL  0x00000000) @ 0x3f697f70
[    0.000000] ACPI: BOOT (v001   SONY       J4 0x20060907 PTL  0x00000001) @ 0x3f697fd8
[    0.000000] ACPI: SSDT (v001   SONY       J4 0x20060907 PTL  0x20050624) @ 0x3f69210b
[    0.000000] ACPI: SSDT (v001   SONY       J4 0x20060907 PTL  0x20050624) @ 0x3f69170a
[    0.000000] ACPI: DSDT (v001   SONY       J4 0x20060907 PTL  0x20050624) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: 2 duplicate APIC table ignored.
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:14 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 6:14 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Detected 1596.085 MHz processor.
[   17.971836] Built 1 zonelists.  Total pages: 229376
[   17.971839] Kernel command line: root=/dev/sda1 ro
[   17.972048] mapped APIC to ffffd000 (fee00000)
[   17.972051] mapped IOAPIC to ffffc000 (fec00000)
[   17.972054] Enabling fast FPU save and restore... done.
[   17.972057] Enabling unmasked SIMD FPU exception support... done.
[   17.972061] Initializing CPU#0
[   17.972126] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   17.973647] Console: colour VGA+ 80x25
[   17.976113] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   17.976569] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   17.994368] Memory: 902104k/917504k available (1408k kernel code, 14816k reserved, 559k data, 196k init, 0k highmem)
[   17.994449] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   18.054045] Calibrating delay using timer specific routine.. 3194.44 BogoMIPS (lpj=1597223)
[   18.054199] Mount-cache hash table entries: 512
[   18.054351] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   18.054361] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   18.054368] monitor/mwait feature present.
[   18.054422] using mwait in idle threads.
[   18.054476] CPU: L1 I cache: 32K, L1 D cache: 32K
[   18.054564] CPU: L2 cache: 2048K
[   18.054616] CPU: Physical Processor ID: 0
[   18.054668] CPU: Processor Core ID: 0
[   18.054720] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
[   18.054729] Compat vDSO mapped to ffffe000.
[   18.054792] Checking 'hlt' instruction... OK.
[   18.058140] SMP alternatives: switching to UP code
[   18.058293] ACPI: Core revision 20060707
[   18.091651] CPU0: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[   18.091832] SMP alternatives: switching to SMP code
[   18.092007] Booting processor 1/1 eip 3000
[   18.102538] Initializing CPU#1
[   18.162923] Calibrating delay using timer specific routine.. 3191.58 BogoMIPS (lpj=1595793)
[   18.162930] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   18.162938] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   18.162943] monitor/mwait feature present.
[   18.162946] CPU: L1 I cache: 32K, L1 D cache: 32K
[   18.162949] CPU: L2 cache: 2048K
[   18.162951] CPU: Physical Processor ID: 0
[   18.162953] CPU: Processor Core ID: 1
[   18.162955] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
[   18.163353] CPU1: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[   18.163934] Total of 2 processors activated (6386.03 BogoMIPS).
[   18.164188] ENABLING IO-APIC IRQs
[   18.164426] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   18.275811] checking TSC synchronization across 2 CPUs: passed.
[    0.000955] Brought up 2 CPUs
[    0.284715] migration_cost=53
[    0.284964] checking if image is initramfs... it is
[    0.678499] Freeing initrd memory: 3914k freed
[    0.678916] NET: Registered protocol family 16
[    0.679050] ACPI: bus type pci registered
[    0.679108] PCI: Using MMCONFIG
[    0.680097] Setting up standard PCI resources
[    0.699770] ACPI: Interpreter enabled
[    0.699825] ACPI: Using IOAPIC for interrupt routing
[    0.712680] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.712738] PCI: Probing PCI hardware (bus 00)
[    0.719670] Boot video device is 0000:00:02.0
[    0.720318] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.721506] PCI: Transparent bridge - 0000:00:1e.0
[    0.721623] PCI: Bus #09 (-#0c) is hidden behind transparent bridge #08 (-#09) (try 'pci=assign-busses')
[    0.721701] Please report the result to linux-kernel to fix this permanently
[    0.721815] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.729700] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.729986] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.730273] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.731404] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.732533] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 *7 10 12 14 15)
[    0.733247] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 11 12 14 15)
[    0.733932] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.734674] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.735432] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.736212] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.736976] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 *4 5 6 7 10 12 14 15)
[    0.737672] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 11 12 14 15)
[    0.738177] ACPI: Embedded Controller [EC] (gpe 23) interrupt mode.
[    0.743243] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.743312] pnp: PnP ACPI init
[    0.753240] pnp: PnP ACPI: found 9 devices
[    0.753343] PCI: Using ACPI for IRQ routing
[    0.753397] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.753969] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    0.754032] PCI: Bridge: 0000:00:1c.0
[    0.754087]   IO window: 2000-2fff
[    0.754151]   MEM window: d6000000-d7ffffff
[    0.754207]   PREFETCH window: d0000000-d1ffffff
[    0.754266] PCI: Bridge: 0000:00:1c.1
[    0.754321]   IO window: 3000-3fff
[    0.754376]   MEM window: d8000000-d9ffffff
[    0.754433]   PREFETCH window: d2000000-d3ffffff
[    0.754491] PCI: Bridge: 0000:00:1c.2
[    0.754545]   IO window: 4000-4fff
[    0.754602]   MEM window: da000000-dbffffff
[    0.754658]   PREFETCH window: d4000000-d5ffffff
[    0.754725] PCI: Bus 9, cardbus bridge: 0000:08:03.0
[    0.754781]   IO window: 00005000-000050ff
[    0.754839]   IO window: 00005400-000054ff
[    0.754896]   PREFETCH window: 50000000-51ffffff
[    0.754954]   MEM window: 52000000-53ffffff
[    0.755011] PCI: Bridge: 0000:00:1e.0
[    0.755065]   IO window: 5000-5fff
[    0.755131]   MEM window: dc000000-dc0fffff
[    0.755187]   PREFETCH window: 50000000-51ffffff
[    0.755264] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[    0.755374] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.755396] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[    0.755504] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.755524] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
[    0.755632] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.755642] PCI: Enabling device 0000:00:1e.0 (0004 -> 0007)
[    0.755703] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.755718] PCI: Enabling device 0000:08:03.0 (0000 -> 0003)
[    0.755777] ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[    0.755888] PCI: Setting latency timer of device 0000:08:03.0 to 64
[    0.755915] NET: Registered protocol family 2
[    0.769144] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.769338] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.770560] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.771234] TCP: Hash tables configured (established 131072 bind 65536)
[    0.771295] TCP reno registered
[    0.771542] Simple Boot Flag at 0x36 set to 0x1
[    0.772608] Initializing Cryptographic API
[    0.772670] io scheduler noop registered
[    0.772759] io scheduler anticipatory registered (default)
[    0.772885] io scheduler deadline registered
[    0.772985] io scheduler cfq registered
[    0.773309] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.773359] assign_interrupt_mode Found MSI capability
[    0.773473] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.773515] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.773550] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.773594] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.773643] assign_interrupt_mode Found MSI capability
[    0.773742] Allocate Port Service[0000:00:1c.1:pcie00]
[    0.773783] Allocate Port Service[0000:00:1c.1:pcie02]
[    0.773817] Allocate Port Service[0000:00:1c.1:pcie03]
[    0.773863] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.773912] assign_interrupt_mode Found MSI capability
[    0.774011] Allocate Port Service[0000:00:1c.2:pcie00]
[    0.774048] Allocate Port Service[0000:00:1c.2:pcie02]
[    0.774085] Allocate Port Service[0000:00:1c.2:pcie03]
[    0.797628] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    0.798806] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    0.798983] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.799042] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.799372] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.802193] i8042.c: Detected active multiplexing controller, rev 1.1.
[    0.805641] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.806389] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.807395] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.809028] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.809985] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.810103] mice: PS/2 mouse device common for all mice
[    0.810253] TCP bic registered
[    0.810943] NET: Registered protocol family 1
[    0.811008] Using IPI No-Shortcut mode
[    0.811377] Time: tsc clocksource has been installed.
[    0.811473] ACPI: (supports S0 S3 S4 S5)
[    0.811856] Freeing unused kernel memory: 196k freed
[    0.862634] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[    0.863294] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[    0.864590] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    0.864744] ACPI: Processor [CPU0] (supports 8 throttling states)
[    0.865429] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[    0.865786] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[    0.866254] ACPI: CPU1 (power states: C1[C1] C2[C2])
[    0.866408] ACPI: Processor [CPU1] (supports 8 throttling states)
[    0.868132] ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active threshold [0] [20060707]
[    0.869086] ACPI: Thermal Zone [TZ00] (36 C)
[    0.870127] ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active threshold [0] [20060707]
[    0.871051] ACPI: Thermal Zone [TZ01] (36 C)
[    1.051000] Time: acpi_pm clocksource has been installed.
[    1.409000] ICH7: IDE controller at PCI slot 0000:00:1f.1
[    1.409000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
[    1.409000] ICH7: chipset revision 2
[    1.409000] ICH7: not 100% native mode: will probe irqs later
[    1.409000]     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
[    1.410000] Probing IDE interface ide0...
[    1.600000] input: AT Translated Set 2 keyboard as /class/input/input0
[    2.082000] hda: PIONEER DVD-RW DVR-K16D, ATAPI CD/DVD-ROM drive
[    2.695000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.703000] hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
[    2.704000] Uniform CD-ROM driver Revision: 3.20
[    2.785000] SCSI subsystem initialized
[    2.789000] libata version 2.00 loaded.
[    2.791000] ata_piix 0000:00:1f.2: version 2.00
[    2.791000] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
[    2.791000] ata_piix 0000:00:1f.2: invalid MAP value 0
[    2.942000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
[    2.942000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    2.942000] ata1: SATA max UDMA/133 cmd 0x18B0 ctl 0x18A6 bmdma 0x1890 irq 225
[    2.942000] ata2: SATA max UDMA/133 cmd 0x18A8 ctl 0x18A2 bmdma 0x1898 irq 225
[    2.942000] scsi0 : ata_piix
[    3.094000] ata1.00: ATA-7, max UDMA/100, 234441648 sectors: LBA48 NCQ (depth 0/32)
[    3.094000] ata1.00: ata1: dev 0 multi count 16
[    3.097000] ata1.00: configured for UDMA/100
[    3.097000] scsi1 : ata_piix
[   10.144000] ata2: port is slow to respond, please be patient
[   33.104000] ata2: port failed to respond (30 secs)
[   33.255000] ata2: SRST failed (status 0xFF)
[   33.255000] ata2: SRST failed (err_mask=0x100)
[   33.255000] ata2: softreset failed, retrying in 5 secs
[   38.407000] ata2: SRST failed (status 0xFF)
[   38.407000] ata2: SRST failed (err_mask=0x100)
[   38.407000] ata2: softreset failed, retrying in 5 secs
[   43.560000] ata2: SRST failed (status 0xFF)
[   43.560000] ata2: SRST failed (err_mask=0x100)
[   43.560000] ata2: reset failed, giving up
[   43.560000]   Vendor: ATA       Model: FUJITSU MHV2120B  Rev: 0000
[   43.561000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   43.567000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[   43.567000] sda: Write Protect is off
[   43.567000] sda: Mode Sense: 00 3a 00 00
[   43.567000] SCSI device sda: drive cache: write back
[   43.568000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[   43.568000] sda: Write Protect is off
[   43.568000] sda: Mode Sense: 00 3a 00 00
[   43.568000] SCSI device sda: drive cache: write back
[   43.568000]  sda: sda1 sda2 sda3
[   43.924000] sd 0:0:0:0: Attached scsi disk sda
[   44.182000] usbcore: registered new driver usbfs
[   44.182000] usbcore: registered new driver hub
[   44.188000] USB Universal Host Controller Interface driver v3.0
[   44.188000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 233
[   44.188000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   44.188000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   44.188000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   44.188000] uhci_hcd 0000:00:1d.0: irq 233, io base 0x00001820
[   44.189000] usb usb1: configuration #1 chosen from 1 choice
[   44.189000] hub 1-0:1.0: USB hub found
[   44.189000] hub 1-0:1.0: 2 ports detected
[   44.200000] ieee1394: Initialized config rom entry `ip1394'
[   44.290000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 169
[   44.291000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   44.291000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   44.291000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   44.291000] uhci_hcd 0000:00:1d.1: irq 169, io base 0x00001840
[   44.291000] usb usb2: configuration #1 chosen from 1 choice
[   44.291000] hub 2-0:1.0: USB hub found
[   44.291000] hub 2-0:1.0: 2 ports detected
[   44.392000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 233
[   44.393000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   44.393000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   44.393000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
[   44.393000] ehci_hcd 0000:00:1d.7: debug port 1
[   44.393000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   44.393000] ehci_hcd 0000:00:1d.7: irq 233, io mem 0xdc444000
[   44.397000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   44.397000] usb usb3: configuration #1 chosen from 1 choice
[   44.397000] hub 3-0:1.0: USB hub found
[   44.397000] hub 3-0:1.0: 6 ports detected
[   44.499000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[   44.499000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   44.499000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   44.499000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   44.499000] uhci_hcd 0000:00:1d.2: irq 185, io base 0x00001860
[   44.499000] usb usb4: configuration #1 chosen from 1 choice
[   44.499000] hub 4-0:1.0: USB hub found
[   44.499000] hub 4-0:1.0: 2 ports detected
[   44.601000] PCI: Enabling device 0000:08:03.1 (0000 -> 0002)
[   44.601000] ACPI: PCI Interrupt 0000:08:03.1[A] -> GSI 16 (level, low) -> IRQ 177
[   44.601000] PCI: Setting latency timer of device 0000:08:03.1 to 64
[   44.658000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[177]  MMIO=[dc005000-dc0057ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   44.670000] Probing IDE interface ide1...
[   45.211000] Attempting manual resume
[   45.223000] EXT3-fs: INFO: recovery required on readonly filesystem.
[   45.223000] EXT3-fs: write access will be enabled during recovery.
[   45.250000] kjournald starting.  Commit interval 5 seconds
[   45.250000] EXT3-fs: recovery complete.
[   45.251000] EXT3-fs: mounted filesystem with ordered data mode.
[   45.916000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460302320543]
[   50.698000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   51.622000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   51.705000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   51.724000] Linux agpgart interface v0.101 (c) Dave Jones
[   51.734000] agpgart: Detected an Intel 945GM Chipset.
[   51.735000] agpgart: Detected 7932K stolen memory.
[   51.753000] agpgart: AGP aperture is 256M @ 0xc0000000
[   51.824000] input: PC Speaker as /class/input/input1
[   51.931000] Real Time Clock Driver v1.12ac
[   52.325000] input: PS/2 Mouse as /class/input/input2
[   52.345000] input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
[   52.387000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[   52.387000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   52.387000] sky2 v1.5 addr 0xd6000000 irq 177 Yukon-FE (0xb7) rev 1
[   52.388000] sky2 eth0: addr 00:13:a9:7d:aa:6f
[   52.442000] ts: Compaq touchscreen protocol output
[   52.649000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 58
[   52.649000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   52.699000] sky2 eth0: enabling interface
[   52.741000] hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
[   52.967000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   52.967000] ieee1394: sbp2: Try serialize_io=0 for better performance
[   53.023000] Adding 2104504k swap on /dev/sda2.  Priority:-1 extents:1 across:2104504k
[   53.067000] EXT3 FS on sda1, internal journal
[   53.677000] kjournald starting.  Commit interval 5 seconds
[   53.678000] EXT3 FS on sda3, internal journal
[   53.679000] EXT3-fs: mounted filesystem with ordered data mode.
[   53.809000] NET: Registered protocol family 17
[   54.587000] sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
[   57.064000] NET: Registered protocol family 10
[   57.064000] lo: Disabled Privacy Extensions
[   57.064000] IPv6 over IPv4 tunneling driver
[   58.956000] ACPI: AC Adapter [ADP1] (on-line)
[   59.006000] ACPI: Battery Slot [BAT0] (battery present)
[   59.021000] ACPI: Lid Switch [LID0]
[   59.022000] ACPI: Power Button (CM) [PWRB]
[   59.067000] Using specific hotkey driver
[   59.138000] ibm_acpi: ec object not found
[   59.176000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   59.186000] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   62.645000] [drm] Initialized drm 1.0.1 20051102
[   62.660000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[   62.662000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[   63.033000] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   63.036000] sonypi: detected type3 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
[   63.036000] sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
[   63.036000] sonypi: device allocated minor is 63
[   63.037000] input: Sony Vaio Jogdial as /class/input/input4
[   63.047000] input: Sony Vaio Keys as /class/input/input5
[   63.176000] sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
[   63.218000] sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 657)
[   63.260000] sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 659)
[   63.307000] sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
[   67.132000] psmouse.c: GlidePoint at isa0060/serio4/input0 lost synchronization, throwing 1 bytes away.
[   67.256000] eth0: no IPv6 routers present
[   67.640000] psmouse.c: resync failed, issuing reconnect request
