From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 14:25:19 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911D1F@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:57758
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbXI1SYM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 14:24:12 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Tejun,

Below is the kernel log from boot to when error occurred.  You can see
right when the raid5 array was built and started the recovery process
the exception occurred.  Also, its now been 24 hours since I disabled
smartd and have not seen any other exceptions since. (also included is
output from smartd -V)

Thanks,
Jon

Linux version 2.6.22.1 (root@hac.ath.cx) (gcc version 4.1.1 20061011
(Red Hat 4.1.1-30)) #4 SMP Tue Sep 18 02:52:31 PDT 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099400 (usable)
 BIOS-e820: 0000000000099400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007feff000 (ACPI data)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6a20
Entering add_active_range(0, 0, 524160) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524160
early_node_map[1] active PFN ranges
    0:        0 ->   524160
On node 0 totalpages: 524160
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2303 pages used for memmap
  HighMem zone: 292481 pages, LIFO batch:31
DMI present.
Using APIC driver default
ACPI: RSDP 000F6A50, 0014 (r0 PTLTD )
ACPI: RSDT 7FEFB835, 0034 (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP 7FEFEE78, 0074 (r1 Intel  SE7500CW  6040000 PTL         8)
ACPI: DSDT 7FEFB869, 360F (r1  INTEL   PLUMAS  6040000 MSFT  100000D)
ACPI: FACS 7FEFFFC0, 0040
ACPI: SPCR 7FEFEEEC, 0050 (r1 PTLTD  $UCRTBL$  6040000 PTL         1)
ACPI: APIC 7FEFEF3C, 009C (r1 PTLTD    APIC    6040000  LTP        0)
ACPI: BOOT 7FEFEFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists.  Total pages: 520065
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80400)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1794.306 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2070316k/2096640k available (3086k kernel code, 25004k reserved,
1656k data, 296k init, 1179072k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc05a9000 - 0xc05f3000   ( 296 kB)
      .data : 0xc0403afb - 0xc05a1dd4   (1656 kB)
      .text : 0xc0100000 - 0xc0403afb   (3086 kB)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 3591.96 BogoMIPS
(lpj=7183936)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 19k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 385 Objects with 46 Devices 110 Methods 17
Regions
 tbxface-0587 [02] tb_load_namespace     : ACPI Tables successfully
acquired
evxfevnt-0091 [02] enable                : Transition to ACPI mode
successful
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3588.61 BogoMIPS
(lpj=7177228)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 3588.36 BogoMIPS
(lpj=7176723)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 3588.75 BogoMIPS
(lpj=7177508)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (14357.69 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
migration_cost=179,708
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd921, last bus=4
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-1191 [03] ev_gpe_initialize     : There are no GPE blocks
defined in the FADT
Completing Region/Field/Buffer/Package
initialization:.........................................
Initialized 17/17 Regions 0/0 Fields 21/21 Buffers 3/3 Packages (394
nodes)
Initializing Device/Processor/Thermal objects by executing _INI
methods:.
Executed 1 _INI methods requiring 1 _STA executions (examined 56
objects)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Firmware left 0000:04:04.0 e100 interrupts enabled, disabling
PCI: Firmware left 0000:04:05.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICH3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z000._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z001._PRT]
[ACPI Debug]  Buffer: [0x06]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 14 15) *12
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *7 10 11 14 15)
[ACPI Debug]  Buffer: [0x06]
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 15)
[ACPI Debug]  Buffer: [0x06]
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 10 11 14 15)
[ACPI Debug]  Buffer: [0x06]
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 14 15)
[ACPI Debug]  Buffer: [0x06]
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *12
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:01:1d.0
  IO window: 8000-8fff
  MEM window: f4200000-f42fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:01:1f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 8000-8fff
  MEM window: f4100000-f42fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-9fff
  MEM window: f4300000-f5ffffff
  PREFETCH window: f8000000-fbffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1933k freed
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Boot video device is 0000:04:03.0
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Intel 82802 RNG detected
Linux agpgart interface v0.102 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 20 (level, low) -> IRQ 16
e100: eth0: e100_probe: addr 0xf4305000, irq 16, MAC addr
00:02:B3:B0:6B:8C
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 23 (level, low) -> IRQ 17
e100: eth1: e100_probe: addr 0xf4306000, irq 17, MAC addr
00:02:B3:B0:6B:E5
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Switched to high resolution mode on CPU 2
Switched to high resolution mode on CPU 3
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
hda: ST340014A, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST3750640A, ATA DISK drive
hdd: ST3400632A, ATA DISK drive
hdc: selected mode 0x45
hdd: selected mode 0x45
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 512KiB
hdc: 1465149168 sectors (750156 MB) w/16384KiB Cache, CHS=65535/255/63,
UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
hdd: max request size: 512KiB
hdd: 781422768 sectors (400088 MB) w/16384KiB Cache, CHS=48641/255/63,
UDMA(100)
hdd: cache flushes supported
 hdd: hdd1
3ware Storage Controller device driver for Linux v1.26.02.002.
Fusion MPT base driver 3.04.04
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.04
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00007000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00007020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int32x1    506 MB/s
raid6: int32x2    610 MB/s
raid6: int32x4    549 MB/s
raid6: int32x8    539 MB/s
raid6: mmxx1     1446 MB/s
raid6: mmxx2     1563 MB/s
raid6: sse1x1     726 MB/s
raid6: sse1x2    1256 MB/s
raid6: sse2x1    1303 MB/s
raid6: sse2x2    1895 MB/s
raid6: using algorithm sse2x2 (1895 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  2353.000 MB/sec
raid5: using function: pIII_sse (2353.000 MB/sec)
md: faulty personality registered for level -5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 296k freed
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for
generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI
USB Serial Device
ftdi_sio 1-2:1.0: FTDI USB Serial Device converter detected
drivers/usb/serial/ftdi_sio.c: Detected FT232BM
usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB0
usbcore: registered new interface driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
PDC20267: IDE controller at PCI slot 0000:04:06.0
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 22 (level, low) -> IRQ 21
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xf4310000
PDC20267: 100% native mode on irq 21
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0x9480-0x9487, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9488-0x948f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
libata version 3.00 loaded.
Linux video capture interface: v2.00
ivtv:  ==================== START INIT IVTV ====================
ivtv:  version 1.0.0 (2.6.22.1 SMP mod_unload PENTIUM4 ) loading
hde: ST3500630A, ATA DISK drive
hdf: ST3500630A, ATA DISK drive
hde: selected mode 0x45
hdf: selected mode 0x45
ide2 at 0x94d0-0x94d7,0x94c6 on irq 21
hde: max request size: 128KiB
hde: 976773168 sectors (500107 MB) w/16384KiB Cache, CHS=60801/255/63,
UDMA(100)
hde: cache flushes supported
 hde: hde1
hdf: max request size: 128KiB
hdf: 976773168 sectors (500107 MB) w/16384KiB Cache, CHS=60801/255/63,
UDMA(100)
hdf: cache flushes supported
 hdf: hdf1
Probing IDE interface ide3...
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 17 (level, low) -> IRQ 22
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]
MMIO=[f4307000-f43077ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
sata_sil24 0000:02:02.0: version 1.0
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 28 (level, low) -> IRQ 23
sata_sil24 0000:02:02.0: Applying completion IRQ loss on PCI-X errata
fix
scsi0 : sata_sil24
scsi1 : sata_sil24
scsi2 : sata_sil24
scsi3 : sata_sil24
ata1: SATA max UDMA/100 cmd 0xf88d0000 ctl 0x00000000 bmdma 0x00000000
irq 23
ata2: SATA max UDMA/100 cmd 0xf88d2000 ctl 0x00000000 bmdma 0x00000000
irq 23
ata3: SATA max UDMA/100 cmd 0xf88d4000 ctl 0x00000000 bmdma 0x00000000
irq 23
ata4: SATA max UDMA/100 cmd 0xf88d6000 ctl 0x00000000 bmdma 0x00000000
irq 23
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0016b5fffeb1a5e6]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00010800100081c8]
NOTE: The dv1394 driver is unsupported and may be removed in a future
Linux release. Use raw1394 instead.
ieee1394: raw1394: /dev/raw1394 device initialized
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.01: hard resetting link
ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 300)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata1.01: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
ata1.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.01: configured for UDMA/100
ata1.02: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
ata1.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.02: configured for UDMA/100
ata1.03: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
ata1.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.03: configured for UDMA/100
ata1: EH complete
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata2.00: hard resetting link
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.01: hard resetting link
ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 300)
ata2.05: hard resetting link
ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
ata2.00: 490234752 sectors, multi 0: LBA48 
ata2.00: configured for UDMA/100
ata2.01: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
ata2.01: 490234752 sectors, multi 0: LBA48 
ata2.01: configured for UDMA/100
ata2.02: ATA-7: Maxtor 7Y250M0, YAR51KW0, max UDMA/133
ata2.02: 490234752 sectors, multi 0: LBA48 
ata2.02: configured for UDMA/100
ata2.03: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
ata2.03: 490234752 sectors, multi 0: LBA48 
ata2.03: configured for UDMA/100
ata2: EH complete
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 0:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0
ANSI: 5
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 0:1:0:0: [sdb] Attached SCSI disk
scsi 0:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0
ANSI: 5
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1
sd 0:2:0:0: [sdc] Attached SCSI disk
scsi 0:3:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0
ANSI: 5
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1
sd 0:3:0:0: [sdd] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0
ANSI: 5
sd 1:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sde: sde1
sd 1:0:0:0: [sde] Attached SCSI disk
scsi 1:1:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0
ANSI: 5
sd 1:1:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdf: sdf1
sd 1:1:0:0: [sdf] Attached SCSI disk
scsi 1:2:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0
ANSI: 5
sd 1:2:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdg: sdg1
sd 1:2:0:0: [sdg] Attached SCSI disk
scsi 1:3:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0
ANSI: 5
sd 1:3:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdh: sdh1
sd 1:3:0:0: [sdh] Attached SCSI disk
ivtv0: Autodetected Hauppauge card (cx23416 based)
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 19 (level, low) -> IRQ 20
ivtv0: loaded v4l-cx2341x-enc.fw firmware (376836 bytes)
ivtv0: Encoder revision: 0x02060039
tveeprom 1-0050: Hauppauge model 26032, rev C199, serial# 8297267
tveeprom 1-0050: tuner model is TCL 2002N 5H (idx 99, type 50)
tveeprom 1-0050: TV standards NTSC(M) (eeprom 0x08)
tveeprom 1-0050: audio processor is CX25841 (idx 35)
tveeprom 1-0050: decoder processor is CX25841 (idx 28)
tveeprom 1-0050: has no radio, has IR receiver, has IR transmitter
ivtv0: Autodetected Hauppauge WinTV PVR-150
ivtv0: reopen i2c bus for IR-blaster support
tuner 1-0061: chip found @ 0xc2 (ivtv i2c driver #0)
cx25840 1-0044: cx25841-23 found @ 0x88 (ivtv i2c driver #0)
cx25840 1-0044: loaded v4l-cx25840.fw firmware (16382 bytes)
wm8775 1-001b: chip found @ 0x36 (ivtv i2c driver #0)
tuner 1-0061: type set to 50 (TCL 2002N)
ivtv0: Registered device video0 for encoder MPEG (4 MB)
ivtv0: Registered device video32 for encoder YUV (2 MB)
ivtv0: Registered device vbi0 for encoder VBI (1 MB)
ivtv0: Registered device video24 for encoder PCM audio (1 MB)
ivtv0: Initialized Hauppauge WinTV PVR-150, card #0
ivtv:  ====================  END INIT IVTV  ====================
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md: created md0
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdh1
raid0:   comparing sdh1(245111616) with sdh1(245111616)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdg1
raid0:   comparing sdg1(245111616) with sdh1(245111616)
raid0:   EQUAL
raid0: looking at sdf1
raid0:   comparing sdf1(245111616) with sdh1(245111616)
raid0:   EQUAL
raid0: looking at sde1
raid0:   comparing sde1(245111616) with sdh1(245111616)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 980446464 blocks.
raid0 : conf->hash_spacing is 980446464 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on hdf1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
across:2031608k
process `sysctl' is using deprecated sysctl (syscall)
net.ipv6.neigh.default.retrans_time; Use
net.ipv6.neigh.default.retrans_time_ms instead.
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
vmmon: no version for "struct_module" found: kernel tainted.
vmmon: module license 'unspecified' taints kernel.
vmmon: No versions for exported symbols. Tainting kernel.
/dev/vmmon[3604]: VMCI: Driver initialized.
/dev/vmmon[3604]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[3604]: Module vmmon: initialized
/dev/vmnet: open called by PID 3635 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
eth0: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
/dev/vmnet: open called by PID 3746 (vmware-vmx)
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
/dev/vmmon[3894]: host clock rate change request 0 -> 19
/dev/vmmon[3894]: host clock rate change request 19 -> 83
lirc_dev: No versions for exported symbols. Tainting kernel.
lirc_dev: IR Remote Control driver registered, at major 61 
lirc_serial: auto-detected active high receiver
lirc_dev: lirc_register_plugin: sample_rate: 0
device eth0 left promiscuous mode
bridge-eth0: disabled promiscuous mode
/dev/vmnet: open called by PID 3894 (vmware-vmx)
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1
md: md0 stopped.
md: unbind<sdh1>
md: export_rdev(sdh1)
md: unbind<sdg1>
md: export_rdev(sdg1)
md: unbind<sdf1>
md: export_rdev(sdf1)
md: unbind<sde1>
md: export_rdev(sde1)
md: md1 stopped.
md: bind<sde1>
md: bind<sdg1>
md: bind<sdh1>
md: bind<sdf1>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdf1
raid0:   comparing sdf1(245111616) with sdf1(245111616)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdh1
raid0:   comparing sdh1(245111616) with sdf1(245111616)
raid0:   EQUAL
raid0: looking at sdg1
raid0:   comparing sdg1(245111616) with sdf1(245111616)
raid0:   EQUAL
raid0: looking at sde1
raid0:   comparing sde1(245111616) with sdf1(245111616)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 980446464 blocks.
raid0 : conf->hash_spacing is 980446464 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 4204kB for md0
raid5: raid level 5 set md0 active with 3 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:3
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
RAID5 conf printout:
 --- rd:4 wd:3
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
md: recovery of RAID array md0
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000
KB/sec) for recovery.
md: using 128k window, over a total of 488383936 blocks.
ata1.03: exception Emask 0x0 SAct 0x2220897f SErr 0x400000 action 0x2
ata1.03: irq_stat 0x00020002, device error via SDB FIS
ata1.03: cmd 61/88:a8:3f:00:00/00:00:00:00:00/40 tag 21 cdb 0x0 data
69632 out
         res 41/84:38:8f:00:00/60:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata1.03: soft resetting link
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata1.03: exception Emask 0x0 SAct 0x1ffc SErr 0x400000 action 0x2
ata1.03: irq_stat 0x00020002, device error via SDB FIS
ata1.03: cmd 61/88:10:3f:00:00/00:00:00:00:00/40 tag 2 cdb 0x0 data
69632 out
         res 41/84:78:4f:00:00/00:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata1.03: soft resetting link
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata1.03: exception Emask 0x0 SAct 0x7ff SErr 0x400000 action 0x2
ata1.03: irq_stat 0x00020002, device error via SDB FIS
ata1.03: cmd 61/70:00:57:03:00/01:00:00:00:00/40 tag 0 cdb 0x0 data
188416 out
         res 41/84:a0:27:04:00/60:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata1.03: soft resetting link
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata1.03: limiting SATA link speed to 1.5 Gbps
ata1.03: exception Emask 0x0 SAct 0x7ff SErr 0x400000 action 0x6
ata1.03: irq_stat 0x00020002, device error via SDB FIS
ata1.03: cmd 61/88:00:3f:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data
69632 out
         res 41/84:38:8f:00:00/00:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA




[root@hac tmp]# smartd -V
smartd version 5.37 [i686-redhat-linux-gnu] Copyright (C) 2002-6 Bruce
Allen
Home page is http://smartmontools.sourceforge.net/

smartd comes with ABSOLUTELY NO WARRANTY. This is
free software, and you are welcome to redistribute it
under the terms of the GNU General Public License
Version 2. See http://www.gnu.org for further details.

CVS version IDs of files used to build this code are:
Module: atacmdnames.cpp  revision: 1.15  date: 2006/10/22
  uses: atacmdnames.h    revision: 1.5   date: 2006/04/12
Module: atacmds.cpp      revision: 1.177 date: 2006/10/27
  uses: atacmds.h        revision: 1.83  date: 2006/08/25
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: extern.h         revision: 1.47  date: 2006/09/15
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: scsiata.h        revision: 1.2   date: 2006/07/01
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: ataprint.cpp     revision: 1.171 date: 2006/10/28
  uses: atacmdnames.h    revision: 1.5   date: 2006/04/12
  uses: atacmds.h        revision: 1.83  date: 2006/08/25
  uses: ataprint.h       revision: 1.29  date: 2006/09/17
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: extern.h         revision: 1.47  date: 2006/09/15
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: knowndrives.h    revision: 1.17  date: 2006/08/09
  uses: smartctl.h       revision: 1.24  date: 2006/07/20
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: knowndrives.cpp  revision: 1.156 date: 2006/10/30
  uses: atacmds.h        revision: 1.83  date: 2006/08/25
  uses: ataprint.h       revision: 1.29  date: 2006/09/17
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: extern.h         revision: 1.47  date: 2006/09/15
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: knowndrives.h    revision: 1.17  date: 2006/08/09
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: os_linux.cpp     revision: 1.88  date: 2006/10/25
  uses: atacmds.h        revision: 1.83  date: 2006/08/25
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: os_linux.h       revision: 1.25  date: 2006/08/25
  uses: scsicmds.h       revision: 1.63  date: 2006/11/12
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: scsicmds.cpp     revision: 1.92  date: 2006/11/12
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: extern.h         revision: 1.47  date: 2006/09/15
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: scsicmds.h       revision: 1.63  date: 2006/11/12
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: smartd.cpp       revision: 1.384 date: 2006/11/12
  uses: atacmds.h        revision: 1.83  date: 2006/08/25
  uses: ataprint.h       revision: 1.29  date: 2006/09/17
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: extern.h         revision: 1.47  date: 2006/09/15
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: knowndrives.h    revision: 1.17  date: 2006/08/09
  uses: scsicmds.h       revision: 1.63  date: 2006/11/12
  uses: smartd.h         revision: 1.84  date: 2006/11/11
  uses: utility.h        revision: 1.47  date: 2006/10/09
Module: utility.cpp      revision: 1.62  date: 2006/08/09
  uses: configure.in     revision: 1.121 date: 2006/10/30
  uses: int64.h          revision: 1.16  date: 2006/10/29
  uses: utility.h        revision: 1.47  date: 2006/10/09

smartmontools release 5.37 dated 2006/12/20 at 20:37:59 UTC
smartmontools build host: i686-redhat-linux-gnu
smartmontools build configured: 2007/08/20 09:06:38 UTC
smartd compile dated Aug 20 2007 at 05:06:43
smartmontools configure arguments:  '--build=i686-redhat-linux-gnu'
'--host=i686-redhat-linux-gnu' '--target=i386-redhat-linux-gnu'
'--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr'
'--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc'
'--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib'
'--libexecdir=/usr/libexec' '--localstatedir=/var'
'--sharedstatedir=/usr/com' '--mandir=/usr/share/man'
'--infodir=/usr/share/info' 'build_alias=i686-redhat-linux-gnu'
'host_alias=i686-redhat-linux-gnu' 'target_alias=i386-redhat-linux-gnu'
'CXXFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386
-mtune=generic -fasynchronous-unwind-tables' 'CFLAGS=-O2 -g -pipe -Wall
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector
--param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic
-fasynchronous-unwind-tables'



-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, September 28, 2007 9:51 AM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org; Bruce Allen
Subject: Re: sata_sil24 with port multiplier

Jon Chelton wrote:
> This error occurred when assembling a software raid 5 array using
mdadm.
> It also happened when copying large amounts of data from one drive to
> another.  I saw from an earlier post to disable or upgrade smartd.  I
> tried this (disabled) and moved about 50gb between disks and the error
> has not repeated yet.

Please post full kernel log containing boot message and the following
error trace.  cc'ing Bruce Allen for smartd.

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Friday, September 28, 2007 3:24 AM
> To: Jon Chelton
> Cc: linux-ide@vger.kernel.org
> Subject: Re: sata_sil24 with port multiplier
> 
> Jon Chelton wrote:
>> After applying the patches you sent, I had not received any
additional
>> errors until today.  Below is an output from dmesg.
>>
>> ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata1.15: irq_stat 0x00020002, PMP DMA CS errata
>> ata1.00: exception Emask 0x100 SAct 0x18084200 SErr 0x0 action 0x6
>> frozen
>> ata1.00: cmd 60/00:48:3f:8f:fa/01:00:0a:00:00/40 tag 9 cdb 0x0 data
>> 131072 in
>>          res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
>> error)
> 
> Hmmm... So, when did the above error occur?  Can you reproduce it?
> 


-- 
tejun

