From: Daniel Egger <de@axiros.com>
Subject: Booting from SATA disables IDE?
Date: Fri, 1 Apr 2005 15:42:07 +0200
Message-ID: <1921eeb1e202db77fdccb439f85ac532@axiros.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13-911741180"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:57040
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S262736AbVDANnK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 08:43:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzig@pobox.com


--Apple-Mail-13-911741180
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi,

I've a very serious and annoying problem I have tracked down to a
likely libata problem.

Here's the scenario:
I have a fileserver which, for temporary backup purposes, transfers
data from one drive to another. In order to get some nice SATA
equipment I decided to buy a SATA drive for which the mainboard
(AsRock K7VT4A Pro) already has the necessary facilities (sata_via).

Got the drive connected, loaded the drivers, checked for bad blocks,
partitioned and mkfs'ed the drive, mounted the new partitions: good.

Now the tricky part. After copying over the data from the old drive
the SATA is intended to replace, I installed a bootloader (grub),
forced the system (Debian testing) to rebuild the initrd for the
kernel (2.6.10) with the included sata_via driver and libata.
Rebooted, works: good.

However, I can not use the regular PATA Via driver anymore because
it simply will not detect any devices.

I checked mailinglists, google, even the sourcecode but there seems
to be no way to to make that work correctly.

So everytime I boot from SATA I cannot use PATA anymore because
the driver loads but doesn't work and vice versa (PATA before SATA)
does work but only in theory because I have no system on the PATA
drive and couldn't install one even if I wanted to (and I do not).

Is there any way to have the SATA driver stay away from the PATA
stuff?

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
         Subsystem: Unknown device 1849:3189
         Flags: bus master, 66MHz, medium devsel, latency 8
         Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
         Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge 
(prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Capabilities: [80] Power Management version 2

0000:00:09.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 
00 [VGA])
         Flags: medium devsel
         Memory at de000000 (32-bit, prefetchable) [size=16M]
         Expansion ROM at dfff0000 [disabled] [size=32K]

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8169 Gigabit Ethernet (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit 
Ethernet
         Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 185
         I/O ports at d400 [size=256]
         Memory at dffebf00 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at ffff0000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2

0000:00:0b.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit 
Ethernet Controller
         Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
         Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 177
         Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
         Memory at dffa0000 (32-bit, non-prefetchable) [size=128K]
         I/O ports at d000 [size=64]
         Expansion ROM at fffe0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
         Capabilities: [e4] PCI-X non-bridge device.
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-

0000:00:0d.0 FireWire (IEEE 1394): NEC Corporation uPD72874 IEEE1394 
OHCI 1.1 3-port PHY-Link Ctrlr (rev 01) (prog-if 10 [OHCI])
         Subsystem: NEC Corporation: Unknown device 00ce
         Flags: bus master, medium devsel, latency 128, IRQ 201
         Memory at dffea000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [60] Power Management version 2

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 
SATA RAID Controller (rev 80)
         Subsystem: Unknown device 1849:3149
         Flags: bus master, medium devsel, latency 128, IRQ 169
         I/O ports at ec00 [size=8]
         I/O ports at e800 [size=4]
         I/O ports at e400 [size=8]
         I/O ports at e000 [size=4]
         I/O ports at dc00 [size=16]
         I/O ports at d800 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Unknown device 1849:0571
         Flags: bus master, medium devsel, latency 32, IRQ 255
         I/O ports at fc00 [size=16]
         Capabilities: [c0] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: Unknown device 1849:3038
         Flags: bus master, medium devsel, latency 128, IRQ 209
         I/O ports at c000 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: Unknown device 1849:3038
         Flags: bus master, medium devsel, latency 128, IRQ 209
         I/O ports at c400 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: Unknown device 1849:3038
         Flags: bus master, medium devsel, latency 128, IRQ 209
         I/O ports at c800 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: Unknown device 1849:3038
         Flags: bus master, medium devsel, latency 128, IRQ 209
         I/O ports at cc00 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) 
(prog-if 20 [EHCI])
         Subsystem: Unknown device 1849:3104
         Flags: bus master, medium devsel, latency 128, IRQ 209
         Memory at dffebd00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]
         Subsystem: Unknown device 1849:3227
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
         Subsystem: Unknown device 1849:9761
         Flags: medium devsel, IRQ 217
         I/O ports at bc00 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 78)
         Subsystem: Unknown device 1849:3065
         Flags: bus master, medium devsel, latency 128, IRQ 193
         I/O ports at b800 [size=256]
         Memory at dffebc00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2

libata version 1.10 loaded.
sata_via version 1.0
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 169
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 169
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
elevator: using anticipatory as default io scheduler
   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


Servus,
       Daniel

--Apple-Mail-13-911741180
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCTU+vchlzsq9KoIYRAl6pAJ4tLPCoSTzRpT0Re2Dl7MUhaWDFJwCgk+6w
A3wbT8xL31wGWxDy48RlXDk=
=zNAQ
-----END PGP SIGNATURE-----

--Apple-Mail-13-911741180--

