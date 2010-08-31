From: Wolfram Sang <w.sang@pengutronix.de>
Subject: WARNINGs because of ide-proc handling
Date: Tue, 31 Aug 2010 22:56:05 +0200
Message-ID: <20100831205605.GA23636@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39508 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab0HaU4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 16:56:07 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <wsa@pengutronix.de>)
	id 1OqXsE-0007fG-2v
	for linux-ide@vger.kernel.org; Tue, 31 Aug 2010 22:56:06 +0200
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <wsa@pengutronix.de>)
	id 1OqXsD-0006CX-RV
	for linux-ide@vger.kernel.org; Tue, 31 Aug 2010 22:56:05 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I get the following warning (and some similar ones) on my laptop running
2.6.36-rc3 when removing a CF card via pcmcia:

[ 1087.602129] WARNING: at fs/proc/generic.c:816 remove_proc_entry+0x185/0x=
1d0()
[ 1087.602137] Hardware name: Amilo M14255
[ 1087.602142] name 'cache'
=2E..

It turned out that none of the entries in ide_disk_proc[] gets created when
inserting the card, so trying to remove them triggers this warning. Adding
some debug printouts

=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index a3133d7..5016a54 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -650,6 +651,7 @@ void ide_proc_register_driver(ide_drive_t *drive, struc=
t ide_driver *driver)
        drive->settings =3D driver->proc_devsets(drive);
        mutex_unlock(&ide_setting_mtx);
=20
+       printk(KERN_INFO "*** wsa: %s - %p - %d\n", driver->proc_entries(dr=
ive)->name, drive->proc, (drive->media =3D=3D ide_disk));
        ide_add_proc_entries(drive->proc, driver->proc_entries(drive), driv=
e);
 }
=20
=3D=3D=3D=3D=3D=3D=3D=3D

results in:

[    9.040157] *** wsa: cache - (null) - 1

This shows that the path needed for those proc-entries does not exist at th=
is
moment (pointer is null). So the callchain for creating all the proc-entries
seems to be disordered? The entries are present for my hard-disk, though.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkx9bGUACgkQD27XaX1/VRuopgCgxaH4mozuyqLDag9Jgu+suqEq
yQkAn1dVBTMfGNFEL82q4tZe338lxB0v
=0sTZ
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
