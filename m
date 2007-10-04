From: Yanko Kaneti <yaneti@declera.com>
Subject: PDC20267 (Promise FastTrak100) instabillity/resets with newer
	kernels.
Date: Thu, 04 Oct 2007 22:53:07 +0300
Message-ID: <1191527587.1575.30.camel@indigo.declera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vZI1TB0gj75q51yccYpn"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from indigo.declera.com ([212.116.131.21]:38860 "HELO
	indigo.declera.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759318AbXJDUAc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 16:00:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-vZI1TB0gj75q51yccYpn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

The integrated PDC20267 (FastTrak100 BIOS version 2.30.0140.13)
controller in following constants hardware setup behaves differently
under live-cd fedora kernels 2.6.18-1.2869 and
2.6.23-0.214.rc8.git2.fc8.

- Intel S845WD1-E server motherboard with onboard PDC20267 (105a:4d30),
latest bios revision P12
- two HDT722525DLAT80 Hitachi 250GB harddrives in master mode connected
to the two PDC20267 channels
- a cd connected to the chipset 82801EB/ER (ICH5/ICH5R) IDE Controller
for the purpose of booting the live-cd


The two disk are put in a md raid1 setup. The first one is online, the
second is being added and the raid starts reconstructing.  
The reconstruction works fine with 2.6.18 with a speed of approximately
50MB/s. 
With 2.6.23 immediately as the reconstruction begins there is string  of
ATA bus errors and port resets until it settles on PIO4 transfer mode.

Attached you can find the dmesg output for both cases. 


I would appreciate pointers to where the problem might be in the second
case.  Kernel options to try?  As a hapless kernel user in the second
case I would expect it to figure out defaults that would work.

TIA
Yanko

--=-vZI1TB0gj75q51yccYpn
Content-Disposition: attachment; filename=2.6.18-1.2869.dmesg.log
Content-Type: text/x-log; name=2.6.18-1.2869.dmesg.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-1.2869.fc6 (brewbuilder@ls20-bc2-14.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Wed Dec 20 14:51:19 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 262080
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32704 pages, LIFO batch:7
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D845WD WD84510A 0x20041005 MSFT 0x00001011) @ 0x3fff0000
ACPI: FADT (v001 D845WD WD84510A 0x20041005 MSFT 0x00001011) @ 0x3fff1000
ACPI: MADT (v001 D845WD WD84510A 0x20041005 MSFT 0x00001011) @ 0x3ffe3093
ACPI: SSDT (v001 D845WD WD84510A 0x00000001 MSFT 0x0100000b) @ 0x3ffe30fb
ACPI: DSDT (v001 D845WD WD84510A 0x00000001 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2392.217 MHz processor.
Built 1 zonelists.  Total pages: 262080
Kernel command line: ro  root=CDLABEL=Fedora-6-Zod-LiveCD-1 rootfstype=iso9660 livecd 3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07ae000 soft=c078e000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031176k/1048320k available (2139k kernel code, 16312k reserved, 866k data, 240k init, 130816k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4786.51 BogoMIPS (lpj=2393255)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebf3ff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Total of 1 processors activated (4786.51 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=424 bytes
sizeof(dentry)=148 bytes
sizeof(ext3inode)=600 bytes
sizeof(buffer_head)=52 bytes
sizeof(skbuff)=172 bytes
sizeof(task_struct)=1392 bytes
checking if image is initramfs... it is
Freeing initrd memory: 2880k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Firmware left 0000:02:0c.0 e100 interrupts enabled, disabling
PCI: Firmware left 0000:02:0d.0 e100 interrupts enabled, disabling
Boot video device is 0000:02:0f.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x400-0x47f could not be reserved
pnp: 00:02: ioport range 0x500-0x53f has been reserved
pnp: 00:02: ioport range 0x800-0x87f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc800000-fc8fffff
  PREFETCH window: f4500000-f45fffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fc900000-feafffff
  PREFETCH window: f4600000-f46fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1191516974.745:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 1E0E64C0A8BD9F26
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
Probing IDE interface ide0...
hdb: TEAC DW-548D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PDC20267: IDE controller at PCI slot 0000:02:0e.0
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 22 (level, low) -> IRQ 169
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xf4650000
PDC20267: 100% native mode on irq 169
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xdf00-0xdf07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: HDT722525DLAT80, ATA DISK drive
ide2 at 0xdff0-0xdff7,0xdfe6 on irq 169
Probing IDE interface ide3...
hdg: HDT722525DLAT80, ATA DISK drive
ide3 at 0xdfa8-0xdfaf,0xdfe2 on irq 169
Probing IDE interface ide1...
hde: max request size: 128KiB
hde: 488397168 sectors (250059 MB) w/7674KiB Cache, CHS=30401/255/63, UDMA(100)
hde: cache flushes supported
 hde: unknown partition table
hdg: max request size: 128KiB
hdg: 488397168 sectors (250059 MB) w/7674KiB Cache, CHS=30401/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: unknown partition table
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 386k
input: AT Translated Set 2 keyboard as /class/input/input0
hdb: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 177, io base 0x0000ef40
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 185, io base 0x0000ef80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf8
Unable to load NLS charset utf8
ISO 9660 Extensions: RRIP_1991A
loop: loaded (max 128 devices)
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
squashfs: version 3.2-alpha (2006/12/12) Phillip Lougher
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
audit(1191516983.387:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1580 types, 170 bools, 1 sens, 1024 cats
security:  59 classes, 49346 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=98306
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=98804
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=98801
SELinux: initialized (dev loop120, type squashfs), not configured for labeling
SELinux: initialized (dev hdb, type iso9660), uses genfs_contexts
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
audit(1191516984.013:3): policy loaded auid=4294967295
input: PC Speaker as /class/input/input2
intel_rng: FWH not detected
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 18 (level, low) -> IRQ 193
e100: eth0: e100_probe: addr 0xfeafd000, irq 193, MAC addr 00:07:E9:F2:BF:48
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 19 (level, low) -> IRQ 177
e100: eth1: e100_probe: addr 0xfeafc000, irq 177, MAC addr 00:07:E9:F2:BF:49
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 201
eth2: Tigon3 [partno(AT2915T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:30:84:b3:be:93
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth2: dma_rwctrl[76ff000f] dma_mask[64-bit]
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 169
eth3: Identified chip type is 'RTL8169s/8110s'.
eth3: RTL8169 at 0xf89f8c00, 00:0e:2e:09:5e:a6, IRQ 169
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 209
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
audit(1191517025.942:4): audit_pid=2174 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
PM: Writing back config space on device 0000:02:09.0 at offset b (was 164514e4, writing 29151259)
PM: Writing back config space on device 0000:02:09.0 at offset 3 (was 0, writing 2008)
PM: Writing back config space on device 0000:02:09.0 at offset 2 (was 2000000, writing 2000015)
PM: Writing back config space on device 0000:02:09.0 at offset 1 (was 2b00000, writing 2b00106)
PM: Writing back config space on device 0000:02:09.0 at offset 0 (was 164514e4, writing 3ea173b)
ADDRCONF(NETDEV_UP): eth2: link is not ready
r8169: eth3: link down
ADDRCONF(NETDEV_UP): eth3: link is not ready
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
md: md0 stopped.
md: bind<hdg>
md: bind<hde>
md: raid1 personality registered for level 1
raid1: raid set md0 active with 1 out of 2 mirrors
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:hde
 disk 1, wo:1, o:1, dev:hdg
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 244198464 blocks.

--=-vZI1TB0gj75q51yccYpn
Content-Disposition: attachment; filename=2.6.23-0.214.rc8.git2.fc8.dmesg.log
Content-Type: text/x-log; name=2.6.23-0.214.rc8.git2.fc8.dmesg.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.23-0.214.rc8.git2.fc8 (kojibuilder@) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-28)) #1 SMP Fri Sep 28 17:38:00 EDT 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 262080) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262080
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262080
On node 0 totalpages: 262080
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4040 pages, LIFO batch:0
  Normal zone: 3080 pages used for memmap
  Normal zone: 222200 pages, LIFO batch:31
  HighMem zone: 447 pages used for memmap
  HighMem zone: 32257 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP 000FF980, 0014 (r0 AMI   )
ACPI: RSDT 3FFF0000, 0030 (r1 D845WD WD84510A 20041005 MSFT     1011)
ACPI: FACP 3FFF1000, 0074 (r1 D845WD WD84510A 20041005 MSFT     1011)
ACPI: DSDT 3FFE0000, 3093 (r1 D845WD WD84510A        1 MSFT  100000B)
ACPI: FACS 3FFF8000, 0040
ACPI: APIC 3FFE3093, 0068 (r1 D845WD WD84510A 20041005 MSFT     1011)
ACPI: SSDT 3FFE30FB, 0035 (r1 D845WD WD84510A        1 MSFT  100000B)
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
swsusp: Registered nosave memory region: 000000000009b000 - 000000000009c000
swsusp: Registered nosave memory region: 000000000009c000 - 00000000000e8000
swsusp: Registered nosave memory region: 00000000000e8000 - 0000000000100000
Built 1 zonelists in Zone order.  Total pages: 258497
Kernel command line: initrd=initrd.img root=CDLABEL=Fedora-7.92-Live-i386 rootfstype=iso9660 ro liveimg 3 BOOT_IMAGE=vmlinuz 
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0810000 soft=c07f0000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2392.261 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1024 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1020688k/1048320k available (2266k kernel code, 26960k reserved, 1163k data, 568k init, 130816k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc53000 - 0xfffff000   (3760 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc075f000 - 0xc07ed000   ( 568 kB)
      .data : 0xc0636bbf - 0xc0759a44   (1163 kB)
      .text : 0xc0400000 - 0xc0636bbf   (2266 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 4789.09 BogoMIPS (lpj=2394546)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebf3ff 00000000 00000000 0000b080 00004400 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20070126
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Total of 1 processors activated (4789.09 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=56 bytes
sizeof(inode)=604 bytes
sizeof(dentry)=160 bytes
sizeof(ext3inode)=856 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=180 bytes
sizeof(task_struct)=3376 bytes
khelper used greatest stack depth: 3160 bytes left
Booting paravirtualized kernel on bare hardware
khelper used greatest stack depth: 2836 bytes left
Time: 19:54:39  Date: 09/04/107
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
Time: tsc clocksource has been installed.
pnp: 00:02: ioport range 0x400-0x47f has been reserved
pnp: 00:02: ioport range 0x500-0x53f has been reserved
pnp: 00:02: ioport range 0x800-0x87f has been reserved
pnp: 00:02: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:02: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:0e: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0e: iomem range 0xe8000-0xfffff could not be reserved
pnp: 00:0e: iomem range 0x100000-0x3fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc800000-fc8fffff
  PREFETCH window: f4500000-f45fffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fc900000-feafffff
  PREFETCH window: f4600000-f46fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Switched to high resolution mode on CPU 0
Freeing initrd memory: 4523k freed
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1191527678.884:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
khelper used greatest stack depth: 2808 bytes left
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key C5D13217BADC3CCB
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Firmware left 0000:02:0c.0 e100 interrupts enabled, disabling
PCI: Firmware left 0000:02:0d.0 e100 interrupts enabled, disabling
Boot video device is 0000:02:0f.0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Exception (processor_core-0819): AE_NOT_FOUND, Processor Device is not present [20070126]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
khelper used greatest stack depth: 2784 bytes left
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
  Magic number: 11:231:950
  hash matches device tty7
Freeing unused kernel memory: 568k freed
Write protecting the kernel read-only data: 864k
mknod used greatest stack depth: 2732 bytes left
ln used greatest stack depth: 2720 bytes left
mount used greatest stack depth: 2560 bytes left
SCSI subsystem initialized
modprobe used greatest stack depth: 2296 bytes left
loop: module loaded
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 16, io base 0x0000ef40
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
libata version 2.21 loaded.
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 17, io base 0x0000ef80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
modprobe used greatest stack depth: 1868 bytes left
ata_piix 0000:00:1f.1: version 2.12
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
ata1.01: ATAPI: TEAC DW-548D, K4H6, max UDMA/33
ata1.01: configured for UDMA/33
ata2: port disabled. ignoring.
scsi 0:0:1:0: CD-ROM            TEAC     DW-548D          K4H6 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 22 (level, low) -> IRQ 18
scsi2 : pata_pdc202xx_old
scsi3 : pata_pdc202xx_old
ata3: PATA max UDMA/100 cmd 0x0001dff0 ctl 0x0001dfe6 bmdma 0x0001df00 irq 18
ata4: PATA max UDMA/100 cmd 0x0001dfa8 ctl 0x0001dfe2 bmdma 0x0001df08 irq 18
ata3.00: ATA-7: HDT722525DLAT80, V44OA70A, max UDMA/133
ata3.00: 488397168 sectors, multi 16: LBA48 
ata3.00: configured for UDMA/100
ata4.00: ATA-7: HDT722525DLAT80, V44OA70A, max UDMA/133
ata4.00: 488397168 sectors, multi 16: LBA48 
ata4.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      HDT722525DLAT80  V44O PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      HDT722525DLAT80  V44O PQ: 0 ANSI: 5
modprobe used greatest stack depth: 1392 bytes left
sd 2:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 2:0:0:0: [sda] Attached SCSI disk
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 3:0:0:0: [sdb] Attached SCSI disk
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf8
Unable to load NLS charset utf8
ISO 9660 Extensions: RRIP_1991A
mount used greatest stack depth: 1152 bytes left
squashfs: version 3.2-r2 (2007/01/15) Phillip Lougher
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
audit(1191527687.619:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  8 users, 11 roles, 2284 types, 107 bools, 1 sens, 1024 cats
security:  67 classes, 227389 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=522
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=194
inode_doinit_with_dentry:  no dentry for dev=dm-0 ino=193
SELinux: initialized (dev loop2, type squashfs), not configured for labeling
SELinux: initialized (dev loop0, type squashfs), not configured for labeling
SELinux: initialized (dev sr0, type iso9660), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1191527689.230:3): policy loaded auid=4294967295
iTCO_vendor_support: vendor-support=0
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PBTN]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: Found a ICH2 TCO device (Version=1, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
sr 0:0:1:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 3:0:0:0: Attached scsi generic sg2 type 0
parport_pc 00:0c: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 19
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 18
eth0: RTL8110s at 0xf8aa6c00, 00:0e:2e:09:5e:a6, XID 04000000 IRQ 18
intel_rng: Firmware space is locked read-only. If you can't or
intel_rng: don't want to disable this in firmware setup, and if
intel_rng: you are certain that your system has a functional
intel_rng: RNG, try using the 'no_fwh_detect' option.
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 18 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfeafd000, irq 20, MAC addr 00:07:E9:F2:BF:48
tg3.c:v3.81 (September 5, 2007)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 21
eth2: Tigon3 [partno(AT2915T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:30:84:b3:be:93
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[0]
eth2: dma_rwctrl[76ff000f] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 19 (level, low) -> IRQ 16
e100: eth3: e100_probe: addr 0xfeafc000, irq 16, MAC addr 00:07:E9:F2:BF:49
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on dm-0, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
audit(1191542145.485:4): audit_pid=1911 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
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
e100: eth3: e100_watchdog: link up, 100Mbps, full-duplex
ADDRCONF(NETDEV_UP): eth2: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
r8169: eth0: link down
r8169: eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth3: no IPv6 routers present
md: md0 stopped.
md: bind<sdb>
md: bind<sda>
md: raid1 personality registered for level 1
raid1: raid set md0 active with 1 out of 2 mirrors
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sda
 disk 1, wo:1, o:1, dev:sdb
md: recovery of RAID array md0
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for recovery.
md: using 128k window, over a total of 244198464 blocks.
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/100
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:10:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:10:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/100
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:12:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:12:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/100
ata4: EH complete
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: limiting speed to UDMA/66:PIO4
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:15:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:15:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/66
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:17:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:17:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/66
ata4: EH complete
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:1c:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:1c:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/66
ata4: EH complete
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:1e:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:1e:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/66
ata4: EH complete
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
ata4.00: limiting speed to UDMA/33:PIO4
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:20:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:21:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:2f:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:30:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:72:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:73:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:eb:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:ec:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:05:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:05:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:12:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:12:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:27:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:28:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:80:80:39:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 65536 out
         res 51/84:00:ff:39:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:80:3e:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:7f:3f:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:4f:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:4f:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:b5:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:b5:01/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for UDMA/33
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: limiting speed to PIO4
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x4
ata4.00: cmd ca/00:00:00:10:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 out
         res 51/84:00:ff:10:02/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata4: soft resetting port
ata4.00: configured for PIO4
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

--=-vZI1TB0gj75q51yccYpn--

