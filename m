From: Sascha Silbe <sascha-ml-linux-kernel-ide@silbe.org>
Subject: SiI3811 PATA->SATA bridge not working on OpenRD-Base
Date: Fri, 13 Nov 2009 22:23:32 +0100
Message-ID: <20091113212332.GD1965@twin.sascha.silbe.org>
Reply-To: Sascha Silbe <sascha-ml-reply-to-2009-4@silbe.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from setoy.chost.de ([217.160.209.225]:33069 "EHLO smtp.chost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbZKMVaM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Nov 2009 16:30:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I can't get a SiI3811-based PATA (device) -> SATA (host) converter to=20
work on my OpenRD-Base (ARMv5TE) running 2.6.32-rc7 (and -rc4 before=20
that), even though
a) the converter is working fine (with the same hard disk(s) attached)=20
on my PC (amd64, 2.6.26-2-amd64 from Debian),
b) a native SATA HD is working on the OpenRD-Base and
c) U-Boot (bootloader) is showing the PATA HD quite fine.

Both hard disk and converter are powered via an external power supply,=20
so power draw isn't an issue.

The error messages are:

Nov 13 21:05:02 flatty kernel: ata2: hard resetting link
Nov 13 21:05:03 flatty kernel: ata2: SATA link up 1.5 Gbps (SStatus 113=20
SControl F300)
Nov 13 21:05:03 flatty kernel: ata2.00: failed to IDENTIFY (I/O error,=20
err_mask=3D0x2)
Nov 13 21:05:08 flatty kernel: ata2: hard resetting link
Nov 13 21:05:08 flatty kernel: ata2: SATA link up 1.5 Gbps (SStatus 113=20
SControl F300)
Nov 13 21:05:08 flatty kernel: ata2.00: failed to IDENTIFY (I/O error,=20
err_mask=3D0x2)
Nov 13 21:05:08 flatty kernel: ata2: limiting SATA link speed to 1.5=20
Gbps
Nov 13 21:05:13 flatty kernel: ata2: hard resetting link
Nov 13 21:05:14 flatty kernel: ata2: SATA link up 1.5 Gbps (SStatus 113=20
SControl F310)
Nov 13 21:05:14 flatty kernel: ata2.00: failed to IDENTIFY (I/O error,=20
err_mask=3D0x2)
Nov 13 21:05:19 flatty kernel: ata2: hard resetting link
Nov 13 21:05:19 flatty kernel: ata2: SATA link up 1.5 Gbps (SStatus 113=20
SControl F310)
Nov 13 21:05:19 flatty kernel: ata2: EH complete


Is there a way to figure out what component is to blame? I.e. whether=20
its the SATA host adapter driver (sata_mv) or something more generic?

CU Sascha

--=20
http://sascha.silbe.org/
http://www.infra-silbe.de/
--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAEBAgAGBQJK/c5RAAoJELpz82VMF3Da64IH/1u7djbYo+hKnOnE7aso9oln
FIIZdJ3sVDj8wLgBUQFnAGAE8dHPmcoX9+5ZWdgEBzR4I769RXg1seVXHwQ7NqEQ
pDbNj07Oum3xi0BzEkYehpKqWUm9HSxnsCQT7n0DibWrHCglEbI+2l5V4ZDCVmuz
k6VbQbu3CFFcMjfrZfuQ7BmbDvatz8yxiplSqx3GwUhlzQ2kKM1KDbWFE+a2zYX3
IGHKpJ9OEuVZ29Jyzw7ZE+iFJiqLm7EunDH+msUKXdrU3Ttm4Uz/EkO9dMy+BZde
IkXzTOD334bGL+KiGgatb1egBvH5DpWvvTKLLH8v83/OwPkDzl7GCLfDMXV6H/A=
=dvqu
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
