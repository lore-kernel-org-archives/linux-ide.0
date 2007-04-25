From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 4/3] ahci: hotplug polling functions for vt8251 hardware
	variant
Date: Wed, 25 Apr 2007 00:59:22 -0700
Message-ID: <20070425075922.GI7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <20070425062818.GA7846@curie-int.orbis-terrarum.net> <20070425071327.GD7846@curie-int.orbis-terrarum.net> <20070425071558.GE7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:34133 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161842AbXDYH65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:58:57 -0400
Content-Disposition: inline
In-Reply-To: <20070425071558.GE7846@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com


--C7PTD44AewjTsiSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The VT8251 was missed during the previous 3 patches, as it used to be a
seperate branch by Tejun.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index adaa82b..c151af8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -303,6 +303,9 @@ static const struct ata_port_operations ahci_vt8251_ops=
 =3D {
 	.error_handler		=3D ahci_vt8251_error_handler,
 	.post_internal_cmd	=3D ahci_post_internal_cmd,
=20
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+
 	.port_suspend		=3D ahci_port_suspend,
 	.port_resume		=3D ahci_port_resume,

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLwpaPpIsIjIzwiwRAgA+AKDTE6WgSU8FatUvXb4NfyBUUQbPoACfRW8A
yQKjH/cyiS5P/kNkLG5vaE8=
=FOQ+
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--
