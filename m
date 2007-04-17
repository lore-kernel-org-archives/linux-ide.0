From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 14:41:39 -0400
Message-ID: <20070417184139.GB11211@redhat.com>
References: <20070411002313.29069ca5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030812AbXDQSlq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 14:41:46 -0400
Content-Disposition: inline
In-Reply-To: <20070411002313.29069ca5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, jkeating@redhat.com

On Wed, Apr 11, 2007 at 12:23:13AM +0100, Alan Cox wrote:
 > Signed-off-by: Alan Cox <alan@redhat.com>
 >=20
 > Add support for ignoring the BIOS HPA result (off by default) and se=
tting
 > the disk to the full available size unless already frozen.
 >=20
 > Tested with various platforms/disks and confirmed to work with the
 > Macintosh (which broke earlier) and ata_piix (breakage due to the LB=
A48
 > readback that Tejun fixed).
 >=20
 > For normal users this brings us, I believe, to feature parity with o=
ld IDE
 > (and of course more featured in some areas too).

This is broken horribly on nvidia chipsets..

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (=
rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2=
)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3=
)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Contro=
ller (rev f3)
00:08.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Contro=
ller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
 HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
 Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
 DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
 Miscellaneous Control
01:07.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (re=
v 10)
01:0a.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Lin=
k Layer Controller (rev 01)
05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Rad=
eon X300 (PCIE)]
05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]

During boot it does this..

Linux version 2.6.20-1.3079.fc7 (brewbuilder@hs20-bc2-2.build.redhat.co=
m) (gcc version 4.1.2 20070403 (Red Hat 4.1.2-8)) #1 SMP Mon Apr 16 20:=
05:15 EDT 2007
Command line: initrd=3Dinitrd.img console=3DttyS0,115200 console=3Dtty0=
 BOOT_IMAGE=3Dvmlinuz=20
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000d0000000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
end_pfn_map =3D 1048576
DMI 2.3 present.
ACPI: RSDP 000F6E80, 0014 (r0 Nvidia)
ACPI: RSDT 1FFF3000, 0030 (r1 Nvidia AWRDACPI 42302E31 AWRD  1010101)
ACPI: FACP 1FFF3040, 0074 (r1 Nvidia AWRDACPI 42302E31 AWRD  1010101)
ACPI: DSDT 1FFF30C0, 4C3F (r1 NVIDIA AWRDACPI     1000 MSFT  100000C)
ACPI: FACS 1FFF0000, 0040
ACPI: MCFG 1FFF7D80, 003C (r1 Nvidia AWRDACPI 42302E31 AWRD  1010101)
ACPI: APIC 1FFF7D00, 007C (r1 Nvidia AWRDACPI 42302E31 AWRD  1010101)
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000001fff0000
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000001fff0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      157
    0:      256 ->   131056
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009d000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:b0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 44672 bytes of per cpu data
Built 1 zonelists.  Total pages: 125776
Kernel command line: initrd=3Dinitrd.img console=3DttyS0,115200 console=
=3Dtty0 BOOT_IMAGE=3Dvmlinuz=20
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
time.c: Detected 2211.357 MHz processor.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molna=
r
=2E.. MAX_LOCKDEP_SUBCLASSES:    8
=2E.. MAX_LOCK_DEPTH:          30
=2E.. MAX_LOCKDEP_KEYS:        2048
=2E.. CLASSHASH_SIZE:           1024
=2E.. MAX_LOCKDEP_ENTRIES:     8192
=2E.. MAX_LOCKDEP_CHAINS:      16384
=2E.. CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ 260000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 496444k/524224k available (2465k kernel code, 27384k reserved, =
1445k data, 332k init)
Calibrating delay using timer specific routine.. 4424.38 BogoMIPS (lpj=3D=
2212194)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12564554
Detected 12.564 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4421.83 BogoMIPS (lpj=3D=
2210919)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
Brought up 2 CPUs
migration_cost=3D369
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
0000:00:06.0: cannot adjust BAR0 (not I/O)
0000:00:06.0: cannot adjust BAR1 (not I/O)
0000:00:06.0: cannot adjust BAR2 (not I/O)
0000:00:06.0: cannot adjust BAR3 (not I/O)
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, dis=
abled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post=
 a report
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:01: ioport range 0x1000-0x107f has been reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff has been reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
pnp: 00:0b: iomem range 0xd0000000-0xdfffffff could not be reserved
pnp: 00:0c: iomem range 0xd0000-0xd3fff has been reserved
pnp: 00:0c: iomem range 0xdcc00-0xdffff has been reserved
pnp: 00:0c: iomem range 0xf0000-0xfbfff could not be reserved
pnp: 00:0c: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:09.0
Time: acpi_pm clocksource has been installed.
  IO window: 9000-9fff
  MEM window: ea000000-ea0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: 6000-6fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: 8000-8fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: 7000-7fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: a000-afff
  MEM window: e8000000-e9ffffff
  PREFETCH window: e0000000-e7ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 8, 1048576 bytes)
TCP bind hash table entries: 16384 (order: 7, 917504 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
=46reeing initrd memory: 5657k freed
audit: initializing netlink socket (disabled)
audit(1176816095.338:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
ksign: Installing public key data
Loading keyring
- Added public key 1B1335F4D8AAC8F
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Found disabled HT MSI Mapping on 0000:00:0b.0
PCI: Found enabled HT MSI Mapping on 0000:00:00.0
PCI: Found disabled HT MSI Mapping on 0000:00:0c.0
PCI: Found enabled HT MSI Mapping on 0000:00:00.0
PCI: Found disabled HT MSI Mapping on 0000:00:0d.0
PCI: Found enabled HT MSI Mapping on 0000:00:00.0
PCI: Found disabled HT MSI Mapping on 0000:00:0e.0
PCI: Found enabled HT MSI Mapping on 0000:00:00.0
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enable=
d
=FFserial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ pro=
cessors (version 2.00.00)
ACPI Exception (processor_perflib-0234): AE_NOT_FOUND, Evaluating _PSS =
[20070126]
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
=46reeing unused kernel memory: 332k freed
Write protecting the kernel read-only data: 1058k

HARDWARE ERROR
CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f=
0f
TSC 5d45fa1400=20
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Machine check
BUG: warning at kernel/panic.c:137/panic() (Tainted: G   M  )

Call Trace:
 <#MC>  [<ffffffff8028ce05>] panic+0x202/0x213
 [<ffffffff802647db>] oops_begin+0x29/0x78
 [<ffffffff80270947>] print_mce+0xe8/0xed
 [<ffffffff802709d9>] mce_log+0x0/0xa1
 [<ffffffff80270de2>] do_machine_check+0x316/0x3a8
 [<ffffffff8025d2ef>] machine_check+0x7f/0x90
 [<ffffffff8825ac1d>] :sata_nv:nv_adma_interrupt+0x1d/0x4fc
 [<ffffffff8034c88c>] ioread8+0x1/0x2c
 <<EOE>>  <IRQ>  [<ffffffff8824278d>] :libata:ata_tf_read+0x95/0xc4
 [<ffffffff88238888>] :libata:fill_result_tf+0x23/0x25
 [<ffffffff8823a6de>] :libata:ata_qc_complete+0xa5/0xb1
 [<ffffffff8825b036>] :sata_nv:nv_adma_interrupt+0x436/0x4fc
 [<ffffffff80210753>] handle_IRQ_event+0x20/0x55
 [<ffffffff802bd8c9>] handle_fasteoi_irq+0x9d/0xdd
 [<ffffffff8026bf7f>] do_IRQ+0xf6/0x166
 [<ffffffff8026a666>] default_idle+0x0/0x51
 [<ffffffff8025c666>] ret_from_intr+0x0/0xf
 <EOI>  [<ffffffff80260eba>] __sched_text_start+0x92a/0x962
 [<ffffffff8026a69d>] default_idle+0x37/0x51
 [<ffffffff8026a69b>] default_idle+0x35/0x51
 [<ffffffff8024895d>] cpu_idle+0xa1/0xc4
 [<ffffffff80269cea>] rest_init+0x2b/0x2d
 [<ffffffff80686893>] start_kernel+0x2e3/0x2f0
 [<ffffffff80686158>] _sinittext+0x158/0x15f

BUG: warning at drivers/input/serio/i8042.c:825/i8042_panic_blink() (Ta=
inted: G   M  )

Call Trace:
 <#MC>  [<ffffffff803e6d7a>] i8042_panic_blink+0x143/0x301
 [<ffffffff8028cdab>] panic+0x1a8/0x213
 [<ffffffff802647db>] oops_begin+0x29/0x78
 [<ffffffff80270947>] print_mce+0xe8/0xed
 [<ffffffff802709d9>] mce_log+0x0/0xa1
 [<ffffffff80270de2>] do_machine_check+0x316/0x3a8
 [<ffffffff8025d2ef>] machine_check+0x7f/0x90
 [<ffffffff8825ac1d>] :sata_nv:nv_adma_interrupt+0x1d/0x4fc
 [<ffffffff8034c88c>] ioread8+0x1/0x2c
 <<EOE>>  <IRQ>  [<ffffffff8824278d>] :libata:ata_tf_read+0x95/0xc4
 [<ffffffff88238888>] :libata:fill_result_tf+0x23/0x25
 [<ffffffff8823a6de>] :libata:ata_qc_complete+0xa5/0xb1
 [<ffffffff8825b036>] :sata_nv:nv_adma_interrupt+0x436/0x4fc
 [<ffffffff80210753>] handle_IRQ_event+0x20/0x55
 [<ffffffff802bd8c9>] handle_fasteoi_irq+0x9d/0xdd
 [<ffffffff8026bf7f>] do_IRQ+0xf6/0x166
 [<ffffffff8026a666>] default_idle+0x0/0x51
 [<ffffffff8025c666>] ret_from_intr+0x0/0xf
 <EOI>  [<ffffffff80260eba>] __sched_text_start+0x92a/0x962
 [<ffffffff8026a69d>] default_idle+0x37/0x51
 [<ffffffff8026a69b>] default_idle+0x35/0x51
 [<ffffffff8024895d>] cpu_idle+0xa1/0xc4
 [<ffffffff80269cea>] rest_init+0x2b/0x2d
 [<ffffffff80686893>] start_kernel+0x2e3/0x2f0
 [<ffffffff80686158>] _sinittext+0x158/0x15f

BUG: warning at drivers/input/serio/i8042.c:828/i8042_panic_blink() (Ta=
inted: G   M  )

Call Trace:
 <#MC>  [<ffffffff803e6e63>] i8042_panic_blink+0x22c/0x301
 [<ffffffff8028cdab>] panic+0x1a8/0x213
 [<ffffffff802647db>] oops_begin+0x29/0x78
 [<ffffffff80270947>] print_mce+0xe8/0xed
 [<ffffffff802709d9>] mce_log+0x0/0xa1
 [<ffffffff80270de2>] do_machine_check+0x316/0x3a8
 [<ffffffff8025d2ef>] machine_check+0x7f/0x90
 [<ffffffff8825ac1d>] :sata_nv:nv_adma_interrupt+0x1d/0x4fc
 [<ffffffff8034c88c>] ioread8+0x1/0x2c
 <<EOE>>  <IRQ>  [<ffffffff8824278d>] :libata:ata_tf_read+0x95/0xc4
 [<ffffffff88238888>] :libata:fill_result_tf+0x23/0x25
 [<ffffffff8823a6de>] :libata:ata_qc_complete+0xa5/0xb1
 [<ffffffff8825b036>] :sata_nv:nv_adma_interrupt+0x436/0x4fc
 [<ffffffff80210753>] handle_IRQ_event+0x20/0x55
 [<ffffffff802bd8c9>] handle_fasteoi_irq+0x9d/0xdd
 [<ffffffff8026bf7f>] do_IRQ+0xf6/0x166
 [<ffffffff8026a666>] default_idle+0x0/0x51
 [<ffffffff8025c666>] ret_from_intr+0x0/0xf
 <EOI>  [<ffffffff80260eba>] __sched_text_start+0x92a/0x962
 [<ffffffff8026a69d>] default_idle+0x37/0x51
 [<ffffffff8026a69b>] default_idle+0x35/0x51
 [<ffffffff8024895d>] cpu_idle+0xa1/0xc4
 [<ffffffff80269cea>] rest_init+0x2b/0x2d
 [<ffffffff80686893>] start_kernel+0x2e3/0x2f0
 [<ffffffff80686158>] _sinittext+0x158/0x15f

BUG: warning at drivers/input/serio/i8042.c:831/i8042_panic_blink() (Ta=
inted: G   M  )

Call Trace:
 <#MC>  [<ffffffff803e6f0b>] i8042_panic_blink+0x2d4/0x301
 [<ffffffff8028cdab>] panic+0x1a8/0x213
 [<ffffffff802647db>] oops_begin+0x29/0x78
 [<ffffffff80270947>] print_mce+0xe8/0xed
 [<ffffffff802709d9>] mce_log+0x0/0xa1
 [<ffffffff80270de2>] do_machine_check+0x316/0x3a8
 [<ffffffff8025d2ef>] machine_check+0x7f/0x90
 [<ffffffff8825ac1d>] :sata_nv:nv_adma_interrupt+0x1d/0x4fc
 [<ffffffff8034c88c>] ioread8+0x1/0x2c
 <<EOE>>  <IRQ>  [<ffffffff8824278d>] :libata:ata_tf_read+0x95/0xc4
 [<ffffffff88238888>] :libata:fill_result_tf+0x23/0x25
 [<ffffffff8823a6de>] :libata:ata_qc_complete+0xa5/0xb1
 [<ffffffff8825b036>] :sata_nv:nv_adma_interrupt+0x436/0x4fc
 [<ffffffff80210753>] handle_IRQ_event+0x20/0x55
 [<ffffffff802bd8c9>] handle_fasteoi_irq+0x9d/0xdd
 [<ffffffff8026bf7f>] do_IRQ+0xf6/0x166
 [<ffffffff8026a666>] default_idle+0x0/0x51
 [<ffffffff8025c666>] ret_from_intr+0x0/0xf
 <EOI>  [<ffffffff80260eba>] __sched_text_start+0x92a/0x962
 [<ffffffff8026a69d>] default_idle+0x37/0x51
 [<ffffffff8026a69b>] default_idle+0x35/0x51
 [<ffffffff8024895d>] cpu_idle+0xa1/0xc4
 [<ffffffff80269cea>] rest_init+0x2b/0x2d
 [<ffffffff80686893>] start_kernel+0x2e3/0x2f0
 [<ffffffff80686158>] _sinittext+0x158/0x15f



Without the patch, no MCEs.

	Dave

--=20
http://www.codemonkey.org.uk
