From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] pata_marvell: Add another PCI identifier
Date: Wed, 22 Aug 2007 17:16:26 -0700
Message-ID: <20070823001626.GO28502@curie-int.orbis-terrarum.net>
References: <20070822232705.2decea96@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:34184 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750709AbXHWAXE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 20:23:04 -0400
Content-Disposition: inline
In-Reply-To: <20070822232705.2decea96@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Cc: akpm@osdl.org, jeff@garzik.org


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2007 at 11:27:05PM +0100, Alan Cox wrote:
>  static const struct pci_device_id marvell_pci_tbl[] =3D {
>  	{ PCI_DEVICE(0x11AB, 0x6101), },
> -	{ PCI_DEVICE(0x11AB, 0x6145), },
Why is this ID being removed?

Not that I have that model (I have 0x6101), it just looks weird given
the patch description to "Add another PCI identifier" and I thought I
should check.

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGzNHaPpIsIjIzwiwRAnncAKCf0+QEzKAKv+cfInerdqtV7U8YZgCg1cRM
tkFRQYe8oVK6zExRDip83+c=
=eULh
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--
