From: Martin Hicks <mort@bork.org>
Subject: Re: M-Systems SATA FFD fails IDENTIFY cmd
Date: Tue, 31 Oct 2006 09:57:43 -0500
Message-ID: <20061031145743.GC4410@socrates.bork.org>
References: <20061024182054.GA19657@socrates.bork.org> <45472328.4030504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:54789 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1423460AbWJaO5p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 09:57:45 -0500
Content-Disposition: inline
In-Reply-To: <45472328.4030504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Oct 31, 2006 at 07:19:20PM +0900, Tejun Heo wrote:
> Martin Hicks wrote:
> >Hi,
> >
> >As you can see the INQUIRY command fails after 30 seconds. The x86/ata_p=
iix
> >machine is running 2.6.19-rc3.  The PPC/sata_vsc machine is running
> >2.6.18.
>=20
> Can you try 2.6.19-rc3-mm1 and report the result?  Thanks.

Its even worse because in this version it has to wait for two commands
to time out.

mort@seaking:~$ cat /proc/version=20
Linux version 2.6.19-rc3-mm1 (mort@seaking) (gcc version 4.1.2 20060901 (pr=
erelease) (Debian 4.1.1-13)) #1 SMP Tue Oct 31 09:18:36 EST 2006

Oct 31 09:44:31 localhost kernel: ata_piix 0000:00:1f.2: version 2.00ac7
Oct 31 09:44:31 localhost kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Oct 31 09:44:31 localhost kernel: PCI: Enabling device 0000:00:1f.2 (0000 -=
> 0001)
Oct 31 09:44:31 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GS=
I 18 (level, low) -> IRQ 16
Oct 31 09:44:31 localhost kernel: PCI: Setting latency timer of device 0000=
:00:1f.2 to 64
Oct 31 09:44:31 localhost kernel: ata3: SATA max UDMA/133 cmd 0xBC00 ctl 0x=
B882 bmdma 0xB400 irq 16
Oct 31 09:44:31 localhost kernel: ata4: SATA max UDMA/133 cmd 0xB800 ctl 0x=
B482 bmdma 0xB408 irq 16
Oct 31 09:44:31 localhost kernel: scsi2 : ata_piix
Oct 31 09:44:32 localhost kernel: ATA: abnormal status 0x7F on port 0xBC07
Oct 31 09:44:32 localhost kernel: scsi3 : ata_piix
Oct 31 09:44:32 localhost kernel: ata4.00: ATA-6, max UDMA/100, 8022016 sec=
tors: LBA=20
Oct 31 09:44:32 localhost kernel: ata4.00: ata4: dev 0 multi count 2
Oct 31 09:44:32 localhost kernel: ata4.00: applying bridge limits
Oct 31 09:45:02 localhost kernel: ata4.00: qc timeout (cmd 0xef)
Oct 31 09:45:02 localhost kernel: ata4.00: failed to set xfermode (err_mask=
=3D0x4)
Oct 31 09:45:02 localhost kernel: ata4.00: limiting speed to UDMA/66
Oct 31 09:45:02 localhost kernel: ata4: failed to recover some devices, ret=
rying in 5 secs
Oct 31 09:45:37 localhost kernel: ata4.00: qc timeout (cmd 0xec)
Oct 31 09:45:37 localhost kernel: ata4.00: failed to IDENTIFY (I/O error, e=
rr_mask=3D0x4)
Oct 31 09:45:37 localhost kernel: ata4.00: revalidation failed (errno=3D-5)
Oct 31 09:45:37 localhost kernel: ata4: failed to recover some devices, ret=
rying in 5 secs
Oct 31 09:45:42 localhost kernel: ata4.00: configured for UDMA/66
Oct 31 09:45:42 localhost kernel: scsi 3:0:0:0: Direct-Access     ATA      =
M-Systems FFD Se 1.02 PQ: 0 ANSI: 5
Oct 31 09:45:42 localhost kernel: SCSI device sda: 8022016 512-byte hdwr se=
ctors (4107 MB)
Oct 31 09:45:42 localhost kernel: sda: Write Protect is off
Oct 31 09:45:42 localhost kernel: sda: Mode Sense: 00 3a 00 00
Oct 31 09:45:42 localhost kernel: SCSI device sda: drive cache: write back
Oct 31 09:45:42 localhost kernel: SCSI device sda: 8022016 512-byte hdwr se=
ctors (4107 MB)
Oct 31 09:45:42 localhost kernel: sda: Write Protect is off
Oct 31 09:45:42 localhost kernel: sda: Mode Sense: 00 3a 00 00
Oct 31 09:45:42 localhost kernel: SCSI device sda: drive cache: write back
Oct 31 09:45:42 localhost kernel:  sda: unknown partition table
Oct 31 09:45:42 localhost kernel: sd 3:0:0:0: Attached scsi disk sda


--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFR2Rn0ZUZrUx/K+4RAhV1AKDW9jFlE5eAzVdYy8phac1ugG8NkQCgmAKl
5Kz6gvBfnujhMNjSm3d2FHw=
=V5jA
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
