From: Jason Keltz <jas@cse.yorku.ca>
Subject: ide cdrom problems on new imac
Date: Fri, 06 Jun 2008 13:16:12 -0400
Message-ID: <484970DC.3060209@cse.yorku.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030504050905020701060303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bronze.cs.yorku.ca ([130.63.90.34]:47519 "EHLO
	bronze.cs.yorku.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYFFR7q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 13:59:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504050905020701060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff.

I have the task of determining whether I can get our current Linux 
distribution (CentOS 4.6) to install on a lab of new Apple iMacs.  One 
of the issues seems to be that while the CD-Rom seems to work with the 
regular kernel, each time I try to access it, I get errors as follows:

irq 185: nobody cared! (screaming interrupt?)
irq 185: Please try booting with acpi=off and report a bug
  [<c0107662>] __report_bad_irq+0x3a/0x77
  [<c01078d9>] note_interrupt+0xea/0x115
  [<c0107b85>] do_IRQ+0x143/0x1b8
  [<c02f1a98>] common_interrupt+0x18/0x20
  [<c01040fb>] mwait_idle+0x33/0x42
  [<c01040a4>] cpu_idle+0x2a/0x4e
  [<c03bd786>] start_kernel+0x199/0x19d
handlers:
[<c025d0ae>] (ide_intr+0x0/0x11e)
Disabling IRQ #185

I can't use acpi=off because if I do, the Marvell network driver fails, 
and the errors don't go away anyway.

I was hoping for some advice.

dmesg output attached in dmesg.out but probably most importantly:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH8M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 21 (level, low) -> IRQ 185
ICH8M: chipset revision 3
ICH8M: 100% native mode on irq 185
     ide0: BM-DMA at 0x70e0-0x70e7, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x70e8-0x70ef, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-R UJ-875, ATAPI CD/DVD-ROM drive
Using cfq io scheduler
ide0 at 0x7108-0x710f,0x711e on irq 185
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
.
.
.

libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x70F8 ctl 0x7116 bmdma 0x7020 irq 209
ata2: SATA max UDMA/133 cmd 0x70F0 ctl 0x7112 bmdma 0x7028 irq 209
scsi0 : ata_piix
ata1.00: ATA-8, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
   Vendor: ATA       Model: WDC WD5000AAKS-4  Rev: 58.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

It isn't clear to me whether the device is recognized by libata 
ata_piix, or just by a separate kernel IDE Intel PIIX driver?

After this point in the boot sequence is when I start getting a lot of 
these errors:

irq 185: nobody cared! (screaming interrupt?)
irq 185: Please try booting with acpi=off and report a bug
  [<c0107662>] __report_bad_irq+0x3a/0x77
  [<c01078d9>] note_interrupt+0xea/0x115
  [<c0107b85>] do_IRQ+0x143/0x1b8
  [<c02f1a98>] common_interrupt+0x18/0x20
  [<c01040fb>] mwait_idle+0x33/0x42
  [<c01040a4>] cpu_idle+0x2a/0x4e
  [<c03bd786>] start_kernel+0x199/0x19d
handlers:
[<c025d0ae>] (ide_intr+0x0/0x11e)
Disabling IRQ #185

cat /proc/interrupts:

            CPU0       CPU1
   0:     195845     198319    IO-APIC-edge  timer
   8:          1          5    IO-APIC-edge  rtc
   9:          1          0   IO-APIC-level  acpi
169:       8522       8886   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
177:        501        288   IO-APIC-level  HDA Intel, ehci_hcd, uhci_hcd
185:      50016      49987   IO-APIC-level  ide0, ehci_hcd, uhci_hcd
193:          2          0   IO-APIC-level  ohci1394
201:      22104       1750   IO-APIC-level  eth0
209:       9009       7020   IO-APIC-level  libata, uhci_hcd
NMI:          0          0
LOC:     394050     393992
ERR:          3
MIS:          0

lspci -v output attached in lspci.out but probably most importantly:

00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) 
IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
         Subsystem: Apple Computer Inc.: Unknown device 00a0
         Flags: bus master, medium devsel, latency 0, IRQ 185
         I/O ports at 7108 [size=8]
         I/O ports at 711c [size=4]
         I/O ports at 7100 [size=8]
         I/O ports at 7118 [size=4]
         I/O ports at 70e0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) 
SATA IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
         Subsystem: Apple Computer Inc.: Unknown device 00a0
         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 209
         I/O ports at 70f8 [size=8]
         I/O ports at 7114 [size=4]
         I/O ports at 70f0 [size=8]
         I/O ports at 7110 [size=4]
         I/O ports at 7020 [size=16]
         I/O ports at 4000 [size=16]
         Capabilities: [70] Power Management version 3

I see that in the libata.c file included with CentOS update 4.6, the 
version doesn't include some of the "Apple Specific" PCI stuff that you 
added to a later release, so I tried to build a patch to make the CentOS 
4.6 libata behave like a newer one:

--- ata_piix.c.orig     2008-06-06 11:59:08.000000000 -0400
+++ ata_piix.c  2008-06-06 11:59:29.000000000 -0400
@@ -104,6 +104,7 @@
         PIIX_FLAG_SCR           = (1 << 26), /* SCR available */
         PIIX_FLAG_AHCI          = (1 << 27), /* AHCI possible */
         PIIX_FLAG_CHECKINTR     = (1 << 28), /* make sure PCI INTx 
enabled */
+       PIIX_FLAG_SIDPR         = (1 << 29), /* SATA idx/data pair regs */

         PIIX_PATA_FLAGS         = ATA_FLAG_SLAVE_POSS,
         PIIX_SATA_FLAGS         = ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
@@ -128,6 +129,7 @@
         ich6_sata_ahci          = 7,
         ich6m_sata_ahci         = 8,
         ich8_sata_ahci          = 9,
+        ich8m_apple_sata_ahci   = 10,

         /* constants for mapping table */
         P0                      = 0,  /* port 0 */
@@ -234,6 +236,8 @@
         { 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
         /* Mobile SATA Controller IDE (ICH8M) */
         { 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+        /* Mobile SATA Controller IDE (ICH8M), Apple */
+        { 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata_ahci },
         /* SATA Controller IDE (ICH9) */
         { 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
         /* SATA Controller IDE (ICH9) */
@@ -535,6 +539,16 @@
                 .port_ops       = &piix_sata_ops,
         },

+        [ich8m_apple_sata_ahci] =
+        {
+                .flags          = PIIX_SATA_FLAGS | PIIX_FLAG_AHCI |
+                                  PIIX_FLAG_SIDPR,
+                .pio_mask       = 0x1f, /* pio0-4 */
+                .mwdma_mask     = 0x07, /* mwdma0-2 */
+                .udma_mask      = ATA_UDMA6,
+                .port_ops       = &piix_sata_ops,
+        },
+
         /* ich8_sata_ahci: 9 */
         {
                 .sht            = &piix_sht,
~

Of course now, while my kernel now compiles, it also just panics almost 
right away, so this didn't get me anywhere.  I get something like this 
for traceback:

ata_device_add [libata]
ata_pci_init_one [libata]
call_console_drivers
pci_get_subsys
pci_get_device
piix_check_450nx_errata [ata_piix]
piix_init_one [ata_piix]
pci_device_probe_static
__pci_device_probe
pci_device_probe
bus_match
driver_match
bus_add_driver
pci_register_driver
piix_init [ata_piix]
sys_init_module
syscall_call

I've read in various postings that the Intel PIIX IDE driver doesn't 
handle IRQ clearing (or something like that) correctly, and that libata 
does, which was why I was trying to make libata recognize the device and 
then I would have made the kernel intel ata_piix driver not recognize 
it... but I don't even know if I'm on the right track with that 
assumption or not.

Sorry for my long message.  Again, I'm hoping for any possible feedback. 
  I've spent many hours working on this.

Thanks,

Jason Keltz
jas@cse.yorku.ca

--------------030504050905020701060303
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.6.9-67.0.15.EL.CSE.smp (root@navy) (gcc version 3.4.6) #1 SMP Fri Jun 6 12:29:20 EDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ed44000 (usable)
 BIOS-e820: 000000007ed44000 - 000000007ef45000 (ACPI NVS)
 BIOS-e820: 000000007ef45000 - 000000007effb000 (ACPI data)
 BIOS-e820: 000000007effb000 - 000000007effd000 (ACPI NVS)
 BIOS-e820: 000000007effd000 - 000000007fec4000 (ACPI data)
 BIOS-e820: 000000007fec4000 - 000000007fec6000 (ACPI NVS)
 BIOS-e820: 000000007fec6000 - 000000007fec9000 (ACPI data)
 BIOS-e820: 000000007fec9000 - 000000007fedf000 (ACPI NVS)
 BIOS-e820: 000000007fedf000 - 000000007fef9000 (ACPI data)
 BIOS-e820: 000000007fef9000 - 000000007feff000 (reserved)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
1133MB HIGHMEM available.
896MB LOWMEM available.
NX (Execute Disable) protection: active
On node 0 totalpages: 519492
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 290116 pages, LIFO batch:16
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP (v002 APPLE                                 ) @ 0x000fe020
ACPI: XSDT (v001 APPLE   Apple00 0x000000c1      0x01000013) @ 0x7feee1c0
ACPI: FADT (v003 APPLE   Apple00 0x000000c1 Loki 0x0000005f) @ 0x7feec000
ACPI: HPET (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7feeb000
ACPI: MADT (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7feea000
ACPI: MCFG (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7fee9000
ACPI: ASF! (v032 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7fee8000
ACPI: SBST (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7fee7000
ACPI: ECDT (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x7fee6000
ACPI: SSDT (v001  APPLE    CpuPm 0x00003000 INTL 0x20061109) @ 0x7fec8000
ACPI: SSDT (v001  APPLE  Cpu0Tst 0x00003000 INTL 0x20061109) @ 0x7fec7000
ACPI: SSDT (v001  APPLE  Cpu1Tst 0x00003000 INTL 0x20061109) @ 0x7fec6000
ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20061109) @ 0x7fee1000
ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20061109) @ 0x7fee0000
ACPI: DSDT (v001 APPLE      iMac 0x00080001 INTL 0x20061109) @ 0x00000000
ACPI: BIOS age (2000) fails cutoff (2001), acpi=force is required to enable ACPI
ACPI: acpi=force override
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Enabling APIC mode:  Flat.  Using 0 I/O APICs
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda3 acpi=force
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0418000 soft=c03f8000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2054372k/2077968k available (1991k kernel code, 22600k reserved, 805k data, 192k init, 1160464k highmem)
Using HPET for base-timer
Using HPET for gettimeofday
Detected 3059.232 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 6122.87 BogoMIPS (lpj=3061436)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 20100000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU0: Physical Processor ID: 0
CPU0: Processor Core ID: 0
CPU0: Initial APIC ID: 0
CPU: After all inits, caps:        bfebfbff 20100000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: System reset via FADT Reset Register is supported
CPU0: Intel(R) Core(TM)2 Duo CPU     E8435  @ 3.06GHz stepping 06
per-CPU timeslice cutoff: 17551.49 usecs.
task migration cache decay timeout: 17 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0419000 soft=c03f9000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6118.00 BogoMIPS (lpj=3059004)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 20100000 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU1: Physical Processor ID: 0
CPU1: Processor Core ID: 1
CPU1: Initial APIC ID: 1
CPU: After all inits, caps:        bfebfbff 20100000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     E8435  @ 3.06GHz stepping 06
Total of 2 processors activated (12240.88 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
zapping low mappings.
checking if image is initramfs... it is
Freeing initrd memory: 607k freed
NET: Registered protocol family 16
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Unable to handle 64-bit address space for 
PCI: Unable to handle 64-bit address space for 
PCI: Unable to handle 64-bit address space for 
PCI: Unable to handle 64-bit address space for 
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 *6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: Embedded Controller [EC] (gpe 23)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 21 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 201
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 18 (level, low) -> IRQ 209
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 20 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 21 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 209
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 20 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 201
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1212756762.610:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 2EC1B47079EE6772
  - key was been created 12944 seconds in future
- User ID: CentOS (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 68 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH8M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 21 (level, low) -> IRQ 185
ICH8M: chipset revision 3
ICH8M: 100% native mode on irq 185
    ide0: BM-DMA at 0x70e0-0x70e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x70e8-0x70ef, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-R UJ-875, ATAPI CD/DVD-ROM drive
Using cfq io scheduler
ide0 at 0x7108-0x710f,0x711e on irq 185
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
APIC error on CPU0: 00(60)
APIC error on CPU0: 60(60)
APIC error on CPU0: 60(60)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 262144 (order: 9, 3145728 bytes)
TCP: Hash tables configured (established 262144 bind 262144)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
FRWR ARPT GIGE UHC1 UHC2 UHC3 UHC4 UHC5 EHC1 EHC2   EC 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 192k freed
SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x70F8 ctl 0x7116 bmdma 0x7020 irq 209
ata2: SATA max UDMA/133 cmd 0x70F0 ctl 0x7112 bmdma 0x7028 irq 209
scsi0 : ata_piix
ata1.00: ATA-8, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD5000AAKS-4  Rev: 58.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
irq 185: nobody cared! (screaming interrupt?)
irq 185: Please try booting with acpi=off and report a bug
 [<c0107662>] __report_bad_irq+0x3a/0x77
 [<c01078d9>] note_interrupt+0xea/0x115
 [<c0107b85>] do_IRQ+0x143/0x1b8
 [<c02f1a98>] common_interrupt+0x18/0x20
 [<c01040fb>] mwait_idle+0x33/0x42
 [<c01040a4>] cpu_idle+0x2a/0x4e
 [<c03bd786>] start_kernel+0x199/0x19d
handlers:
[<c025d0ae>] (ide_intr+0x0/0x11e)
Disabling IRQ #185
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
inserting floppy driver for 2.6.9-67.0.15.EL.CSE.smp
floppy0: no floppy controllers found
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 201
sk98lin: Network Device Driver v10.60.2.3
(C)Copyright 1999-2008 Marvell(R).
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:05:00.0 to 64
divert: allocating divert_blk for eth0
eth0: Marvell Yukon 88E8058 Gigabit Ethernet Controller
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
hw_random hardware driver 1.0.0 loaded
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86 Kernel Module  169.12  Thu Feb 14 17:53:07 PST 2008
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 21 (level, low) -> IRQ 185
ehci_hcd 0000:00:1a.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: irq 185, pci mem f8910c00
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 20 (level, low) -> IRQ 177
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 177, pci mem f8912800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 177
uhci_hcd 0000:00:1a.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: irq 177, io base 000070c0
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 16 (level, low) -> IRQ 169
uhci_hcd 0000:00:1a.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: irq 169, io base 000070a0
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 169, io base 00007080
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 18 (level, low) -> IRQ 209
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 209, io base 00007060
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 185
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 185, io base 00007040
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:03:00.0 to 64
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[a3400000-a34007ff]  Max Packet=[4096]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
usb 2-1: new high speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 2-4: new high speed USB device using address 3
usb 3-1: new full speed USB device using address 2
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usb 2-1.2: new low speed USB device using address 5
input: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1d.7-1.2
input: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1d.7-1.2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001ff3fffe304b46]
usb 2-1.3: new low speed USB device using address 6
input: USB HID v1.10 Mouse [Primax Electronics Apple Optical USB Mouse] on usb-0000:00:1d.7-1.3
usb 7-1: new low speed USB device using address 2
EXT3 FS on sda3, internal journal
device-mapper: 4.5.5-ioctl (2006-12-01) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2040244k swap on /dev/sda2.  Priority:-1 extents:1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No new microdata for cpu 1
microcode: No new microdata for cpu 0
IA-32 Microcode Update Driver v1.14 unregistered
usb 7-1: control timeout on ep0out
uhci_hcd 0000:00:1d.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 340 bytes per conntrack
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
usb 7-1: control timeout on ep0out
usb 7-1: device not accepting address 2, error -110
usb 7-1: new low speed USB device using address 3
usb 7-1: control timeout on ep0out
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0369c00(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
divert: not allocating divert_blk for non-ethernet device tun0
usb 7-1: control timeout on ep0out
usb 7-1: device not accepting address 3, error -110
usb 3-1.1: new full speed USB device using address 3
usb 3-1.2: new full speed USB device using address 4
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
ieee1394: raw1394: /dev/raw1394 device initialized
video1394: Installed video1394 module
eth0: no IPv6 routers present
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.11 Keyboard [05ac:820a] on usb-0000:00:1a.0-1.2
usb 3-1.3: new full speed USB device using address 5
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.11 Mouse [05ac:820b] on usb-0000:00:1a.0-1.3
input: PC Speaker

--------------030504050905020701060303
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub (rev 03)
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile PM965/GM965/GL960 PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: a0000000-a30fffff
	Prefetchable memory behind bridge: 0000000080000000-000000009ff00000
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 3
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Contoller #4 (rev 03) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at 70c0 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 70a0 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 185
	Memory at a3604c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, fast devsel, latency 0, IRQ 177
	Memory at a3600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Flags: fast devsel
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: a3500000-a35fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: a3400000-a34fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Memory behind bridge: a3300000-a33fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 6 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: a3200000-a32fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 7080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 209
	I/O ports at 7060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at 7040 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 177
	Memory at a3604800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	Memory behind bridge: a3100000-a31fffff
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface Controller (rev 03)
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at 7108 [size=8]
	I/O ports at 711c [size=4]
	I/O ports at 7100 [size=8]
	I/O ports at 7118 [size=4]
	I/O ports at 70e0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 209
	I/O ports at 70f8 [size=8]
	I/O ports at 7114 [size=4]
	I/O ports at 70f0 [size=8]
	I/O ports at 7110 [size=4]
	I/O ports at 7020 [size=16]
	I/O ports at 4000 [size=16]
	Capabilities: [70] Power Management version 3

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
	Subsystem: Apple Computer Inc.: Unknown device 00a0
	Flags: medium devsel, IRQ 177
	Memory at a3605000 (32-bit, non-prefetchable) [size=256]
	I/O ports at efa0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0609 (rev a2) (prog-if 00 [VGA])
	Subsystem: Apple Computer Inc.: Unknown device 00a7
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at a2000000 (32-bit, non-prefetchable) [size=16M]
	Memory at 80000000 (64-bit, prefetchable) [size=512M]
	Memory at a0000000 (64-bit, non-prefetchable) [size=32M]
	I/O ports at 6000 [size=128]
	Expansion ROM at a3000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 3
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting
	Capabilities: [600] Unknown (11)

03:00.0 FireWire (IEEE 1394): Agere Systems: Unknown device 5901 (rev 06) (prog-if 10 [OHCI])
	Subsystem: Agere Systems: Unknown device 5900
	Flags: bus master, fast devsel, latency 0, IRQ 193
	Memory at a3400000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 3
	Capabilities: [4c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [60] Express Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [170] Device Serial Number 00-00-00-00-00-00-00-00

04:00.0 Network controller: Broadcom Corporation BCM4328 802.11a/b/g/n (rev 05)
	Subsystem: Apple Computer Inc.: Unknown device 008c
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at a3300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [58] Vendor Specific Information
	Capabilities: [e8] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel
	Capabilities: [160] Device Serial Number 1e-00-c3-ff-ff-c2-62-d8
	Capabilities: [16c] Power Budgeting

05:00.0 Ethernet controller: Marvell Technology Group Ltd. Marvell Yukon 88E8058 PCI-E Gigabit Ethernet Controller (rev 13)
	Subsystem: Marvell Technology Group Ltd.: Unknown device 00ba
	Flags: bus master, fast devsel, latency 0, IRQ 201
	Memory at a3200000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 5000 [size=256]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 3
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting


--------------030504050905020701060303--
