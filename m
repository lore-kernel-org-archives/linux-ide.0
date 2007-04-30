From: Craig Metz <cmetz@inner.net>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Mon, 30 Apr 2007 10:44:09 -0400
Message-ID: <20070430144409.E1A85582C@rmail.inner.net>
References: <010501c78736$aad2e480$0703a8c0@SJAWINXP> <20070426023534.68007582C@rmail.inner.net> <4634CB4E.30402@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rmail.inner.net ([199.33.248.12]:4228 "EHLO rmail.inner.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423300AbXD3Ocy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Apr 2007 10:32:54 -0400
In-reply-to: <4634CB4E.30402@gmail.com> 
Content-ID: <13374.1177944219.0@inner.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Steven J. Ackerman" <sjackerman@comcast.net>, linux-ide@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13374.1177944219.1@inner.net>

In message <4634CB4E.30402@gmail.com>, you write:
>>   I am also having problems with this device, but on both an ICH5 and on a
>> VIA pre-AHCI SATA controller. I just tried 2.6.21-rc7 - it fails in exactly 
>> same way as with 2.6.20.
>
>Can you please post full dmesg?

  Two attachments - one ICH5, one VIA.

									-Craig


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="linux-2.6.21-rc7-enhanced";
	charset="us-ascii"
Content-ID: <13374.1177944219.2@inner.net>

ecking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 4096k freed
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
ACPI: Fan [FAN] (off)
ACPI: Invalid passive threshold
ACPI: Thermal Zone [THRM] (53 C)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
intel_rng: FWH not detected
i8xx TCO timer: initialized (0x0460). heartbeat=30 sec (nowayout=0)
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: I/O address 0x0460 already in use
iTCO_wdt: No card detected
iTCO_vendor_support: vendor-support=0
SoftDog: cannot register miscdev on minor=130 (err=-16)
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: AGP aperture is 4M @ 0xf6000000
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508d0000f67cf6]
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:50:8d:f7:7c:f6
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt 0000:03:09.0[A] -> GSI 17 (level, low) -> IRQ 17
eth1: 0000:03:09.0, 00:90:27:8C:59:68, IRQ 17.
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 20 (level, low) -> IRQ 18
eth2: 0000:04:04.0, 00:20:FC:1E:57:24, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 082100-010, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
  Receiver lock-up workaround activated.
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 21 (level, low) -> IRQ 19
eth3: 0000:04:05.0, 00:20:FC:1E:57:25, IRQ 19.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 082100-010, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
  Receiver lock-up workaround activated.
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 22 (level, low) -> IRQ 20
eth4: 0000:04:06.0, 00:20:FC:1E:57:26, IRQ 20.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 082100-010, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
  Receiver lock-up workaround activated.
ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 23 (level, low) -> IRQ 21
eth5: 0000:04:07.0, 00:20:FC:1E:57:27, IRQ 21.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 082100-010, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
  Receiver lock-up workaround activated.
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
via-rhine: Broken BIOS detected, avoid_D3 enabled.
Marvell 88E1101: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
HDLC support module revision 1.21
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
Loading iSCSI transport class v2.0-724.
iscsi: registered transport (tcp)
ata_piix 0000:00:1f.2: version 2.10ac1
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x0001c000 ctl 0x0001c402 bmdma 0x0001d000 irq 16
ata2: SATA max UDMA/133 cmd 0x0001c800 ctl 0x0001cc02 bmdma 0x0001d008 irq 16
scsi0 : ata_piix
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: limiting speed to UDMA7:PIO5
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ATA: abnormal status 0xD0 on port 0x0001c007
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x0001c807
sata_sil 0000:03:03.0: version 2.1
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 22
ata3: SATA max UDMA/100 cmd 0xf8870080 ctl 0xf887008a bmdma 0xf8870000 irq 22
ata4: SATA max UDMA/100 cmd 0xf88700c0 ctl 0xf88700ca bmdma 0xf8870008 irq 22
scsi2 : sata_sil
ata3: SATA link down (SStatus 0 SControl 310)
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
aoe: AoE v32 initialised.
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xf6400000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000bc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000b000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 16, io base 0x0000b400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000b800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for DeLorme Earthmate USB
drivers/usb/serial/usb-serial.c: USB Serial support registered for HID->COM RS232 Adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Nokia CA-42 V2 Adapter
usbcore: registered new interface driver cypress
drivers/usb/serial/cypress_m8.c: Cypress USB to Serial Driver v1.09
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:03 failed with error -16
i2c /dev entries driver
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
md: raid1 personality registered for level 1
raid6: int32x1    666 MB/s
raid6: int32x2    874 MB/s
raid6: int32x4    759 MB/s
raid6: int32x8    581 MB/s
raid6: mmxx1     2271 MB/s
raid6: mmxx2     2933 MB/s
raid6: sse1x1    1441 MB/s
raid6: sse1x2    2391 MB/s
raid6: sse2x1    2941 MB/s
raid6: sse2x2    3133 MB/s
raid6: using algorithm sse2x2 (3133 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3652.800 MB/sec
raid5: using function: pIII_sse (3652.800 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EDAC MC: Ver: 2.0.1 Apr 26 2007
EDAC i82875p: i82875p init one
PCI: Unable to reserve mem region #1:1000@fecf0000 for device 0000:00:06.0
EDAC MC0: Giving out device to i82875p_edac i82875p: DEV 0000:00:00.0
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
wbsd: Winbond W83L51xD SD/MMC card interface driver
wbsd: Copyright(c) Pierre Ossman
padlock: No VIA PadLock drivers have been loaded.
padlock: VIA PadLock not detected.
padlock: VIA PadLock Hash Engine not detected.
pktgen v2.68: Packet Generator for packet performance testing.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
input: PS/2 Generic Mouse as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 172.16.1.15, my address is 172.16.1.92
IP-Config: Complete:
      device=eth1, addr=172.16.1.92, mask=255.255.255.0, gw=172.16.1.1,
     host=lab2, domain=int.inner.net, nis-domain=(none),
     bootserver=172.16.1.15, rootserver=172.16.1.15, rootpath=
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 240k freed
aoe: e1.1: setting 1024 byte data frames on eth1
aoe: e3.1: setting 1024 byte data frames on eth1
aoe: e3.2: setting 1024 byte data frames on eth1
aoe: e2.2: setting 1024 byte data frames on eth1
aoe: e2.1: setting 1024 byte data frames on eth1
aoe: e1.2: setting 1024 byte data frames on eth1
aoe: e0.4: setting 1024 byte data frames on eth1
aoe: 000e0c378c92 e1.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e3.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e3.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e2.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e2.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e1.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e0.4 v400c has 1048576 sectors
 etherd/e1.1: unknown partition table
 etherd/e3.1: unknown partition table
 etherd/e3.2: unknown partition table
 etherd/e2.2: unknown partition table
 etherd/e2.1: unknown partition table
 etherd/e1.2: unknown partition table
 etherd/e0.4:
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on etherd/e2.1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on etherd/e2.1, internal journal

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="linux-2.6.21-rc7-via"; charset="us-ascii"
Content-ID: <13374.1177944219.3@inner.net>

6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs *20)
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22), disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
libata version 2.20 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
pnp: 00:00: iomem range 0xd3800-0xd3fff has been reserved
Time: tsc clocksource has been installed.
pnp: 00:00: iomem range 0xf0000-0xf7fff could not be reserved
pnp: 00:00: iomem range 0xf8000-0xfbfff could not be reserved
pnp: 00:00: iomem range 0xfc000-0xfffff could not be reserved
pnp: 00:02: ioport range 0x400-0x47f has been reserved
pnp: 00:02: ioport range 0x500-0x50f has been reserved
ieee1394: Initialized config rom entry `ip1394'
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fb000000-fcffffff
  PREFETCH window: f4000000-f7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 4096k freed
microcode: CPU0 not a capable Intel processor
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (25 C)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
VIA RNG detected
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: No card detected
iTCO_vendor_support: vendor-support=0
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected VIA VT3314 chipset
agpgart: AGP aperture is 32M @ 0xf8000000
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Time: acpi_pm clocksource has been installed.
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:00:08.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:37:0a:c8
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
via-rhine: Broken BIOS detected, avoid_D3 enabled.
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKD] -> GSI 23 (level, low) -> IRQ 17
eth1: VIA Rhine II at 0xfdffe000, 00:16:ec:e1:92:bc, IRQ 17.
eth1: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
Marvell 88E1101: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
HDLC support module revision 1.21
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
Loading iSCSI transport class v2.0-724.
iscsi: registered transport (tcp)
sata_via 0000:00:0f.0: version 2.1
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 18
sata_via 0000:00:0f.0: routed to hard irq line 11
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata1: SATA max UDMA/133 cmd 0x0001fe00 ctl 0x0001fd02 bmdma 0x0001fa00 irq 18
ata2: SATA max UDMA/133 cmd 0x0001fc00 ctl 0x0001fb02 bmdma 0x0001fa08 irq 18
scsi0 : sata_via
ata1: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x0001fe07
scsi1 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: limiting speed to UDMA7:PIO5
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0x7F on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ATA: abnormal status 0xD0 on port 0x0001fc07
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0x7F on port 0x0001fc07
pata_via 0000:00:0f.1: version 0.2.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:0f.1 to 64
ata3: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f900 irq 14
ata4: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f908 irq 15
scsi2 : pata_via
ATA: abnormal status 0x8 on port 0x000101f7
scsi3 : pata_via
ATA: abnormal status 0x8 on port 0x00010177
aoe: AoE v32 initialised.
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:10.4 to 64
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 19, io mem 0xfdfff000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:10.0 to 64
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 19, io base 0x0000f800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:10.1 to 64
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 19, io base 0x0000f700
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:10.2 to 64
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000f600
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:10.3 to 64
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 19, io base 0x0000f500
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for DeLorme Earthmate USB
drivers/usb/serial/usb-serial.c: USB Serial support registered for HID->COM RS232 Adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Nokia CA-42 V2 Adapter
usbcore: registered new interface driver cypress
drivers/usb/serial/cypress_m8.c: Cypress USB to Serial Driver v1.09
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:05 failed with error -16
i2c /dev entries driver
md: raid1 personality registered for level 1
raid6: int32x1    165 MB/s
raid6: int32x2    208 MB/s
raid6: int32x4    210 MB/s
raid6: int32x8    178 MB/s
raid6: mmxx1      464 MB/s
raid6: mmxx2      775 MB/s
raid6: sse1x1     536 MB/s
raid6: sse1x2     782 MB/s
raid6: sse2x1     947 MB/s
raid6: sse2x2    1130 MB/s
raid6: using algorithm sse2x2 (1130 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3325.600 MB/sec
raid5: using function: pIII_sse (3325.600 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EDAC MC: Ver: 2.0.1 Apr 26 2007
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
wbsd: Winbond W83L51xD SD/MMC card interface driver
wbsd: Copyright(c) Pierre Ossman
padlock: No VIA PadLock drivers have been loaded.
padlock: Using VIA PadLock ACE for AES algorithm.
padlock: Using VIA PadLock ACE for SHA1/SHA256 algorithms.
pktgen v2.68: Packet Generator for packet performance testing.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
longhaul: APIC detected. Longhaul is currently broken in this configuration.
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
input: AT Translated Set 2 keyboard as /class/input/input0
input: PS/2 Generic Mouse as /class/input/input1
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 172.16.1.15, my address is 172.16.1.93
IP-Config: Complete:
      device=eth1, addr=172.16.1.93, mask=255.255.255.0, gw=172.16.1.1,
     host=lab3, domain=int.inner.net, nis-domain=(none),
     bootserver=172.16.1.15, rootserver=172.16.1.15, rootpath=
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 240k freed
aoe: e1.1: setting 1024 byte data frames on eth1
aoe: e3.1: setting 1024 byte data frames on eth1
aoe: e3.2: setting 1024 byte data frames on eth1
aoe: e2.2: setting 1024 byte data frames on eth1
aoe: e2.1: setting 1024 byte data frames on eth1
aoe: e1.2: setting 1024 byte data frames on eth1
aoe: e0.4: setting 1024 byte data frames on eth1
aoe: 000e0c378c92 e1.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e3.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e3.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e2.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e2.1 v400c has 4194304 sectors
aoe: 000e0c378c92 e1.2 v400c has 4194304 sectors
aoe: 000e0c378c92 e0.4 v400c has 1048576 sectors
 etherd/e1.1: unknown partition table
 etherd/e3.1: unknown partition table
 etherd/e3.2: unknown partition table
 etherd/e2.2: unknown partition table
 etherd/e2.1: unknown partition table
 etherd/e1.2: unknown partition table
 etherd/e0.4:
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on etherd/e3.1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on etherd/e3.1, internal journal

------- =_aaaaaaaaaa0--
