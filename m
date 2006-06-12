From: Jeff Garzik <jeff@garzik.org>
Subject: DMADIR+AHCI slows boot a lot
Date: Sun, 11 Jun 2006 23:01:16 -0400
Message-ID: <448CD8FC.5070508@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070502070902040900030900"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3310 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbWFLDBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:01:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070502070902040900030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It looks like we will need to implement an "impatient probe".

I have an SiI PATA<->SATA bridge that requires DMADIR to enable ATAPI. 
When ATAPI_ENABLE_DMADIR is -not- enabled, it makes a good test case for 
the EH :)

See the attached dmesg output, which illustrates that the boot is slowed 
by several minutes.  It would be ideal if we could execute EH in the 
background during probe, and simply stop waiting if it takes too long. 
bootplug should handle any devices that appear after the bus probe gets 
"too impatient", and stops waiting.

	Jeff



--------------070502070902040900030900
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Bootdata ok (command line is ro root=/dev/md0 nogui)
Linux version 2.6.17-rc5-libata1-g1049cb47 (jgarzik@pretzel.yyz.us) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Sun Jun 11 16:53:05 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe8ac00 (usable)
 BIOS-e820: 000000007fe8ac00 - 000000007fe8cc00 (ACPI NVS)
 BIOS-e820: 000000007fe8cc00 - 000000007fe8ec00 (ACPI data)
 BIOS-e820: 000000007fe8ec00 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: RSDP (v002 DELL                                  ) @ 0x00000000000feb00
ACPI: XSDT (v001 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd25f
ACPI: FADT (v003 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd357
ACPI: SSDT (v001   DELL    st_ex 0x00001000 INTL 0x20050211) @ 0x00000000fffcf0a6
ACPI: MADT (v001 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd44b
ACPI: BOOT (v001 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd4bd
ACPI: ASF! (v016 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd4e5
ACPI: MCFG (v001 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd54c
ACPI: HPET (v001 DELL    WS 380  0x00000006 ASL  0x00000061) @ 0x00000000000fd58a
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 INTL 0x20050211) @ 0x0000000000000000
On node 0 totalpages: 515466
  DMA zone: 2754 pages, LIFO batch:0
  DMA32 zone: 512712 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists
Kernel command line: ro root=/dev/md0 nogui
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2992.618 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2057196k/2095656k available (1858k kernel code, 37748k reserved, 1179k data, 172k init)
Calibrating delay using timer specific routine.. 5991.28 BogoMIPS (lpj=11982574)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
result 12469172
Detected 12.469 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5985.05 BogoMIPS (lpj=11970116)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
APIC error on CPU1: 00(40)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=390
checking if image is initramfs... it is
Freeing initrd memory: 1080k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
pnp: 00:01: ioport range 0x800-0x85f could not be reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
pnp: 00:01: ioport range 0x860-0x8ff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ed000000-efefffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: ecf00000-ecffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: disabled.
  MEM window: ece00000-ecefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: ecd00000-ecdfffff
  PREFETCH window: disabled.
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x7a set to 0x80
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1150079551.760:1): initialized
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0.PCI2 OSHP fails=0x5
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0 OSHP fails=0x5
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
pciehp: HPC vendor_id 8086 device_id 27e0 ss_vid 0 ss_did 0
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0.PCI5 OSHP fails=0x5
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0 OSHP fails=0x5
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.4
pciehp: HPC vendor_id 8086 device_id 27e2 ss_vid 0 ss_did 0
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 177
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0.PCI6 OSHP fails=0x5
Evaluate _OSC Set fails. Status = 0x0005
acpi_run_oshp:\_SB_.PCI0 OSHP fails=0x5
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 169
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
ICH7: neither IDE port enabled (BIOS)
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Can't read CTR while initializing i8042.
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 172k freed
Write protecting the kernel read-only data: 717k
SCSI subsystem initialized
libata version 1.30 loaded.
ahci 0000:00:1f.2: version 1.3
GSI 18 sharing vector 0xE1 and IRQ 18
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004D00 ctl 0x0 bmdma 0x0 irq 233
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004D80 ctl 0x0 bmdma 0x0 irq 233
ata3: SATA max UDMA/133 cmd 0xFFFFC20000004E00 ctl 0x0 bmdma 0x0 irq 233
ata4: SATA max UDMA/133 cmd 0xFFFFC20000004E80 ctl 0x0 bmdma 0x0 irq 233
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3e01 87:4763 88:207f
ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3e01 87:4763 88:207f
ata3.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0007
ata4.00: ATAPI, max UDMA/33
ata4.00: configured for UDMA/33
  Vendor: ATA       Model: HDS725050KLA360   Rev: K2AO
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: HDS725050KLA360   Rev: K2AO
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 2:0:0:0: Attached scsi disk sdb
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: soft resetting port
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: port is slow to respond, please be patient
ata4: port failed to respond (30 secs)
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: soft resetting port
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: port is slow to respond, please be patient
ata4: port failed to respond (30 secs)
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: soft resetting port
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: port is slow to respond, please be patient
ata4: port failed to respond (30 secs)
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/33
ata4: EH complete
ata4.00: limiting speed to UDMA/25
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: soft resetting port
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: port is slow to respond, please be patient
ata4: port failed to respond (30 secs)
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/25
ata4: EH complete
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb1 has different UUID to sdb3
md:  adding sda5 ...
md: sda2 has different UUID to sdb3
md: created md1
md: bind<sda5>
md: bind<sdb3>
md: running: <sdb3><sda5>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb1>
md: running: <sdb1><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
tg3.c:v3.58 (May 22, 2006)
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:12:3f:6f:ba:4b
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
GSI 19 sharing vector 0x32 and IRQ 19
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 18 (level, low) -> IRQ 50
eth1: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:04:76:f1:77:cf
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth1: dma_rwctrl[76ff000f] dma_mask[64-bit]
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
USB Universal Host Controller Interface driver v3.0
GSI 20 sharing vector 0x3A and IRQ 20
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 58, io base 0x0000ff80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
GSI 21 sharing vector 0x42 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 66, io base 0x0000ff60
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 50, io base 0x0000ff40
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
GSI 22 sharing vector 0x4A and IRQ 22
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 74, io base 0x0000ff20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 58, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
lp: driver loaded but no devices found
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
Using specific hotkey driver
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 4-1: new low speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
input: Microsoft Natural Keyboard Elite as /class/input/input1
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Elite] on usb-0000:00:1d.3-1
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1D17
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2048276k swap on /dev/sdb2.  Priority:-1 extents:1 across:2048276k
Adding 2048276k swap on /dev/sda3.  Priority:-2 extents:1 across:2048276k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period

--------------070502070902040900030900--
