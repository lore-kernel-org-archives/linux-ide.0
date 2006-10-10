From: Oleg Verych <olecom@flower.upol.cz>
Subject: [BUG] .17-.19-rc1 fails to detect PIONEER DVD-RW DVR-K15, .16 works fine
Date: Tue, 10 Oct 2006 14:17:57 +0000 (UTC)
Message-ID: <slrneinauu.3nd.olecom@deen.upol.cz.local>
Reply-To: Georg Wittenburg <georg.wittenburg@gmx.net>,
	   Oleg Verych <olecom@flower.upol.cz>,
	   "no PIONEER DVD-Drive above .16" <390541@bugs.debian.org>,
	   Linux IDE Mailing List <linux-ide@vger.kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965098AbWJJSf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Oct 2006 14:35:28 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GXMRT-0006OE-33
	for linux-ide@vger.kernel.org; Tue, 10 Oct 2006 20:35:03 +0200
Received: from 158.194.180.30 ([158.194.180.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 10 Oct 2006 20:35:03 +0200
Received: from georg.wittenburg by 158.194.180.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 10 Oct 2006 20:35:03 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hallo.

It was asked to test 2.6.19-rc1, but test was with no luck. Maybe
someone will have a clue before git bisect.

Bug's thread with more logs is here:
<http://permalink.gmane.org/gmane.linux.debian.devel.kernel/22903>

Thanks.

On Sun, Oct 08, 2006 at 05:26:51PM +0200, Georg Wittenburg wrote:
> Hi Oleg
> 
> Sorry for taking so long to reply.
> 
> On Thursday 05 October 2006 06:55, you wrote:
> > On Tue, Oct 03, 2006 at 04:30:13PM +0200, Georg Wittenburg wrote:
> > > On Tuesday 03 October 2006 16:24, you wrote:
> > > > On 2006-10-02, Georg Wittenburg <georg.wittenburg@gmx.net> wrote:
> >
> > [.]
> >
> > > > Please don't be so selfish ;), attach full bootlog (dmesg + mount
> > > > output). Here i see hdb, that means device node for your drive set up.
> > > > What's problem, is not clear.
> >
> > [.]
> >
> > > No problem. ;) Please find attached to complete dmesg output of 2.6.16,
> > > 2.6.17 and 2.6.18. 2.6.16 works as expected, 2.6.17 and 2.6.18 fail to
> > > detect the DVD drive.
> >
> > OK, but before will go further with this, can you give 2.6.19-rc1 a try ?
> > 2.6.18 had very long cycle, maybe that was fixed already.
> 
> I tried 2.6.19-rc1 with Debian's /boot/config-2.6.18-1-686 and default values 
> for all new options. Unfortunately, even 2.6.19-rc1 fails to detect the DVD 
> drive. I'm attaching the dmesg output to this mail.
 
CPU: 

> georg@vaio:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 13
> model name      : Intel(R) Pentium(R) M processor 1.86GHz
> stepping        : 8
> cpu MHz         : 800.000
> cache size      : 2048 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
> bogomips        : 1599.97

dmesg:

> Linux version 2.6.19-rc1 (root@vaio) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 SMP Sun Oct 8 16:19:23 CEST 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
>  BIOS-e820: 000000003fee0000 - 000000003feea000 (ACPI data)
>  BIOS-e820: 000000003feea000 - 000000003ff00000 (ACPI NVS)
>  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
>  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
>  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
>  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> 126MB HIGHMEM available.
> 896MB LOWMEM available.
> Entering add_active_range(0, 0, 261856) 0 entries of 256 used
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->   229376
>   HighMem    229376 ->   261856
> early_node_map[1] active PFN ranges
>     0:        0 ->   261856
> On node 0 totalpages: 261856
>   DMA zone: 32 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 4064 pages, LIFO batch:0
>   Normal zone: 1760 pages used for memmap
>   Normal zone: 223520 pages, LIFO batch:31
>   HighMem zone: 253 pages used for memmap
>   HighMem zone: 32227 pages, LIFO batch:7
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7520
> ACPI: RSDT (v001   Sony       J1 0x20060605 PTL  0x00000000) @ 0x3fee5890
> ACPI: MADT (v001   Sony       J1 0x20060605 PTL  0x0000005f) @ 0x3fee9e78
> ACPI: FADT (v002   Sony       J1 0x20060605 PTL  0x0000005f) @ 0x3fee9ee0
> ACPI: BOOT (v001   Sony       J1 0x20060605 PTL  0x00000001) @ 0x3fee9fd8
> ACPI: MCFG (v001   Sony       J1 0x20060605 PTL  0x0000005f) @ 0x3fee9f9c
> ACPI: SSDT (v001   Sony       J1 0x20060605 PTL  0x20030224) @ 0x3fee614d
> ACPI: SSDT (v001   Sony       J1 0x20060605 PTL  0x20030224) @ 0x3fee5d08
> ACPI: SSDT (v001   Sony       J1 0x20060605 PTL  0x20030224) @ 0x3fee5aed
> ACPI: SSDT (v001   Sony       J1 0x20060605 PTL  0x20030224) @ 0x3fee58d4
> ACPI: DSDT (v001   Sony       J1 0x20060605 PTL  0x20030224) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:13 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
> Detected 1862.385 MHz processor.
> Built 1 zonelists.  Total pages: 259811
> Kernel command line: root=/dev/hda6 ro vga=791 resume2=swap:/dev/hda5
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1030552k/1047424k available (1566k kernel code, 16180k reserved, 591k data, 192k init, 129920k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
>     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
>     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
>       .init : 0xc0321000 - 0xc0351000   ( 192 kB)
>       .data : 0xc028794e - 0xc031b894   ( 591 kB)
>       .text : 0xc0100000 - 0xc028794e   (1566 kB)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 3728.40 BogoMIPS (lpj=7456816)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Capability LSM initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 2048K
> CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> Freeing SMP alternatives: 12k freed
> ACPI: Core revision 20060707
> CPU0: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
> Total of 1 processors activated (3728.40 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> Brought up 1 CPUs
> checking if image is initramfs... it is
> Freeing initrd memory: 4493k freed
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using MMCONFIG
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH6 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> Boot video device is 0000:01:00.0
> PCI: Firmware left 0000:06:08.0 e100 interrupts enabled, disabling
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
> ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 *4 5 6 7 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
> ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 *7 10 12 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
> ACPI: Embedded Controller [EC] (gpe 23) interrupt mode.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 8 devices
> PnPBIOS: Disabled by ACPI PNP
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Bridge: 0000:00:01.0
>   IO window: disabled.
>   MEM window: 90000000-afffffff
>   PREFETCH window: c0000000-cfffffff
> PCI: Bus 7, cardbus bridge: 0000:06:03.0
>   IO window: 00002400-000024ff
>   IO window: 00002800-000028ff
>   PREFETCH window: 50000000-51ffffff
>   MEM window: 52000000-53ffffff
> PCI: Bridge: 0000:00:1e.0
>   IO window: 2000-2fff
>   MEM window: b0000000-b00fffff
>   PREFETCH window: 50000000-51ffffff
> ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> PCI: Enabling device 0000:06:03.0 (0000 -> 0003)
> ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> Simple Boot Flag at 0x36 set to 0x1
> audit: initializing netlink socket (disabled)
> audit(1160327549.980:1): initialized
> highmem bounce pool size: 64 pages
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:01.0:pcie00]
> Allocate Port Service[0000:00:01.0:pcie03]
> vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 3072k, total 32768k
> vesafb: mode is 1024x768x16, linelength=2048, pages=1
> vesafb: protected mode interface info at c000:d360
> vesafb: pmi: set display start = c00cd396, set palette = c00cd400
> vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> Console: switching to colour frame buffer device 128x48
> fb0: VESA VGA frame buffer device
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> Using IPI No-Shortcut mode
> ACPI: (supports S0 S3 S4<6>Time: tsc clocksource has been installed.
>  S5)
> Freeing unused kernel memory: 192k freed
> input: AT Translated Set 2 keyboard as /class/input/input0
> ACPI: CPU0 (power states: C1[C1] C2[C2])
> ACPI: Processor [CPU0] (supports 8 throttling states)
> ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
> ACPI: Getting cpuindex for acpiid 0x1
> ACPI: Thermal Zone [THRM] (68 C)
> e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
> e100: Copyright(c) 1999-2006 Intel Corporation
> ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 20 (level, low) -> IRQ 17
> e100: eth0: e100_probe: addr 0xb0007000, irq 17, MAC addr 00:01:4A:5E:E3:1D
> ieee1394: Initialized config rom entry `ip1394'
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH6: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ICH6: chipset revision 3
> ICH6: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:DMA, hdb:DMA
> Probing IDE interface ide0...
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> USB Universal Host Controller Interface driver v3.0
> Time: acpi_pm clocksource has been installed.
> hda: TOSHIBA MK1031GAS, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ACPI: PCI Interrupt 0000:06:03.2[C] -> GSI 18 (level, low) -> IRQ 18
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[b0004000-b00047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:1d.7: debug port 1
> PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: irq 19, io mem 0x80004000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> hda: max request size: 512KiB
> hda: 195371568 sectors (100030 MB), CHS=16383/255/63, UDMA(100)
> hda: cache flushes supported
>  hda:<6>ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:1d.0: irq 19, io base 0x00001800
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
>  hda1 hda2 < hda5 hda6 hda7 >
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1d.1 to 64
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001820
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ohci1394: fw-host0: Running dma failed because Node ID is not valid
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-1: new high speed USB device using ehci_hcd and address 2
> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1d.3 to 64
> uhci_hcd 0000:00:1d.3: UHCI Host Controller
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
> uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> usb 1-1: configuration #1 chosen from 1 choice
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
> ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> Attempting manual resume
> kjournald starting.  Commit interval 5 seconds
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301e35f41]
> EXT3-fs: mounted filesystem with ordered data mode.
> usb 3-1: new low speed USB device using uhci_hcd and address 2
> usb 3-1: configuration #1 chosen from 1 choice
> usb 1-1.4: new high speed USB device using ehci_hcd and address 4
> usb 1-1.4: configuration #1 chosen from 1 choice
> hub 1-1.4:1.0: USB hub found
> hub 1-1.4:1.0: 4 ports detected
> usb 1-1.4.1: new high speed USB device using ehci_hcd and address 5
> usb 1-1.4.1: configuration #1 chosen from 1 choice
> usb 1-1.4.4: new full speed USB device using ehci_hcd and address 6
> usb 1-1.4.4: configuration #1 chosen from 1 choice
> Yenta: CardBus bridge found at 0000:06:03.0 [104d:818f]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:06:03.0, mfunc 0x01001b22, devctl 0x64
> Linux agpgart interface v0.101 (c) Dave Jones
> agpgart: Detected an Intel 915GM Chipset.
> agpgart: AGP aperture is 256M @ 0x0
> Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
> Socket status: 30000006
> Yenta: Raising subordinate bus# of parent bus (#06) from #07 to #0a
> pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
> cs: IO port probe 0x2000-0x2fff: clean.
> pcmcia: parent PCI bridge Memory window: 0xb0000000 - 0xb00fffff
> pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
> Real Time Clock Driver v1.12ac
> input: PC Speaker as /class/input/input1
> input: PS/2 Mouse as /class/input/input2
> intel_rng: FWH not detected
> input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
> eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> Bluetooth: Core ver 2.10
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> usbcore: registered new interface driver hiddev
> ieee80211_crypt: registered algorithm 'NULL'
> ieee80211: 802.11 data/management/control stack, git-1.1.13
> ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> input: Logitech Optical USB Mouse as /class/input/input4
> input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.1-1
> usbcore: registered new interface driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 20
> Bluetooth: HCI USB driver ver 2.9
> ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kmq
> ipw2200: Copyright(c) 2003-2006 Intel Corporation
> ACPI: PCI Interrupt 0000:06:04.0[A] -> GSI 22 (level, low) -> IRQ 21
> ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
> usbcore: registered new interface driver hci_usb
> cs: IO port probe 0x100-0x3af: clean.
> cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
> usbcore: registered new interface driver snd-usb-audio
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> Adding 1959888k swap on /dev/hda5.  Priority:-1 extents:1 across:1959888k
> EXT3 FS on hda6, internal journal
> device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
> pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
> pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
> ACPI: Battery Slot [BAT0] (battery absent)
> ACPI: AC Adapter [ADP1] (on-line)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID0]
> ACPI: Power Button (CM) [PWRB]
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> lp: driver loaded but no devices found
> ppdev: user-space parallel port driver
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> ADDRCONF(NETDEV_UP): wlan0: link is not ready
> IPv6 over IPv4 tunneling driver
> sonypi: Sony Programmable I/O Controller Driver v1.26.
> sonypi: detected type3 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
> sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
> sonypi: device allocated minor is 62
> input: Sony Vaio Jogdial as /class/input/input5
> input: Sony Vaio Keys as /class/input/input6
> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 657)
> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 659)
> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 646)
> Bluetooth: L2CAP ver 2.8
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.8

