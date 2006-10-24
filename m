From: Martin Hicks <mort@bork.org>
Subject: M-Systems SATA FFD fails IDENTIFY cmd
Date: Tue, 24 Oct 2006 14:20:54 -0400
Message-ID: <20061024182054.GA19657@socrates.bork.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:54794 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1161136AbWJXSU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2006 14:20:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id 8CE9D42C2
	for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 14:20:57 -0400 (EDT)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09669-02 for <linux-ide@vger.kernel.org>;
	Tue, 24 Oct 2006 14:20:57 -0400 (EDT)
Received: from socrates.bork.org (socrates.bork.org [192.168.3.3])
	by galileo.bork.org (Postfix) with ESMTP id 2C5FB404B
	for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 14:20:57 -0400 (EDT)
Received: from mort by socrates.bork.org with local (Exim 4.63)
	(envelope-from <mort@socrates.bork.org>)
	id 1GcQtS-0005ec-UU
	for linux-ide@vger.kernel.org; Tue, 24 Oct 2006 14:20:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I've got a few M-Systems SATA FFD 2.5" solid state disks that behave
strangely with some drivers.

When probing the disks on an Asus P5P800-MX motherboard's onboard SATA
and with an embedded PPC440gx machine with an on-board Intel 31244
(sata_vsc) SATA controller I get the following:

mort@seaking:~$ sudo modprobe ata_piix
Oct 24 12:54:15 localhost kernel: ata_piix 0000:00:1f.2: version 2.00ac6
Oct 24 12:54:15 localhost kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Oct 24 12:54:15 localhost kernel: PCI: Enabling device 0000:00:1f.2 (0000 -=
> 0001)
Oct 24 12:54:15 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GS=
I 18 (level, low) -> IRQ 16
Oct 24 12:54:15 localhost kernel: PCI: Setting latency timer of device 0000=
:00:1f.2 to 64
Oct 24 12:54:15 localhost kernel: ata11: SATA max UDMA/133 cmd 0xAC00 ctl 0=
xA882 bmdma 0xA400 irq 16
Oct 24 12:54:15 localhost kernel: ata12: SATA max UDMA/133 cmd 0xA800 ctl 0=
xA482 bmdma 0xA408 irq 16
Oct 24 12:54:15 localhost kernel: scsi10 : ata_piix
Oct 24 12:54:45 localhost kernel: ata11.00: qc timeout (cmd 0xec)
Oct 24 12:54:45 localhost kernel: ata11.00: failed to IDENTIFY (I/O error, =
err_mask=3D0x4)
Oct 24 12:54:46 localhost kernel: ata11.00: ATA-6, max UDMA/100, 16074752 s=
ectors: LBA=20
Oct 24 12:54:46 localhost kernel: ata11.00: ata11: dev 0 multi count 2
Oct 24 12:54:46 localhost kernel: ata11.00: applying bridge limits
Oct 24 12:54:46 localhost kernel: ata11.00: configured for UDMA/100
Oct 24 12:54:46 localhost kernel: scsi11 : ata_piix
Oct 24 12:54:46 localhost kernel: ATA: abnormal status 0x7F on port 0xA807
Oct 24 12:54:46 localhost kernel: scsi 10:0:0:0: Direct-Access     ATA     =
 M-Systems FFD Se 1.03 PQ: 0 ANSI: 5
Oct 24 12:54:46 localhost kernel: SCSI device sda: 16074752 512-byte hdwr s=
ectors (8230 MB)
Oct 24 12:54:46 localhost kernel: sda: Write Protect is off
Oct 24 12:54:46 localhost kernel: sda: Mode Sense: 00 3a 00 00
Oct 24 12:54:46 localhost kernel: SCSI device sda: drive cache: write back
Oct 24 12:54:46 localhost kernel: SCSI device sda: 16074752 512-byte hdwr s=
ectors (8230 MB)
Oct 24 12:54:46 localhost kernel: sda: Write Protect is off
Oct 24 12:54:46 localhost kernel: sda: Mode Sense: 00 3a 00 00
Oct 24 12:54:46 localhost kernel: SCSI device sda: drive cache: write back
Oct 24 12:54:46 localhost kernel:  sda: unknown partition table
Oct 24 12:54:46 localhost kernel: sd 10:0:0:0: Attached scsi disk sda


As you can see the INQUIRY command fails after 30 seconds. The x86/ata_piix
machine is running 2.6.19-rc3.  The PPC/sata_vsc machine is running
2.6.18.

Two other controllers were tested on the x86 machine and they both
worked as expected:

Silicon Image, Inc. Adaptec AAR-1210SA SATA HostRAID Controller (rev 02)
Promise Technology, Inc. PDC20575 (SATAII150 TX2plus) (rev 02)

Is this likely a problem with the M-Systems drive or a libata/driver proble=
m?
mh

--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPlmG0ZUZrUx/K+4RAovBAJ41zYyMLDYB3SB5a652nYhpWhDXPwCghfFl
AcCFVjw7frWsRr8wlURfL0U=
=Cmjo
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
