From: Greg Meyer <greg@gkmweb.com>
Subject: Port Multiplier Support for sata_sil24
Date: Fri, 19 Oct 2007 19:34:38 -0400
Message-ID: <200710191934.38349.greg@gkmweb.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O8TGHzVkEBd5Un1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.phpwebhosting.com ([70.84.132.50]:54821 "HELO
	smtp1.phpwebhosting.com.phpwebhosting.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1763297AbXJSXlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 19:41:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

--Boundary-00=_O8TGHzVkEBd5Un1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.  I was very excited to see port multiplier support for the sata_sil24 
module in your patchset, but it does not appear to be working here, and I am 
not sure if I am doing something wrong or if it still is not supported.  I am 
working on a project to get a RAID enclosure that came with a Silicon Image 
eSATA controller with a port multiplier. It is a MicroNet SR42000E.

We are using Ubuntu Gutsy 7.10 (upgraded to release version), with a 
self-compiled 2.6.23.1 kernel, patched with libata-tj-2.6.23-20071011.  I 
don't recall any special compile time options during the config, and modinfo 
doesn't display anything that looks like a runtime option.

Interestingly, the device nodes are created for the 4 separate disks (which is 
what we want), but no disk partitioning utility, like fdisk, cfdisk or 
qparted can open the devices.  sata_sil24 is loaded.


$ lsmod |grep sil24
sata_sil24             18052  0
libata                152632  5 
ata_generic,ata_piix,pata_acpi,sata_vsc,sata_sil24

If this is a bug or something still unsupported, I would be happy to do 
additional testing and debugging at your direction or give you any additional 
information that you would like.  Thanks in advance for any insight you can 
provide.  I have attached the dmesg and lspci -vv reports as follows for the 
eSATA controller:


02:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II 
Controller (rev 01)
        Subsystem: Silicon Image, Inc. Unknown device 7132
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at fddf8000 (64-bit, non-prefetchable) [size=16K]
        Region 4: I/O ports at ef00 [size=128]
        [virtual] Expansion ROM at fdc00000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting

-- 
Greg

--Boundary-00=_O8TGHzVkEBd5Un1
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.log"

[    0.000000] Linux version 2.6.23.1-libata-tj (root@will-linux) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #1 SMP Wed Oct 17 00:04:50 EDT 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
[    0.000000]  BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f7f0000 (usable)
[    0.000000]  BIOS-e820: 000000007f7f0000 - 000000007f7f3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f7f3000 - 000000007f800000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 1143MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f4f20
[    0.000000] Entering add_active_range(0, 0, 522224) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   522224
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   522224
[    0.000000] On node 0 totalpages: 522224
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2287 pages used for memmap
[    0.000000]   HighMem zone: 290561 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000F8F30, 0014 (r0 GATEWA)
[    0.000000] ACPI: RSDT 7F7F3040, 003C (r1 GATEWA SYSTEM   42302E31 AWRD        0)
[    0.000000] ACPI: FACP 7F7F30C0, 0074 (r1 GATEWA SYSTEM   42302E31 AWRD        0)
[    0.000000] ACPI: DSDT 7F7F3180, 4B98 (r1 GATEWA AWRDACPI     1000 MSFT  100000E)
[    0.000000] ACPI: FACS 7F7F0000, 0040
[    0.000000] ACPI: SLIC 7F7F7E80, 0176 (r1 GATEWA SYSTEM   42302E31 AWRD        1)
[    0.000000] ACPI: MCFG 7F7F8040, 003C (r1 GATEWA SYSTEM   42302E31 AWRD        0)
[    0.000000] ACPI: APIC 7F7F7D80, 0084 (r1 GATEWA SYSTEM   42302E31 AWRD        0)
[    0.000000] ACPI: SSDT 7F7F80C0, 015C (r1  PmRef  Cpu0Ist     3000 INTL 20040311)
[    0.000000] ACPI: SSDT 7F7F8550, 02F1 (r1  PmRef    CpuPm     3000 INTL 20040311)
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:15 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 6:15 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 7f800000:60800000)
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 518145
[    0.000000] Kernel command line: root=UUID=f658c897-ca24-4124-b01c-c5083f2be783 ro quiet splash
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1799.926 MHz processor.
[   54.325212] Console: colour VGA+ 80x25
[   54.325215] console [tty0] enabled
[   54.325431] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   54.325678] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   54.414654] Memory: 2022988k/2088896k available (2042k kernel code, 64604k reserved, 931k data, 356k init, 1171392k highmem)
[   54.414661] virtual kernel memory layout:
[   54.414661]     fixmap  : 0xfff4b000 - 0xfffff000   ( 720 kB)
[   54.414663]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   54.414663]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   54.414664]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   54.414665]       .init : 0xc03ed000 - 0xc0446000   ( 356 kB)
[   54.414666]       .data : 0xc02fe808 - 0xc03e7744   ( 931 kB)
[   54.414667]       .text : 0xc0100000 - 0xc02fe808   (2042 kB)
[   54.414670] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   54.494678] Calibrating delay using timer specific routine.. 3602.73 BogoMIPS (lpj=7205475)
[   54.494718] Security Framework v1.0.0 initialized
[   54.494724] SELinux:  Disabled at boot.
[   54.494741] Mount-cache hash table entries: 512
[   54.494883] CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e39d 00000000 00000001 00000000
[   54.494890] monitor/mwait feature present.
[   54.494892] using mwait in idle threads.
[   54.494897] CPU: L1 I cache: 32K, L1 D cache: 32K
[   54.494899] CPU: L2 cache: 1024K
[   54.494901] CPU: Physical Processor ID: 0
[   54.494903] CPU: Processor Core ID: 0
[   54.494905] CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e39d 00000000 00000001 00000000
[   54.494914] Compat vDSO mapped to ffffe000.
[   54.494928] Checking 'hlt' instruction... OK.
[   54.511059] SMP alternatives: switching to UP code
[   54.512237] ACPI: Core revision 20070126
[   54.523065] CPU0: Intel Genuine Intel(R) CPU            2160  @ 1.80GHz stepping 02
[   54.523082] SMP alternatives: switching to SMP code
[   54.523574] Booting processor 1/1 eip 2000
[   54.533674] Initializing CPU#1
[   54.610488] Calibrating delay using timer specific routine.. 3599.90 BogoMIPS (lpj=7199803)
[   54.610494] CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e39d 00000000 00000001 00000000
[   54.610499] monitor/mwait feature present.
[   54.610502] CPU: L1 I cache: 32K, L1 D cache: 32K
[   54.610503] CPU: L2 cache: 1024K
[   54.610505] CPU: Physical Processor ID: 0
[   54.610506] CPU: Processor Core ID: 1
[   54.610508] CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e39d 00000000 00000001 00000000
[   54.610961] CPU1: Intel Genuine Intel(R) CPU            2160  @ 1.80GHz stepping 02
[   54.610980] Total of 2 processors activated (7202.63 BogoMIPS).
[   54.611127] ENABLING IO-APIC IRQs
[   54.611300] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   54.758392] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[   54.778376] Brought up 2 CPUs
[   54.778584] Booting paravirtualized kernel on bare hardware
[   54.778702] NET: Registered protocol family 16
[   54.778884] EISA bus registered
[   54.778889] ACPI: bus type pci registered
[   54.778961] PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub with MMCONFIG support.
[   54.778964] PCI: Using MMCONFIG
[   54.779408] Setting up standard PCI resources
[   54.789799] ACPI: EC: Look up EC in DSDT
[   54.794407] ACPI: Interpreter enabled
[   54.794409] ACPI: (supports S0 S5)
[   54.794416] ACPI: Using IOAPIC for interrupt routing
[   54.800415] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   54.800798] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[   54.800802] PCI quirk: region 0480-04bf claimed by ICH6 GPIO
[   54.801307] PCI: Transparent bridge - 0000:00:1e.0
[   54.801341] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   54.801488] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[   54.801567] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[   54.801653] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   54.813217] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   54.813325] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   54.813433] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 *15)
[   54.813539] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 11 12 14 *15)
[   54.813644] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
[   54.813749] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   54.813855] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   54.813961] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 11 12 14 15)
[   54.814085] Linux Plug and Play Support v0.97 (c) Adam Belay
[   54.814113] pnp: PnP ACPI init
[   54.814119] ACPI: bus type pnp registered
[   54.817271] pnp: PnP ACPI: found 14 devices
[   54.817274] ACPI: ACPI bus type pnp unregistered
[   54.817279] PnPBIOS: Disabled by ACPI PNP
[   54.817469] PCI: Using ACPI for IRQ routing
[   54.817472] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   54.838265] NET: Registered protocol family 8
[   54.838268] NET: Registered protocol family 20
[   54.842257] Time: tsc clocksource has been installed.
[   54.854360] pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
[   54.854370] pnp: 00:0c: iomem range 0xe0000000-0xefffffff could not be reserved
[   54.854379] pnp: 00:0d: iomem range 0xcc000-0xcffff has been reserved
[   54.854382] pnp: 00:0d: iomem range 0xd5000-0xd7fff has been reserved
[   54.854386] pnp: 00:0d: iomem range 0xf0000-0xfbfff could not be reserved
[   54.854390] pnp: 00:0d: iomem range 0xfc000-0xfffff could not be reserved
[   54.884718] PCI: Bridge: 0000:00:1c.0
[   54.884721]   IO window: c000-cfff
[   54.884725]   MEM window: fdb00000-fdbfffff
[   54.884728]   PREFETCH window: fde00000-fdefffff
[   54.884734] PCI: Bridge: 0000:00:1c.1
[   54.884736]   IO window: e000-efff
[   54.884740]   MEM window: fdd00000-fddfffff
[   54.884742]   PREFETCH window: fdc00000-fdcfffff
[   54.884747] PCI: Bridge: 0000:00:1e.0
[   54.884749]   IO window: d000-dfff
[   54.884752]   MEM window: fda00000-fdafffff
[   54.884755]   PREFETCH window: fd900000-fd9fffff
[   54.884775] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   54.884780] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   54.884795] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[   54.884799] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   54.884806] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   54.884833] NET: Registered protocol family 2
[   54.930608] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   54.930718] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[   54.931614] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   54.931890] TCP: Hash tables configured (established 131072 bind 65536)
[   54.931893] TCP reno registered
[   54.942784] checking if image is initramfs... it is
[   58.519016] Freeing initrd memory: 43635k freed
[   58.519693] audit: initializing netlink socket (disabled)
[   58.519705] audit(1192795771.980:1): initialized
[   58.519813] highmem bounce pool size: 64 pages
[   58.519892] VFS: Disk quotas dquot_6.5.1
[   58.519901] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   58.519950] io scheduler noop registered
[   58.519952] io scheduler anticipatory registered
[   58.519954] io scheduler deadline registered
[   58.519965] io scheduler cfq registered (default)
[   58.519975] Boot video device is 0000:00:02.0
[   58.520154] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   58.520183] assign_interrupt_mode Found MSI capability
[   58.520210] Allocate Port Service[0000:00:1c.0:pcie00]
[   58.520241] Allocate Port Service[0000:00:1c.0:pcie02]
[   58.520270] Allocate Port Service[0000:00:1c.0:pcie03]
[   58.520333] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   58.520361] assign_interrupt_mode Found MSI capability
[   58.520384] Allocate Port Service[0000:00:1c.1:pcie00]
[   58.520413] Allocate Port Service[0000:00:1c.1:pcie02]
[   58.520447] Allocate Port Service[0000:00:1c.1:pcie03]
[   58.520609] isapnp: Scanning for PnP cards...
[   58.873285] isapnp: No Plug & Play device found
[   58.891771] Real Time Clock Driver v1.12ac
[   58.891867] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   58.891960] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.892115] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   58.892677] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.892875] 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   58.893601] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   58.893686] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   58.893689] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   58.893897] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   58.893899] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[   58.894386] serio: i8042 KBD port at 0x60,0x64 irq 1
[   58.894481] mice: PS/2 mouse device common for all mice
[   58.894599] EISA: Probing bus 0 at eisa.0
[   58.894629] EISA: Detected 0 cards.
[   58.894701] TCP cubic registered
[   58.894709] NET: Registered protocol family 1
[   58.894730] Starting balanced_irq
[   58.894748] Using IPI No-Shortcut mode
[   58.895006] Freeing unused kernel memory: 356k freed
[   58.918633] input: AT Translated Set 2 keyboard as /class/input/input0
[   60.099018] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
[   60.123424] ACPI: Fan [FAN] (on)
[   60.127724] ACPI: SSDT 7F7F84C0, 0087 (r1  PmRef  Cpu1Ist     3000 INTL 20040311)
[   60.127852] ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device is not present [20070126]
[   60.127861] ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device is not present [20070126]
[   60.129285] ACPI: Thermal Zone [THRM] (40 C)
[   60.191118] md: raid0 personality registered for level 0
[   60.657626] usbcore: registered new interface driver usbfs
[   60.657651] usbcore: registered new interface driver hub
[   60.660035] usbcore: registered new device driver usb
[   60.664425] USB Universal Host Controller Interface driver v3.0
[   60.664958] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 18
[   60.664969] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   60.664972] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   60.665189] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   60.665217] uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000fe00
[   60.665397] usb usb1: configuration #1 chosen from 1 choice
[   60.665486] hub 1-0:1.0: USB hub found
[   60.665493] hub 1-0:1.0: 2 ports detected
[   60.670320] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[   60.678729] SCSI subsystem initialized
[   60.687205] libata version 3.00 loaded.
[   60.769357] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   60.769369] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   60.769373] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   60.769400] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   60.769427] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fd00
[   60.769520] usb usb2: configuration #1 chosen from 1 choice
[   60.769544] hub 2-0:1.0: USB hub found
[   60.769549] hub 2-0:1.0: 2 ports detected
[   60.873694] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
[   60.873705] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   60.873708] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   60.873732] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   60.873759] uhci_hcd 0000:00:1d.2: irq 20, io base 0x0000fc00
[   60.873855] usb usb3: configuration #1 chosen from 1 choice
[   60.873878] hub 3-0:1.0: USB hub found
[   60.873884] hub 3-0:1.0: 2 ports detected
[   60.978040] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[   60.978049] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   60.978052] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   60.978075] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[   60.978101] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000fb00
[   60.978193] usb usb4: configuration #1 chosen from 1 choice
[   60.978216] hub 4-0:1.0: USB hub found
[   60.978221] hub 4-0:1.0: 2 ports detected
[   61.083310] sata_sil24 0000:02:00.0: version 1.1
[   61.083334] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   61.083390] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   61.083501] scsi0 : sata_sil24
[   61.083552] scsi1 : sata_sil24
[   61.083579] ata1: SATA max UDMA/100 host m128@0xfddff000 port 0xfddf8000 irq 17
[   61.083583] ata2: SATA max UDMA/100 host m128@0xfddff000 port 0xfddfa000 irq 17
[   61.114298] usb 2-2: new low speed USB device using uhci_hcd and address 2
[   61.283717] usb 2-2: configuration #1 chosen from 1 choice
[   61.523935] usb 3-2: new full speed USB device using uhci_hcd and address 2
[   61.667596] usb 3-2: configuration #1 chosen from 1 choice
[   61.670522] hub 3-2:1.0: USB hub found
[   61.672479] hub 3-2:1.0: 7 ports detected
[   62.025975] usb 4-2: new full speed USB device using uhci_hcd and address 2
[   62.190239] usb 4-2: configuration #1 chosen from 1 choice
[   62.200628] usbcore: registered new interface driver hiddev
[   62.214318] input: USB Optical Mouse as /class/input/input1
[   62.214340] input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:1d.1-2
[   62.214359] usbcore: registered new interface driver usbhid
[   62.214362] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   62.214526] usbcore: registered new interface driver libusual
[   62.221703] Initializing USB Mass Storage driver...
[   62.222276] scsi2 : SCSI emulation for USB Mass Storage devices
[   62.222398] usb-storage: device found at 2
[   62.222400] usb-storage: waiting for device to settle before scanning
[   62.222412] usbcore: registered new interface driver usb-storage
[   62.222415] USB Mass Storage support registered.
[   63.290792] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.291017] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[   63.291277] ata1.00: hard resetting link
[   63.612171] ata1.00: SATA link down (SStatus 0 SControl 10)
[   63.612201] ata1.01: hard resetting link
[   63.933281] ata1.01: SATA link down (SStatus 0 SControl 300)
[   63.933311] ata1.02: hard resetting link
[   64.254393] ata1.02: SATA link down (SStatus 0 SControl 300)
[   64.254423] ata1.03: hard resetting link
[   64.575502] ata1.03: SATA link down (SStatus 0 SControl 300)
[   64.575532] ata1.04: hard resetting link
[   64.896614] ata1.04: SATA link down (SStatus 0 SControl 300)
[   64.896620] ata1.05: hard resetting link
[   65.217724] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   65.217785] ata1: EH complete
[   67.237856] usb-storage: device scan complete
[   67.240852] scsi 2:0:0:0: Direct-Access     Generic  USB SD Reader    1.00 PQ: 0 ANSI: 0
[   67.243849] scsi 2:0:0:1: Direct-Access     Generic  USB CF Reader    1.01 PQ: 0 ANSI: 0
[   67.246844] scsi 2:0:0:2: Direct-Access     Generic  USB SM Reader    1.02 PQ: 0 ANSI: 0
[   67.249838] scsi 2:0:0:3: Direct-Access     Generic  USB MS Reader    1.03 PQ: 0 ANSI: 0
[   67.262882] sd 2:0:0:0: [sda] Attached SCSI removable disk
[   67.267838] sd 2:0:0:1: [sdb] Attached SCSI removable disk
[   67.272833] sd 2:0:0:2: [sdc] Attached SCSI removable disk
[   67.277823] sd 2:0:0:3: [sdd] Attached SCSI removable disk
[   67.282148] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   67.282170] sd 2:0:0:1: Attached scsi generic sg1 type 0
[   67.282191] sd 2:0:0:2: Attached scsi generic sg2 type 0
[   67.282212] sd 2:0:0:3: Attached scsi generic sg3 type 0
[   67.305013] ata2: SATA link down (SStatus 0 SControl 0)
[   67.306812] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 18
[   67.306827] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   67.306831] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   67.306871] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[   67.306900] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   67.306907] ehci_hcd 0000:00:1d.7: irq 18, io mem 0xfdfff000
[   67.310800] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   67.310906] usb usb5: configuration #1 chosen from 1 choice
[   67.310936] hub 5-0:1.0: USB hub found
[   67.310942] hub 5-0:1.0: 8 ports detected
[   67.361248] usb 2-2: USB disconnect, address 2
[   67.413607] 8139cp 0000:03:05.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
[   67.413611] 8139cp 0000:03:05.0: Try the "8139too" driver instead.
[   67.413738] sata_vsc 0000:03:02.0: version 2.3
[   67.413785] ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 19 (level, low) -> IRQ 19
[   67.413894] scsi3 : sata_vsc
[   67.413938] scsi4 : sata_vsc
[   67.413973] scsi5 : sata_vsc
[   67.414007] scsi6 : sata_vsc
[   67.414032] ata3: SATA max UDMA/133 mmio m4096@0xfdaff000 port 0xfdaff200 irq 221
[   67.414035] ata4: SATA max UDMA/133 mmio m4096@0xfdaff000 port 0xfdaff400 irq 221
[   67.414038] ata5: SATA max UDMA/133 mmio m4096@0xfdaff000 port 0xfdaff600 irq 221
[   67.414041] ata6: SATA max UDMA/133 mmio m4096@0xfdaff000 port 0xfdaff800 irq 221
[   67.416191] 8139too Fast Ethernet driver 0.9.28
[   67.489594] usb 3-2: USB disconnect, address 2
[   67.617917] usb 4-2: USB disconnect, address 2
[   67.882933] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   67.899360] ata3.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   67.899365] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   67.915518] ata3.00: configured for UDMA/133
[   68.171839] usb 5-6: new high speed USB device using ehci_hcd and address 3
[   68.304685] usb 5-6: configuration #1 chosen from 1 choice
[   68.304855] hub 5-6:1.0: USB hub found
[   68.304954] hub 5-6:1.0: 7 ports detected
[   68.384571] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   68.403821] ata4.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   68.403825] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   68.417142] ata4.00: configured for UDMA/133
[   68.649509] usb 5-8: new high speed USB device using ehci_hcd and address 4
[   68.784263] usb 5-8: configuration #1 chosen from 1 choice
[   68.784514] scsi7 : SCSI emulation for USB Mass Storage devices
[   68.784683] usb-storage: device found at 4
[   68.784684] usb-storage: waiting for device to settle before scanning
[   68.886365] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   68.903307] ata5.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   68.903311] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   68.919085] ata5.00: configured for UDMA/133
[   69.022882] usb 2-2: new low speed USB device using uhci_hcd and address 3
[   69.191697] usb 2-2: configuration #1 chosen from 1 choice
[   69.207816] input: USB Optical Mouse as /class/input/input2
[   69.207839] input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:1d.1-2
[   69.388476] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   69.397769] ata6.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
[   69.397773] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   69.413995] ata6.00: configured for UDMA/133
[   69.414128] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[   69.414223] sd 3:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   69.414234] sd 3:0:0:0: [sda] Write Protect is off
[   69.414236] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   69.414251] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.414303] sd 3:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   69.414312] sd 3:0:0:0: [sda] Write Protect is off
[   69.414314] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   69.414329] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.414333]  sda: unknown partition table
[   69.423643] sd 3:0:0:0: [sda] Attached SCSI disk
[   69.423699] sd 3:0:0:0: Attached scsi generic sg0 type 0
[   69.423827] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[   69.423883] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
[   69.423894] sd 4:0:0:0: [sdb] Write Protect is off
[   69.423896] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   69.423911] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.423953] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
[   69.423963] sd 4:0:0:0: [sdb] Write Protect is off
[   69.423965] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   69.423980] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.423982]  sdb: [mac] sdb1 sdb2 sdb3 sdb4
[   69.428611] sd 4:0:0:0: [sdb] Attached SCSI disk
[   69.428659] sd 4:0:0:0: Attached scsi generic sg1 type 0
[   69.428813] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[   69.428881] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[   69.428891] sd 5:0:0:0: [sdc] Write Protect is off
[   69.428893] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   69.428908] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.428947] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[   69.428958] sd 5:0:0:0: [sdc] Write Protect is off
[   69.428960] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   69.428975] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   69.428978]  sdc: [mac] sdc1 sdc2 sdc3 sdc4
[   69.437238] sd 5:0:0:0: [sdc] Attached SCSI disk
[   69.437290] sd 5:0:0:0: Attached scsi generic sg2 type 0
[   69.437414] scsi 6:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
[   69.437488] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
[   69.437497] sd 6:0:0:0: [sdd] Write Protect is off
[   69.437499] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   69.437514] sd 6:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   69.437551] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
[   69.437560] sd 6:0:0:0: [sdd] Write Protect is off
[   69.437562] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   69.437577] sd 6:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   69.437579]  sdd: unknown partition table
[   69.451004] sd 6:0:0:0: [sdd] Attached SCSI disk
[   69.451052] sd 6:0:0:0: Attached scsi generic sg3 type 0
[   69.451338] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 20
[   69.451371] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   69.451374] ata4294967295: failed to start port (errno=-19)
[   69.451382] ACPI: PCI interrupt for device 0000:00:1f.1 disabled
[   69.451409] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   69.451425] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   69.451428] ata4294967295: failed to start port (errno=-19)
[   69.451434] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[   69.453994] ata_piix 0000:00:1f.1: version 2.12
[   69.454011] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 20
[   69.454042] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   69.454092] scsi8 : ata_piix
[   69.454139] scsi9 : ata_piix
[   69.454235] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
[   69.454238] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
[   69.634351] md: md0 stopped.
[   69.773125] ata7.00: ATAPI: HL-DT-ST DVDRAM GSA-H40N, RG01, max UDMA/66
[   69.792256] md: bind<sdb>
[   69.792495] md: bind<sdc>
[   69.792652] md: bind<sdd>
[   69.792882] md: bind<sda>
[   69.800271] md0: setting max_sectors to 128, segment boundary to 32767
[   69.800275] raid0: looking at sda
[   69.800277] raid0:   comparing sda(488386496) with sda(488386496)
[   69.800279] raid0:   END
[   69.800280] raid0:   ==> UNIQUE
[   69.800281] raid0: 1 zones
[   69.800283] raid0: looking at sdd
[   69.800284] raid0:   comparing sdd(488386496) with sda(488386496)
[   69.800286] raid0:   EQUAL
[   69.800288] raid0: looking at sdc
[   69.800289] raid0:   comparing sdc(488386496) with sda(488386496)
[   69.800291] raid0:   EQUAL
[   69.800293] raid0: looking at sdb
[   69.800294] raid0:   comparing sdb(488386496) with sda(488386496)
[   69.800296] raid0:   EQUAL
[   69.800297] raid0: FINAL 1 zones
[   69.800301] raid0: done.
[   69.800302] raid0 : md_size is 1953545984 blocks.
[   69.800304] raid0 : conf->hash_spacing is 1953545984 blocks.
[   69.800305] raid0 : nb_zone is 1.
[   69.800307] raid0 : Allocating 4 bytes for hash.
[   69.945373] ata7.00: configured for UDMA/66
[   69.945410] ata8: port disabled. ignoring.
[   69.948915] scsi 8:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H40N  RG01 PQ: 0 ANSI: 5
[   69.949013] scsi 8:0:0:0: Attached scsi generic sg4 type 5
[   69.949066] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   69.949099] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   69.949133] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   69.949250] scsi10 : ata_piix
[   69.949298] scsi11 : ata_piix
[   69.949417] ata9: SATA max UDMA/133 cmd 0xf900 ctl 0xf800 bmdma 0xf500 irq 19
[   69.949421] ata10: SATA max UDMA/133 cmd 0xf700 ctl 0xf600 bmdma 0xf508 irq 19
[   70.114360] ata9.00: ATA-7: Hitachi HDT725040VLA380, V5COA52A, max UDMA/133
[   70.114365] ata9.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   70.130427] ata9.00: configured for UDMA/133
[   70.335587] ata10.00: ATA-7: ST3750640AS, 3.AAK, max UDMA/133
[   70.335592] ata10.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   70.402114] ata10.00: configured for UDMA/133
[   70.402267] scsi 10:0:0:0: Direct-Access     ATA      Hitachi HDT72504 V5CO PQ: 0 ANSI: 5
[   70.402364] sd 10:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[   70.402376] sd 10:0:0:0: [sde] Write Protect is off
[   70.402378] sd 10:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.402394] sd 10:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.402448] sd 10:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[   70.402457] sd 10:0:0:0: [sde] Write Protect is off
[   70.402459] sd 10:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.402475] sd 10:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.402479]  sde: sde1 sde2 < sde5 >
[   70.430148] sd 10:0:0:0: [sde] Attached SCSI disk
[   70.430205] sd 10:0:0:0: Attached scsi generic sg5 type 0
[   70.430308] scsi 11:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   70.430364] sd 11:0:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
[   70.430374] sd 11:0:0:0: [sdf] Write Protect is off
[   70.430376] sd 11:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.430392] sd 11:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.430431] sd 11:0:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
[   70.430442] sd 11:0:0:0: [sdf] Write Protect is off
[   70.430444] sd 11:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.430459] sd 11:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.430461]  sdf: sdf1
[   70.450086] sd 11:0:0:0: [sdf] Attached SCSI disk
[   70.450134] sd 11:0:0:0: Attached scsi generic sg6 type 0
[   70.450387] ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 20 (level, low) -> IRQ 21
[   70.450846] eth0: RealTek RTL8139 at 0xf8882000, 00:19:21:fe:57:62, IRQ 21
[   70.450849] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[   70.489310] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   70.489316] Uniform CD-ROM driver Revision: 3.20
[   70.489394] sr 8:0:0:0: Attached scsi CD-ROM sr0
[   70.647925] kjournald starting.  Commit interval 5 seconds
[   70.647941] EXT3-fs: mounted filesystem with ordered data mode.
[   73.809300] usb-storage: device scan complete
[   73.809911] scsi 7:0:0:0: Direct-Access     Generic  USB SD Reader    1.00 PQ: 0 ANSI: 0
[   73.810540] scsi 7:0:0:1: Direct-Access     Generic  USB CF Reader    1.01 PQ: 0 ANSI: 0
[   73.811163] scsi 7:0:0:2: Direct-Access     Generic  USB SM Reader    1.02 PQ: 0 ANSI: 0
[   73.811787] scsi 7:0:0:3: Direct-Access     Generic  USB MS Reader    1.03 PQ: 0 ANSI: 0
[   73.812941] sd 7:0:0:0: [sdg] Attached SCSI removable disk
[   73.812997] sd 7:0:0:0: Attached scsi generic sg7 type 0
[   73.813936] sd 7:0:0:1: [sdh] Attached SCSI removable disk
[   73.813982] sd 7:0:0:1: Attached scsi generic sg8 type 0
[   73.814936] sd 7:0:0:2: [sdi] Attached SCSI removable disk
[   73.814981] sd 7:0:0:2: Attached scsi generic sg9 type 0
[   73.815932] sd 7:0:0:3: [sdj] Attached SCSI removable disk
[   73.815978] sd 7:0:0:3: Attached scsi generic sg10 type 0
[   77.049455] usb_id[3966]: segfault at 00000000 eip b7e82648 esp bfec70b0 error 4
[   77.806953] input: PC Speaker as /class/input/input3
[   77.947634] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   77.998519] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   78.065394] intel_rng: FWH not detected
[   78.126011] iTCO_vendor_support: vendor-support=0
[   78.134360] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
[   78.134428] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0460)
[   78.134457] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   78.160838] Linux agpgart interface v0.102
[   78.265578] input: Power Button (FF) as /class/input/input4
[   78.265617] ACPI: Power Button (FF) [PWRF]
[   78.265677] input: Power Button (CM) as /class/input/input5
[   78.265705] ACPI: Power Button (CM) [PWRB]
[   78.314531] agpgart: Detected an Intel 945G Chipset.
[   78.315067] agpgart: Detected 7932K stolen memory.
[   78.429935] agpgart: AGP aperture is 256M @ 0xd0000000
[   78.582365] parport_pc 00:08: reported by Plug and Play ACPI
[   78.582410] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   78.741130] usb_id[4833]: segfault at 00000000 eip b7da5648 esp bfdf3fd0 error 4
[   78.756253] usb_id[4835]: segfault at 00000000 eip b7e85648 esp bfe6d050 error 4
[   79.156954] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
[   79.156977] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   79.188477] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[   79.510939] fuse init (API version 7.8)
[   79.529177] lp0: using parport0 (interrupt-driven).
[   79.593462] Adding 6056464k swap on /dev/sde5.  Priority:-1 extents:1 across:6056464k
[   79.839283] EXT3 FS on sde1, internal journal
[   80.319345] JFS: nTxBlock = 8192, nTxLock = 65536
[   83.248565] No dock devices found.
[   83.257485] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   85.125614] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   85.901898] [drm] Initialized drm 1.1.0 20060810
[   85.917287] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   85.917350] [drm] Initialized i915 1.6.0 20060119 on minor 0
[   86.598493] NET: Registered protocol family 10
[   86.598566] lo: Disabled Privacy Extensions
[   87.683413] ppdev: user-space parallel port driver
[   92.321154] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   92.625203] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   92.642819] NFSD: starting 90-second grace period
[   95.023094] Capability LSM initialized
[   96.264445] Bluetooth: Core ver 2.11
[   96.264512] NET: Registered protocol family 31
[   96.264516] Bluetooth: HCI device and connection manager initialized
[   96.264521] Bluetooth: HCI socket layer initialized
[   96.410973] Bluetooth: L2CAP ver 2.8
[   96.410980] Bluetooth: L2CAP socket layer initialized
[   96.624179] Bluetooth: RFCOMM socket layer initialized
[   96.624196] Bluetooth: RFCOMM TTY layer initialized
[   96.624198] Bluetooth: RFCOMM ver 1.8
[  101.719485] NET: Registered protocol family 17
[  115.323943] eth0: no IPv6 routers present

--Boundary-00=_O8TGHzVkEBd5Un1--
