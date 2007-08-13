From: "Ole-Christian S. Hagenes" <ole@fjordn.net>
Subject: Problems with the sata_promise driver while using smart.
Date: Mon, 13 Aug 2007 17:01:21 +0200
Message-ID: <46C07241.7010605@fjordn.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from asav4.lyse.net ([81.167.36.150]:44903 "EHLO asav4.lyse.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S946266AbXHMPhH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 11:37:07 -0400
Received: from asav4.lyse.net (asav4 [127.0.0.1])
	by localhost (Postfix) with ESMTP id 18CE635019C
	for <linux-ide@vger.kernel.org>; Mon, 13 Aug 2007 17:02:28 +0200 (CEST)
Received: from [127.0.0.1] (15.81-167-171.customer.lyse.net
	[81.167.171.15])by asav4.lyse.net (Postfix) with ESMTP id 04E5B35003Dfor
	<linux-ide@vger.kernel.org>; Mon, 13 Aug 2007 17:02:28 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have experienced some problems with the sata_promise driver on a 
FastTrak4000 card. Doing smart-requests, like munins hddtemp_smartctl 
plugin, to the disks while under load, makes the drives randomly timeout.

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd c8/00:08:d7:b3:ce/00:00:00:00:00/e1 tag 0 cdb 0x0 data \ 
4096  in
          res 40/00:01:01:4f:c2/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/100
ata3: EH complete
sd 3:0:0:0: [sde] 361882080 512-byte hardware sectors (185284 MB)
sd 3:0:0:0: [sde] Write Protect is off
sd 3:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't\ 
support DPO or FUA


Turning off the hddtempt_smartctl plugin in munin makes this problem go 
away. I am currently running 2.6.22.2 on debian stable compiled with 
mostly everything as a module. I used the debian-config for 2.6.18 and 
did make oldconfig.

I have made attempts to figure out if its disk og driver/card related by 
swapping disks around, and the same error occurs with different disks on 
the same card. But it doesnt follow the disks.

Is it expected behaviour that smart makes the drives timeout or is 
something wrong?

As the machine doesnt hold any valuable data at the moment, I am more 
then happy try out patches etc.

The complete dmesg:

  klogd 1.4.1#18, log source = /proc/kmsg started.
  Linux version 2.6.22.2 (ochagenes@litago) (gcc version 4.1.2 20061115 
(prerelease) (Debian 4.1.1-21)) #1 SMP Sun Aug 12 02:55:57 BST 2007
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
   BIOS-e820: 000000003ffe0000 - 000000003ffefc00 (ACPI data)
   BIOS-e820: 000000003ffefc00 - 000000003ffff000 (reserved)
   BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
   BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
   BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  127MB HIGHMEM available.
  896MB LOWMEM available.
  found SMP MP-table at 000fe710
  Zone PFN ranges:
    DMA             0 ->     4096
    Normal       4096 ->   229376
    HighMem    229376 ->   262112
  early_node_map[1] active PFN ranges
      0:        0 ->   262112
  DMI 2.3 present.
  ACPI: RSDP 000FDC40, 0014 (r0 DELL  )
  ACPI: RSDT 000FDC54, 0030 (r1 DELL   PE1600SC        1 MSFT  100000A)
  ACPI: FACP 000FDC84, 0074 (r1 DELL   PE1600SC        1 MSFT  100000A)
  ACPI: DSDT 3FFE0000, 3121 (r1 DELL   PE1600SC        1 MSFT  100000A)
  ACPI: FACS 3FFEFC00, 0040
  ACPI: APIC 000FDCF8, 0088 (r1 DELL   PE1600SC        1 MSFT  100000A)
  ACPI: SPCR 000FDD80, 0050 (r1 DELL   PE1600SC        1 MSFT  100000A)
  ACPI: PM-Timer IO Port: 0x808
  ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
  Processor #0 15:2 APIC version 20
  ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
  Processor #6 15:2 APIC version 20
  ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
  ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
  ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
  ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
  IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-15
  ACPI: IOAPIC (id[0x09] address[0xfec01000] gsi_base[16])
  IOAPIC[1]: apic_id 9, version 17, address 0xfec01000, GSI 16-31
  ACPI: IOAPIC (id[0x0a] address[0xfec02000] gsi_base[32])
  IOAPIC[2]: apic_id 10, version 17, address 0xfec02000, GSI 32-47
  Enabling APIC mode:  Flat.  Using 3 I/O APICs
  Using ACPI (MADT) for SMP configuration information
  Allocating PCI resources starting at 40000000 (gap: 3ffff000:bec01000)
  Built 1 zonelists.  Total pages: 260065
  Kernel command line: auto BOOT_IMAGE=Linux ro root=900
  Enabling fast FPU save and restore... done.
  Enabling unmasked SIMD FPU exception support... done.
  Initializing CPU#0
  PID hash table entries: 4096 (order: 12, 16384 bytes)
  Detected 2790.945 MHz processor.
  Console: colour VGA+ 80x25
  Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
  Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
  Memory: 1030536k/1048448k available (1668k kernel code, 17356k 
reserved, 639k data, 224k init, 130944k highmem)
  virtual kernel memory layout:
      fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
      pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
      vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
      lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
        .init : 0xc0347000 - 0xc037f000   ( 224 kB)
        .data : 0xc02a1039 - 0xc0340f44   ( 639 kB)
        .text : 0xc0100000 - 0xc02a1039   (1668 kB)
  Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
  Calibrating delay using timer specific routine.. 5585.91 BogoMIPS 
(lpj=11171822)
  Security Framework v1.0.0 initialized
  SELinux:  Disabled at boot.
  Capability LSM initialized
  Mount-cache hash table entries: 512
  CPU: Trace cache: 12K uops, L1 D cache: 8K
  CPU: L2 cache: 512K
  CPU: Hyper-Threading is disabled
  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#0.
  CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
  CPU0: Thermal monitoring enabled
  Compat vDSO mapped to ffffe000.
  Checking 'hlt' instruction... OK.
  SMP alternatives: switching to UP code
  ACPI: Core revision 20070126
  CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
  SMP alternatives: switching to SMP code
  Booting processor 1/6 eip 3000
  Initializing CPU#1
  Calibrating delay using timer specific routine.. 5581.87 BogoMIPS 
(lpj=11163752)
  CPU: Trace cache: 12K uops, L1 D cache: 8K
  CPU: L2 cache: 512K
  CPU: Hyper-Threading is disabled
  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#1.
  CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
  CPU1: Thermal monitoring enabled
  CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
  Total of 2 processors activated (11167.78 BogoMIPS).
  ENABLING IO-APIC IRQs
  ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
  checking TSC synchronization [CPU#0 -> CPU#1]: passed.
  Brought up 2 CPUs
  migration_cost=1164
  NET: Registered protocol family 16
  ACPI: bus type pci registered
  PCI: PCI BIOS revision 2.10 entry at 0xfc68e, last bus=2
  PCI: Using configuration type 1
  Setting up standard PCI resources
  ACPI: Interpreter enabled
  ACPI: (supports S0 S4 S5)
  ACPI: Using IOAPIC for interrupt routing
  ACPI: PCI Root Bridge [PCI0] (0000:00)
  ACPI: PCI Root Bridge [PCI1] (0000:01)
  ACPI: PCI Root Bridge [PCI2] (0000:02)
  ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14)
  ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14)
  ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14)
  ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 9 10 11 12 14)
  ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNK8] (IRQs *3 4 5 6 7 9 10 11 12 14)
  ACPI: PCI Interrupt Link [LNK9] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14)
  ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN16] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN17] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN18] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN19] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1A] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1B] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1C] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1D] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1E] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LN1F] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, 
disabled.
  ACPI: PCI Interrupt Link [LUSB] (IRQs 3 4 5 6 7 *10 11 12 14)
  Linux Plug and Play Support v0.97 (c) Adam Belay
  pnp: PnP ACPI init
  ACPI: bus type pnp registered
  pnp: PnP ACPI: found 13 devices
  ACPI: ACPI bus type pnp unregistered
  PnPBIOS: Disabled by ACPI PNP
  PCI: Using ACPI for IRQ routing
  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post 
a report
  NET: Registered protocol family 8
  NET: Registered protocol family 20
  ACPI: RTC can wake from S4
  pnp: 00:09: ioport range 0x814-0x85b has been reserved
  pnp: 00:09: ioport range 0x820-0x83f has been reserved
  pnp: 00:09: ioport range 0x8a0-0x8af has been reserved
  pnp: 00:09: ioport range 0xc00-0xcd7 has been reserved
  pnp: 00:09: ioport range 0xf50-0xf58 has been reserved
  pnp: 00:09: ioport range 0x800-0x819 could not be reserved
  pnp: 00:09: ioport range 0x880-0x89f has been reserved
  pnp: 00:09: ioport range 0x8c0-0x8c3 has been reserved
  pnp: 00:0a: iomem range 0x0-0x0 could not be reserved
  pnp: 00:0a: iomem range 0x0-0x9ffff could not be reserved
  pnp: 00:0a: iomem range 0x100000-0x3fffffff could not be reserved
  pnp: 00:0a: iomem range 0xf0000-0xfffff could not be reserved
  Time: tsc clocksource has been installed.
  NET: Registered protocol family 2
  IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
  TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
  TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
  TCP: Hash tables configured (established 131072 bind 65536)
  TCP reno registered
  checking if image is initramfs... it is
  Freeing initrd memory: 5458k freed
  audit: initializing netlink socket (disabled)
  audit(1186919226.000:1): initialized
  highmem bounce pool size: 64 pages
  VFS: Disk quotas dquot_6.5.1
  Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
  io scheduler noop registered
  io scheduler anticipatory registered
  io scheduler deadline registered
  io scheduler cfq registered (default)
  PCI: MSI quirk detected. MSI deactivated.
  PCI: MSI quirk detected. MSI deactivated.
  isapnp: Scanning for PnP cards...
  isapnp: No Plug & Play device found
  Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
  00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
  PNP: PS/2 Controller [PNP0303:KBD] at 0x60,0x64 irq 1
  PNP: PS/2 controller doesn't have AUX irq; using default 12
  serio: i8042 KBD port at 0x60,0x64 irq 1
  serio: i8042 AUX port at 0x60,0x64 irq 12
  mice: PS/2 mouse device common for all mice
  TCP bic registered
  NET: Registered protocol family 1
  NET: Registered protocol family 17
  Starting balanced_irq
  Using IPI No-Shortcut mode
  Freeing unused kernel memory: 224k freed
  input: AT Translated Set 2 keyboard as /class/input/input0
  ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device 
is not present [20070126]
  ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device 
is not present [20070126]
  Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
  Copyright (c) 1999-2006 Intel Corporation.
  ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
  SCSI subsystem initialized
  Fusion MPT base driver 3.04.04
  Copyright (c) 1999-2007 LSI Logic Corporation
  e1000: 0000:00:02.0: e1000_probe: (PCI:33MHz:32-bit) 00:11:43:d1:19:d8
  Fusion MPT SPI Host driver 3.04.04
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
  e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
  scsi0 : pata_serverworks
  scsi1 : pata_serverworks
  ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x000108b0 
irq 14
  ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x000108b8 
irq 15
  ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 29 (level, low) -> IRQ 17
  mptbase: Initiating ioc0 bringup
  ACPI: PCI Interrupt Link [LUSB] enabled at IRQ 10
  ACPI: PCI Interrupt 0000:00:0f.2[A] -> Link [LUSB] -> GSI 10 (level, 
low) -> IRQ 10
  ohci_hcd 0000:00:0f.2: OHCI Host Controller
  ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
  ohci_hcd 0000:00:0f.2: irq 10, io mem 0xfe120000
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  ioc0: 53C1030: Capabilities={Initiator,Target}
  scsi2 : ioc0: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=17
  scsi 2:0:4:0: Direct-Access     MAXTOR   ATLAS10K4_73WLS  DFV0 PQ: 0 
ANSI: 3
   target2:0:4: Beginning Domain Validation
   target2:0:4: Ending Domain Validation
   target2:0:4: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 
127)
  scsi 2:0:6:0: Direct-Access     MAXTOR   ATLAS10K4_73WLS  DFV0 PQ: 0 
ANSI: 3
   target2:0:6: Beginning Domain Validation
   target2:0:6: Ending Domain Validation
   target2:0:6: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 
127)
  ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 21 (level, low) -> IRQ 18
  ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 19
  scsi3 : sata_promise
  scsi4 : sata_promise
  scsi5 : sata_promise
  scsi6 : sata_promise
  ata3: PATA max UDMA/133 cmd 0xf8832200 ctl 0xf8832238 bmdma 0x00000000 
irq 18
  ata4: PATA max UDMA/133 cmd 0xf8832280 ctl 0xf88322b8 bmdma 0x00000000 
irq 18
  ata5: PATA max UDMA/133 cmd 0xf8832300 ctl 0xf8832338 bmdma 0x00000000 
irq 18
  ata6: PATA max UDMA/133 cmd 0xf8832380 ctl 0xf88323b8 bmdma 0x00000000 
irq 18
  pata_pdc2027x 0000:01:02.0: PLL input clock 33216 kHz
  scsi7 : pata_pdc2027x
  scsi8 : pata_pdc2027x
  ata7: PATA max UDMA/133 cmd 0xf88c17c0 ctl 0xf88c1fda bmdma 0xf88c1000 
irq 19
  ata8: PATA max UDMA/133 cmd 0xf88c15c0 ctl 0xf88c1dda bmdma 0xf88c1008 
irq 19
  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
  sd 2:0:4:0: [sda] 143666192 512-byte hardware sectors (73557 MB)
  sd 2:0:4:0: [sda] Write Protect is off
  sd 2:0:4:0: [sda] Write cache: enabled, read cache: enabled, supports 
DPO and FUA
  sd 2:0:4:0: [sda] 143666192 512-byte hardware sectors (73557 MB)
  sd 2:0:4:0: [sda] Write Protect is off
  sd 2:0:4:0: [sda] Write cache: enabled, read cache: enabled, supports 
DPO and FUA
   sda: sda1
  sd 2:0:4:0: [sda] Attached SCSI disk
  sd 2:0:6:0: [sdb] 143666192 512-byte hardware sectors (73557 MB)
  sd 2:0:6:0: [sdb] Write Protect is off
  sd 2:0:6:0: [sdb] Write cache: enabled, read cache: enabled, supports 
DPO and FUA
  sd 2:0:6:0: [sdb] 143666192 512-byte hardware sectors (73557 MB)
  sd 2:0:6:0: [sdb] Write Protect is off
  sd 2:0:6:0: [sdb] Write cache: enabled, read cache: enabled, supports 
DPO and FUA
   sdb: sdb1
  sd 2:0:6:0: [sdb] Attached SCSI disk
  ata3.00: ATA-6: IC35L180AVV207-1, V26OA66A, max UDMA/100
  ata3.00: 361882080 sectors, multi 0: LBA48
  ata3.00: configured for UDMA/100
  ata7.01: ATA-7: Maxtor 6Y200P0, YAR41VW0, max UDMA/133
  ata7.01: 398297088 sectors, multi 16: LBA48
  ata7.01: configured for UDMA/133
  ata4.00: ATA-6: IC35L180AVV207-1, V26OA66A, max UDMA/100
  ata4.00: 361882080 sectors, multi 0: LBA48
  ata4.00: configured for UDMA/100
  ata8.01: ATA-7: Maxtor 6Y200P0, YAR41VW0, max UDMA/133
  ata8.01: 398297088 sectors, multi 16: LBA48
  ata8.01: configured for UDMA/133
  scsi 7:0:1:0: Direct-Access     ATA      Maxtor 6Y200P0   YAR4 PQ: 0 
ANSI: 5
  sd 7:0:1:0: [sdc] 398297088 512-byte hardware sectors (203928 MB)
  sd 7:0:1:0: [sdc] Write Protect is off
  sd 7:0:1:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 7:0:1:0: [sdc] 398297088 512-byte hardware sectors (203928 MB)
  sd 7:0:1:0: [sdc] Write Protect is off
  sd 7:0:1:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdc: sdc1 sdc2
  sd 7:0:1:0: [sdc] Attached SCSI disk
  scsi 8:0:1:0: Direct-Access     ATA      Maxtor 6Y200P0   YAR4 PQ: 0 
ANSI: 5
  sd 8:0:1:0: [sdd] 398297088 512-byte hardware sectors (203928 MB)
  sd 8:0:1:0: [sdd] Write Protect is off
  sd 8:0:1:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 8:0:1:0: [sdd] 398297088 512-byte hardware sectors (203928 MB)
  sd 8:0:1:0: [sdd] Write Protect is off
  sd 8:0:1:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdd: sdd1 sdd2
  sd 8:0:1:0: [sdd] Attached SCSI disk
  ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 20 (level, low) -> IRQ 20
  ata5.00: ATA-6: IC35L180AVV207-1, V26OA66A, max UDMA/100
  ata5.00: 361882080 sectors, multi 0: LBA48
  ata5.00: configured for UDMA/100
  pata_pdc2027x 0000:01:06.0: PLL input clock 33216 kHz
  scsi9 : pata_pdc2027x
  scsi10 : pata_pdc2027x
  ata9: PATA max UDMA/133 cmd 0xf89497c0 ctl 0xf8949fda bmdma 0xf8949000 
irq 20
  ata10: PATA max UDMA/133 cmd 0xf89495c0 ctl 0xf8949dda bmdma 
0xf8949008 irq 20
  ata6.00: ATA-6: IC35L180AVV207-1, V26OA66A, max UDMA/100
  ata6.00: 361882080 sectors, multi 0: LBA48
  ata6.00: configured for UDMA/100
  scsi 3:0:0:0: Direct-Access     ATA      IC35L180AVV207-1 V26O PQ: 0 
ANSI: 5
  sd 3:0:0:0: [sde] 361882080 512-byte hardware sectors (185284 MB)
  sd 3:0:0:0: [sde] Write Protect is off
  sd 3:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 3:0:0:0: [sde] 361882080 512-byte hardware sectors (185284 MB)
  sd 3:0:0:0: [sde] Write Protect is off
  sd 3:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sde: sde1
  sd 3:0:0:0: [sde] Attached SCSI disk
  scsi 4:0:0:0: Direct-Access     ATA      IC35L180AVV207-1 V26O PQ: 0 
ANSI: 5
  sd 4:0:0:0: [sdf] 361882080 512-byte hardware sectors (185284 MB)
  sd 4:0:0:0: [sdf] Write Protect is off
  sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 4:0:0:0: [sdf] 361882080 512-byte hardware sectors (185284 MB)
  sd 4:0:0:0: [sdf] Write Protect is off
  sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdf: sdf1
  sd 4:0:0:0: [sdf] Attached SCSI disk
  scsi 5:0:0:0: Direct-Access     ATA      IC35L180AVV207-1 V26O PQ: 0 
ANSI: 5
  sd 5:0:0:0: [sdg] 361882080 512-byte hardware sectors (185284 MB)
  sd 5:0:0:0: [sdg] Write Protect is off
  sd 5:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 5:0:0:0: [sdg] 361882080 512-byte hardware sectors (185284 MB)
  sd 5:0:0:0: [sdg] Write Protect is off
  sd 5:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdg:<6>ata9.01: ATA-6: WDC WD2000BB-22GUA0, 08.02D08, max UDMA/100
  ata9.01: 390721968 sectors, multi 16: LBA48
   sdg1
  sd 5:0:0:0: [sdg] Attached SCSI disk
  scsi 6:0:0:0: Direct-Access     ATA      IC35L180AVV207-1 V26O PQ: 0 
ANSI: 5
  sd 6:0:0:0: [sdh] 361882080 512-byte hardware sectors (185284 MB)
  sd 6:0:0:0: [sdh] Write Protect is off
  sd 6:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 6:0:0:0: [sdh] 361882080 512-byte hardware sectors (185284 MB)
  sd 6:0:0:0: [sdh] Write Protect is off
  sd 6:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdh:<6>ata9.01: configured for UDMA/100
   sdh1
  sd 6:0:0:0: [sdh] Attached SCSI disk
  ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 21
  scsi11 : sata_promise
  scsi12 : sata_promise
  scsi13 : sata_promise
  scsi14 : sata_promise
  ata11: PATA max UDMA/133 cmd 0xf883a200 ctl 0xf883a238 bmdma 
0x00000000 irq 21
  ata12: PATA max UDMA/133 cmd 0xf883a280 ctl 0xf883a2b8 bmdma 
0x00000000 irq 21
  ata13: PATA max UDMA/133 cmd 0xf883a300 ctl 0xf883a338 bmdma 
0x00000000 irq 21
  ata14: PATA max UDMA/133 cmd 0xf883a380 ctl 0xf883a3b8 bmdma 
0x00000000 irq 21
  ata10.01: ATA-6: WDC WD2000BB-22GUA0, 08.02D08, max UDMA/100
  ata10.01: 390721968 sectors, multi 16: LBA48
  ata11.00: ATA-6: HDS722525VLAT80, V36OA6MA, max UDMA/100
  ata11.00: 488397168 sectors, multi 0: LBA48
  ata10.01: configured for UDMA/100
  scsi 9:0:1:0: Direct-Access     ATA      WDC WD2000BB-22G 08.0 PQ: 0 
ANSI: 5
  sd 9:0:1:0: [sdi] 390721968 512-byte hardware sectors (200050 MB)
  sd 9:0:1:0: [sdi] Write Protect is off
  sd 9:0:1:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 9:0:1:0: [sdi] 390721968 512-byte hardware sectors (200050 MB)
  sd 9:0:1:0: [sdi] Write Protect is off
  sd 9:0:1:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdi: sdi1 sdi2
  sd 9:0:1:0: [sdi] Attached SCSI disk
  scsi 10:0:1:0: Direct-Access     ATA      WDC WD2000BB-22G 08.0 PQ: 0 
ANSI: 5
  sd 10:0:1:0: [sdj] 390721968 512-byte hardware sectors (200050 MB)
  sd 10:0:1:0: [sdj] Write Protect is off
  sd 10:0:1:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 10:0:1:0: [sdj] 390721968 512-byte hardware sectors (200050 MB)
  sd 10:0:1:0: [sdj] Write Protect is off
  sd 10:0:1:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdj:<6>ata11.00: configured for UDMA/100
   sdj1 sdj2
  sd 10:0:1:0: [sdj] Attached SCSI disk
  ata12.00: ATA-6: HDS722525VLAT80, V36OA6MA, max UDMA/100
  ata12.00: 488397168 sectors, multi 0: LBA48
  ata12.00: configured for UDMA/100
  ata13.00: ATA-6: HDS722525VLAT80, V36OA6MA, max UDMA/100
  ata13.00: 488397168 sectors, multi 0: LBA48
  ata13.00: configured for UDMA/100
  ata14.00: ATA-6: HDS722525VLAT80, V36OA6MA, max UDMA/100
  ata14.00: 488397168 sectors, multi 0: LBA48
  ata14.00: configured for UDMA/100
  scsi 11:0:0:0: Direct-Access     ATA      HDS722525VLAT80  V36O PQ: 0 
ANSI: 5
  sd 11:0:0:0: [sdk] 488397168 512-byte hardware sectors (250059 MB)
  sd 11:0:0:0: [sdk] Write Protect is off
  sd 11:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 11:0:0:0: [sdk] 488397168 512-byte hardware sectors (250059 MB)
  sd 11:0:0:0: [sdk] Write Protect is off
  sd 11:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdk: unknown partition table
  sd 11:0:0:0: [sdk] Attached SCSI disk
  scsi 12:0:0:0: Direct-Access     ATA      HDS722525VLAT80  V36O PQ: 0 
ANSI: 5
  sd 12:0:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
  sd 12:0:0:0: [sdl] Write Protect is off
  sd 12:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 12:0:0:0: [sdl] 488397168 512-byte hardware sectors (250059 MB)
  sd 12:0:0:0: [sdl] Write Protect is off
  sd 12:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdl: unknown partition table
  sd 12:0:0:0: [sdl] Attached SCSI disk
  scsi 13:0:0:0: Direct-Access     ATA      HDS722525VLAT80  V36O PQ: 0 
ANSI: 5
  sd 13:0:0:0: [sdm] 488397168 512-byte hardware sectors (250059 MB)
  sd 13:0:0:0: [sdm] Write Protect is off
  sd 13:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 13:0:0:0: [sdm] 488397168 512-byte hardware sectors (250059 MB)
  sd 13:0:0:0: [sdm] Write Protect is off
  sd 13:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdm: unknown partition table
  sd 13:0:0:0: [sdm] Attached SCSI disk
  scsi 14:0:0:0: Direct-Access     ATA      HDS722525VLAT80  V36O PQ: 0 
ANSI: 5
  sd 14:0:0:0: [sdn] 488397168 512-byte hardware sectors (250059 MB)
  sd 14:0:0:0: [sdn] Write Protect is off
  sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sd 14:0:0:0: [sdn] 488397168 512-byte hardware sectors (250059 MB)
  sd 14:0:0:0: [sdn] Write Protect is off
  sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
   sdn: unknown partition table
  sd 14:0:0:0: [sdn] Attached SCSI disk
  md: raid1 personality registered for level 1
  raid5: automatically using best checksumming function: pIII_sse
     pIII_sse  :  3617.000 MB/sec
  raid5: using function: pIII_sse (3617.000 MB/sec)
  raid6: int32x1    857 MB/s
  raid6: int32x2    860 MB/s
  raid6: int32x4    732 MB/s
  raid6: int32x8    519 MB/s
  raid6: mmxx1     2247 MB/s
  raid6: mmxx2     2453 MB/s
  raid6: sse1x1    1160 MB/s
  raid6: sse1x2    1960 MB/s
  raid6: sse2x1    2083 MB/s
  raid6: sse2x2    2832 MB/s
  raid6: using algorithm sse2x2 (2832 MB/s)
  md: raid6 personality registered for level 6
  md: raid5 personality registered for level 5
  md: raid4 personality registered for level 4
  md: md2 stopped.
  md: bind<sdk>
  md: bind<sdn>
  md: bind<sdl>
  md: bind<sdm>
  raid5: device sdm operational as raid disk 0
  raid5: device sdl operational as raid disk 3
  raid5: device sdn operational as raid disk 2
  raid5: device sdk operational as raid disk 1
  raid5: allocated 4204kB for md2
  raid5: raid level 5 set md2 active with 4 out of 4 devices, algorithm 2
  RAID5 conf printout:
   --- rd:4 wd:4
   disk 0, o:1, dev:sdm
   disk 1, o:1, dev:sdk
   disk 2, o:1, dev:sdn
   disk 3, o:1, dev:sdl
  md: md1 stopped.
  md: bind<sdh1>
  md: bind<sdg1>
  md: bind<sde1>
  md: bind<sdj1>
  md: bind<sdi1>
  md: bind<sdc1>
  md: bind<sdd1>
  md: bind<sdf1>
  raid5: device sdf1 operational as raid disk 0
  raid5: device sdc1 operational as raid disk 7
  raid5: device sdi1 operational as raid disk 5
  raid5: device sdj1 operational as raid disk 4
  raid5: device sde1 operational as raid disk 3
  raid5: device sdg1 operational as raid disk 2
  raid5: device sdh1 operational as raid disk 1
  raid5: allocated 8368kB for md1
  RAID5 conf printout:
   --- rd:8 wd:7
   disk 0, o:1, dev:sdf1
   disk 1, o:1, dev:sdh1
   disk 2, o:1, dev:sdg1
   disk 3, o:1, dev:sde1
   disk 4, o:1, dev:sdj1
   disk 5, o:1, dev:sdi1
   disk 7, o:1, dev:sdc1
  RAID5 conf printout:
   --- rd:8 wd:7
   disk 0, o:1, dev:sdf1
   disk 1, o:1, dev:sdh1
   disk 2, o:1, dev:sdg1
   disk 3, o:1, dev:sde1
   disk 4, o:1, dev:sdj1
   disk 5, o:1, dev:sdi1
   disk 6, o:1, dev:sdd1
   disk 7, o:1, dev:sdc1
  md: recovery of RAID array md1
  md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
  md: using maximum available idle IO bandwidth (but not more than 
200000 KB/sec) for recovery.
  md: using 128k window, over a total of 180939968 blocks.
  md: md0 stopped.
  md: bind<sdb1>
  md: bind<sda1>
  raid1: raid set md0 active with 2 out of 2 mirrors
  device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
  kjournald starting.  Commit interval 5 seconds
  EXT3-fs: mounted filesystem with ordered data mode.
  input: PC Speaker as /class/input/input1
  parport_pc 00:07: reported by Plug and Play ACPI
  parport0: PC-style at 0x378 (0x778), irq 7, dma 1 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
  Linux agpgart interface v0.102 (c) Dave Jones
  Real Time Clock Driver v1.12ac
  piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
  FDC 0 is a National Semiconductor PC87306
  EXT3 FS on md0, internal journal
  loop: module loaded
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on dm-1, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on dm-0, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  ip_tables: (C) 2000-2006 Netfilter Core Team
  e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, 
Flow Control: RX/TX
  input: Power Button (FF) as /class/input/input2
  ACPI: Power Button (FF) [PWRF]
  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
  NFSD: starting 90-second grace period
  NET: Registered protocol family 10
  lo: Disabled Privacy Extensions

