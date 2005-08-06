From: Raphael Bossek <raphael.bossek@gmx.de>
Subject: Looking for support of Promise PDC40775 (SATA 300 TX2plus)
Date: Sat, 6 Aug 2005 23:10:16 +0200
Message-ID: <20050806231016.7a4f6553.raphael.bossek@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__6_Aug_2005_23_10_16_+0200_rT27=Tp6ehKt0AGa"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:57738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263354AbVHFVKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Aug 2005 17:10:22 -0400
Received: from localhost ([127.0.0.1] helo=imac.elena.home)
	by imac.elena.home with smtp (Exim 4.50)
	id 1E1Vvv-0004mZ-BR
	for linux-ide@vger.kernel.org; Sat, 06 Aug 2005 23:10:19 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

--Signature=_Sat__6_Aug_2005_23_10_16_+0200_rT27=Tp6ehKt0AGa
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi IDE experts,

I'm looking for 2.6 support of this kind of Promise controller.
Is there any progress ongoing to support this kind of hardware
with SATA and PATA conectors?
Promise released GPL source code Linux 2.4 driver for this controllers

PDC40518        Promise SATAII150 TX4
PDC20575        Promise SATAII150 TX2plus
PDC20579        Promise SATAII150 579
PDC20718        Promise SATA 300 TX4
PDC40775        Promise SATA 300 TX2plus
PDC40779        Promise SATA 300 779

The download link is
http://www.promise.com/support/download/download2_eng.asp?productID=3D138&c=
ategory=3Dall&os=3D100

Do Promise supported Linux 2.6 ever? Is the Linux 2.6 support be
done by volunteer only? Are there any specs available? I hope the
GPL code is not the only place to reference to while writting the
Linux 2.6 driver?

--=20
Raphael Bossek

--Signature=_Sat__6_Aug_2005_23_10_16_+0200_rT27=Tp6ehKt0AGa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC9Sc6N2lBq4Nesv8RAiCQAJ44xwz6OmklZJwupr27ueMIcufxBgCfbkMU
Sf09jhpnoUkzZRM2ShemcIE=
=UPQ+
-----END PGP SIGNATURE-----

--Signature=_Sat__6_Aug_2005_23_10_16_+0200_rT27=Tp6ehKt0AGa--
