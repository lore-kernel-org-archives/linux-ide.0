From: Brad Campbell <brad@wasp.net.au>
Subject: 2.6.19-rc3 pata_hpt37x dying with "irq 16: nobody cared"
Date: Wed, 25 Oct 2006 01:31:26 +0400
Message-ID: <453E862E.2020308@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:38042 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1161227AbWJXVb5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2006 17:31:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

G'day all,

I have a Highpoint Rocketraid 1540 (which is a 374 with SATA bridges) driving 3 WD 200GB ATA drives 
via SATA-PATA bridgeboards. Within 5-10 minutes of starting a RAID sync on the machine I can kill it 
repeatably. This machine boots with PXE and runs an nfs root. It has 3 drives and a single 4-port 
controller. It has nothing on it I'm remotely afraid of losing and would not particularly flinch if 
the whole thing exploded. I really only put it together to try and help test the HPT libata code, so 
if there are any nasty tests I can perform I'm more than happy to do so.

I have tried with all permutations of irqpoll and pci=routeirq. If I don't use irqpoll then it takes 
forever to get past the initial device probe on bootup where it reports "abnormal status".

I managed to get it to hardlock once with the standard IDE driver also, however I do *know* for 
certain that happened when one of the drives hit a bad sector. I'm not sure how good the error 
recovery code is in the IDE driver.

I've included full dmesg, lspci -v, /proc/cpuinfo/interrupts/ioports. Is there anything else that 
might help ?

Regards,
Brad

--

Linux version 2.6.19-rc3 (brad@srv) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #7 Wed Oct 25 01:04:21 
GST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003eff0000 (usable)
  BIOS-e820: 000000003eff0000 - 000000003eff3000 (ACPI NVS)
  BIOS-e820: 000000003eff3000 - 000000003f000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1007MB LOWMEM available.
found SMP MP-table at 000f52d0
Entering add_active_range(0, 0, 258032) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   258032
early_node_map[1] active PFN ranges
     0:        0 ->   258032
On node 0 totalpages: 258032
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 1983 pages used for memmap
   Normal zone: 251953 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 KM266                                 ) @ 0x000f6d90
ACPI: RSDT (v001 KM266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff3000
ACPI: FADT (v001 KM266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff3040
ACPI: MADT (v001 KM266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff7f40
ACPI: DSDT (v001 KM266  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f000000:bfc00000)
Detected 1666.560 MHz processor.
Built 1 zonelists.  Total pages: 256017
Kernel command line: BOOT_IMAGE=storage2-2.6.19-rc3 root=/dev/nfs 
nfsroot=/nfsroot-storage2,rsize=16384,wsize=16384 panic=20 ip=both vga=0x305 nmi_watchdog=1 
pci=routeirq irqpoll
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1018784k/1032128k available (2324k kernel code, 12800k reserved, 995k data, 196k init, 0k 
highmem)
virtual kernel memory layout:
     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
     vmalloc : 0xef800000 - 0xfffb5000   ( 263 MB)
     lowmem  : 0xb0000000 - 0xeeff0000   (1007 MB)
       .init : 0xb0440000 - 0xb0471000   ( 196 kB)
       .data : 0xb03450b8 - 0xb043df44   ( 995 kB)
       .text : 0xb0100000 - 0xb03450b8   (2324 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3337.85 BogoMIPS (lpj=6675708)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Sempron(tm)   2400+ stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbaf0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON
PCI: MSI-K8T-Neo2Fir, soundcard on
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 *12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs *20), disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 17
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 19
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKD] -> GSI 23 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: ec000000-edffffff
   PREFETCH window: e8000000-ebffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12ac
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKD] -> GSI 23 (level, low) -> IRQ 20
eth0: VIA Rhine II at 0x1e000, 00:11:09:95:ec:12, IRQ 20.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link cde1.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
libata version 2.00 loaded.
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ata1: PATA max UDMA/133 cmd 0xD000 ctl 0xD102 bmdma 0xD400 irq 16
ata2: PATA max UDMA/133 cmd 0xD200 ctl 0xD302 bmdma 0xD408 irq 16
scsi0 : pata_hpt37x
ata1.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
ata1.00: ata1: dev 0 multi count 16
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata1.00: configured for UDMA/100
scsi1 : pata_hpt37x
ata2.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata2.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 02.1 PQ: 0 ANSI: 5
SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 16
ata3: PATA max UDMA/133 cmd 0xD500 ctl 0xD602 bmdma 0xD900 irq 16
ata4: PATA max UDMA/133 cmd 0xD700 ctl 0xD802 bmdma 0xD908 irq 16
scsi2 : pata_hpt37x
ata3.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
ata3.00: ata3: dev 0 multi count 16
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata3.00: configured for UDMA/100
scsi3 : pata_hpt37x
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ATA: abnormal status 0x7F on port 0xD707
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
ATA: abnormal status 0x7F on port 0xD707
scsi 2:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 18, io mem 0xee021000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 18, io base 0x0000db00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000dc00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 18, io base 0x0000dd00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 18, io base 0x0000de00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
raid6: int32x1    668 MB/s
raid6: int32x2    896 MB/s
raid6: int32x4    574 MB/s
raid6: int32x8    501 MB/s
raid6: mmxx1     1405 MB/s
raid6: mmxx2     2434 MB/s
raid6: sse1x1    1295 MB/s
raid6: sse1x2    2173 MB/s
raid6: using algorithm sse1x2 (2173 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  2141.000 MB/sec
raid5: using function: pIII_sse (2141.000 MB/sec)
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.2.1, my address is 192.168.2.86
IP-Config: Complete:
       device=eth0, addr=192.168.2.86, mask=255.255.255.0, gw=192.168.2.1,
      host=192.168.2.86, domain=home, nis-domain=(none),
      bootserver=192.168.2.1, rootserver=192.168.2.1, rootpath=
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Looking up port of RPC 100003/2 on 192.168.2.1
Looking up port of RPC 100005/1 on 192.168.2.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 196k freed
md: md0 stopped.
md: bind<sdb1>
md: bind<sdc1>
md: bind<sda1>
raid5: device sda1 operational as raid disk 0
raid5: device sdb1 operational as raid disk 1
raid5: allocated 3162kB for md0
raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
  --- rd:3 wd:2
  disk 0, o:1, dev:sda1
  disk 1, o:1, dev:sdb1
RAID5 conf printout:
  --- rd:3 wd:2
  disk 0, o:1, dev:sda1
  disk 1, o:1, dev:sdb1
  disk 2, o:1, dev:sdc1
md: recovery of RAID array md0
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for recovery.
md: using 128k window, over a total of 195189632 blocks.
VFS: Can't find ext3 filesystem on dev md0.
md: md0: recovery done.
md: md0 stopped.
md: unbind<sda1>
md: export_rdev(sda1)
md: unbind<sdc1>
md: export_rdev(sdc1)
md: unbind<sdb1>
md: export_rdev(sdb1)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata2.00: configured for UDMA/100
ata2: EH complete
irq 16: nobody cared (try booting with the "irqpoll" option)
  [<b0133f6a>] __report_bad_irq+0x2a/0x90
  [<b0134064>] note_interrupt+0x74/0x110
  [<b013472a>] handle_fasteoi_irq+0x8a/0xa0
  [<b01054d7>] do_IRQ+0x57/0xa0
  [<b0115c94>] profile_tick+0x54/0x70
  [<b0100da1>] default_idle+0x31/0x50
  [<b010372e>] common_interrupt+0x1a/0x20
  [<b0100da1>] default_idle+0x31/0x50
  [<b0100e37>] cpu_idle+0x57/0x60
  [<b04407dd>] start_kernel+0x16d/0x1a0
  [<b0440340>] unknown_bootoption+0x0/0x1b0
  =======================
handlers:
[<b0290850>] (ata_interrupt+0x0/0x180)
[<b0290850>] (ata_interrupt+0x0/0x180)
Disabling IRQ #16
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata2.00: configured for UDMA/100
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata2.00: configured for UDMA/100
ata2: EH complete
ata2.00: limiting speed to UDMA/66
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 68 reports 12AC8242
ata2.00: configured for UDMA/66
ata2: EH complete
ata2.00: limiting speed to UDMA/44
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 67 reports 128C8242
ata2.00: configured for UDMA/44
ata2: EH complete
ata2.00: limiting speed to UDMA/33
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
Find mode for 12 reports A81F442
Find mode for DMA 66 reports 120C8242
ATA: abnormal status 0x58 on port 0xD207
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to UDMA/25
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ATA: abnormal status 0x58 on port 0xD207
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ATA: abnormal status 0x58 on port 0xD207
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key=0xb
     ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 1
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 2
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 3
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 4
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 5
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 6
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 7
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 8
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 9
lost page write due to I/O error on sdb
ata2: EH complete
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 1024
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 2096
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 624
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 1848
sdb : READ CAPACITY failed.
sdb : status=0, message=00, host=4, driver=00
sdb : sense not available.
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
sdb: asking for cache data failed
sdb: assuming drive cache: write through


storage2:/home/brad# cat /proc/cmdline
BOOT_IMAGE=storage2-2.6.19-rc3 root=/dev/nfs nfsroot=/nfsroot-storage2,rsize=16384,wsize=16384 
panic=20 ip=both vga=0x305 nmi_watchdog=1 pci=routeirq irqpoll

brad@srv:/usr/src/linux-2.6.19-rc3-storage2$ cat .config | awk '{if (($0 !~ /^#/) && (NF != 0) ) 
print $0}'

CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_UID16=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_BLOCK=y
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_PREEMPT_NONE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_VM86=y
CONFIG_NOHIGHMEM=y
CONFIG_VMSPLIT_3G_OPT=y
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
CONFIG_COMPAT_VDSO=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_ATA=y
CONFIG_PATA_HPT37X=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID456=y
CONFIG_MD_RAID5_RESHAPE=y
CONFIG_NETDEVICES=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_SENSORS_W83627HF=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y


storage2:/home/brad# lspci -v
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Host Bridge
         Subsystem: VIA Technologies, Inc. VT8378 [KM400] Chipset Host Bridge
         Flags: bus master, 66MHz, medium devsel, latency 8
         Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
         Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: ec000000-edffffff
         Prefetchable memory behind bridge: e8000000-ebffffff
         Capabilities: [80] Power Management version 2

0000:00:05.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
         Subsystem: Triones Technologies, Inc.: Unknown device 0001
         Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 16
         I/O ports at d000 [size=8]
         I/O ports at d100 [size=4]
         I/O ports at d200 [size=8]
         I/O ports at d300 [size=4]
         I/O ports at d400 [size=256]
         Expansion ROM at 40000000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2

0000:00:05.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
         Subsystem: Triones Technologies, Inc.: Unknown device 0001
         Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 16
         I/O ports at d500 [size=8]
         I/O ports at d600 [size=4]
         I/O ports at d700 [size=8]
         I/O ports at d800 [size=4]
         I/O ports at d900 [size=256]
         Capabilities: [60] Power Management version 2

0000:00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
         Flags: bus master, medium devsel, latency 32, IRQ 17
         I/O ports at da00 [size=16]
         Capabilities: [c0] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at db00 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at dc00 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at dd00 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at de00 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: VIA Technologies, Inc. USB 2.0
         Flags: bus master, medium devsel, latency 32, IRQ 18
         Memory at ee021000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio 
Controller (rev 60)
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7061
         Flags: medium devsel, IRQ 19
         I/O ports at df00 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7061
         Flags: bus master, medium devsel, latency 32, IRQ 20
         I/O ports at e000 [size=256]
         Memory at ee020000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3 UniChrome] Integrated 
Video (rev 01) (prog-if 00 [VGA])
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7061
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 16
         Memory at e8000000 (32-bit, prefetchable) [size=64M]
         Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
         Expansion ROM at ed000000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
         Capabilities: [70] AGP version 2.0

storage2:/home/brad# cat /proc/cpuinfo /proc/interrupts /proc/ioports
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Sempron(tm)   2400+
stepping        : 1
cpu MHz         : 1666.560
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse syscall mp mmxext 3dnowext 3dnow ts
bogomips        : 3337.85

            CPU0
   0:     321712   IO-APIC-edge      timer
   1:         22   IO-APIC-edge      i8042
   8:          4   IO-APIC-edge      rtc
   9:          0   IO-APIC-fasteoi   acpi
  16:    1400000   IO-APIC-fasteoi   libata, libata
  18:          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, 
uhci_hcd:usb5
  20:      67440   IO-APIC-fasteoi   eth0
NMI:     321729
LOC:     321683
ERR:          0
MIS:          0
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0295-0296 : w83627hf
02f8-02ff : serial
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : motherboard
   4000-4003 : ACPI PM1a_EVT_BLK
   4004-4005 : ACPI PM1a_CNT_BLK
   4008-400b : ACPI PM_TMR
   4020-4023 : ACPI GPE0_BLK
5000-500f : motherboard
d000-d007 : 0000:00:05.0
   d000-d007 : libata
d100-d103 : 0000:00:05.0
   d100-d103 : libata
d200-d207 : 0000:00:05.0
   d200-d207 : libata
d300-d303 : 0000:00:05.0
   d300-d303 : libata
d400-d4ff : 0000:00:05.0
   d400-d4ff : libata
d500-d507 : 0000:00:05.1
   d500-d507 : libata
d600-d603 : 0000:00:05.1
   d600-d603 : libata
d700-d707 : 0000:00:05.1
   d700-d707 : libata
d800-d803 : 0000:00:05.1
   d800-d803 : libata
d900-d9ff : 0000:00:05.1
   d900-d9ff : libata
da00-da0f : 0000:00:0f.0
db00-db1f : 0000:00:10.0
   db00-db1f : uhci_hcd
dc00-dc1f : 0000:00:10.1
   dc00-dc1f : uhci_hcd
dd00-dd1f : 0000:00:10.2
   dd00-dd1f : uhci_hcd
de00-de1f : 0000:00:10.3
   de00-de1f : uhci_hcd
df00-dfff : 0000:00:11.5
e000-e0ff : 0000:00:12.0
   e000-e0ff : via-rhine

