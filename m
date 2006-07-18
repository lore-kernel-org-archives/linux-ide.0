From: Benjamin Schieder <blindcoder@scavenger.homeip.net>
Subject: harddisk or controller broken?
Date: Tue, 18 Jul 2006 08:47:12 +0200
Message-ID: <20060718064712.GA16538@scavenger.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pallas.crash-override.net ([213.239.220.170]:29590 "EHLO
	pallas.crash-override.net") by vger.kernel.org with ESMTP
	id S932074AbWGRGsr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Jul 2006 02:48:47 -0400
Received: from ceres.scavenger.homeip.net (dslb-088-073-017-021.pools.arcor-ip.net [88.73.17.21])
	by pallas.crash-override.net (Postfix) with ESMTP id 5D95E7BFCAA
	for <linux-ide@vger.kernel.org>; Tue, 18 Jul 2006 08:48:45 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list.

Recently I've had trouble with my software raid which have been (mosstly)
resolved with the help of people from the linux-raid list.

While doing that, I stumbled over these lines in my /var/log/messages:

---
Jul 16 16:59:36 ceres kernel: hdb: status error: status=3D0x00 { }
Jul 16 16:59:36 ceres kernel: ide: failed opcode was: 0xea
Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:36 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:36 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:36 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:36 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: ide0: reset: success
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x00 { }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: ide0: reset: success
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x00 { }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
Jul 16 16:59:37 ceres kernel: end_request: I/O error, dev hdb, sector 48839=
1932
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: hdb: status error: status=3D0x10 { SeekComple=
te }
Jul 16 16:59:37 ceres kernel: ide: failed opcode was: 0xea
Jul 16 16:59:37 ceres kernel: raid5: Disk failure on hdb8, disabling device=
=2E Operation continuing on 2 devices
Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
Jul 16 16:59:37 ceres kernel: RAID5 conf printout:
Jul 16 16:59:37 ceres kernel:  --- rd:3 wd:2 fd:1
Jul 16 16:59:37 ceres kernel:  disk 0, o:0, dev:hdb8
Jul 16 16:59:37 ceres kernel:  disk 1, o:1, dev:hda8
Jul 16 16:59:37 ceres kernel:  disk 2, o:1, dev:hdc8
Jul 16 16:59:37 ceres kernel: RAID5 conf printout:
Jul 16 16:59:37 ceres kernel:  --- rd:3 wd:2 fd:1
Jul 16 16:59:37 ceres kernel:  disk 1, o:1, dev:hda8
Jul 16 16:59:37 ceres kernel:  disk 2, o:1, dev:hdc8
---

Now, is this a broken IDE controller or harddisk? Because smartctl claims
that everything is fine.

---
root@ceres:~# smartctl -H /dev/hdb
smartctl version 5.33 [i586-unknown-linux-gnu] Copyright (C) 2002-4 Bruce A=
llen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED
---

I run short tests every night and long tests every sunday to check the
devices. They're brand new, although I know that that isn't always a guaran=
tee
that they also work.

If it's important, I've attached the IDE specific output of the boot messag=
es.

---
Jul  7 23:15:08 ceres kernel: Uniform Multi-Platform E-IDE driver Revision:=
 7.00alpha2
Jul  7 23:15:08 ceres kernel: ide: Assuming 33MHz system bus speed for PIO =
modes; override with idebus=3Dxx
Jul  7 23:15:08 ceres kernel: VP_IDE: IDE controller at PCI slot 0000:00:04=
=2E1
Jul  7 23:15:08 ceres kernel: VP_IDE: chipset revision 6
Jul  7 23:15:08 ceres kernel: VP_IDE: not 100%% native mode: will probe irq=
s later
Jul  7 23:15:08 ceres kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 co=
ntroller on pci0000:00:04.1
Jul  7 23:15:08 ceres kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS setti=
ngs: hda:DMA, hdb:DMA
Jul  7 23:15:08 ceres kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS setti=
ngs: hdc:DMA, hdd:pio
Jul  7 23:15:08 ceres kernel: hda: ST3250624A, ATA DISK drive
Jul  7 23:15:08 ceres kernel: hdb: ST3250624A, ATA DISK drive
Jul  7 23:15:08 ceres kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul  7 23:15:08 ceres kernel: hdc: ST3250624A, ATA DISK drive
Jul  7 23:15:08 ceres kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  7 23:15:08 ceres kernel: PDC20268: IDE controller at PCI slot 0000:00:=
0a.0
Jul  7 23:15:08 ceres kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18=
 (level, low) -> IRQ 16
Jul  7 23:15:08 ceres kernel: PDC20268: chipset revision 2
Jul  7 23:15:08 ceres kernel: PDC20268: ROM enabled at 0x20010000
Jul  7 23:15:08 ceres kernel: PDC20268: 100%% native mode on irq 16
Jul  7 23:15:08 ceres kernel:     ide2: BM-DMA at 0xa400-0xa407, BIOS setti=
ngs: hde:pio, hdf:pio
Jul  7 23:15:08 ceres kernel:     ide3: BM-DMA at 0xa408-0xa40f, BIOS setti=
ngs: hdg:pio, hdh:pio
Jul  7 23:15:08 ceres kernel: hde: IC35L120AVV207-0, ATA DISK drive
Jul  7 23:15:08 ceres kernel: Warning: Primary channel requires an 80-pin c=
able for operation.
Jul  7 23:15:08 ceres kernel: hde reduced to Ultra33 mode.
Jul  7 23:15:08 ceres kernel: ide2 at 0xb800-0xb807,0xb402 on irq 16
Jul  7 23:15:08 ceres kernel: hda: max request size: 512KiB
Jul  7 23:15:08 ceres kernel: hda: 488397168 sectors (250059 MB) w/16384KiB=
 Cache, CHS=3D30401/255/63, UDMA(100)
Jul  7 23:15:08 ceres kernel: hda: cache flushes supported
Jul  7 23:15:08 ceres kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hd=
a8 >
Jul  7 23:15:08 ceres kernel: hdb: max request size: 512KiB
Jul  7 23:15:08 ceres kernel: hdb: 488397168 sectors (250059 MB) w/16384KiB=
 Cache, CHS=3D30401/255/63, UDMA(100)
Jul  7 23:15:08 ceres kernel: hdb: cache flushes supported
Jul  7 23:15:08 ceres kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hd=
b8 >
Jul  7 23:15:09 ceres kernel: hdc: max request size: 512KiB
Jul  7 23:15:09 ceres kernel: hdc: 488397168 sectors (250059 MB) w/16384KiB=
 Cache, CHS=3D30401/255/63, UDMA(100)
Jul  7 23:15:09 ceres kernel: hdc: cache flushes supported
Jul  7 23:15:09 ceres kernel:  hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hd=
c8 >
Jul  7 23:15:09 ceres kernel: hde: max request size: 512KiB
Jul  7 23:15:09 ceres kernel: hde: 241254720 sectors (123522 MB) w/1821KiB =
Cache, CHS=3D16383/255/63, UDMA(33)
Jul  7 23:15:09 ceres kernel: hde: cache flushes supported
Jul  7 23:15:09 ceres kernel:  hde: hde1
---

hde has since been removed from the machine, but the pdc20268 is still
present.

If someone has an idea if it's the controller or the disk or anything else
I'd very much appreciate any help you can offer!


Greetings,
	Benjamin

--=20
Today, memory either forgets things when you don't want it to,
or remembers things long after they're better forgotten.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvIPwr0OTeImXvg8RApwyAKC07l5y0xtgQfwGTqgTRstE/p0nJgCg2FCo
3qBcA+PpNgdwvNT+KYNOlRM=
=e8lb
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
