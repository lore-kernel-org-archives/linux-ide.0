From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 21 Feb 2007 16:41:50 -0800
Message-ID: <20070222004150.GC6129@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <20070217003454.GA25571@us.ibm.com> <45DC3DAA.2080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59096 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728AbXBVAlx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 19:41:53 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l1M0f4wO009678
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 19:41:04 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1M0fr1T518986
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 17:41:53 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1M0fqv1007790
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 17:41:52 -0700
Content-Disposition: inline
In-Reply-To: <45DC3DAA.2080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

Hi Tejun,
Thanks for the help.

On Wed, Feb 21, 2007 at 09:40:10PM +0900, Tejun Heo wrote:
> Hello, Gary.
> 
> Gary Hade wrote:
> > I instrumented the code and found that for the SATA hard drive BSY was set 
> > just before the call to ahci_init_port() from ahci_port_start() and clear 
> > after the return from ahci_init_port().  For the GoVault BSY was still set 
> > after the return from ahci_init_port() and remained set for almost 2 seconds.
> > 
> > The below patch which gives BSY some extra time to clear repairs the problem.  
> > Unlike the extra delay for ata-piix needed by GoVault I believe this delay 
> > will only be seen for attached devices that need it.  Please let me know 
> > what you think.
> 
> Can you post full dmesg without the patch?  

Included below.

> And which controller are you using (lspci -nn please)?  

[root@elm3a114 ~]# lspci -s 00:1f.2
00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)
[root@elm3a114 ~]# lspci -s 00:1f.2 -nn
00:1f.2 0101: 8086:2652 (rev 03)
[root@elm3a114 ~]# lspci -s 00:1f.2 -nvv
00:1f.2 0101: 8086:2652 (rev 03) (prog-if 8f)
        Subsystem: 1014:2652
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 20c0 [size=8]
        Region 1: I/O ports at 20b8 [size=4]
        Region 2: I/O ports at 20b0 [size=8]
        Region 3: I/O ports at 20a4 [size=4]
        Region 4: I/O ports at 2090 [size=16]
        Region 5: Memory at d8500c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> How come it doesn't support CLO?

I don't know.

> 
> I don't think the patch is a good idea.  

No problem.  I asked for your opinion. :)

> !BSY wait before reset is
> supposed to be done in ->prereset() if possible.  ahci skips that step
> because waiting for !BSY isn't reliable after hotplug and it often
> wastes 30secs for no good reason after an hotplug event.
> 
> Even if you need to add that specific shorter wait, the correct place
> would be ->prereset() not at the end of ->port_start().

Yea, I did see that wait for !BSY in ata_std_prereset() and remember
wondering why it was turned off for ahci where it would have nicely
solved the problem.  I actually considered inserting the short wait 
there (i.e. the change you suggest below) but since the problem 
appeared to happen only during initialization I thought it might be
better to put it in a less frequently visited ahci-only place.

> 
> I don't think fixing here and there for GoVault drive is a good idea.
> It's not gonna be tested widely and GoValut would end up working on some
> controllers while broken on others.  I think recently posted EH
> improvements and faster reset patches should help here.  The first reset
> will fail timely and all in all the drive should be detected in slightly
> over ten secs, which isn't that bad and actually is okay if parallel
> probing is implemented.

I could give them a try but it seems unlikely that they will show 
up in all of the soon to be released Distro updates we're worried 
about.

> 
> I dunno.  Maybe the correct thing to do is wait briefly for !BSY in
> std_prereset() when SKIP_D2H_BSY is set.  

This definitely works for me if the other information I included 
in this message doesn't change your mind.

> What status value does the
> controller report in that state - 0x80 or 0xff?

0x80

I believe I tried with GoVault attached to each of the 4 ports 
and always saw 0x80.  Below is my ugly 2.6.20-rc6 debug output 
(hard drive on ata2, GoVault on ata3) that may be of interest.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

========================
2.6.20-rc7 dmesg - start
========================
Linux version 2.6.20-rc7 (root@elm3a114.beaverton.ibm.com) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #1 SMP Fri Feb 16 09:54:30 PST 2007
Command line: ro root=LABEL=/
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fef6000 (ACPI data)
 BIOS-e820: 000000003fef6000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 155) 0 entries of 3200 used
Entering add_active_range(0, 256, 261872) 1 entries of 3200 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f6e60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000003fef024b
ACPI: FADT (v001 INTEL           0x06040000 PTL  0x00000003) @ 0x000000003fef5de7
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x000000003fef5e5b
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000003fef5eab
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x000000003fef5f05
ACPI: ASF! (v032    MBI          0x06040000  0x00000000) @ 0x000000003fef5f2d
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x000000003fef5fc4
ACPI: DSDT (v001    IBM FIREBIRD 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000003fef0000
Entering add_active_range(0, 0, 155) 0 entries of 3200 used
Entering add_active_range(0, 256, 261872) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003fef0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      155
    0:      256 ->   261872
On node 0 totalpages: 261771
  DMA zone: 56 pages used for memmap
  DMA zone: 9 pages reserved
  DMA zone: 3930 pages, LIFO batch:0
  DMA32 zone: 3524 pages used for memmap
  DMA32 zone: 254252 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009b000 - 000000000009c000
Nosave address range: 000000000009c000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e4000
Nosave address range: 00000000000e4000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
PERCPU: Allocating 67840 bytes of per cpu data
Built 1 zonelists.  Total pages: 258182
Kernel command line: ro root=LABEL=/
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1021828k/1047488k available (2377k kernel code, 25256k reserved, 1284k data, 332k init)
Calibrating delay using timer specific routine.. 7185.52 BogoMIPS (lpj=3592761)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Hyper-Threading is disabled
CPU0: Thermal monitoring handled by SMI
SMP alternatives: switching to UP code
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12468941
Detected 12.468 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 3591.068 MHz processor.
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: d8100000-d81fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: d8000000-d80fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: d8200000-d82fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Enabling device 0000:00:1e.0 (0144 -> 0146)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1538k freed
Simple Boot Flag at 0x36 set to 0x1
audit: initializing netlink socket (disabled)
audit(1172091506.301:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: HL-DT-ST GCE-8483B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 332k freed
Write protecting the kernel read-only data: 723k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002020
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00002040
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd8500000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
input: PS/2 Generic Mouse as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: PORTS_IMPL is zero, forcing 0xf
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC2000001CD00 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xFFFFC2000001CD80 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xFFFFC2000001CE00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xFFFFC2000001CE80 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 156312576 sectors: LBA 
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATAPI, max UDMA/66
ata3.00: configured for UDMA/66
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 >
sd 1:0:0:0: Attached scsi disk sda
scsi 2:0:0:0: Direct-Access     IBM      GoVault          0096 PQ: 0 ANSI: 5
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
sdb: cache data unavailable
sdb: assuming drive cache: write through
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
sdb: cache data unavailable
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 2:0:0:0: Attached scsi removable disk sdb
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1172091564.004:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1587 types, 172 bools, 1 sens, 1024 cats
security:  59 classes, 49762 rules
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda8, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1172091564.636:3): policy loaded auid=4294967295
tg3.c:v3.72 (January 8, 2007)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95721) rev 4100 PHY(5750)] (PCI Express) 10/100/1000Base-T Ethernet 00:0d:60:b7:76:b3
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
input: PC Speaker as /class/input/input2
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
intel_rng: FWH not detected
hda: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sd 1:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
PCI: Enabling device 0000:00:1e.2 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 50307 usecs
intel8x0: clocking to 48000
FDC 0 is a National Semiconductor PC87306
lp0: using parport0 (interrupt-driven).
lp0: console ready
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EXT3 FS on sda8, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev sda1, type ext2), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda2, type ext3), uses xattr
Adding 1028120k swap on /dev/sda12.  Priority:-1 extents:1 across:1028120k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.retrans_time; Use net.ipv6.neigh.lo.retrans_time_ms instead.
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
audit(1172091587.001:4): audit_pid=2126 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.25.0 20060524 on minor 0
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
========================
2.6.20-rc7 dmesg - end
========================

===============================
2.6.20-rc6 debug output - start
===============================
                 ...
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: PORTS_IMPL is zero, forcing 0xf
XXX - ~PORT_CMD_FIS_RX in ahci_stop_fix_rx
XXX - ~PORT_CMD_FIS_RX in ahci_stop_fix_rx
XXX - ~PORT_CMD_FIS_RX in ahci_stop_fix_rx
XXX - ~PORT_CMD_FIS_RX in ahci_stop_fix_rx
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part 
ata1: XXX - in ata_device_add before port_start
ata1: XXX entering ahci_port_start status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
ata1: XXX in ahci_port_start before ahci_power_up status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_ICC_ACTIVE in ahci_power_up
ata1: XXX in ahci_port_start after ahci_power_up status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_FIS_RX in ahci_start_fis_rx
ata1: XXX in ahci_init_port after ahci_start_fis_rx status=0x7f BSY=0 DRQ=1 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata1: XXX in ahci_init_port after ahci_start_engine status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX in ahci_port_start after ahci_init_port status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX - in ata_device_add after port_start
ata1: SATA max UDMA/133 cmd 0xFFFFC2000001CD00 ctl 0x0 bmdma 0x0 irq 19
ata1: XXX in ahci_freeze before turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX in ahci_freeze after turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX ata_device_add after ata_eh_freeze_port: status=0x7f BSY=0 DRQ=1
ata2: XXX - in ata_device_add before port_start
ata2: XXX entering ahci_port_start status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
ata2: XXX in ahci_port_start before ahci_power_up status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_ICC_ACTIVE in ahci_power_up
ata2: XXX in ahci_port_start after ahci_power_up status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_FIS_RX in ahci_start_fis_rx
ata2: XXX in ahci_init_port after ahci_start_fis_rx status=0x50 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata2: XXX in ahci_init_port after ahci_start_engine status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX in ahci_port_start after ahci_init_port status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX - in ata_device_add after port_start
ata2: SATA max UDMA/133 cmd 0xFFFFC2000001CD80 ctl 0x0 bmdma 0x0 irq 19
ata2: XXX in ahci_freeze before turn IRQ off status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX in ahci_freeze after turn IRQ off status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX ata_device_add after ata_eh_freeze_port: status=0x50 BSY=0 DRQ=0
ata3: XXX - in ata_device_add before port_start
ata3: XXX entering ahci_port_start status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
ata3: XXX in ahci_port_start before ahci_power_up status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_ICC_ACTIVE in ahci_power_up
ata3: XXX in ahci_port_start after ahci_power_up status=0x80 BSY=1 DRQ=0 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_FIS_RX in ahci_start_fis_rx
ata3: XXX in ahci_init_port after ahci_start_fis_rx status=0x80 BSY=1 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: XXX in ahci_init_port after ahci_start_engine status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX in ahci_port_start after ahci_init_port status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX - in ata_device_add after port_start
ata3: SATA max UDMA/133 cmd 0xFFFFC2000001CE00 ctl 0x0 bmdma 0x0 irq 19
ata3: XXX in ahci_freeze before turn IRQ off status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX in ahci_freeze after turn IRQ off status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX ata_device_add after ata_eh_freeze_port: status=0x80 BSY=1 DRQ=0
ata4: XXX - in ata_device_add before port_start
ata4: XXX entering ahci_port_start status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
ata4: XXX in ahci_port_start before ahci_power_up status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_ICC_ACTIVE in ahci_power_up
ata4: XXX in ahci_port_start after ahci_power_up status=0x7f BSY=0 DRQ=1 CR=0 FR=0 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_FIS_RX in ahci_start_fis_rx
ata4: XXX in ahci_init_port after ahci_start_fis_rx status=0x7f BSY=0 DRQ=1 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata4: XXX in ahci_init_port after ahci_start_engine status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX in ahci_port_start after ahci_init_port status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX - in ata_device_add after port_start
ata4: SATA max UDMA/133 cmd 0xFFFFC2000001CE80 ctl 0x0 bmdma 0x0 irq 19
ata4: XXX in ahci_freeze before turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX in ahci_freeze after turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX ata_device_add after ata_eh_freeze_port: status=0x7f BSY=0 DRQ=1
ata1: XXX ata_device_add before sata_scr_read: status=0x7f BSY=0 DRQ=1
ata1: XXX ata_device_add before scsi_add_host: status=0x7f BSY=0 DRQ=1
scsi0 : ahci
ata1: XXX ata_device_add before scheduleing eh: status=0x7f BSY=0 DRQ=1
ata1: XXX entering ahci_error_handler: status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX in ahci_freeze before turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX in ahci_freeze after turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: XXX before ata_port_offline status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata1: SATA link down (SStatus 0 SControl 300)
XXX - ~PORT_CMD_ATAPI in ahci_postreset
ata2: XXX ata_device_add before sata_scr_read: status=0x50 BSY=0 DRQ=0
ata2: XXX ata_device_add before scsi_add_host: status=0x50 BSY=0 DRQ=0
scsi1 : ahci
ata2: XXX ata_device_add before scheduleing eh: status=0x50 BSY=0 DRQ=0
ata2: XXX entering ahci_error_handler: status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX in ahci_freeze before turn IRQ off status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX in ahci_freeze after turn IRQ off status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX before ata_port_offline status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata2: XXX before stop_engine status=0x50 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - ~PORT_CMD_START in ahci_stop_engine
ata2: XXX before BSY/DRQ check status=0x50 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
XXX - ~PORT_CMD_ATAPI in ahci_postreset
ata2.00: ATA-7, max UDMA/133, 156312576 sectors: LBA 
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
ata3: XXX ata_device_add before sata_scr_read: status=0x80 BSY=1 DRQ=0
ata3: XXX ata_device_add before scsi_add_host: status=0x80 BSY=1 DRQ=0
scsi2 : ahci
ata3: XXX ata_device_add before scheduleing eh: status=0x80 BSY=1 DRQ=0
ata3: XXX entering ahci_error_handler: status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX in ahci_freeze before turn IRQ off status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX in ahci_freeze after turn IRQ off status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX before ata_port_offline status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX before stop_engine status=0x80 BSY=1 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: XXX before BSY/DRQ check status=0x80 BSY=1 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
XXX - PORT_CMD_START in ahci_start_engine
ata3: hardreset failed, retrying in 5 secs
XXX - ~PORT_CMD_START in ahci_stop_engine
XXX - PORT_CMD_START in ahci_start_engine
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
XXX - PORT_CMD_ATAPI in ahci_postreset
ata3.00: ATAPI, max UDMA/66
ata3.00: configured for UDMA/66
ata4: XXX ata_device_add before sata_scr_read: status=0x7f BSY=0 DRQ=1
ata4: XXX ata_device_add before scsi_add_host: status=0x7f BSY=0 DRQ=1
scsi3 : ahci
ata4: XXX ata_device_add before scheduleing eh: status=0x7f BSY=0 DRQ=1
ata4: XXX entering ahci_error_handler: status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX in ahci_freeze before turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX in ahci_freeze after turn IRQ off status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: XXX before ata_port_offline status=0x7f BSY=0 DRQ=1 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata4: SATA link down (SStatus 0 SControl 300)
XXX - ~PORT_CMD_ATAPI in ahci_postreset
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 >
sd 1:0:0:0: Attached scsi disk sda
scsi 2:0:0:0: Direct-Access     IBM      GoVault          0096 PQ: 0 ANSI: 5
ata3: XXX entering ahci_error_handler: status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x1
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: XXX in ahci_error_handler after ahci_stop_engine status=0x51 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: XXX in ahci_error_handler after ahci_start_engine status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
ata3: XXX entering ahci_error_handler: status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x1
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: XXX in ahci_error_handler after ahci_stop_engine status=0x51 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: XXX in ahci_error_handler after ahci_start_engine status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
ata3: XXX entering ahci_error_handler: status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x1
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: XXX in ahci_error_handler after ahci_stop_engine status=0x51 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: XXX in ahci_error_handler after ahci_start_engine status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
sdb: cache data unavailable
sdb: assuming drive cache: write through
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
ata3: XXX entering ahci_error_handler: status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x1
XXX - ~PORT_CMD_START in ahci_stop_engine
ata3: XXX in ahci_error_handler after ahci_stop_engine status=0x51 BSY=0 DRQ=0 CR=0 FR=1 ICC=0 CCS=0x0, CI=0x0
XXX - PORT_CMD_START in ahci_start_engine
ata3: XXX in ahci_error_handler after ahci_start_engine status=0x51 BSY=0 DRQ=0 CR=1 FR=1 ICC=0 CCS=0x0, CI=0x0
sdb: cache data unavailable
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 2:0:0:0: Attached scsi removable disk sdb
                       ...
===============================
2.6.20-rc6 debug output - end
===============================
