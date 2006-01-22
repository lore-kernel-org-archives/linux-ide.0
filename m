From: Chris Bamford <chris@bammers.net>
Subject: sata_sis on Ubuntu 5.10
Date: Sun, 22 Jan 2006 20:55:31 +0000
Message-ID: <43D3F143.9000401@bammers.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040900000601080905000101"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ranger.systems.pipex.net ([62.241.162.32]:3744 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1751340AbWAVUzl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jan 2006 15:55:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: touch@sis.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900000601080905000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Uwe,

I have been unsuccessfully trying to get Linux to work with my SATA disk 
on my ASUS Vintage AE-1 barebone machine.

I have posted to the ASUS support site (see 
http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM200601212130302557), 
and am still waiting for a reply.
For more background on the problem, please see the attached message 
which I sent to the ubuntu-users mailing list - which did not produce 
any answers. 
The BIOS can see the SATA disk, but Linux does not!
If I type "lsmod | grep -i ata" it returns nothing (no 'ata' drivers 
loaded). If I type 'locate sata_sis', it finds 2 copies, so I assume it 
should be OK if I load the drivers with modprobe:

    mobprobe sat_sis
    modprobe ata

"lsmod | grep -i ata" now shows them loaded, but what do I do next?  the 
devices /dev/sd* are not present, so I cannot access the disk. Am I 
missing a step?
I tried to build the driver from the sources provided on the CD with the 
machine, but it would not build (filesystem layout differences between 
Fedora and Debian??).

Anyway, please help!

Any pointers/info/etc would be gratefully received.

Thanks,

- Chris


--------------040900000601080905000101
Content-Type: message/rfc822;
 name="Attached Message.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message.eml"

X-Account-Key: account1
Return-Path: <SRS0=umAS=3K=lists.ubuntu.com=ubuntu-users-bounces@srs.kundenserver.de>
X-Original-To: bamfords@dsl.pipex.com
X-Envelope-To: bamfords@dsl.pipex.com
Delivered-To: bamfords@dsl.pipex.com
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.126.187])
	by twilight.systems.pipex.net (Postfix) with ESMTP id 9249FE000099
	for <bamfords@dsl.pipex.com>; Sat, 14 Jan 2006 10:25:00 +0000 (GMT)
Received: from [82.211.81.173] (helo=esperanza.ubuntu.com)
	by mx.kundenserver.de (node=mxeu11) with ESMTP (Nemesis),
	id 0MKuA8-1Exiah3zUv-0000RO for chris@bammers.net; Sat, 14 Jan 2006 11:25:00 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.52)
	id 1ExiWT-0003cv-9p; Sat, 14 Jan 2006 10:20:37 +0000
Received: from ranger.systems.pipex.net ([62.241.162.32])
	by esperanza.ubuntu.com with esmtp (Exim 4.52) id 1ExiWR-0003co-59
	for ubuntu-users@lists.ubuntu.com; Sat, 14 Jan 2006 10:20:35 +0000
Received: from [192.168.1.2] (81-86-119-77.dsl.pipex.com [81.86.119.77])
	by ranger.systems.pipex.net (Postfix) with ESMTP id 5838DE000149
	for <ubuntu-users@lists.ubuntu.com>;
	Sat, 14 Jan 2006 10:20:33 +0000 (GMT)
Message-ID: <43C8D070.2060007@bammers.net>
Date: Sat, 14 Jan 2006 10:20:32 +0000
From: Chris Bamford <chris@bammers.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ubuntu-users@lists.ubuntu.com
Content-Type: multipart/mixed; boundary="------------080103020208020000030401"
Subject: SATA disk not recognised by Breezy
X-BeenThere: ubuntu-users@lists.ubuntu.com
X-Mailman-Version: 2.1.5
Precedence: list
Reply-To: Ubuntu Help and User Discussions <ubuntu-users@lists.ubuntu.com>
List-Id: Ubuntu Help and User Discussions <ubuntu-users.lists.ubuntu.com>
List-Unsubscribe: <http://lists.ubuntu.com/mailman/listinfo/ubuntu-users>,
	<mailto:ubuntu-users-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <http://lists.ubuntu.com/archives/ubuntu-users>
List-Post: <mailto:ubuntu-users@lists.ubuntu.com>
List-Help: <mailto:ubuntu-users-request@lists.ubuntu.com?subject=help>
List-Subscribe: <http://lists.ubuntu.com/mailman/listinfo/ubuntu-users>,
	<mailto:ubuntu-users-request@lists.ubuntu.com?subject=subscribe>
Sender: ubuntu-users-bounces@lists.ubuntu.com
Errors-To: ubuntu-users-bounces@lists.ubuntu.com

This is a multi-part message in MIME format.
--------------080103020208020000030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi - I've recently bought an ASUS Vintage-AE1 bare bone system and 
installed Breezy Badger on it.  All aspects of the system work fine 
except the SATA disk which is recognised by the BIOS, but not seen at 
all by Ubuntu.  The BIOS supports the following configuration options 
for the onboard PCI SATA Controller:

    * disabled
    * native
    * RAID by ROM

None of these seem to help.

I have checked the mailing list and searched the Ubuntu bugzilla but 
have had no joy.

The system chipset is the SIS 760GX and supports Serial ATA RAID.
The disk is a MAXTOR 6L250S0 250Gb drive.

Frustratingly, if I boot from a Tom's Root Boot CD, the disk is visible 
as /dev/hde, so I know it does work!  I am assuming that Ubuntu is 
either not loading the correct driver or having a problem initialising 
it.  I attach the dmesg bootlog from Ubuntu.

Please can anyone advise?


Thanks
Chris

--------------080103020208020000030401
Content-Type: text/plain;
 name="ubuntu5.10.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ubuntu5.10.dmesg"

04000508 MSFT 0x00000097) @ 0x3df40390
[4294667.296000] ACPI: OEMB (v001 A M I  AMI_OEM  0x04000508 MSFT 0x00000097) @ 0x3df50040
[4294667.296000] ACPI: DSDT (v001  A0253 A0253203 0x00000203 INTL 0x02002026) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:12 APIC version 16
[4294667.296000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 1, version 20, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 3e000000 (gap: 3e000000:c17c0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda1 ro quiet splash
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1995.667 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294667.703000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294667.704000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294667.719000] Memory: 997740k/1015040k available (1416k kernel code, 16612k reserved, 762k data, 224k init, 97536k highmem)
[4294667.719000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294667.719000] Calibrating delay loop... 3964.92 BogoMIPS (lpj=1982464)
[4294667.741000] Security Framework v1.0.0 initialized
[4294667.741000] SELinux:  Disabled at boot.
[4294667.741000] Mount-cache hash table entries: 512
[4294667.741000] CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
[4294667.741000] CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
[4294667.741000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[4294667.741000] CPU: L2 Cache: 512K (64 bytes/line)
[4294667.741000] CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000010 00000001 00000000 00000001
[4294667.741000] CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 02
[4294667.741000] Enabling fast FPU save and restore... done.
[4294667.741000] Enabling unmasked SIMD FPU exception support... done.
[4294667.741000] Checking 'hlt' instruction... OK.
[4294667.745000] Checking for popad bug... OK.
[4294667.745000] checking if image is initramfs... it is
[4294668.134000] Freeing initrd memory: 5171k freed
[4294668.134000] ACPI: Looking for DSDT in initrd... not found!
[4294668.178000]  not found!
[4294668.185000] ENABLING IO-APIC IRQs
[4294668.185000] ..TIMER: vector=0x31 pin1=2 pin2=-1
[4294668.296000] NET: Registered protocol family 16
[4294668.296000] EISA bus registered
[4294668.296000] ACPI: bus type pci registered
[4294668.296000] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
[4294668.296000] PCI: Using configuration type 1
[4294668.296000] mtrr: v2.0 (20020519)
[4294668.296000] ACPI: Subsystem revision 20050729
[4294668.303000] ACPI: Interpreter enabled
[4294668.303000] ACPI: Using IOAPIC for interrupt routing
[4294668.304000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294668.304000] PCI: Probing PCI hardware (bus 00)
[4294668.304000] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[4294668.307000] Boot video device is 0000:01:00.0
[4294668.317000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294668.317000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[4294668.322000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
[4294668.322000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[4294668.322000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
[4294668.323000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294668.323000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294668.323000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 12 14 15)
[4294668.323000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 10 11 12 14 15)
[4294668.323000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294668.324000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 7 10 11 12 14 15)
[4294668.324000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294668.324000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294668.324000] pnp: PnP ACPI init
[4294668.328000] pnp: PnP ACPI: found 11 devices
[4294668.328000] PnPBIOS: Disabled by ACPI PNP
[4294668.328000] PCI: Using ACPI for IRQ routing
[4294668.328000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294668.338000] pnp: 00:08: ioport range 0x290-0x297 has been reserved
[4294668.338000] audit: initializing netlink socket (disabled)
[4294668.339000] audit: initialized
[4294668.339000] highmem bounce pool size: 64 pages
[4294668.339000] VFS: Disk quotas dquot_6.5.1
[4294668.339000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294668.339000] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[4294668.339000] devfs: boot_options: 0x0
[4294668.339000] Initializing Cryptographic API
[4294668.339000] isapnp: Scanning for PnP cards...
[4294668.693000] isapnp: No Plug & Play device found
[4294668.705000] PNP: No PS/2 controller found. Probing ports directly.
[4294668.706000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294668.706000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294668.706000] Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
[4294668.706000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294668.706000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294668.707000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294668.707000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294668.707000] io scheduler noop registered
[4294668.707000] io scheduler anticipatory registered
[4294668.707000] io scheduler deadline registered
[4294668.707000] io scheduler cfq registered
[4294668.708000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[4294668.708000] EISA: Probing bus 0 at eisa.0
[4294668.708000] Cannot allocate resource for EISA slot 8
[4294668.708000] EISA: Detected 0 cards.
[4294668.708000] NET: Registered protocol family 2
[4294668.717000] IP: routing cache hash table of 8192 buckets, 64Kbytes
[4294668.717000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[4294668.718000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294668.718000] TCP: Hash tables configured (established 131072 bind 65536)
[4294668.718000] NET: Registered protocol family 8
[4294668.718000] NET: Registered protocol family 20
[4294668.718000] ACPI wakeup devices: 
[4294668.718000] EUSB  USB USB2 USB3 AC97 MC97 PCI1 PCI2  MAC 
[4294668.718000] ACPI: (supports S0 S1 S3 S4 S5)
[4294668.718000] Freeing unused kernel memory: 224k freed
[4294668.731000] vga16fb: initializing
[4294668.731000] vga16fb: mapped to 0xc00a0000
[4294668.814000] Console: switching to colour frame buffer device 80x30
[4294668.814000] fb0: VGA16 VGA frame buffer device
[4294669.882000] Capability LSM initialized
[4294669.891000] NET: Registered protocol family 1
[4294669.900000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294669.900000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294669.900000] ACPI: bus type ide registered
[4294669.914000] SIS5513: IDE controller at PCI slot 0000:00:02.5
[4294669.914000] SIS5513: chipset revision 1
[4294669.914000] SIS5513: not 100% native mode: will probe irqs later
[4294669.914000] SIS5513: IDE controller at PCI slot 0000:00:02.5
[4294669.914000] SIS5513: chipset revision 1
[4294669.914000] SIS5513: not 100% native mode: will probe irqs later
[4294669.914000] SIS_IDE: probe of 0000:00:02.5 failed with error -1
[4294669.914000] Probing IDE interface ide0...
[4294670.298000] hda: QUANTUM FIREBALL CR6.4A, ATA DISK drive
[4294670.706000] hdb: SONY DVD RW DW-Q30A, ATAPI CD/DVD-ROM drive
[4294670.757000] Probing IDE interface ide1...
[4294671.275000] Probing IDE interface ide2...
[4294671.787000] Probing IDE interface ide3...
[4294672.299000] Probing IDE interface ide4...
[4294672.811000] Probing IDE interface ide5...
[4294673.323000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294673.325000] hda: max request size: 128KiB
[4294673.340000] hda: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=13328/15/63
[4294673.340000] hda: cache flushes not supported
[4294673.340000]  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
[4294673.372000] hdb: ATAPI 8X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[4294673.372000] Uniform CD-ROM driver Revision: 3.20
[4294673.598000] Attempting manual resume
[4294673.604000] swsusp: Suspend partition has wrong signature?
[4294673.641000] usbcore: registered new driver usbfs
[4294673.641000] usbcore: registered new driver hub
[4294673.641000] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[4294673.641000] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
[4294673.641000] ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
[4294673.674000] ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
[4294673.674000] ohci_hcd 0000:00:03.0: irq 20, io mem 0xfbefc000
[4294673.727000] hub 1-0:1.0: USB hub found
[4294673.727000] hub 1-0:1.0: 3 ports detected
[4294673.730000] ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
[4294673.730000] ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
[4294673.741000] ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
[4294673.741000] ohci_hcd 0000:00:03.1: irq 21, io mem 0xfbefd000
[4294673.794000] hub 2-0:1.0: USB hub found
[4294673.794000] hub 2-0:1.0: 3 ports detected
[4294673.797000] ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
[4294673.797000] ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
[4294673.808000] ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
[4294673.808000] ohci_hcd 0000:00:03.2: irq 22, io mem 0xfbefe000
[4294673.861000] hub 3-0:1.0: USB hub found
[4294673.861000] hub 3-0:1.0: 2 ports detected
[4294673.882000] ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
[4294673.882000] ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
[4294673.882000] ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
[4294673.882000] ehci_hcd 0000:00:03.3: irq 23, io mem 0xfbeff000
[4294673.882000] PCI: cache line size of 64 is not supported by device 0000:00:03.3
[4294673.882000] ehci_hcd 0000:00:03.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[4294673.882000] hub 4-0:1.0: USB hub found
[4294673.882000] hub 4-0:1.0: 8 ports detected
[4294673.933000] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294673.933000] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[4294673.933000] 0000:00:09.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x8800. Vers LK1.1.19
[4294673.954000] eth0: Dropping NETIF_F_SG since no checksum feature.
[4294674.497000] usb 1-2: new low speed USB device using ohci_hcd and address 3
[4294674.773000] usb 3-1: new full speed USB device using ohci_hcd and address 2
[4294674.883000] hub 3-1:1.0: USB hub found
[4294674.886000] hub 3-1:1.0: 3 ports detected
[4294675.091000] usb 3-1.1: new full speed USB device using ohci_hcd and address 3
[4294675.997000] usbcore: registered new driver hiddev
[4294676.006000] input: USB HID v1.00 Mouse [04b3:3108] on usb-0000:00:03.0-2
[4294676.014000] input: USB HID v1.10 Keyboard [Lite-On Technology USB Productivity Option Keyboard( has the hu] on usb-0000:00:03.2-1.1
[4294676.023000] input: USB HID v1.10 Device [Lite-On Technology USB Productivity Option Keyboard( has the hu] on usb-0000:00:03.2-1.1
[4294676.023000] usbcore: registered new driver usbhid
[4294676.023000] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[4294676.311000] ACPI: CPU0 (power states: C1[C1])
[4294676.422000] Attempting manual resume
[4294676.424000] swsusp: Suspend partition has wrong signature?
[4294676.458000] kjournald starting.  Commit interval 5 seconds
[4294676.458000] EXT3-fs: mounted filesystem with ordered data mode.
[4294678.927000] md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294682.589000] Adding 297160k swap on /dev/hda5.  Priority:-1 extents:1
[4294682.924000] EXT3 FS on hda1, internal journal
[4294709.059000] parport: PnPBIOS parport detected.
[4294709.060000] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[4294709.146000] lp0: using parport0 (interrupt-driven).
[4294709.177000] mice: PS/2 mouse device common for all mice
[4294711.819000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294716.368000] Linux agpgart interface v0.101 (c) Dave Jones
[4294716.375000] agpgart: Detected SiS 760 chipset
[4294716.398000] agpgart: AGP aperture is 4M @ 0xf4000000
[4294716.779000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[4294716.892000] shpchp: shpc_init : shpc_cap_offset == 0
[4294716.893000] shpchp: shpc_init : shpc_cap_offset == 0
[4294716.893000] shpchp: shpc_init : shpc_cap_offset == 0
[4294716.894000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[4294717.538000] ACPI: PCI Interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
[4294717.851000] intel8x0_measure_ac97_clock: measured 49372 usecs
[4294717.851000] intel8x0: clocking to 48000
[4294724.282000] Real Time Clock Driver v1.12
[4294724.388000] input: PC Speaker
[4294724.533000] Floppy drive(s): fd0 is 1.44M
[4294724.548000] FDC 0 is a post-1991 82077
[4294727.046000] ts: Compaq touchscreen protocol output
[4294728.072000] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294728.083000] NET: Registered protocol family 17
[4294732.924000] NET: Registered protocol family 10
[4294732.924000] Disabled Privacy Extensions on device c02eb280(lo)
[4294732.924000] IPv6 over IPv4 tunneling driver
[4294733.888000] ACPI: Power Button (FF) [PWRF]
[4294733.888000] ACPI: Power Button (CM) [PWRB]
[4294733.969000] ibm_acpi: ec object not found
[4294743.664000] eth0: no IPv6 routers present
[4294751.734000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294751.734000] apm: overridden by ACPI.
[4294753.086000] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.4)
[4294753.088000] powernow-k8: BIOS error - no PSB or ACPI _PSS objects
[4294754.904000] Bluetooth: Core ver 2.7
[4294754.904000] NET: Registered protocol family 31
[4294754.904000] Bluetooth: HCI device and connection manager initialized
[4294754.904000] Bluetooth: HCI socket layer initialized
[4294754.949000] Bluetooth: L2CAP ver 2.7
[4294754.949000] Bluetooth: L2CAP socket layer initialized
[4294754.982000] Bluetooth: RFCOMM ver 1.5
[4294754.982000] Bluetooth: RFCOMM socket layer initialized
[4294754.982000] Bluetooth: RFCOMM TTY layer initialized
[4298199.820000] ISO 9660 Extensions: RRIP_1991A

--------------080103020208020000030401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
ubuntu-users mailing list
ubuntu-users@lists.ubuntu.com
http://lists.ubuntu.com/mailman/listinfo/ubuntu-users

--------------080103020208020000030401--




--------------040900000601080905000101--
