From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Slow SATA detection on bootup
Date: Wed, 25 Oct 2006 14:07:34 -0700
Message-ID: <20061025140734.561f566a@localhost>
References: <20061025114504.450b3425@localhost>
	<20061025190620.GI19513@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:13244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422879AbWJYVIB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 17:08:01 -0400
In-Reply-To: <20061025190620.GI19513@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Wed, 25 Oct 2006 15:06:20 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Wed, Oct 25, 2006 at 11:45:04AM -0700, Stephen Hemminger wrote:
> > This laptop has long timeouts during bootup.  Something is
> > wrong. This is a Sony VAIO NG170. On a positive note suspend works.
> > 
> > Here is the console log during the 40 seconds of dead time.
> 
> What are results from the latest 2.6.19-rcX-gitX, and from the latest -mm?
> 
> 	Jeff
> 


Same problem with current git tree.

[    1.339696] ata4: SATA max UDMA/133 cmd 0x18A8 ctl 0x18A2 bmdma 0x1898 irq 19
[    1.339766] scsi2 : ata_piix
[    1.492243] ata3.00: ATA-7, max UDMA/100, 234441648 sectors: LBA48 NCQ (depth 0/32)
[    1.492325] ata3.00: ata3: dev 0 multi count 16
[    1.495405] ata3.00: configured for UDMA/100
[    1.495461] scsi3 : ata_piix
[    8.530407] ata4: port is slow to respond, please be patient (Status 0xff)
[   31.505574] ata4: port failed to respond (30 secs, Status 0xff)
[   31.656404] ata4: SRST failed (status 0xFF)
[   31.656459] ata4: SRST failed (err_mask=0x100)
[   31.656514] ata4: softreset failed, retrying in 5 secs
[   36.804622] ata4: SRST failed (status 0xFF)
[   36.804681] ata4: SRST failed (err_mask=0x100)
[   36.804737] ata4: softreset failed, retrying in 5 secs
[   41.951843] ata4: SRST failed (status 0xFF)
[   41.951898] ata4: SRST failed (err_mask=0x100)
[   41.951952] ata4: reset failed, giving up


It is Intel ICH7 chips, here are the relevant portions of lspci

0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation: Unknown device 8212
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1810 [size=16]
00: 86 80 df 27 05 00 80 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 11 18 00 00 00 00 00 00 00 00 00 00 4d 10 12 82
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

0000:00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Sony Corporation: Unknown device 8212
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at 18b0 [size=8]
	Region 1: I/O ports at 18a4 [size=4]
	Region 2: I/O ports at 18a8 [size=8]
	Region 3: I/O ports at 18a0 [size=4]
	Region 4: I/O ports at 1890 [size=16]
	Region 5: Memory at dc444400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c4 27 07 00 b0 02 02 8f 01 01 00 00 00 00
10: b1 18 00 00 a5 18 00 00 a9 18 00 00 a1 18 00 00
20: 91 18 00 00 00 44 44 dc 00 00 00 00 4d 10 12 82
30: 00 00 00 00 70 00 00 00 00 00 00 00 0a 02 00 00



Full log.

[    0.000000] Linux version 2.6.19-rc3 (shemminger@sony-laptop) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #3 SMP PREEMPT Wed Oct 25 13:47:23 PDT 2006
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
[    0.000000] 118MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f71b0
[    0.000000] Entering add_active_range(0, 0, 259728) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   259728
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   259728
[    0.000000] On node 0 totalpages: 259728
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 237 pages used for memmap
[    0.000000]   HighMem zone: 30115 pages, LIFO batch:7
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
[    0.000000] Detected 1596.091 MHz processor.
[   13.409916] Built 1 zonelists.  Total pages: 257699
[   13.409921] Kernel command line: root=/dev/sda1 ro
[   13.410111] mapped APIC to ffffd000 (fee00000)
[   13.410114] mapped IOAPIC to ffffc000 (fec00000)
[   13.410117] Enabling fast FPU save and restore... done.
[   13.410120] Enabling unmasked SIMD FPU exception support... done.
[   13.410123] Initializing CPU#0
[   13.410191] CPU 0 irqstacks, hard=c03a4000 soft=c03ac000
[   13.410195] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   13.411710] Console: colour VGA+ 80x25
[   13.414446] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   13.414874] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   13.441204] Memory: 1022472k/1038912k available (1567k kernel code, 15808k reserved, 611k data, 204k init, 121408k highmem)
[   13.441294] virtual kernel memory layout:
[   13.441296]     fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
[   13.441297]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   13.441299]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   13.441300]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   13.441302]       .init : 0xc036c000 - 0xc039f000   ( 204 kB)
[   13.441304]       .data : 0xc0287d89 - 0xc0320b30   ( 611 kB)
[   13.441305]       .text : 0xc0100000 - 0xc0287d89   (1567 kB)
[   13.441738] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   13.501101] Calibrating delay using timer specific routine.. 3194.47 BogoMIPS (lpj=1597238)
[   13.501257] Mount-cache hash table entries: 512
[   13.501413] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   13.501421] monitor/mwait feature present.
[   13.501475] using mwait in idle threads.
[   13.501531] CPU: L1 I cache: 32K, L1 D cache: 32K
[   13.501617] CPU: L2 cache: 2048K
[   13.501668] CPU: Physical Processor ID: 0
[   13.501720] CPU: Processor Core ID: 0
[   13.501773] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
[   13.501783] Compat vDSO mapped to ffffe000.
[   13.501846] Checking 'hlt' instruction... OK.
[   13.505201] SMP alternatives: switching to UP code
[   13.505353] ACPI: Core revision 20060707
[   13.544920] CPU0: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[   13.545109] SMP alternatives: switching to SMP code
[   13.545271] Booting processor 1/1 eip 3000
[   13.545326] CPU 1 irqstacks, hard=c03a5000 soft=c03ad000
[   13.555858] Initializing CPU#1
[   13.615972] Calibrating delay using timer specific routine.. 3191.59 BogoMIPS (lpj=1595795)
[   13.615979] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[   13.615985] monitor/mwait feature present.
[   13.615989] CPU: L1 I cache: 32K, L1 D cache: 32K
[   13.615991] CPU: L2 cache: 2048K
[   13.615993] CPU: Physical Processor ID: 0
[   13.615995] CPU: Processor Core ID: 1
[   13.615997] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
[   13.616464] CPU1: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[   13.617044] Total of 2 processors activated (6386.06 BogoMIPS).
[   13.617298] ENABLING IO-APIC IRQs
[   13.617548] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   13.728856] checking TSC synchronization across 2 CPUs: passed.
[    0.000962] Brought up 2 CPUs
[    0.207488] migration_cost=73
[    0.207750] checking if image is initramfs... it is
[    0.570873] Freeing initrd memory: 3604k freed
[    0.571302] NET: Registered protocol family 16
[    0.571451] ACPI: bus type pci registered
[    0.571513] PCI: Using MMCONFIG
[    0.572501] Setting up standard PCI resources
[    0.593906] ACPI: Interpreter enabled
[    0.593961] ACPI: Using IOAPIC for interrupt routing
[    0.606808] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.606869] PCI: Probing PCI hardware (bus 00)
[    0.613788] Boot video device is 0000:00:02.0
[    0.614281] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.614341] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.614443] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.615480] PCI: Transparent bridge - 0000:00:1e.0
[    0.615597] PCI: Bus #09 (-#0c) is hidden behind transparent bridge #08 (-#09) (try 'pci=assign-busses')
[    0.615676] Please report the result to linux-kernel to fix this permanently
[    0.615788] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.623927] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.624216] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.624503] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.625666] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.626809] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 *7 10 12 14 15)
[    0.627515] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 11 12 14 15)
[    0.628207] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.628954] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.629694] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.630467] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.631238] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 *4 5 6 7 10 12 14 15)
[    0.631934] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 11 12 14 15)
[    0.636478] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.636541] pnp: PnP ACPI init
[    0.645610] pnp: PnP ACPI: found 9 devices
[    0.645694] intel_rng: FWH not detected
[    0.645889] SCSI subsystem initialized
[    0.645966] PCI: Using ACPI for IRQ routing
[    0.646021] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.646602] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    0.646664] PCI: Bridge: 0000:00:1c.0
[    0.646719]   IO window: 2000-2fff
[    0.646776]   MEM window: d6000000-d7ffffff
[    0.646832]   PREFETCH window: d0000000-d1ffffff
[    0.646890] PCI: Bridge: 0000:00:1c.1
[    0.646943]   IO window: 3000-3fff
[    0.646999]   MEM window: d8000000-d9ffffff
[    0.647056]   PREFETCH window: d2000000-d3ffffff
[    0.647114] PCI: Bridge: 0000:00:1c.2
[    0.647169]   IO window: 4000-4fff
[    0.647230]   MEM window: da000000-dbffffff
[    0.647292]   PREFETCH window: d4000000-d5ffffff
[    0.647356] PCI: Bus 9, cardbus bridge: 0000:08:03.0
[    0.647412]   IO window: 00005000-000050ff
[    0.647469]   IO window: 00005400-000054ff
[    0.647526]   PREFETCH window: 50000000-51ffffff
[    0.647584]   MEM window: 52000000-53ffffff
[    0.647641] PCI: Bridge: 0000:00:1e.0
[    0.647696]   IO window: 5000-5fff
[    0.647751]   MEM window: dc000000-dc0fffff
[    0.647807]   PREFETCH window: 50000000-51ffffff
[    0.647885] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
[    0.647994] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.648015] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
[    0.648124] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.648144] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[    0.648258] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.648268] PCI: Enabling device 0000:00:1e.0 (0004 -> 0007)
[    0.648328] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.648343] PCI: Enabling device 0000:08:03.0 (0000 -> 0003)
[    0.648402] ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 16 (level, low) -> IRQ 17
[    0.648513] PCI: Setting latency timer of device 0000:08:03.0 to 64
[    0.648542] NET: Registered protocol family 2
[    0.658276] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.658476] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.659696] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.660356] TCP: Hash tables configured (established 131072 bind 65536)
[    0.660415] TCP reno registered
[    0.660686] Simple Boot Flag at 0x36 set to 0x1
[    0.661253] highmem bounce pool size: 64 pages
[    0.661456] io scheduler noop registered
[    0.661543] io scheduler anticipatory registered (default)
[    0.661665] io scheduler deadline registered
[    0.661760] io scheduler cfq registered
[    0.662077] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.662127] assign_interrupt_mode Found MSI capability
[    0.662239] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.662276] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.662307] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.662409] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.662457] assign_interrupt_mode Found MSI capability
[    0.662550] Allocate Port Service[0000:00:1c.1:pcie00]
[    0.662584] Allocate Port Service[0000:00:1c.1:pcie02]
[    0.662615] Allocate Port Service[0000:00:1c.1:pcie03]
[    0.662710] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.662759] assign_interrupt_mode Found MSI capability
[    0.662853] Allocate Port Service[0000:00:1c.2:pcie00]
[    0.662886] Allocate Port Service[0000:00:1c.2:pcie02]
[    0.662922] Allocate Port Service[0000:00:1c.2:pcie03]
[    0.685392] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    0.686530] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    0.686708] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.686768] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.687072] libata version 2.00 loaded.
[    0.687143] ata_piix 0000:00:1f.1: version 2.00ac6
[    0.687157] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[    0.687280] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[    0.687328] ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
[    0.688305] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
[    0.688385] scsi0 : ata_piix
[    1.002858] ata1.00: ATAPI, max UDMA/33
[    1.166641] ata1.00: configured for UDMA/33
[    1.166705] scsi1 : ata_piix
[    1.166813] ata2: port disabled. ignoring.
[    1.178390] ATA: abnormal status 0xFF on port 0x177
[    1.187849] scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-K16D 1.00 PQ: 0 ANSI: 5
[    1.188008] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
[    1.188224] ata_piix 0000:00:1f.2: invalid MAP value 0
[    1.339464] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[    1.339584] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    1.339610] ata3: SATA max UDMA/133 cmd 0x18B0 ctl 0x18A6 bmdma 0x1890 irq 19
[    1.339696] ata4: SATA max UDMA/133 cmd 0x18A8 ctl 0x18A2 bmdma 0x1898 irq 19
[    1.339766] scsi2 : ata_piix
[    1.492243] ata3.00: ATA-7, max UDMA/100, 234441648 sectors: LBA48 NCQ (depth 0/32)
[    1.492325] ata3.00: ata3: dev 0 multi count 16
[    1.495405] ata3.00: configured for UDMA/100
[    1.495461] scsi3 : ata_piix
[    8.530407] ata4: port is slow to respond, please be patient (Status 0xff)
[   31.505574] ata4: port failed to respond (30 secs, Status 0xff)
[   31.656404] ata4: SRST failed (status 0xFF)
[   31.656459] ata4: SRST failed (err_mask=0x100)
[   31.656514] ata4: softreset failed, retrying in 5 secs
[   36.804622] ata4: SRST failed (status 0xFF)
[   36.804681] ata4: SRST failed (err_mask=0x100)
[   36.804737] ata4: softreset failed, retrying in 5 secs
[   41.951843] ata4: SRST failed (status 0xFF)
[   41.951898] ata4: SRST failed (err_mask=0x100)
[   41.951952] ata4: reset failed, giving up
[   41.952074] scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHV2120B 0000 PQ: 0 ANSI: 5
[   41.952301] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   41.956101] i8042.c: Detected active multiplexing controller, rev 1.1.
[   41.961208] serio: i8042 KBD port at 0x60,0x64 irq 1
[   41.961269] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   41.961328] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   41.961387] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   41.961446] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   41.961584] mice: PS/2 mouse device common for all mice
[   41.961731] TCP cubic registered
[   41.961789] NET: Registered protocol family 1
[   41.961857] Using IPI No-Shortcut mode
[   41.961971] ACPI: (supports<6>Time: tsc clocksource has been installed.
[   41.962067]  S0 S3 S4 S5)
[   41.962404] Freeing unused kernel memory: 204k freed
[   42.011608] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[   42.012264] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[   42.012682] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   42.012839] ACPI: Processor [CPU0] (supports 8 throttling states)
[   42.013518] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[   42.013874] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [  SONY] OemTableId [      J4] [20060707]
[   42.014344] ACPI: CPU1 (power states: C1[C1] C2[C2])
[   42.014496] ACPI: Processor [CPU1] (supports 8 throttling states)
[   42.016427] ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active threshold [0] [20060707]
[   42.017311] ACPI: Thermal Zone [TZ00] (54 C)
[   42.018667] ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active threshold [0] [20060707]
[   42.019543] ACPI: Thermal Zone [TZ01] (54 C)
[   42.241000] Time: acpi_pm clocksource has been installed.
[   42.381000] input: AT Translated Set 2 keyboard as /class/input/input0
[   42.390000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[   42.390000] sda: Write Protect is off
[   42.390000] sda: Mode Sense: 00 3a 00 00
[   42.390000] SCSI device sda: drive cache: write back
[   42.390000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[   42.390000] sda: Write Protect is off
[   42.390000] sda: Mode Sense: 00 3a 00 00
[   42.390000] SCSI device sda: drive cache: write back
[   42.391000]  sda: sda1 sda2 sda3
[   42.732000] sd 2:0:0:0: Attached scsi disk sda
[   43.057000] usbcore: registered new interface driver usbfs
[   43.057000] usbcore: registered new interface driver hub
[   43.058000] usbcore: registered new device driver usb
[   43.060000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
[   43.060000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   43.060000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   43.060000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   43.060000] ehci_hcd 0000:00:1d.7: debug port 1
[   43.060000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   43.060000] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xdc444000
[   43.064000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   43.064000] usb usb1: configuration #1 chosen from 1 choice
[   43.064000] hub 1-0:1.0: USB hub found
[   43.065000] hub 1-0:1.0: 6 ports detected
[   43.065000] USB Universal Host Controller Interface driver v3.0
[   43.166000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
[   43.166000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   43.166000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   43.167000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   43.167000] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
[   43.167000] usb usb2: configuration #1 chosen from 1 choice
[   43.167000] hub 2-0:1.0: USB hub found
[   43.167000] hub 2-0:1.0: 2 ports detected
[   43.268000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 16
[   43.268000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   43.268000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   43.268000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   43.268000] uhci_hcd 0000:00:1d.1: irq 16, io base 0x00001840
[   43.268000] usb usb3: configuration #1 chosen from 1 choice
[   43.268000] hub 3-0:1.0: USB hub found
[   43.268000] hub 3-0:1.0: 2 ports detected
[   43.369000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   43.369000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   43.369000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   43.369000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   43.369000] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
[   43.369000] usb usb4: configuration #1 chosen from 1 choice
[   43.369000] hub 4-0:1.0: USB hub found
[   43.369000] hub 4-0:1.0: 2 ports detected
[   43.495000] ide0: I/O resource 0x1F0-0x1F7 not free.
[   43.496000] ide0: ports already in use, skipping probe
[   43.496000] ide1: I/O resource 0x170-0x177 not free.
[   43.496000] ide1: ports already in use, skipping probe
[   43.525000] Attempting manual resume
[   43.570000] kjournald starting.  Commit interval 5 seconds
[   43.570000] EXT3-fs: mounted filesystem with ordered data mode.
[   43.575000] usb 3-1: new low speed USB device using uhci_hcd and address 2
[   43.739000] usb 3-1: configuration #1 chosen from 1 choice
[   48.586000] warning: process `ls' used the removed sysctl system call
[   48.888000] scsi 0:0:0:0: Attached scsi generic sg0 type 5
[   48.888000] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   49.036000] Adding 2104504k swap on /dev/sda2.  Priority:-1 extents:1 across:2104504k
[   49.101000] EXT3 FS on sda1, internal journal
[   49.103000] warning: process `touch' used the removed sysctl system call
[   49.166000] warning: process `touch' used the removed sysctl system call
[   49.422000] input: PS/2 Mouse as /class/input/input1
[   49.441000] input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
[   49.462000] warning: process `evms_activate' used the removed sysctl system call
[   49.933000] Linux agpgart interface v0.101 (c) Dave Jones
[   49.949000] agpgart: Detected an Intel 945GM Chipset.
[   49.950000] agpgart: Detected 7932K stolen memory.
[   49.965000] Real Time Clock Driver v1.12ac
[   49.968000] agpgart: AGP aperture is 256M @ 0xc0000000
[   49.990000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   49.993000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   50.025000] input: PC Speaker as /class/input/input3
[   50.394000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
[   50.409000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   50.409000] sky2 v1.10 addr 0xd6000000 irq 17 Yukon-FE (0xb7) rev 1
[   50.409000] sky2 eth0: addr 00:13:a9:7d:aa:6f
[   50.482000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
[   50.482000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   50.536000] hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
[   50.555000] usbcore: registered new interface driver hiddev
[   50.580000] input: KYE Genius USB Wheel Mouse as /class/input/input4
[   50.580000] input: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb-0000:00:1d.1-1
[   50.580000] usbcore: registered new interface driver usbhid
[   50.581000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   50.739000] warning: process `alsactl' used the removed sysctl system call
[   50.872000] kjournald starting.  Commit interval 5 seconds
[   50.895000] EXT3 FS on sda3, internal journal
[   50.895000] EXT3-fs: mounted filesystem with ordered data mode.
[   52.290000] NET: Registered protocol family 17
[   55.168000] ACPI: AC Adapter [ADP1] (on-line)
[   55.223000] ACPI: Battery Slot [BAT0] (battery present)
[   55.242000] ACPI: Lid Switch [LID0]
[   55.242000] ACPI: Power Button (CM) [PWRB]
[   55.287000] Using specific hotkey driver
[   55.342000] ibm_acpi: ec object not found
[   55.390000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   55.400000] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   58.544000] [drm] Initialized drm 1.0.1 20051102
[   58.560000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
[   58.565000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[   59.117000] sky2 eth0: enabling interface
[   59.221000] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   59.222000] sonypi: detected type3 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
[   59.222000] sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
[   59.222000] sonypi: device allocated minor is 63
[   59.251000] input: Sony Vaio Jogdial as /class/input/input5
[   59.251000] input: Sony Vaio Keys as /class/input/input6
[   59.351000] sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
[   59.391000] sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 657)
[   59.431000] sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 659)
[   59.472000] sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
[   60.785000] sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both

