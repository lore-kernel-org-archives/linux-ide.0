From: =?ISO-8859-2?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 12:20:29 +0100
Message-ID: <438EDC7D.2020704@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438D6B73.2060902@keytradebank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070905060905020000010706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail114.messagelabs.com ([195.245.231.163]:14252 "HELO
	mail114.messagelabs.com") by vger.kernel.org with SMTP
	id S932153AbVLALUn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 06:20:43 -0500
In-Reply-To: <438D6B73.2060902@keytradebank.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, "0602@eq.cz" <0602@eq.cz>

This is a cryptographically signed message in MIME format.

--------------ms070905060905020000010706
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable

Jean-Fran=E7ois Stenuit wrote:

> A failed boot shows "ata1: SATA port has no device". I'll try to=20
> set-up a serial console to log the boot messages.

As promised, here is the complete bootlog of a failed, then a=20
successfull boot :

    GNU GRUB  version 0.95  (622K lower / 1046976K upper memory)

+------------------------------------------------------------------------=
-+||||||||||||||||||||||||+----------------------------------------------=
---------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.  Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-10                             Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-10 (recovery mode)             Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-9                              Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-9 (recovery mode)                            =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                           The highlighte=
d entry will be booted automatically in 5 seconds.    The highlighted ent=
ry will be booted automatically in 4 seconds.    The highlighted entry wi=
ll be booted automatically in 3 seconds.    The highlighted entry will be=
 booted automatically in 2 seconds.    The highlighted entry will be boot=
ed automatically in 1 seconds.      Booting 'Debian GNU/Linux, kernel 2.6=
=2E15-rc3-dl140-10 '

root  (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel  /boot/vmlinuz-2.6.15-rc3-dl140-10 root=3D/dev/sda1 ro console=3Dt=
tyS0,9600n8
   [Linux-bzImage, setup=3D0x1c00, size=3D0x1a817b]
savedefault
boot
Linux version 2.6.15-rc3-dl140-10 (jfs@dl140) (gcc version 3.3.5 (Debian =
1:3.3.5-13)) #1 SMP Thu Dec 1 11:44:28 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7a000 (ACPI data)
 BIOS-e820: 000000003ff7a000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6790
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec84000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec84000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec84400] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec84400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=3D/dev/sda1 ro console=3DttyS0,9600n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.863 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034136k/1048000k available (2098k kernel code, 12972k reserved, =
1222k data, 204k init, 130496k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 5608.53 BogoMIPS (lpj=3D=
11217073)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.62 BogoMIPS (lpj=3D=
11201255)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Total of 2 processors activated (11209.16 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd83a, last bus=3D7
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled=
=2E
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled=
=2E
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 *11 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: dd100000-dd1fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: dd200000-dd2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: dd300000-dd3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: dd400000-deffffff
  PREFETCH window: 50000000-500fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Simple Boot Flag at 0x3b set to 0x1
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled=

serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
Ethernet Channel Bonding Driver: v2.6.5 (November 4, 2005)
bonding: Warning: either miimon or arp_interval and arp_ip_target module =
parameters must be specified, otherwise bonding will not detect link fail=
ures! see bonding.txt for details.
tg3.c:v3.43 (Oct 24, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1=
000BaseT Ethernet 00:14:c2:54:b4:b6
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOc=
ap[1]=20
eth0: dma_rwctrl[76180000]
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1=
000BaseT Ethernet 00:14:c2:54:b4:b7
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOc=
ap[1]=20
eth1: dma_rwctrl[76180000]
Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@red=
hat.com)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1470 irq 14
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
ata2: SATA port has no device.
scsi1 : ata_piix
mice: PS/2 mouse device common for all mice
Mirror/redirect action on
netem: version 1.1
u32 classifier
    Perfomance counters on
    input device check on=20
    Actions configured=20
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8187 buckets, 65496 max) - 212 bytes per conntr=
ack
ip_tables: (C) 2000-2002 Netfilter core team
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.ne=
t/projects/ipt_recent/
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Starting balanced_irq
Using IPI Shortcut mode
VFS: Cannot open root device "sda1" or unknown-block(0,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block=
(0,0)
=20
    GNU GRUB  version 0.95  (622K lower / 1046976K upper memory)

+------------------------------------------------------------------------=
-+||||||||||||||||||||||||+----------------------------------------------=
---------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.  Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-10                             Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-10 (recovery mode)             Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-9                              Debian GNU/Lin=
ux, kernel 2.6.15-rc3-dl140-9 (recovery mode)                            =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                           The highlighte=
d entry will be booted automatically in 5 seconds.    The highlighted ent=
ry will be booted automatically in 4 seconds.    The highlighted entry wi=
ll be booted automatically in 3 seconds.    The highlighted entry will be=
 booted automatically in 2 seconds.    The highlighted entry will be boot=
ed automatically in 1 seconds.      Booting 'Debian GNU/Linux, kernel 2.6=
=2E15-rc3-dl140-10 '

root  (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel  /boot/vmlinuz-2.6.15-rc3-dl140-10 root=3D/dev/sda1 ro console=3Dt=
tyS0,9600n8
   [Linux-bzImage, setup=3D0x1c00, size=3D0x1a817b]
savedefault
boot
Linux version 2.6.15-rc3-dl140-10 (jfs@dl140) (gcc version 3.3.5 (Debian =
1:3.3.5-13)) #1 SMP Thu Dec 1 11:44:28 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7a000 (ACPI data)
 BIOS-e820: 000000003ff7a000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6790
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec84000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec84000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec84400] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec84400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=3D/dev/sda1 ro console=3DttyS0,9600n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.704 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034136k/1048000k available (2098k kernel code, 12972k reserved, =
1222k data, 204k init, 130496k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 5608.50 BogoMIPS (lpj=3D=
11217008)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.65 BogoMIPS (lpj=3D=
11201307)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Total of 2 processors activated (11209.15 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd83a, last bus=3D7
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled=
=2E
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled=
=2E
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 *11 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: dd100000-dd1fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: dd200000-dd2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: dd300000-dd3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: dd400000-deffffff
  PREFETCH window: 50000000-500fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Simple Boot Flag at 0x3b set to 0x1
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled=

serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
Ethernet Channel Bonding Driver: v2.6.5 (November 4, 2005)
bonding: Warning: either miimon or arp_interval and arp_ip_target module =
parameters must be specified, otherwise bonding will not detect link fail=
ures! see bonding.txt for details.
tg3.c:v3.43 (Oct 24, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1=
000BaseT Ethernet 00:14:c2:54:b4:b6
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOc=
ap[1]=20
eth0: dma_rwctrl[76180000]
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1=
000BaseT Ethernet 00:14:c2:54:b4:b7
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOc=
ap[1]=20
eth1: dma_rwctrl[76180000]
Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@red=
hat.com)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1470 irq 14
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
ata2: SATA port has no device.
scsi1 : ata_piix
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
mice: PS/2 mouse device common for all mice
Mirror/redirect action on
netem: version 1.1
u32 classifier
    Perfomance counters on
    input device check on=20
    Actions configured=20
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8187 buckets, 65496 max) - 212 bytes per conntr=
ack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.ne=
t/projects/ipt_recent/
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Starting balanced_irq
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
INIT: version 2.86 booting
Activating swap.
Adding 2714944k swap on /dev/sda7.  Priority:-1 extents:1 across:2714944k=

Checking root file system...
fsck 1.37 (21-Mar-2005)
/: clean, 6566/136544 files, 441EXT3 FS on sda1, 68/273073 blocksinternal=
 journal

System time was Thu Dec  1 10:55:29 UTC 2005.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Thu Dec  1 10:55:31 UTC 2005.
Cleaning up ifupdown...done.
Checking all file systems...
fsck 1.37 (21-Mar-2005)
/home: clean, 22860/8372224 files, 366885/16737714 blocks
/tmp: clean, 11/192768 files, 32456/393217 blocks
/usr: clean, 18050/kjournald starting.  Commit interval 5 seconds
610432 files, 86EXT3 FS on sda9, internal journal
948/1220932 blocEXT3-fs: mounted filesystem with ordered data mode.
ks
/var: clean,kjournald starting.  Commit interval 5 seconds
 1295/366528 filEXT3 FS on sda8, internal journal
es, 40433/732957EXT3-fs: mounted filesystem with ordered data mode.
 blocks
Setting kernel variables ...
=2E.. done.kjournald starting.  Commit interval 5 seconds

Mounting localEXT3 FS on sda5, internal journal
 filesystems...EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting MTA: exim4.
Starting internet superserver: inetd.
Starting SMP IRQ Balancer: irqbalance.
Starting OpenBSD Secure Shell server: sshd.
Starting deferred execution scheduler: atd.

Starting periodic command scheduler: cron.


--=20
Jean-Fran=E7ois "Jef" Stenuit
Network & Security manager
Keytrade Bank SA



--------------ms070905060905020000010706
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII9TCC
AtUwggI+oAMCAQICAw940zANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwOTEzMTU0NDM0WhcNMDYwOTEzMTU0NDM0
WjBGMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSMwIQYJKoZIhvcNAQkBFhRq
ZnNAa2V5dHJhZGViYW5rLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJvF
EsxKTbVcg2evoxzm3Gs2PErR2jLXLyAosTiTvopWw3HZAKTD+3rVBQKZA4ykdbC4Spk7ca05
2ENgt3naP/6bJ8gWCrgd9AQ0CRRDNuyE1A0YWjM4G8SYaKNXC+yjhrhaobmKcBQhtysQxHMo
s0+SDVbNAOdYjK7rdjN+WGZQpbjJ3E8LtP4Vqv4YoA5LpyumVGq1aCcRNvHC0EbNfGi9p6R6
sIjMglPH0ZAa9YGcX9U6qz/je8ImvL/k9B7Hys8YAN8uLDol9qMKXkys7Nc2UA/V6Qy3/vME
PkQ6mnx8m30a1IAHK8zxvpRSpY/SmdSGIk3PGrOwXnCazsAKyX8CAwEAAaMxMC8wHwYDVR0R
BBgwFoEUamZzQGtleXRyYWRlYmFuay5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQF
AAOBgQC0RNI63E0hHdNOy1ffX2Vg+qddH4vJDdtKHcYbI6B3/C8OJTCQLWRRZpOPwVQqNpVL
8OzsDYTX1ARzlzMA9H0grN5AD3hLZxSsNJj0X47SpEq8OyVPlACaKa1YAulRg5QL57gCDSGf
9xPO1nrA9sdlRG0fZLSauFLf4IOdnF7hJzCCAtUwggI+oAMCAQICAw940zANBgkqhkiG9w0B
AQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcN
MDUwOTEzMTU0NDM0WhcNMDYwOTEzMTU0NDM0WjBGMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1h
aWwgTWVtYmVyMSMwIQYJKoZIhvcNAQkBFhRqZnNAa2V5dHJhZGViYW5rLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAJvFEsxKTbVcg2evoxzm3Gs2PErR2jLXLyAosTiT
vopWw3HZAKTD+3rVBQKZA4ykdbC4Spk7ca052ENgt3naP/6bJ8gWCrgd9AQ0CRRDNuyE1A0Y
WjM4G8SYaKNXC+yjhrhaobmKcBQhtysQxHMos0+SDVbNAOdYjK7rdjN+WGZQpbjJ3E8LtP4V
qv4YoA5LpyumVGq1aCcRNvHC0EbNfGi9p6R6sIjMglPH0ZAa9YGcX9U6qz/je8ImvL/k9B7H
ys8YAN8uLDol9qMKXkys7Nc2UA/V6Qy3/vMEPkQ6mnx8m30a1IAHK8zxvpRSpY/SmdSGIk3P
GrOwXnCazsAKyX8CAwEAAaMxMC8wHwYDVR0RBBgwFoEUamZzQGtleXRyYWRlYmFuay5jb20w
DAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQC0RNI63E0hHdNOy1ffX2Vg+qddH4vJ
DdtKHcYbI6B3/C8OJTCQLWRRZpOPwVQqNpVL8OzsDYTX1ARzlzMA9H0grN5AD3hLZxSsNJj0
X47SpEq8OyVPlACaKa1YAulRg5QL57gCDSGf9xPO1nrA9sdlRG0fZLSauFLf4IOdnF7hJzCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8xggM7MIIDNwIBATBpMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMAkGBSsOAwIaBQCgggGnMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwMTExMjAyOVowIwYJ
KoZIhvcNAQkEMRYEFLdZNpOkT2tqQzzAD8SVHcY1UR33MFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBAIl2l8k3hXGYjzMW3jFzKo5+WK/Sz+X6P7DwHIxo1zliWDwPXhuAi3JFwIgvso6HzY5h
nSXUbkLY/FKQoM4opiiteS9glgOc/31aAefN9/rCky+TDawhlKXVreMVKlziowhf0ajW8mYn
HOq7ayBWxZHSr82ljCScIAp5pv9oqL6FJ/5mmwbVrwBAGpvn5BQYWMFRabBit5/mLM3iZ3RP
M/BS017kkLMbBxteMAkcffo1AX0jtBDSKLsIj0ltrjw3mqS+AmOXefuYEQ5K0x648aYO++NR
MBDWhpA9k+TsANzQCLIYnCSQImh4I/WS4k5UQc0ViqZ7Ab8lDZtAEN3RgVwAAAAAAAA=
--------------ms070905060905020000010706--
