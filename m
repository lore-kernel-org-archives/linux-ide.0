From: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume.laures@club-internet.fr>
Subject: Re: sata disk failure?
Date: Tue, 15 Feb 2005 14:53:38 +0100
Message-ID: <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--828083930"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050213150102.GB13468@harddisk-recovery.com>
Resent-Message-ID: <S-uwZD.A.DJF.L8fECB@murphy>
List-Post: <mailto:debian-amd64@lists.debian.org>
List-Help: <mailto:debian-amd64-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-amd64-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-amd64-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-amd64/>
To: linux-ide@vger.kernel.org
Cc: Erik Mouw <erik@harddisk-recovery.com>, debian-amd64@lists.debian.org
List-Id: linux-ide@vger.kernel.org


--Apple-Mail-2--828083930
Content-Type: multipart/mixed; boundary=Apple-Mail-1--828083937


--Apple-Mail-1--828083937
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hello,

Here is a small report in attachement, done with 2.6.11-rc4.
--Apple-Mail-1--828083937
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	x-unix-mode=0755;
	name="nv_sata_bug.txt"
Content-Disposition: attachment;
	filename=nv_sata_bug.txt

 * Hardware is nforce3 250GB, booting debian pure64 on pata (Maxtor 30Gb =
6E030L0) drive. The goal is to mount data found on a sata disk (seagate =
200Gb ST3200822AS). The pata drive holds / and lvm partition with /usr, =
/var /tmp and /home.
The ultimate goal is to switch all this to the sata drive, which already =
holds a (barely used) swap partition.

 * Soon after boot the console displays:
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
...
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device added
nv_sata: Primary device added
and the sata disk seems to spin down at the same time.
This is currently on 2.6.11-rc4, although I got the same behaviour with =
2.6.10 and 2.6.11-rc3. Removing power from the drive and pluging it =
again seems to make te drive work some time , until it spins down =
again...

 * lspci gives (see partial lspci -vvvxx at the end):
0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev =
a1)
0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev =
a2)
0000:00:01.1 SMBus: nVidia Corporation: Unknown device 00e4 (rev a1)
0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 00e7 =
(rev a1)
0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 00e7 =
(rev a1)
0000:00:02.2 USB Controller: nVidia Corporation: Unknown device 00e8 =
(rev a2)
0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation: Unknown =
device 00ea (rev a1)
0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 00e5 (rev =
a2)
0000:00:0a.0 IDE interface: nVidia Corporation: Unknown device 00e3 (rev =
a2)
0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 00e2 (rev =
a2)
0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 00ed (rev =
a2)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce =
FX 5200] (rev a1)
0000:02:06.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host =
Controller (rev 80)
0000:02:0a.0 Multimedia video controller: Internext Compression Inc =
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)

 * dmesg gives:
Bootdata ok (command line is root=3D/dev/hda1 ro )
Linux version 2.6.11-rc4 (root@ideq-210p) (gcc version 3.3.5 (Debian =
1:3.3.5-5)) #1 Tue Feb 15 12:59:47 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ =
0x00000000000f6d20
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ =
0x000000003fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ =
0x000000003fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ =
0x000000003fff7800
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ =
0x0000000000000000
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258032 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=3D/dev/hda1 ro  console=3Dtty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2009.789 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1022816k/1048512k available (1774k kernel code, 25112k reserved, =
1006k data, 148k init)
Calibrating delay loop... 3981.31 BogoMIPS (lpj=3D1990656)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
checking if image is initramfs...it isn't (bad gzip magic numbers); =
looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22) *0, disabled.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing =
enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:=20
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1=20
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4212KiB [1 disk] into ram disk... =
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
SCSI subsystem initialized
libata version 1.10 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 22
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 22
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 =
88:407f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6E030L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IDE-DVD ROM 16x, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3D59582/16/63, =
UDMA(133)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first =
block 18, max trans len 1024, max batch 900, max commit age 30, max =
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
Unable to find swap-space signature
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
mice: PS/2 mouse device common for all mice
it87: Found IT8712F chip at 0x290, revision 7
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first =
block 18, max trans len 1024, max batch 900, max commit age 30, max =
trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first =
block 18, max trans len 1024, max batch 900, max commit age 30, max =
trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first =
block 18, max trans len 1024, max batch 900, max commit age 30, max =
trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first =
block 18, max trans len 1024, max batch 900, max commit age 30, max =
trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
Unable to find swap-space signature
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[16]  =
MMIO=3D[e6000000-e60007ff]  Max Packet=3D[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0030670000047119]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x4c40
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
ohci_hcd 0000:00:02.0: PCI device 10de:00e7 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 21, pci mem 0xe7002000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
ohci_hcd 0000:00:02.1: PCI device 10de:00e7 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 20, pci mem 0xe7003000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
usb 2-4: new full speed USB device using ohci_hcd and address 2
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
ehci_hcd 0000:00:02.2: PCI device 10de:00e8 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 22, pci mem 0xe7004000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec =
2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
usb 2-4: USB disconnect, address 2
usb 2-4: new full speed USB device using ohci_hcd and address 3
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
  Vendor: IC        Model: USB Storage-CFC   Rev: 322E
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
  Vendor: IC        Model: USB Storage-SMC   Rev: 322E
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi3, channel 0, id 0, lun 1
  Vendor: IC        Model: USB Storage-MMC   Rev: 322E
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi3, channel 0, id 0, lun 2
  Vendor: IC        Model: USB Storage-MSC   Rev: 322E
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sde at scsi3, channel 0, id 0, lun 3
usb-storage: device scan complete
NET: Registered protocol family 17
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8037fb60(lo)
IPv6 over IPv4 tunneling driver
Xprt[5184]: segfault at 00000000000000f8 rip 000000000040646e rsp =
00007ffffffff368 error 4
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device removed
nv_sata: Primary device added
nv_sata: Primary device added

 * then any try to access the sata drive (cfdisk, mount  a partition =
etc...) throw this:
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ata1: command 0x25 timeout, stat 0x80 host_stat 0x21
ata1: status=3D0x80 { Busy }
SCSI error : <0 0 0 0> return code =3D 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ata1: command 0x25 timeout, stat 0x80 host_stat 0x21
ata1: status=3D0x80 { Busy }
SCSI error : <0 0 0 0> return code =3D 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 8
Buffer I/O error on device sda, logical block 1
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ata1: command 0x25 timeout, stat 0x80 host_stat 0x21
ata1: status=3D0x80 { Busy }
SCSI error : <0 0 0 0> return code =3D 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 16
Buffer I/O error on device sda, logical block 2
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7
ATA: abnormal status 0x80 on port 0x9F7

 * lspci -vvvxx gives (some parts removed):
0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev =
a1)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [44] #08 [01c0]
	Capabilities: [c0] AGP version 3.0
		Status: RQ=3D32 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- =
GART64- HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- =
64bit- FW- Rate=3Dx4
00: de 10 e1 00 06 00 b0 00 a1 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev =
a2)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: de 10 e0 00 0f 00 a0 00 a2 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.1 SMBus: nVidia Corporation: Unknown device 00e4 (rev a1)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e400 [size=3D32]
	Region 4: I/O ports at 4c00 [size=3D64]
	Region 5: I/O ports at 4c40 [size=3D64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e4 00 01 00 b0 00 a1 00 05 0c 00 00 80 00
10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 4c 00 00 41 4c 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 00e7 =
(rev a1) (prog-if 10 [OHCI])
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at e7002000 (32-bit, non-prefetchable) =
[size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e7 00 07 00 b0 00 a1 10 03 0c 00 00 80 00
10: 00 20 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01

0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 00e7 =
(rev a1) (prog-if 10 [OHCI])
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at e7003000 (32-bit, non-prefetchable) =
[size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e7 00 07 00 b0 00 a1 10 03 0c 00 00 80 00
10: 00 30 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 02 03 01

0000:00:02.2 USB Controller: nVidia Corporation: Unknown device 00e8 =
(rev a2) (prog-if 20 [EHCI])
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at e7004000 (32-bit, non-prefetchable) =
[size=3D256]
	Capabilities: [44] #0a [2098]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e8 00 06 00 b0 00 a2 20 03 0c 00 00 80 00
10: 00 40 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 03 03 01

0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 2501
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e7005000 (32-bit, non-prefetchable) =
[size=3D4K]
	Region 1: I/O ports at b800 [size=3D8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 df 00 07 00 b0 00 a2 00 80 06 00 00 00 00
10: 00 50 00 e7 01 b8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 01 25
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 01 14

0000:00:06.0 Multimedia audio controller: nVidia Corporation: Unknown =
device 00ea (rev a1)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 8212
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at bc00 [size=3D256]
	Region 1: I/O ports at c000 [size=3D128]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) =
[size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 ea 00 07 00 b0 00 a1 00 01 04 00 00 00 00
10: 01 bc 00 00 01 c0 00 00 00 00 00 e7 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 65 15 12 82
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 05

0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 00e5 (rev =
a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 3401
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=3D16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e5 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 65 15 01 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01

0000:00:0a.0 IDE interface: nVidia Corporation: Unknown device 00e3 (rev =
a2) (prog-if 85 [Master SecO PriO])
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 5400
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 09f0 [size=3D8]
	Region 1: I/O ports at 0bf0 [size=3D4]
	Region 2: I/O ports at 0970 [size=3D8]
	Region 3: I/O ports at 0b70 [size=3D4]
	Region 4: I/O ports at dc00 [size=3D16]
	Region 5: I/O ports at e000 [size=3D128]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 e3 00 05 00 b0 00 a2 85 01 01 00 00 00 00
10: f1 09 00 00 f1 0b 00 00 71 09 00 00 71 0b 00 00
20: 01 dc 00 00 01 e0 00 00 00 00 00 00 65 15 00 54
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01

0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 00e2 (rev =
a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium =
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D10
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: de 10 e2 00 07 01 20 02 a2 00 04 06 00 10 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 0a f0 00 20 22
20: 00 e4 f0 e5 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0e 00

0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 00ed (rev =
a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, =
sec-latency=3D128
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e6000000-e6ffffff
	Prefetchable memory behind bridge: e0000000-e3ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00: de 10 ed 00 07 01 a0 00 a2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 80 a0 a0 80 22
20: 00 e6 f0 e6 00 e0 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 02

Hope this helps,
GoM

--Apple-Mail-1--828083937
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed



I don't really knows what is the relevant part of the output of lspci,=20=

so I included a simple shot (lspci) and kept only the "nVidia=20
Coproration Unknown device" parts from the long one (lspci -vvvxx).

Hope this helps !

GoM
Le 13 f=E9vr. 05, =E0 16:01, Erik Mouw a =E9crit :

> On Sun, Feb 13, 2005 at 01:04:16AM +0100, Guillaume Laur?s wrote:
>> I get this behaviour too ! After some time I get the "abnormal =
status"
>> messages and the disk is dead until reboot. pure64 is installed on a
>> pata drive (the sata is almost unusable).
>> nforce 250Gb (sata_nv) + seagate 200 G (dont have the model number
>> handy)
>
> I haven't heard about sata_nv doing weird things with seagate disks.
>
>> I tried the 2.6.10 kernel from pure64 as well as a self-compiled
>> 2.6.11-rc3.
>
> This sounds like a bug that's not yet fixed in a  recent kernel. Could
> you report this to linux-ide@vger.kernel.org? Be sure to include
> (relevant) output of 'lspci -vvvxx', the exact model number of the
> drive and the kernel error log?
>
>
> Erik
>
> --=20
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
>

--Apple-Mail-1--828083937--

--Apple-Mail-2--828083930
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: =?ISO-8859-1?Q?Ceci_est_une_signature_=E9lectronique_PGP?=
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFCEf7ixnIJde5abSkRAtMzAJ0TKEOhFnXVcDquZQAlMGdEulVXlQCgmH0P
3o+Vmlbg+j64NAoiHJmNzG4=
=9W0k
-----END PGP SIGNATURE-----

--Apple-Mail-2--828083930--
